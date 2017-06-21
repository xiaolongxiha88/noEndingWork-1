//
//  loginViewController.m
//  shinelink
//
//  Created by sky on 16/2/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "loginViewController.h"
#import "LoginButton.h"
#import "StTransitions.h"
#import "findViewController.h"
#import "energyViewController.h"
#import "deviceViewController.h"
#import "meViewController.h"
#import "registerViewController.h"
#import "countryViewController.h"
#import "UserInfo.h"
#import <CommonCrypto/CommonDigest.h>
#import "MBProgressHUD.h"
#import "forgetViewController.h"
#import "LZPageViewController.h"
#import "energyViewController.h"
#import "energyDemo.h"
#import "AddressPickView.h"
#import "JPUSHService.h"
#import "phoneRegisterViewController.h"
#import "quickRegisterViewController.h"
#import "AVfirstView.h"
#import "topAvViewController.h"
#import "forgetOneViewController.h"
#import "ShinePhone-Swift.h"
#import "OssMessageViewController.h"


@interface loginViewController ()<UINavigationControllerDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) NSString *loginUserName;
@property (nonatomic, strong) NSString *loginUserPassword;
//@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registButton;
@property (nonatomic, strong) UILabel *registLable;
@property (nonatomic, strong) UILabel *forgetLable;
@property (nonatomic, strong) UILabel *demoLable;
@property (nonatomic, strong) NSDictionary *dataSource;
@property (nonatomic, strong) NSMutableDictionary *demoArray;
@property (nonatomic, strong) NSString *serverDemoAddress;
@property (nonatomic, strong) NSString *adNumber;
 @property (nonatomic, strong)  NSString *languageValue;
@property (nonatomic, strong) NSString *OssFirst;
@property (nonatomic, strong) NSString *userNameGet;
@property (nonatomic) int getServerAddressNum;

@end

@implementation loginViewController
-(void)viewDidAppear:(BOOL)animated{
     animated=NO;
 [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *bgImage = IMAGE(@"bg3.jpg");
    self.view.layer.contents = (id)bgImage.CGImage;
   
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:17/255.0f green:183/255.0f blue:243/255.0f alpha:0]];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        _languageValue=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }
       [self.navigationController setNavigationBarHidden:YES];

    
    //////////测试区域
        NSString *testDemo=@"O";
        if ([testDemo isEqualToString:@"OK"]) {
            IntegratorFirst *testView=[[IntegratorFirst alloc]init];
            [self.navigationController pushViewController:testView animated:NO];
        }else{
          [self getLoginType];
        }
    

}


