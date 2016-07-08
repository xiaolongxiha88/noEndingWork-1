//
//  editViewController.m
//  shinelink
//
//  Created by sky on 16/2/26.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "editViewController.h"
#import "userdataViewController.h"
#import "loginViewController.h"
#import "UserInfo.h"

#define Kwidth [UIScreen mainScreen].bounds.size.width
#define moveHeight 270*NOW_SIZE
#define moveHeight2 12*NOW_SIZE


@interface editViewController ()<UITextFieldDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSMutableArray *textFieldMutableArray;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation editViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(toEdit)];
    [self.navigationItem setRightBarButtonItem:right];
      [self initUI];
    
}
-(void)toEdit{
    
  [self.navigationController popViewControllerAnimated:YES];

}
-(void)initUI{
    double imageSize=150;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
    
    NSArray *imageArray=[NSArray arrayWithObjects:@"iconfont-gongsijianjie@3x.png", @"icon---Email---Full@3x.png", @"iconfont-nengyuanlei@3x.png", @"iconfont-address@3x.png",nil];
    NSArray *labelArray=[NSArray arrayWithObjects:@"公司名字:", @"邮箱:", @"电话:", @"地址:", nil];
    NSArray *labelArray2=[NSArray arrayWithObjects:@"请输入公司名字", @"请输入邮箱", @"请输入电话", @"请输入地址", nil];
       _textFieldMutableArray=[NSMutableArray new];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,250*NOW_SIZE)];
    UIColor *color=[UIColor colorWithRed:130/ 255.0f green:200 / 255.0f blue:250 / 255.0f alpha:1];
    [headerView setBackgroundColor:color];
    [_scrollView addSubview:headerView];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake((Kwidth-80*NOW_SIZE)/2,(210*NOW_SIZE-imageSize)/2+imageSize+10*NOW_SIZE, 80*NOW_SIZE, 25*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:15.0];
    goBut.backgroundColor = [UIColor whiteColor];
    [goBut setTitle:@"更换头像" forState:UIControlStateNormal];
    //[goBut setTintColor:[UIColor colorWithRed:130/ 255.0f green:200 / 255.0f blue:250 / 255.0f alpha:1]];
    [goBut setTitleColor: [UIColor colorWithRed:130/ 255.0f green:200 / 255.0f blue:250 / 255.0f alpha:1] forState:(UIControlStateNormal)];
    [goBut addTarget:self action:@selector(PresentGo) forControlEvents:UIControlEventTouchUpInside];
    //  goBut.highlighted=[UIColor grayColor];
    [_scrollView  addSubview:goBut];
    
    UIButton *registerUser =  [UIButton buttonWithType:UIButtonTypeCustom];
    registerUser.frame=CGRectMake((Kwidth-150*NOW_SIZE)/2,500*NOW_SIZE, 150*NOW_SIZE, 40*NOW_SIZE);
    [registerUser.layer setMasksToBounds:YES];
    [registerUser.layer setCornerRadius:20.0];
    registerUser.backgroundColor = [UIColor redColor];
    [registerUser setTitle:@"注销账号" forState:UIControlStateNormal];
    //[goBut setTintColor:[UIColor colorWithRed:130/ 255.0f green:200 / 255.0f blue:250 / 255.0f alpha:1]];
    [registerUser setTitleColor: [UIColor whiteColor]forState:UIControlStateNormal];
    [registerUser addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    //  goBut.highlighted=[UIColor grayColor];
    [_scrollView addSubview:registerUser];
    
    
    UIImageView *userImage= [[UIImageView alloc] initWithFrame:CGRectMake((Kwidth-imageSize)/2, (210*NOW_SIZE-imageSize)/2, imageSize, imageSize)];
    [userImage setImage:[UIImage imageNamed:@"1.jpg"]];
    userImage.layer.masksToBounds=YES;
    userImage.layer.cornerRadius=imageSize/2.0;
    [headerView addSubview:userImage];
    for (int i=0; i<4; i++)
    {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,16*NOW_SIZE+i*50*NOW_SIZE+moveHeight,40*NOW_SIZE, 40*NOW_SIZE)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds=YES;
        imageView.image=[UIImage imageNamed:imageArray[i]];
        [_scrollView addSubview:imageView];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(70*NOW_SIZE,10*NOW_SIZE+i*50*NOW_SIZE+moveHeight+moveHeight2, 70*NOW_SIZE, 30*NOW_SIZE)];
        label.text=labelArray[i];
        label.textAlignment=NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15*NOW_SIZE];
        label.textColor=[UIColor grayColor];
        [_scrollView addSubview:label];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,40*NOW_SIZE+i*50*NOW_SIZE+moveHeight+moveHeight2, 260*NOW_SIZE, 1)];
        line.backgroundColor=[UIColor grayColor];
        [_scrollView addSubview:line];
        
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(150*NOW_SIZE,10*NOW_SIZE+i*50*NOW_SIZE+moveHeight+moveHeight2, 180*NOW_SIZE, 30*NOW_SIZE)];
        textField.placeholder =labelArray2[i];
        
        textField.textColor = [UIColor grayColor];
        textField.tintColor = [UIColor grayColor];
        [textField setValue:[UIColor orangeColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont systemFontOfSize:13*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
        textField.font = [UIFont systemFontOfSize:15*NOW_SIZE];
        textField.tag = i;
        textField.delegate = self;
        [_scrollView addSubview:textField];
        [_textFieldMutableArray addObject:textField];
    }
    
}

-(void)registerUser{
    [[UserInfo defaultUserInfo] setUserPassword:nil];
    [[UserInfo defaultUserInfo] setUserName:nil];
    loginViewController *login =[[loginViewController alloc]init];
   
  
    self.hidesBottomBarWhenPushed=YES;
     [login.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:login animated:YES];

}
-(void)PresentGo{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        self.cameraImagePicker = [[UIImagePickerController alloc] init];
        self.cameraImagePicker.allowsEditing = YES;
        self.cameraImagePicker.delegate = self;
        self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_cameraImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        self.photoLibraryImagePicker.allowsEditing = YES;
        self.photoLibraryImagePicker.delegate = self;
        self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
    }
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
