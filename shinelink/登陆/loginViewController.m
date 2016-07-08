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

@interface loginViewController ()<UINavigationControllerDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
//@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registButton;
@property (nonatomic, strong) UILabel *registLable;
@property (nonatomic, strong) UILabel *forgetLable;
@property (nonatomic, strong) UILabel *demoLable;
@property (nonatomic, strong) NSDictionary *dataSource;
@property (nonatomic, strong) NSMutableDictionary *demoArray;
@property (nonatomic, strong) NSString *serverDemoAddress;

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
   
   // [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:17/255.0f green:183/255.0f blue:243/255.0f alpha:0]];
     [self.navigationController setNavigationBarHidden:YES];
    
 NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
   NSString *reUsername=[ud objectForKey:@"userName"];
   NSString *rePassword=[ud objectForKey:@"userPassword"];
 //  [self addSubViews];
    
   // NSString *reUsername=@"123";
    //NSString *rePassword=@"234";
    
    NSLog(@"reUsername=%@",reUsername);
    NSLog(@"rePassword=%@",rePassword);
    
    //NSString *isdemo=[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"];
    
    if (reUsername==nil || reUsername==NULL||([reUsername isEqual:@""] )) {
      //  [ [NSNotificationCenter defaultCenter]postNotificationName:@"reroadDemo" object:nil];
        
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
          [self performSelectorOnMainThread:@selector(netRequest) withObject:nil waitUntilDone:NO];
        //添加布局
    }
}




//添加布局
- (void)addSubViews {
    float sizeH=20*HEIGHT_SIZE;
    
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
    UIImageView *userBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 145*HEIGHT_SIZE+sizeH, SCREEN_Width - 80*NOW_SIZE, 45*HEIGHT_SIZE)];
    userBgImageView.userInteractionEnabled = YES;
    userBgImageView.image = IMAGE(@"name3.jpg");
    [_scrollView addSubview:userBgImageView];
    
    self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE, 0, CGRectGetWidth(userBgImageView.frame) - 50*NOW_SIZE, 45*HEIGHT_SIZE)];
    self.userTextField.placeholder = root_Alet_user_messge;
    self.userTextField.textColor = [UIColor whiteColor];
    self.userTextField.tintColor = [UIColor whiteColor];
    [self.userTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.userTextField setValue:[UIFont systemFontOfSize:13*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.userTextField.font = [UIFont systemFontOfSize:15*HEIGHT_SIZE];
    [userBgImageView addSubview:_userTextField];
    
    //密码
    UIImageView *pwdBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE,210*HEIGHT_SIZE+sizeH , SCREEN_Width - 80*NOW_SIZE, 45*HEIGHT_SIZE)];
    pwdBgImageView.image = IMAGE(@"pass3.jpg");
    pwdBgImageView.userInteractionEnabled = YES;
    [_scrollView addSubview:pwdBgImageView];
    
    self.pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE, 0, CGRectGetWidth(pwdBgImageView.frame) - 50*NOW_SIZE, 45*HEIGHT_SIZE)];
    self.pwdTextField.placeholder = root_Alet_user_pwd;
    self.pwdTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.pwdTextField.secureTextEntry = YES;
    self.pwdTextField.textColor = [UIColor whiteColor];
    self.pwdTextField.tintColor = [UIColor whiteColor];
    [self.pwdTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdTextField setValue:[UIFont systemFontOfSize:13*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.pwdTextField.font = [UIFont systemFontOfSize:15*HEIGHT_SIZE];
    [pwdBgImageView addSubview:_pwdTextField];
    
 
   
    self.forgetLable= [[UILabel alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 260*HEIGHT_SIZE+sizeH, 120*NOW_SIZE, 40*HEIGHT_SIZE)];
    self.forgetLable.text=root_forget_pwd;
     self.forgetLable.textColor=[UIColor whiteColor];
        self.forgetLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    self.forgetLable.textAlignment = NSTextAlignmentLeft;
     self.forgetLable.userInteractionEnabled=YES;
    UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forget2)];
    [self.forgetLable addGestureRecognizer:forget2];
    [_scrollView addSubview:self.forgetLable];
    
    
   _registLable= [[UILabel alloc] initWithFrame:CGRectMake(160*NOW_SIZE, 260*HEIGHT_SIZE+sizeH, 115*NOW_SIZE, 40*HEIGHT_SIZE)];
    self.registLable.text=root_register;
    self.registLable.textColor=[UIColor whiteColor];
    self.registLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    self.registLable.textAlignment = NSTextAlignmentRight;
    self.registLable.userInteractionEnabled=YES;
    UITapGestureRecognizer * forget1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLable2)];
    [self.registLable addGestureRecognizer:forget1];
    [_scrollView addSubview:self.registLable];
    
    _demoLable= [[UILabel alloc] initWithFrame:CGRectMake(100*NOW_SIZE, 310*HEIGHT_SIZE+sizeH+90*HEIGHT_SIZE, 120*NOW_SIZE, 40*HEIGHT_SIZE)];
    self.demoLable.text=root_demo_test;
    self.demoLable.textColor=COLOR(210, 210, 210, 1);
    self.demoLable.font = [UIFont systemFontOfSize:20*HEIGHT_SIZE];
    self.demoLable.textAlignment = NSTextAlignmentCenter;
    self.demoLable.userInteractionEnabled=YES;
    UITapGestureRecognizer * demo1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(demoTest)];
    [self.demoLable addGestureRecognizer:demo1];
    [_scrollView addSubview:self.demoLable];
    
    
    
    LoginButton *loginBtn = [[LoginButton alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 310*HEIGHT_SIZE+sizeH, SCREEN_Width - 80*NOW_SIZE, 45*HEIGHT_SIZE)];
    loginBtn.backgroundColor = [UIColor colorWithRed:149/255.0f green:226/255.0f blue:98/255.0f alpha:1];
    [_scrollView addSubview:loginBtn];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [loginBtn setTitle:root_log_in forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(PresentCtrl:) forControlEvents:UIControlEventTouchUpInside];
    
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
    forgetViewController *registerRoot=[[forgetViewController alloc]init];
    //[self presentViewController:registerRoot animated:YES completion:nil];
    
    [self.navigationController pushViewController:registerRoot animated:YES];
}