-(void)getLoginType{

   _OssFirst=@"Y";
    
    NSString *LoginType=@"First";
    LoginType=[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginType"];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *reUsername=[ud objectForKey:@"userName"];
    NSString *rePassword=[ud objectForKey:@"userPassword"];
    
      NSString *OssName=[ud objectForKey:@"OssName"];
          NSString *OssPassword=[ud objectForKey:@"OssPassword"];
    
    if ([LoginType isEqualToString:@"O"]) {
        if (OssName==nil || OssName==NULL||([OssName isEqual:@""] )||OssPassword==nil || OssPassword==NULL||([OssPassword isEqual:@""] )) {
            [[UserInfo defaultUserInfo] setCoreDataEnable:@"1"];
            [self addSubViews];
        }else{
            _OssFirst=@"N";
            _userTextField=[[UITextField alloc]init];
            _userTextField.text=OssName;
            _pwdTextField=[[UITextField alloc]init];
            _pwdTextField.text=OssPassword;
            _loginUserName=OssName;
            _loginUserPassword=OssPassword;
              [self performSelectorOnMainThread:@selector(getOSSnet) withObject:nil waitUntilDone:NO];
        }
        
    }else if ([LoginType isEqualToString:@"S"]){
        if (reUsername==nil || reUsername==NULL||([reUsername isEqual:@""] )||rePassword==nil || rePassword==NULL||([rePassword isEqual:@""] )) {
            
            [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
            NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
            NSString *server=[ud objectForKey:@"server"];
            
            if (server==nil || server==NULL||[server isEqual:@""]) {
                [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
            }
            
            [[UserInfo defaultUserInfo] setCoreDataEnable:@"1"];
            
            [self addSubViews];
            
        }else{
            _userTextField=[[UITextField alloc]init];
            _userTextField.text=reUsername;
            _pwdTextField=[[UITextField alloc]init];
            _pwdTextField.text=rePassword;
            _loginUserName=reUsername;
            _loginUserPassword=rePassword;
            if ([_LogType isEqualToString:@"1"]) {
                _getServerAddressNum=0;
                [self performSelectorOnMainThread:@selector(netServerInit) withObject:nil waitUntilDone:NO];
            }else{
                [self performSelectorOnMainThread:@selector(netRequest) withObject:nil waitUntilDone:NO];
                //添加布局
            }
            
        }

    }else{
    
        [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        NSString *server=[ud objectForKey:@"server"];
        
        if (server==nil || server==NULL||[server isEqual:@""]) {
            [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
        }
        
        [[UserInfo defaultUserInfo] setCoreDataEnable:@"1"];
        
        [self addSubViews];
        
    }
    

    

    
    

   
    
    
    
    


}


//添加布局
- (void)addSubViews {
    float sizeH=20*HEIGHT_SIZE;
    
    if (_userTextField) {
        [_userTextField removeFromSuperview];
        _userTextField=nil;
    }
    if (_pwdTextField) {
        [_pwdTextField removeFromSuperview];
        _pwdTextField=nil;
    }
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    //logo
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(50*NOW_SIZE, 60*HEIGHT_SIZE, SCREEN_Width - 100*NOW_SIZE, 55*HEIGHT_SIZE)];
    logo.image = IMAGE(@"logo.png");
    [_scrollView addSubview:logo];
    
    //用户名
    UIImageView *userBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 145*HEIGHT_SIZE+sizeH, SCREEN_Width - 80*NOW_SIZE, 35*HEIGHT_SIZE)];
    userBgImageView.userInteractionEnabled = YES;
    userBgImageView.image = IMAGE(@"frame_user.png");
    [_scrollView addSubview:userBgImageView];
    
    if (!_userTextField) {
         self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE, 0, CGRectGetWidth(userBgImageView.frame) - 50*NOW_SIZE, 35*HEIGHT_SIZE)];
    }
   
    self.userTextField.placeholder = root_Alet_user_messge;
    if (_oldName) {
        self.userTextField.text = _oldName;

    }
    
    self.userTextField.textColor = [UIColor whiteColor];
    self.userTextField.tintColor = [UIColor whiteColor];
    [self.userTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.userTextField setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.userTextField.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [userBgImageView addSubview:_userTextField];
    
    //密码
    UIImageView *pwdBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE,200*HEIGHT_SIZE+sizeH , SCREEN_Width - 80*NOW_SIZE, 35*HEIGHT_SIZE)];
    pwdBgImageView.image = IMAGE(@"frame_password.png");
    pwdBgImageView.userInteractionEnabled = YES;
    [_scrollView addSubview:pwdBgImageView];
    
    if (!_pwdTextField) {
      self.pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE, 0, CGRectGetWidth(pwdBgImageView.frame) - 50*NOW_SIZE, 35*HEIGHT_SIZE)];
    }
    self.pwdTextField.placeholder = root_Alet_user_pwd;
    if (_oldPassword) {
        self.pwdTextField.text = _oldPassword;
    }
    self.pwdTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.pwdTextField.secureTextEntry = YES;
    self.pwdTextField.textColor = [UIColor whiteColor];
    self.pwdTextField.tintColor = [UIColor whiteColor];
    [self.pwdTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdTextField setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.pwdTextField.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView addSubview:_pwdTextField];
    
 
    float H_down=20*HEIGHT_SIZE;
    
    if (!_forgetLable) {
     self.forgetLable= [[UILabel alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 265*HEIGHT_SIZE+sizeH-H_down, 140*NOW_SIZE, 40*HEIGHT_SIZE)];
    }
    
 NSString *LableContent1=root_forget_pwd;
       NSDictionary *attributes1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14*HEIGHT_SIZE],};
    CGSize textSize1 = [LableContent1 boundingRectWithSize:CGSizeMake(140*NOW_SIZE,40*HEIGHT_SIZE) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;
     [ self.forgetLable setFrame:CGRectMake(40*NOW_SIZE, 265*HEIGHT_SIZE+sizeH-H_down, textSize1.width, 40*HEIGHT_SIZE)];
    
    self.forgetLable.text=root_forget_pwd;
     self.forgetLable.textColor=[UIColor whiteColor];
        self.forgetLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    self.forgetLable.textAlignment = NSTextAlignmentLeft;
 //   _forgetLable.adjustsFontSizeToFitWidth=YES;
     self.forgetLable.userInteractionEnabled=YES;
    UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forget2)];
    [self.forgetLable addGestureRecognizer:forget2];
    [_scrollView addSubview:self.forgetLable];
    
    if (!_registLable) {
        _registLable= [[UILabel alloc] initWithFrame:CGRectMake(160*NOW_SIZE, 265*HEIGHT_SIZE+sizeH-H_down, 115*NOW_SIZE, 40*HEIGHT_SIZE)];
    }
    
    NSString *LableContent2=root_register;
    NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14*HEIGHT_SIZE],};
    CGSize textSize2 = [LableContent2 boundingRectWithSize:CGSizeMake(120*NOW_SIZE,40*HEIGHT_SIZE) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes2 context:nil].size;
    [ self.registLable setFrame:CGRectMake(280*NOW_SIZE-textSize2.width, 265*HEIGHT_SIZE+sizeH-H_down, textSize2.width, 40*HEIGHT_SIZE)];
    
    self.registLable.text=root_register;
    self.registLable.textColor=[UIColor whiteColor];
    self.registLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
   // self.registLable.font =_forgetLable.font;
    self.registLable.textAlignment = NSTextAlignmentRight;
    self.registLable.userInteractionEnabled=YES;
    UITapGestureRecognizer * forget1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLable2)];
    [self.registLable addGestureRecognizer:forget1];
    [_scrollView addSubview:self.registLable];
    
    
    
    if (!_demoLable) {
            _demoLable= [[UILabel alloc] initWithFrame:CGRectMake(100*NOW_SIZE, 317*HEIGHT_SIZE+sizeH+90*HEIGHT_SIZE, 120*NOW_SIZE, 40*HEIGHT_SIZE)];
    }
    self.demoLable.text=root_demo_test;
