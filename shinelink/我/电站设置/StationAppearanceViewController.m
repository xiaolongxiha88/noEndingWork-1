//
//  StationAppearanceViewController.m
//  ShinePhone
//
//  Created by ZML on 15/5/28.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "StationAppearanceViewController.h"

@interface StationAppearanceViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITabBarControllerDelegate>
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSDictionary *dictData;
@property (nonatomic, strong) UIActionSheet *uploadImageActionSheet;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong) UIButton *goBut;
@end

@implementation StationAppearanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=root_WO_tupian;
//    UIImage *bgImage = IMAGE(@"bg4.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
    self.view.backgroundColor=MainColor;
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(40*NOW_SIZE, 20*HEIGHT_SIZE, 240*NOW_SIZE, 240*HEIGHT_SIZE)];
    _imageView.contentMode=UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds=YES;
    [self.view addSubview:_imageView];
    [self requestData];
    [self initUI];
}


-(void)requestData{
    [self showProgressView];
    [BaseRequest requestImageWithMethodByGet:HEAD_URL paramars:@{@"id":[UserInfo defaultUserInfo].plantID} paramarsSite:@"/newPlantAPI.do?op=getImg" sucessBlock:^(id content) {
        [self hideProgressView];
        _imageView.image=content;
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
    }];
}


-(void)initUI{
    UIButton *button=[[UIButton alloc]initWithFrame:_imageView.frame];
    [button addTarget:self action:@selector(selectImageButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    UIButton *delButton=[[UIButton alloc]initWithFrame:CGRectMake(80*NOW_SIZE, 400*NOW_SIZE, 60*NOW_SIZE, 21*NOW_SIZE)];
//    [delButton setBackgroundImage:IMAGE(@"圆角矩形.png") forState:0];
//    [delButton setTitle:root_Cancel forState:UIControlStateNormal];
//    [delButton setTitleColor:COLOR(73, 135, 43, 1) forState:UIControlStateNormal];
//    [delButton addTarget:self action:@selector(delButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:delButton];
//    
//    UIButton *addButton=[[UIButton alloc]initWithFrame:CGRectMake(180*NOW_SIZE, 400*NOW_SIZE, 60*NOW_SIZE, 21*NOW_SIZE)];
//    [addButton setBackgroundImage:IMAGE(@"圆角矩形.png") forState:0];
//    [addButton setTitle:root_Yes forState:UIControlStateNormal];
//    [addButton setTitleColor:COLOR(73, 135, 43, 1) forState:UIControlStateNormal];
//    [addButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:addButton];
    
    _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(60*NOW_SIZE,280*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
//    [_goBut.layer setMasksToBounds:YES];
//    [_goBut.layer setCornerRadius:25.0];
      _goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:root_finish forState:UIControlStateNormal];
    [_goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_goBut];

}


-(void)selectImageButtonPressed{
    
    NSLog(@"取照片");
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: root_paiZhao style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        self.cameraImagePicker = [[UIImagePickerController alloc] init];
        self.cameraImagePicker.allowsEditing = YES;
        self.cameraImagePicker.delegate = self;
        self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_cameraImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_xiangkuang_xuanQu style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        self.photoLibraryImagePicker.allowsEditing = YES;
        self.photoLibraryImagePicker.delegate = self;
        self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];

    
    
    
    
    
    
    
    
//    self.uploadImageActionSheet = [[UIActionSheet alloc] initWithTitle:root_dianzhan_xuanzhe delegate:self cancelButtonTitle:root_Cancel destructiveButtonTitle:nil otherButtonTitles:root_paiZhao, root_xiangkuang_xuanQu, nil];
//    self.uploadImageActionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
//    [self.uploadImageActionSheet showInView:self.view];
}

-(void)delButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)addButtonPressed{
    //4.根据是否为浏览用户(登录接口返回参数判断)，屏蔽添加电站、添加采集器、修改电站信息功能，给予提示(浏览用户禁止操作)。
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }
    NSData *imageData = UIImageJPEGRepresentation(_imageView.image, 0.5);
    
    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
    [dataImageDict setObject:imageData forKey:@"plantMap"];
    //NSString *plantId = _stationId;
        [BaseRequest uplodImageWithMethod:HEAD_URL paramars:@{@"id":[UserInfo defaultUserInfo].plantID} paramarsSite:@"/newPlantAPI.do?op=updateImg" dataImageDict:dataImageDict sucessBlock:^(id content) {
            NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            if ([res rangeOfString:@"true"].location == NSNotFound) {
                [self showToastViewWithTitle:NSLocalizedString(@"Successfully fails", @"Successfully fails")];
               
            } else {
                [self showToastViewWithTitle:NSLocalizedString(@"Modification modified", @"Modification modified")];
                 [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            [self showToastViewWithTitle:root_Networking];
        }];
}



#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet == _uploadImageActionSheet) {
        //拍照
        if (buttonIndex == 0) {
            self.cameraImagePicker = [[UIImagePickerController alloc] init];
            self.cameraImagePicker.allowsEditing = YES;
            self.cameraImagePicker.delegate = self;
            self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_cameraImagePicker animated:YES completion:nil];
        }
        //从相册选择
        if (buttonIndex == 1) {
            
            self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
            self.photoLibraryImagePicker.allowsEditing = YES;
            self.photoLibraryImagePicker.delegate = self;
            self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    _imageView.image=image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