-(void)demoTest{
NSLog(@"体验馆");
    
    
    _userTextField=[[UITextField alloc]init];
    _userTextField.text=Demo_Name;
    _pwdTextField=[[UITextField alloc]init];
    _pwdTextField.text=Demo_password;
    
     [[NSUserDefaults standardUserDefaults] setObject:@"isDemo" forKey:@"isDemo"];
    
    [self getDemoData];
  
    
}

-(void)getDemoData{
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL_Demo paramars:@{@"admin":@"admin"} paramarsSite:@"/newLoginAPI.do?op=getServerUrlList" sucessBlock:^(id content) {
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
                [self showToastViewWithTitle:root_country_huoQu];
                return;
                
            }

            
            
            
        }else{
            [self hideProgressView];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];


}


-(void)tapLable2{
    NSLog(@"注册");
   // self.registLable.highlighted=YES;
   // self.registLable.highlightedTextColor=[UIColor whiteColor];
    countryViewController *registerRoot=[[countryViewController alloc]init];
    
    [self.navigationController pushViewController:registerRoot animated:NO];
    

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
            
           
            [self netServerInit];
         
        }];
    }
}

-(void)netRequest{

    [self showProgressView];
    [BaseRequest requestWithMethod:HEAD_URL paramars:@{@"userName":_userTextField.text, @"password":[self MD5:_pwdTextField.text]} paramarsSite:@"/newLoginAPI.do" sucessBlock:^(id content) {
     [self hideProgressView];
      NSLog(@"loginIn:%@",content);
        if (content) {
            if ([content[@"success"] integerValue] == 0) {
                //登陆失败
                if ([content[@"msg"] integerValue] == 501) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"User name or password is blank" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
                    [alertView show];
                }
                if ([content[@"msg"] integerValue] ==502) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"username password error" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
                    [alertView show];
                }
                if ([content[@"msg"] integerValue] ==503) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"server error" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
                    [alertView show];
                }
                
                if (!_scrollView) {
                        [self addSubViews];
                }
             
                
            } else {
                
                NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
                NSString *reUsername=[ud objectForKey:@"userName"];
               
                
                if (reUsername==nil || reUsername==NULL||([reUsername isEqual:@""] )) {
                
                      [self setAlias];
                }
                
                //登陆成功
                [[UserInfo defaultUserInfo] setUserPassword:_pwdTextField.text];
                [[UserInfo defaultUserInfo] setUserName:_userTextField.text];
                self.dataSource = [NSDictionary dictionaryWithDictionary:content];
                
                if ([_dataSource[@"user"][@"rightlevel"] integerValue]==2) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"isDemo" forKey:@"isDemo"];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:@"isNotDemo" forKey:@"isDemo"];
                }

                
                [[UserInfo defaultUserInfo] setTelNumber:_dataSource[@"user"][@"phoneNum"]];
                [[UserInfo defaultUserInfo] setUserID:_dataSource[@"user"][@"id"]];
                [[UserInfo defaultUserInfo] setEmail:_dataSource[@"user"][@"email"]];
                   [[UserInfo defaultUserInfo] setAgentCode:_dataSource[@"user"][@"agentCode"]];
                
                NSString *ID=[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
                NSLog(@"ID=%@",ID);
                
              
                
                //获取服务器
              //  [self netServerInit];
             [self didPresentControllerButtonTouch];
                
            }
        }
        
    } failure:^(NSError *error) {
         [self didPresentControllerButtonTouch];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //[self showToastViewWithTitle:root_Networking];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.labelText = @"Networking Timeout";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
    }];

}