//    self.demoLable.textColor=COLOR(210, 210, 210, 1);
      self.demoLable.textColor=[UIColor whiteColor];
    self.demoLable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    self.demoLable.textAlignment = NSTextAlignmentCenter;
    self.demoLable.userInteractionEnabled=YES;
    UITapGestureRecognizer * demo1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(demoTest)];
    [self.demoLable addGestureRecognizer:demo1];
       [self.demoLable sizeToFit];
    _demoLable.center=CGPointMake(SCREEN_Width/2, 317*HEIGHT_SIZE+sizeH+90*HEIGHT_SIZE+20*HEIGHT_SIZE);
    [_scrollView addSubview:self.demoLable];
    
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:16*HEIGHT_SIZE] forKey:NSFontAttributeName];
            CGSize size = [root_demo_test boundingRectWithSize:CGSizeMake(MAXFLOAT, 40*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
  

    
    UIImageView *demoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width/2+size.width/2, 317*HEIGHT_SIZE+sizeH+90*HEIGHT_SIZE+20*HEIGHT_SIZE-2*HEIGHT_SIZE, 16*NOW_SIZE, 5*HEIGHT_SIZE)];
    demoImageView.image = IMAGE(@"icon_jiantou.png");
    demoImageView.userInteractionEnabled = YES;
    [_scrollView addSubview:demoImageView];
    
    
    LoginButton *loginBtn = [[LoginButton alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 315*HEIGHT_SIZE+sizeH-H_down, SCREEN_Width - 80*NOW_SIZE, 35*HEIGHT_SIZE)];
 loginBtn.backgroundColor = [UIColor colorWithRed:149/255.0f green:226/255.0f blue:98/255.0f alpha:1];
    
    [_scrollView addSubview:loginBtn];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [loginBtn setTitle:root_log_in forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(PresentCtrl:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    NSLocale *currentLocale = [NSLocale currentLocale];
//    NSString *countryCode1 = [currentLocale objectForKey:NSLocaleCountryCode];
    
    if ([_languageValue isEqualToString:@"0"]) {
        UIButton *quickRegister =  [UIButton buttonWithType:UIButtonTypeCustom];
        quickRegister.frame=CGRectMake(40*NOW_SIZE,315*HEIGHT_SIZE+sizeH+72*HEIGHT_SIZE-H_down, SCREEN_Width - 80*NOW_SIZE, 35*HEIGHT_SIZE);
        [quickRegister.layer setMasksToBounds:YES];
        [quickRegister.layer setCornerRadius:20.0];
        //UIImage *quickM=IMAGE(@"icon_yijianjianzhan.png");
        UIImage *quickM=[self changeAlphaOfImageWith:0.9 withImage:IMAGE(@"icon_yijianjianzhan.png")];
        UIImage *quickM2=[self changeAlphaOfImageWith:0.5 withImage:IMAGE(@"icon_yijianjianzhan.png")];
        [quickRegister setBackgroundImage:quickM forState:UIControlStateNormal];
        [quickRegister setBackgroundImage:quickM2 forState:UIControlStateSelected];
        [quickRegister setBackgroundImage:quickM2 forState:UIControlStateHighlighted];
        quickRegister.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
        [quickRegister setTitle:root_yijian_jianzhan forState:UIControlStateNormal];
        [quickRegister addTarget:self action:@selector(goQuickRegister) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:quickRegister];
    }
    
 
    
}

-(void)goQuickRegister{
    quickRegisterViewController *registerRoot=[[quickRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerRoot animated:YES];
}

-(UIImage *)changeAlphaOfImageWith:(CGFloat)alpha withImage:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_userTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
        [_userTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [_userTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
}
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}


-(void)forget2{
  
    forgetOneViewController *registerRoot=[[forgetOneViewController alloc]init];
    

    
    [self.navigationController pushViewController:registerRoot animated:YES];
    
}



-(void)demoTest{
NSLog(@"体验馆");
    
    
    _userTextField=[[UITextField alloc]init];
    _loginUserName=Demo_Name;
    _pwdTextField=[[UITextField alloc]init];
   _loginUserPassword=Demo_password;
    
     [[NSUserDefaults standardUserDefaults] setObject:@"isDemo" forKey:@"isDemo"];
    
       _getServerAddressNum=0;
    [self getDemoData];
  
    
}

-(void)getDemoData{
    
       _getServerAddressNum++;
    
    NSString *serverInitAddress;
    if ([_languageValue isEqualToString:@"0"]) {
        serverInitAddress=HEAD_URL_Demo_CN;
    }else{
        serverInitAddress=HEAD_URL_Demo;
    }
    
    if (_getServerAddressNum==2) {
        if ([serverInitAddress isEqualToString:HEAD_URL_Demo_CN]) {
            serverInitAddress=HEAD_URL_Demo;
        }else if ([serverInitAddress isEqualToString:HEAD_URL_Demo]){
            serverInitAddress=HEAD_URL_Demo_CN;
        }
    }
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:serverInitAddress paramars:@{@"language":_languageValue} paramarsSite:@"/newLoginAPI.do?op=getServerUrlList" sucessBlock:^(id content) {
         [self hideProgressView];
        NSLog(@"getServerUrlList: %@", content);
        if (content) {
            
            _demoArray=[NSMutableDictionary dictionaryWithDictionary:content];
            
            if(_demoArray.count>0){
                AddressPickView *addressPickView1 = [AddressPickView shareInstance];
                addressPickView1.provinceArray=[NSMutableArray arrayWithArray:[_demoArray allKeys]];
                [self.view addSubview:addressPickView1];
                addressPickView1.block = ^(NSString *province){
                    // [self.dataDic setObject:city forKey:@"regCountry"];
                    // [self.dataDic setObject:town forKey:@"regCity"];
                    _serverDemoAddress = [_demoArray objectForKey:[NSString stringWithFormat:@"%@",province]] ;
                    
                    NSString *server2=@"http://";
                    NSString *server=[NSString stringWithFormat:@"%@%@",server2,_serverDemoAddress];
                    
                      [[UserInfo defaultUserInfo] setServer:server];
                    
                     [self netRequest];
                    
                };
            }else{
                   [self hideProgressView];
                
                if (_getServerAddressNum==1) {
                    [self getDemoData];
                }else{
                    [self showToastViewWithTitle:root_Networking];
                    return;
                }
  
            }
      
        }else{
            [self hideProgressView];
            if (_getServerAddressNum==1) {
                [self getDemoData];
            }else{
                [self showToastViewWithTitle:root_Networking];
                return;
            }
            
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        if (_getServerAddressNum==1) {
            [self getDemoData];
        }else{
            [self showToastViewWithTitle:root_Networking];
            return;
        }
    }];


}


-(void)tapLable2{
    NSLog(@"注册");

        countryViewController *registerRoot=[[countryViewController alloc]init];
        [self.navigationController pushViewController:registerRoot animated:YES];

}


- (NSString *)MD5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        NSString *tStr = [NSString stringWithFormat:@"%x", digest[i]];
        if (tStr.length == 1) {
            [result appendString:@"c"];
        }
        [result appendFormat:@"%@", tStr];
    }
    return result;
}



