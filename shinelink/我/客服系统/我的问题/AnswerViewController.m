//
//  AnswerViewController.m
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "AnswerViewController.h"
#import "myListSecond.h"
#import "GetServerViewController.h"

@interface AnswerViewController ()<UITextFieldDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *SNTextField;
@property (nonatomic, strong) UILabel* registLable;
@property (nonatomic, strong) UITextView *contentView;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong) NSMutableArray *picArray;
@property (nonatomic, strong) NSMutableDictionary *allDict;
@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@end

@implementation AnswerViewController
{
int picTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=root_ME_tijiao_wenti;
    picTime=0;
    
    _picArray=[NSMutableArray array];
    [self initUI];
}


-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
 //   float Size1=50*NOW_SIZE;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    
        UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 17*HEIGHT_SIZE, 80*NOW_SIZE,20*HEIGHT_SIZE )];
        PV1Lable.text=root_ME_neirong;
        PV1Lable.textAlignment=NSTextAlignmentRight;
        PV1Lable.textColor=[UIColor blackColor];
        PV1Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:PV1Lable];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(80*NOW_SIZE, 17*HEIGHT_SIZE, 220*NOW_SIZE,205*HEIGHT_SIZE )];
    image2.userInteractionEnabled = YES;
    image2.image = IMAGE(@"content4.jpg");
    [_scrollView addSubview:image2];
    
    self.contentView = [[UITextView alloc] initWithFrame:CGRectMake(85*NOW_SIZE, 19*HEIGHT_SIZE, 205*NOW_SIZE,200*HEIGHT_SIZE )];
    // self.contentView.placeholder = @"请输入内容";
    self.contentView.textColor = [UIColor blackColor];
    self.contentView.tintColor = [UIColor blackColor];
    // [self.contentView setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    //  [self.contentView setValue:[UIFont systemFontOfSize:12*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.contentView.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:_contentView];
    
    UILabel *PV1Lable1=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 29*HEIGHT_SIZE+200*HEIGHT_SIZE, 80*NOW_SIZE,20*HEIGHT_SIZE )];
    PV1Lable1.text=root_ME_fujian;
    PV1Lable1.textAlignment=NSTextAlignmentRight;
    PV1Lable1.textColor=[UIColor blackColor];
    PV1Lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:PV1Lable1];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(80*NOW_SIZE, 27*HEIGHT_SIZE+200*HEIGHT_SIZE, 220*NOW_SIZE,30*HEIGHT_SIZE )];
    image1.userInteractionEnabled = YES;
    image1.image = IMAGE(@"frame2@2x.png");
    [_scrollView addSubview:image1];
    
    UILabel *registLable1= [[UILabel alloc] initWithFrame:CGRectMake(85*NOW_SIZE, 27*HEIGHT_SIZE+200*HEIGHT_SIZE, 220*NOW_SIZE,30*HEIGHT_SIZE )];
    registLable1.text=root_ME_shangchuan_tupian;
    registLable1.textColor=[UIColor grayColor];
    registLable1.textAlignment = NSTextAlignmentLeft;
    registLable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    registLable1.userInteractionEnabled=YES;
    UITapGestureRecognizer * labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(controlPhoto)];
    [registLable1 addGestureRecognizer:labelTap1];
    [_scrollView addSubview:registLable1];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE, 45*HEIGHT_SIZE+200*HEIGHT_SIZE+160*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
//    [goBut.layer setMasksToBounds:YES];
//    [goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_finish forState:UIControlStateNormal];
     goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut addTarget:self action:@selector(finishDone) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:goBut];
    
    float size5=70*NOW_SIZE;
    for(int i=0;i<3;i++){
        UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(90*NOW_SIZE+size5*i, 267*HEIGHT_SIZE, 50*NOW_SIZE,50*HEIGHT_SIZE )];
        // image5.userInteractionEnabled = YES;
        image5.image = IMAGE(@"frame_add.png");
        [_scrollView addSubview:image5];
    }
    
//    for(int i=0;i<4;i++){
//        UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(75*NOW_SIZE+size5*i, 90*NOW_SIZE+200*NOW_SIZE+50*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
//        // image5.userInteractionEnabled = YES;
//        image5.image = IMAGE(@"frame_add.png");
//        [_scrollView addSubview:image5];
//    }
    
    
}