-(void)setAlias{
    NSString *AliasName=_userTextField.text;
    
  //  NSString *AliasName=_userTextField.text;
    [JPUSHService setTags:nil alias:AliasName fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
        NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
    }];
}

-(void)netServerInit{
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"userName":_userTextField.text} paramarsSite:@"/newLoginAPI.do?op=getUserServerUrl" sucessBlock:^(id content) {
        
        NSLog(@"getUserServerUrl: %@", content);
        if (content) {
            if ([content[@"success"]intValue]==1) {
                NSString *server1=content[@"msg"];
                NSString *server2=@"http://";
                NSString *server=[NSString stringWithFormat:@"%@%@",server2,server1];
                [[UserInfo defaultUserInfo] setServer:server];
                         [self netRequest];
            }else{
                [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
                [self netRequest];
            }
        }else{
           [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
                 [self netRequest];
        }
        
    } failure:^(NSError *error) {
        [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];

              [self netRequest];
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
        meViewController *meVc=[[meViewController alloc]init];
         meVc.title=root_ME;
        
        UINavigationController *Vc3=[[UINavigationController alloc]initWithRootViewController:findVc];
        UINavigationController *Vc2=[[UINavigationController alloc]initWithRootViewController:energyVc];
        UINavigationController *Vc1=[[UINavigationController alloc]initWithRootViewController:deviceVc];
        UINavigationController *Vc4=[[UINavigationController alloc]initWithRootViewController:meVc];
        Vc1.title=root_device;
        Vc2.title=root_energy_title;
        Vc3.title=root_service;
        Vc4.title=root_ME;
        Vc1.tabBarItem.image=[UIImage imageNamed:@"equipment@2x.png"];
        Vc1.tabBarItem.selectedImage=[UIImage imageNamed:@"equipment@2x.png"];
        Vc2.tabBarItem.image=[UIImage imageNamed:@"energy@2x.png"];
        Vc2.tabBarItem.selectedImage=[UIImage imageNamed:@"energy@2x.png"];
        Vc3.tabBarItem.image=[UIImage imageNamed:@"server@2x.png"];
        Vc3.tabBarItem.selectedImage=[UIImage imageNamed:@"server@2x.png"];
        Vc4.tabBarItem.image=[UIImage imageNamed:@"mine@2x.png"];
        Vc4.tabBarItem.selectedImage=[UIImage imageNamed:@"mine@2x.png"];
        
        //Vc1.tabBarController.tabBar.selectedImageTintColor = MainColor;
        
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