//模拟网络访问
- (void)PresentCtrl:(LoginButton *)loginBtn {
    
    typeof(self) __weak weak = self;
    //模拟网络访问
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weak loginBtnAction:loginBtn];
    });
}
//判断登录
- (void)loginBtnAction:(LoginButton *)loginBtn {
   
    
    if (_userTextField.text == nil || _userTextField.text == NULL || [_userTextField.text isEqualToString:@""]) {//判断用户名为空
        //按钮动画还原
        [loginBtn ErrorRevertAnimationCompletion:nil];
        //延迟调用弹出提示框方法
        [self performSelector:@selector(userAlertAction) withObject:nil afterDelay:1.0];
    }else if (_pwdTextField.text == nil || _pwdTextField.text == NULL || [_pwdTextField.text isEqualToString:@""]) {//判断密码为空或者不正确
        //按钮动画还原
        [loginBtn ErrorRevertAnimationCompletion:nil];
        //延迟调用弹出提示框方法
        [self performSelector:@selector(passWordAlertAction) withObject:nil afterDelay:1.0];
    }else {
        //用户名和密码输入正确跳转页面
        [loginBtn ExitAnimationCompletion:^{
            
            _loginUserName=_userTextField.text ;
            _loginUserPassword=_pwdTextField.text;
            
          [self getOSSnet];
  
      //      _getServerAddressNum=0;
      //    [self netServerInit];
         
        }];
    }
}