-(void)finishDone{
    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
//    for (int i=0; i<_picArray.count; i++) {
//        NSData *imageData = UIImageJPEGRepresentation(_picArray[i], 0.5);
//        NSString *imageName=@"imageName";
//        [dataImageDict setObject:imageData forKey:imageName];
//    }
    
    NSMutableArray *picAll=[NSMutableArray arrayWithArray:_picArray];
    [picAll removeObject:@"del"];
    for (int i=0; i<picAll.count; i++) {
        NSData *imageData = UIImageJPEGRepresentation(picAll[i], 0.5);
        NSString *imageName=[NSString stringWithFormat:@"image%d",i+1];
        [dataImageDict setObject:imageData forKey:imageName];
    }
    
    if ([[_contentView text] isEqual:@""]) {
        [self showToastViewWithTitle:root_ME_shuru_leirong];
        return;
    }
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userID=[ud objectForKey:@"userID"];
    _allDict=[NSMutableDictionary dictionary];
      [_allDict setObject:[_contentView text] forKey:@"message"];
     [_allDict setObject:_qusetionId forKey:@"questionId"];
     [_allDict setObject:userID forKey:@"userId"];
    
     [self showProgressView];
    [BaseRequest uplodImageWithMethod:HEAD_URL paramars:_allDict paramarsSite:@"/questionAPI.do?op=replyMessage" dataImageDict:dataImageDict sucessBlock:^(id content) {
        NSLog(@"addCustomerQuestion==%@", content);
         [self hideProgressView];
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if (content1) {
            if ([content1[@"success"] integerValue] == 1) {
                
                [self goback];
                [self showAlertViewWithTitle:nil message:root_ME_tianjia_chenggong cancelButtonTitle:root_Yes];
               [self.navigationController popViewControllerAnimated:NO];
            }
        }else{
            [self showAlertViewWithTitle:nil message:root_ME_tianjia_shibai cancelButtonTitle:root_Yes];
             [self.navigationController popViewControllerAnimated:NO];
        }
    }
                              failure:^(NSError *error) {
                                  [self showToastViewWithTitle:root_Networking];
                                   [self hideProgressView];
                                  [self.navigationController popViewControllerAnimated:NO];
                              }];
    
}

-(void)goback{
   // myListSecond *second=[[myListSecond alloc]init];
    [self.navigationController popViewControllerAnimated:NO];

}

-(void)controlPhoto{
    if (_image1 &&_image2 &&_image3) {
        [self showAlertViewWithTitle:nil message:@"最多上传3张图片" cancelButtonTitle:root_Yes];
    }else{
    
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
    }
        
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
 
     float size5=70*NOW_SIZE;
    
    if(!_image1){
        [_picArray insertObject:image atIndex:0];
        _image1=[[UIImageView alloc]initWithFrame:CGRectMake(90*NOW_SIZE+size5*0, 267*HEIGHT_SIZE, 50*NOW_SIZE,50*HEIGHT_SIZE )];
        _image1.userInteractionEnabled = YES;
        _image1.image = image;
        _image1.tag=1+3000;
        [_scrollView addSubview:_image1];
        
        _button1= [[UIButton alloc] initWithFrame:CGRectMake(90*NOW_SIZE+size5*0, 252*HEIGHT_SIZE+55*HEIGHT_SIZE, 50*NOW_SIZE,50*HEIGHT_SIZE )];
        [_button1 setTitle:root_del forState:UIControlStateNormal];
        _button1.backgroundColor=[UIColor clearColor];
        [_button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _button1.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        _button1.tag=2000+1;
         //_button1.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        [_button1 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_button1];
        
    }else if(_image1 && !_image2){
        [_picArray insertObject:image atIndex:1];
        _image2=[[UIImageView alloc]initWithFrame:CGRectMake(90*NOW_SIZE+size5*1, 267*HEIGHT_SIZE, 50*NOW_SIZE,50*HEIGHT_SIZE )];
        _image2.userInteractionEnabled = YES;
        _image2.image = image;
        _image2.tag=2+3000;
        [_scrollView addSubview:_image2];
        
        _button2= [[UIButton alloc] initWithFrame:CGRectMake(90*NOW_SIZE+size5*1, 252*HEIGHT_SIZE+55*HEIGHT_SIZE, 50*NOW_SIZE,50*HEIGHT_SIZE )];
        [_button2 setTitle:root_del forState:UIControlStateNormal];
        _button2.backgroundColor=[UIColor clearColor];
        [_button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _button2.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        _button2.tag=2000+2;
        // _button2.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        [_button2 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_button2];
        
    }else if(_image1 && _image2 && !_image3){
        [_picArray insertObject:image atIndex:2];
        _image3=[[UIImageView alloc]initWithFrame:CGRectMake(90*NOW_SIZE+size5*2, 267*HEIGHT_SIZE, 50*NOW_SIZE,50*HEIGHT_SIZE )];
        _image3.userInteractionEnabled = YES;
        _image3.image = image;
        _image3.tag=3+3000;
        [_scrollView addSubview:_image3];
        
        _button3= [[UIButton alloc] initWithFrame:CGRectMake(90*NOW_SIZE+size5*2, 252*HEIGHT_SIZE+55*HEIGHT_SIZE, 50*NOW_SIZE,50*HEIGHT_SIZE )];
        [_button3 setTitle:root_del forState:UIControlStateNormal];
        _button3.backgroundColor=[UIColor clearColor];
        [_button3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        _button3.tag=2000+3;
       //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        [_button3 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_button3];
    }
    
    
    picTime++;
    
}

-(void)delPicture:(UIButton*)del{
    UIButton  *a=del;
    NSString *replaceName=@"del";
    
    [_picArray replaceObjectAtIndex:a.tag-2001 withObject:replaceName];
    
    if ((a.tag-2000)==1) {
        [_image1 removeFromSuperview];
        [_button1 removeFromSuperview];
        _image1=nil;
        _button1=nil;
    }else  if ((a.tag-2000)==2) {
        [_image2 removeFromSuperview];
        [_button2 removeFromSuperview];
        _image2=nil;
        _button2=nil;
    }else  if ((a.tag-2000)==3) {
        [_image3 removeFromSuperview];
        [_button3 removeFromSuperview];
        _image3=nil;
        _button3=nil;
    }
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_contentView resignFirstResponder];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