-(void)netRequest{

//    NSString *Username=[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
//    [BaseRequest getAppError:@"test" useName:Username];
    
    
    [self showProgressView];
    [BaseRequest requestWithMethod:HEAD_URL paramars:@{@"userName":_loginUserName, @"password":[self MD5:_loginUserPassword]} paramarsSite:@"/newLoginAPI.do" sucessBlock:^(id content) {
     [self hideProgressView];
      NSLog(@"loginIn:%@",content);
        if (content) {
            if ([content[@"success"] integerValue] == 0) {
                //登陆失败
                if ([content[@"msg"] integerValue] == 501) {
                    [self showAlertViewWithTitle:nil message:root_yongHuMing_mima_weikong cancelButtonTitle:root_OK];

                }
                if ([content[@"msg"] integerValue] ==502) {
                        [self showAlertViewWithTitle:nil message:root_yongHuMing_mima_cuowu cancelButtonTitle:root_OK];

                }
                if ([content[@"msg"] integerValue] ==503) {
                       [self showAlertViewWithTitle:nil message:root_fuWuQi_cuoWu cancelButtonTitle:root_OK];

                }
                
                if (!_scrollView) {
                        [self addSubViews];
                }
             
                
            } else {
                
                           self.dataSource = [NSDictionary dictionaryWithDictionary:content];
                _userNameGet=_dataSource[@"user"][@"accountName"];
                
                _adNumber=content[@"app_code"];
                
              
                
                NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
                
                NSString *reUsername=[ud objectForKey:@"userName"];
               
                if (reUsername==nil || reUsername==NULL||([reUsername isEqual:@""] )) {
                
                      [self setAlias];
                }
                
                //登陆成功
                
                
                
                [[UserInfo defaultUserInfo] setUserPassword:_pwdTextField.text];
                [[UserInfo defaultUserInfo] setUserName:_userNameGet];
                
     
                
                if ([_dataSource[@"user"][@"rightlevel"] integerValue]==2) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"isDemo" forKey:@"isDemo"];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:@"isNotDemo" forKey:@"isDemo"];
                }

                
                NSString *counrtyName=_dataSource[@"user"][@"counrty"];
                  NSString *timeZoneNum=_dataSource[@"user"][@"timeZone"];
                [[NSUserDefaults standardUserDefaults] setObject:counrtyName forKey:@"counrtyName"];
                [[NSUserDefaults standardUserDefaults] setObject:timeZoneNum forKey:@"timeZoneNum"];
                
          [[NSUserDefaults standardUserDefaults] setObject:@"S" forKey:@"LoginType"];
                [[UserInfo defaultUserInfo] setTelNumber:_dataSource[@"user"][@"phoneNum"]];
                [[UserInfo defaultUserInfo] setUserID:_dataSource[@"user"][@"id"]];
                [[UserInfo defaultUserInfo] setEmail:_dataSource[@"user"][@"email"]];
                   [[UserInfo defaultUserInfo] setAgentCode:_dataSource[@"user"][@"agentCode"]];
                
                NSString *ID=[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
                NSLog(@"ID=%@",ID);
                
              
                NSString *serviceBool=_dataSource[@"service"];
                if ([serviceBool isEqualToString:@"0"]||[serviceBool isEqualToString:@""]) {
                      [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"serviceBool"];
                }else if ([serviceBool isEqualToString:@"1"]){
                  [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"serviceBool"];
                }
                
                
         
             [self didPresentControllerButtonTouch];
                
            }
        }
        
    } failure:^(NSError *error) {
         [self didPresentControllerButtonTouch];
            [self showToastViewWithTitle:root_Networking];

    }];

}


-(void)getOSSnet{
   [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL_Demo paramars:@{@"userName":_loginUserName, @"userPassword":[self MD5:_loginUserPassword]} paramarsSite:@"/api/v1/login/userLogin" sucessBlock:^(id content) {
        [self hideProgressView];
       
        if (content) {
         id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
             NSLog(@"OSSloginIn:%@",jsonObj);
         
            if ([jsonObj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *allDic=[NSDictionary dictionaryWithDictionary:jsonObj];
                if ([allDic[@"result"] intValue]==1) {
                    if ([allDic.allKeys containsObject:@"obj"]) {
                        NSDictionary *objDic=[NSDictionary dictionaryWithDictionary:allDic[@"obj"]];
                        if ([objDic.allKeys containsObject:@"userType"]) {
                            NSString *userType=[NSString stringWithFormat:@"%@",[objDic objectForKey:@"userType"]];
                            if ([userType isEqualToString:@"0"]) {
                                NSString *server1=[NSString stringWithFormat:@"%@",[objDic objectForKey:@"userServerUrl"]];
                                NSString *server2=@"http://";
                                NSString *serverAdress=[NSString stringWithFormat:@"%@%@",server2,server1];
                                [[UserInfo defaultUserInfo] setServer:serverAdress];
                                
                                
                                
                                [self netRequest];
                                
                            }else{
                                if ([objDic.allKeys containsObject:@"ossServerUrl"]) {
                                    NSString *server1=[NSString stringWithFormat:@"%@",[objDic objectForKey:@"ossServerUrl"]];
                                    NSString *server2=@"http://";
                                    NSString *serverAdress=[NSString stringWithFormat:@"%@%@",server2,server1];
                                    [[UserInfo defaultUserInfo] setOSSserver:serverAdress];
                                }
                                NSMutableArray *serverListArray=[NSMutableArray array];
                                if ([objDic.allKeys containsObject:@"serverList"]) {
                                    [serverListArray addObjectsFromArray:[objDic objectForKey:@"serverList"]];
                                }
                                
                                NSString *PhoneNum;
                                if ([objDic.allKeys containsObject:@"user"]) {
                                    PhoneNum=objDic[@"user"][@"phone"];
                                }
                                [[NSUserDefaults standardUserDefaults] setObject:@"O" forKey:@"LoginType"];
                                
                                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",objDic[@"user"][@"role"]] forKey:@"roleNum"];
                                
                                
                                if ([_OssFirst isEqualToString:@"N"]) {
                                    ossFistVC *OSSView=[[ossFistVC alloc]init];
                                    OSSView.serverListArray=[NSMutableArray arrayWithArray:serverListArray];
                                    [self.navigationController pushViewController:OSSView animated:NO];
                                }else{
                                    OssMessageViewController *OSSView=[[OssMessageViewController alloc]init];
                                    OSSView.serverListArray=[NSMutableArray arrayWithArray:serverListArray];
                                    OSSView.phoneNum=PhoneNum;
                                    OSSView.OssName=_loginUserName;
                                    OSSView.OssPassword=_loginUserPassword;
                                    [self.navigationController pushViewController:OSSView animated:NO];
                                }
                                
                                
                                
                            }
                            
                        }
                        
                    }
                } else if ([allDic[@"result"] intValue]==0) {
                     [self showToastViewWithTitle:root_Networking];
                }else if ([allDic[@"result"] intValue]==4) {
                    [self showToastViewWithTitle:root_WO_yonghu_bucunzai];
                }else if ([allDic[@"result"] intValue]==5) {
                    [self showToastViewWithTitle:root_yongHuMing_mima_cuowu];
                }else{
                    _getServerAddressNum=0;
                    [self netServerInit];
                }
  
            }
            
            
            
            
        }else{
            _getServerAddressNum=0;
            [self netServerInit];
            [self hideProgressView];
        }
        
    } failure:^(NSError *error) {
  
        _getServerAddressNum=0;
        [self netServerInit];
          [self hideProgressView];
   
        
    }];

}






-(void)setAlias{
    NSString *AliasName=_userNameGet;
    
  //  NSString *AliasName=_userTextField.text;
    [JPUSHService setTags:nil alias:AliasName fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
        NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
    }];
}

-(void)netServerInit{
    
    _getServerAddressNum++;
    
    NSString *serverInitAddress;
    if ([_languageValue isEqualToString:@"0"]) {
        serverInitAddress=HEAD_URL_Demo_CN;
    }else{
        serverInitAddress=HEAD_URL_Demo;
    }
    
    if (_getServerAddressNum==2) {
        if ([serverInitAddress isEqualToString:HEAD_URL_Demo_CN]) {
            serverInitAddress=HEAD_URL_Demo;
        }else if ([serverInitAddress isEqualToString:HEAD_URL_Demo]){
            serverInitAddress=HEAD_URL_Demo_CN;
        }
    }
    
     NSString *userName=_loginUserName;
       [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:serverInitAddress paramars:@{@"userName":userName} paramarsSite:@"/newLoginAPI.do?op=getUserServerUrl" sucessBlock:^(id content) {
           [self hideProgressView];
        NSLog(@"getUserServerUrl: %@", content);
        if (content) {
            if ([content[@"success"]intValue]==1) {
                NSString *server1=content[@"msg"];
                NSString *server2=@"http://";
                NSString *server=[NSString stringWithFormat:@"%@%@",server2,server1];
                [[UserInfo defaultUserInfo] setServer:server];
                         [self netRequest];
            }else{
                if (_getServerAddressNum==1) {
                    [self netServerInit];
                }else{
                    if ([_languageValue isEqualToString:@"0"]) {
                              [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo_CN];
                    }else{
                        [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
                    }
                             [self netRequest];
                }
          
            }
        }else{
            
            if (_getServerAddressNum==1) {
                [self netServerInit];
            }else{
                if ([_languageValue isEqualToString:@"0"]) {
                    [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo_CN];
                }else{
                    [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
                }
                [self netRequest];
            }

        }
        
    } failure:^(NSError *error) {
        if (_getServerAddressNum==1) {
            [self netServerInit];
        }else{
            [self showToastViewWithTitle:root_Networking];
        }
       
        
    }];
    
    
}



//弹出输入用户提示框方法
- (void)userAlertAction {
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:root_Alet_user message:root_Alet_user_messge preferredStyle:UIAlertControllerStyleAlert];
  
    UIAlertAction *btnAction = [UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCtrl addAction:btnAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}
//弹出输入密码提示框方法
- (void)passWordAlertAction {
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:root_Alet_user message:root_Alet_user_pwd preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *btnAction = [UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCtrl addAction:btnAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

    //登录成功条跳转的方法
    - (void)didPresentControllerButtonTouch {
        
        NSMutableArray *stationID1=_dataSource[@"data"];
        NSMutableArray *stationID=[NSMutableArray array];
        if (stationID1.count>0) {
        for(int i=0;i<stationID1.count;i++){
         NSString *a=stationID1[i][@"plantId"];
            [stationID addObject:a];
        }
        }
        NSMutableArray *stationName1=_dataSource[@"data"];
        NSMutableArray *stationName=[NSMutableArray array];
        if (stationID1.count>0) {
        for(int i=0;i<stationID1.count;i++){
            NSString *a=stationName1[i][@"plantName"];
            [stationName addObject:a];
        }
        }

        findViewController *findVc=[[findViewController alloc]init];
        findVc.title=root_service;
        
         LZPageViewController *energyVc = [[LZPageViewController alloc] initWithTitles:@[root_energy,root_energy_Smart,] controllersClass:@[[energyViewController class],[energyDemo class]]];
       // energyViewController *energyVc=[[energyViewController alloc]init];
          // energyVc.title=@"能源分析";
        energyVc.type=@"1";
        
        deviceViewController *deviceVc=[[deviceViewController alloc]initWithDataDict:stationID stationName:stationName];
        deviceVc.adNumber=_adNumber;
        
        meViewController *meVc=[[meViewController alloc]init];
         meVc.title=root_ME;
        
        UINavigationController *Vc3=[[UINavigationController alloc]initWithRootViewController:findVc];
        UINavigationController *Vc2=[[UINavigationController alloc]initWithRootViewController:energyVc];
        UINavigationController *Vc1=[[UINavigationController alloc]initWithRootViewController:deviceVc];
        UINavigationController *Vc4=[[UINavigationController alloc]initWithRootViewController:meVc];
        //Vc1.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
        Vc1.title=root_device;
        Vc2.title=root_energy_title;
        Vc3.title=root_service;
        Vc4.title=root_ME;
        Vc1.tabBarItem.image=[UIImage imageNamed:@"equipment@2x.png"];
        Vc1.tabBarItem.selectedImage=[[UIImage imageNamed:@"equipmentV@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        Vc2.tabBarItem.image=[UIImage imageNamed:@"energyTab@2x.png"];
        Vc2.tabBarItem.selectedImage=[[UIImage imageNamed:@"energy2@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        Vc3.tabBarItem.image=[UIImage imageNamed:@"server@2x.png"];
        Vc3.tabBarItem.selectedImage=[[UIImage imageNamed:@"serverV@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        Vc4.tabBarItem.image=[UIImage imageNamed:@"mine@2x.png"];
        Vc4.tabBarItem.selectedImage=[[UIImage imageNamed:@"mine2v@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [Vc1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [Vc1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                MainColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [Vc2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [Vc2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                MainColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [Vc3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [Vc3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                MainColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [Vc4.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [Vc4.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                MainColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        
        //Vc1.tabBarController.tabBar.tintColor = MainColor;
        
        NSArray *controllers=[NSArray arrayWithObjects:Vc1,Vc2,Vc3,Vc4,nil];
        _tabbar=[[UITabBarController alloc]init];
        _tabbar.viewControllers=controllers;
       
        

        [self presentViewController:_tabbar animated:YES completion:nil];
    }



    - (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [[StTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isBOOL:true];
}
    
    - (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
        
        return [[StTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isBOOL:false];
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
