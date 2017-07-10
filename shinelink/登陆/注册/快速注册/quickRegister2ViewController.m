//
//  quickRegister2ViewController.m
//  ShinePhone
//
//  Created by sky on 17/2/21.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "quickRegister2ViewController.h"
#import "AddDeviceViewController.h"
#import "MainViewController.h"
#import "loginViewController.h"
#import "protocol.h"

@interface quickRegister2ViewController ()
@property (nonatomic, strong)  UITextField *textField;
@property (nonatomic, strong)  UITextField *textField2;
@property (nonatomic, strong)  NSString *getCountry;
@property (nonatomic, strong)  NSString *getZone;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) NSString *setDeviceName;
@property(nonatomic,strong)NSString *userEnable;
@property (nonatomic) int getServerAddressNum;

@end

@implementation quickRegister2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    self.title=@"一键注册";
    _dataDic=[NSMutableDictionary new];
    _userEnable=@"ok";
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
     [self initUI];
    [self getInfo];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_textField resignFirstResponder];
    [_textField2 resignFirstResponder];
}

-(void)getInfo{
    _getCountry=@"initC";
    _getZone=@"initZ";
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode1 = [currentLocale objectForKey:NSLocaleCountryCode];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"englishCountryJson" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *countryArray1=[NSArray arrayWithArray:result[@"data"]];
    for (int i=0; i<countryArray1.count; i++) {
        if ([countryCode1 isEqualToString:countryArray1[i][@"countryCode"]]) {
            _getCountry=countryArray1[i][@"countryName"];
            _getZone=countryArray1[i][@"zone"];
        }
    }
    
    if ([_getCountry isEqualToString:@"initC"]) {
        _getCountry=@"Other";
         _getZone=@"1";
    }
    
}

-(void)initUI{

    float H1=20*HEIGHT_SIZE;float H2=10*HEIGHT_SIZE;
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE,70*HEIGHT_SIZE-H1,220*NOW_SIZE, 25*HEIGHT_SIZE)];
    _textField.placeholder =root_Enter_phone_number;
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
    _textField.textAlignment = NSTextAlignmentCenter;
    [_textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_textField];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(50*NOW_SIZE,95*HEIGHT_SIZE-H1,220*NOW_SIZE, 1*HEIGHT_SIZE)];
    line.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line];
    
    
    UILabel *alertLable= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE,102*HEIGHT_SIZE-H1,300*NOW_SIZE, 15*HEIGHT_SIZE)];
      NSString *alertText1=root_budai_guojia_daima;
    NSString *alertText=[NSString stringWithFormat:@"(%@)",alertText1];
    alertLable.text=alertText;
    alertLable.textColor=COLOR(255, 255, 255, 0.5);
    alertLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    alertLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:alertLable];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE,128*HEIGHT_SIZE-H1+H2,220*NOW_SIZE, 25*HEIGHT_SIZE)];
    _textField2.placeholder =root_Alet_user_pwd;
    _textField2.textColor = [UIColor whiteColor];
    _textField2.tintColor = [UIColor whiteColor];
    _textField2.textAlignment = NSTextAlignmentCenter;
    [_textField2 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField2 setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_textField2];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(50*NOW_SIZE,153*HEIGHT_SIZE-H1+H2,220*NOW_SIZE, 1*HEIGHT_SIZE)];
    line1.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line1];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,215*HEIGHT_SIZE+H2, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:20.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_register forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(registerFrist1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
 
    UIButton *selectButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [selectButton setBackgroundImage:IMAGE(@"未打勾.png") forState:UIControlStateSelected];
    [selectButton setBackgroundImage:IMAGE(@"打勾.png") forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(selectGo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectButton];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
    CGSize size = [root_yonghu_xieyi boundingRectWithSize:CGSizeMake(MAXFLOAT, 16*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    UILabel *userOk= [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_Width-size.width)/2,156*HEIGHT_SIZE-H1+20*HEIGHT_SIZE+H2, size.width, 16*HEIGHT_SIZE)];
    userOk.text=root_yonghu_xieyi;
    userOk.textColor=[UIColor whiteColor];
    userOk.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    userOk.textAlignment = NSTextAlignmentCenter;
    userOk.userInteractionEnabled=YES;
    UITapGestureRecognizer * demo1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GoUsert)];
    [userOk addGestureRecognizer:demo1];
    [self.view addSubview:userOk];
             [userOk sizeToFit];
    
      selectButton.frame=CGRectMake((SCREEN_Width-size.width)/2-22*NOW_SIZE,156*HEIGHT_SIZE-H1+21*HEIGHT_SIZE+H2, 16*HEIGHT_SIZE, 16*HEIGHT_SIZE);
    
    UIView *userView= [[UIView alloc] initWithFrame:CGRectMake((SCREEN_Width-size.width)/2,156*HEIGHT_SIZE-H1+20*HEIGHT_SIZE+20*HEIGHT_SIZE+H2, size.width, 1*HEIGHT_SIZE)];
    userView.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:userView];
    
}

-(void)GoUsert{
    protocol *go=[[protocol alloc]init];
    [self.navigationController pushViewController:go animated:YES];
}

-(void)selectGo:(UIButton*)sender{
    
    if (sender.selected) {
        [sender setSelected:NO];
        _userEnable=@"ok";
        [sender setImage:[UIImage imageNamed:@"没打勾.png"] forState:UIControlStateHighlighted];
        [sender setImage:[UIImage imageNamed:@"打勾.png"] forState:UIControlStateNormal];
 
    }else{
        [sender setSelected:YES];
        
        _userEnable=@"no";

        [sender setImage:[UIImage imageNamed:@"打勾.png"] forState:UIControlStateHighlighted];
        [sender setImage:[UIImage imageNamed:@"没打勾.png"] forState:UIControlStateNormal];
    }
        
}

-(void)registerFrist1{
_getServerAddressNum=0;
    
    [self registerFrist];
}


-(void)registerFrist{
    
    _getServerAddressNum++;
    
    NSString *serverInitAddress;
    if ([self.languageType isEqualToString:@"0"]) {
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
    [BaseRequest requestWithMethodResponseJsonByGet:serverInitAddress paramars:@{@"country":_getCountry} paramarsSite:@"/newLoginAPI.do?op=getServerUrl" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getServerUrl: %@", content);
        if (content) {
            if ([content[@"success"]intValue]==1) {
                NSString *server1=content[@"server"];
                NSString *server2=@"http://";
                NSString *server=[NSString stringWithFormat:@"%@%@",server2,server1];
                [[UserInfo defaultUserInfo] setServer:server];
                
                [self PresentGo];
            }else{
                if (_getServerAddressNum==1) {
                    [self registerFrist];
                }else{
                    [self showToastViewWithTitle:root_Networking];
                }
            }
  
        }else{
            if (_getServerAddressNum==1) {
                [self registerFrist];
            }else{
                [self showToastViewWithTitle:root_Networking];
            }

        }
        
    } failure:^(NSError *error) {
           [self hideProgressView];
        if (_getServerAddressNum==1) {
            [self registerFrist];
        }else{
            [self showToastViewWithTitle:root_Networking];
        }

    }];


}


-(void)PresentGo{
    [self getLanguage];

    
    NSArray *array=[[NSArray alloc]initWithObjects:root_Enter_your_username,root_Enter_your_pwd,nil];
    
        if ([[_textField text] isEqual:@""]) {
            [self showToastViewWithTitle:array[0]];
            return;
        }
    if ([[_textField2 text] isEqual:@""]) {
        [self showToastViewWithTitle:array[1]];
        return;
    }
    if (![_userEnable isEqualToString:@"ok"]) {
        [self showToastViewWithTitle:root_xuanze_yonghu_xieyi];
        return;
    }
    
    
    NSString *UserNAME=[_textField text];
    
    for (int i=0; i<UserNAME.length; i++) {
       NSString *temp = [UserNAME substringWithRange:NSMakeRange(i, 1)];
        NSString*T2=@"0123456789";
        
        if (![T2 containsString:temp]) {
             [self showToastViewWithTitle:root_shoujihao_geshi_cuowu];
            return;
        }
        
    }
    
    if (UserNAME.length!=11) {
        [self showToastViewWithTitle:root_shuru_shiyiwei_shoujihao];
        return;
    }
    
    [_dataDic setObject:[_textField text] forKey:@"regUserName"];
    [_dataDic setObject:[_textField2 text] forKey:@"regPassword"];
    
    
    if (_SnCode==nil) {
           [_dataDic setObject:@"" forKey:@"regDataLoggerNo"];
    }else{
    [_dataDic setObject:_SnCode forKey:@"regDataLoggerNo"];
    }
    if (_SnCheck==nil) {
        [_dataDic setObject:@"" forKey:@"regValidateCode"];
    }else{
     [_dataDic setObject:_SnCheck forKey:@"regValidateCode"];
    }
    
        [_dataDic setObject:_getCountry forKey:@"regCountry"];
    
       NSDictionary *userCheck=[NSDictionary dictionaryWithObject:[_textField text] forKey:@"regUserName"];
    [self showProgressView];
    [BaseRequest requestWithMethod:HEAD_URL paramars:userCheck paramarsSite:@"/newRegisterAPI.do?op=checkUserExist" sucessBlock:^(id content) {
        NSLog(@"checkUserExist: %@", content);
        [self hideProgressView];
        if (content) {
            if ([content[@"success"] integerValue] == 0) {
                  [self showProgressView];
                [BaseRequest requestWithMethod:HEAD_URL paramars:_dataDic paramarsSite:@"/newRegisterAPI.do?op=mobileRegister" sucessBlock:^(id content) {
                    NSLog(@"creatAccount: %@", content);
                    [self hideProgressView];
                    
                    if (content) {
                        if ([content[@"success"] integerValue] == 0) {
                            //注册失败
                            if ([content[@"msg"] isEqual:@"501"]) {
                                [self showAlertViewWithTitle:root_zhuce_shibai message:root_chaoChu_shuLiang cancelButtonTitle:root_Yes];
                            }else if ([content[@"msg"] isEqual:@"506"]){
                                
                                [self showAlertViewWithTitle:root_zhuce_shibai message:root_caijiqi_cuowu cancelButtonTitle:root_Yes];
                            }else if ([content[@"msg"] isEqual:@"503"]){
                                
                                [self showAlertViewWithTitle:root_zhuce_shibai message:root_yongHu_yi_shiYong cancelButtonTitle:root_Yes];
                                [self.navigationController popViewControllerAnimated:NO];
                            }else if ([content[@"msg"] isEqual:@"604"]){
                                
                                [self showAlertViewWithTitle:root_zhuce_shibai message:root_dailishang_cuowu cancelButtonTitle:root_Yes];
                                [self.navigationController popViewControllerAnimated:NO];
                            }else if ([content[@"msg"] isEqual:@"605"]){
                                
                                [self showAlertViewWithTitle:root_zhuce_shibai message:root_xuliehao_yijing_cunzai cancelButtonTitle:root_Yes];
                            }else if ([content[@"msg"] isEqual:@"606"]||[content[@"msg"] isEqual:@"607"]||[content[@"msg"] isEqual:@"608"]||[content[@"msg"] isEqual:@"609"]||[content[@"msg"] isEqual:@"602"]||[content[@"msg"] isEqual:@"502"]||[content[@"msg"] isEqual:@"603"]){
                                
                                NSString *failName=[NSString stringWithFormat:@"%@(%@)",root_zhuce_shibai,content[@"msg"]];
                                if ([[_dataDic objectForKey:@"regCountry"] isEqualToString:@"China"]) {
                                    
                                    [self showAlertViewWithTitle:failName message:root_fuwuqi_cuowu_tishi_2 cancelButtonTitle:root_Yes];
                                }else{
                                    [self showAlertViewWithTitle:failName message:root_fuwuqi_cuowu_tishi cancelButtonTitle:root_Yes];
                                }
                                
                                [BaseRequest getAppError:failName useName:[_dataDic objectForKey:@"regUserName"]];
                                
                            }else if ([content[@"msg"] isEqual:@"701"]){
                                
                                [self showAlertViewWithTitle:root_zhuce_shibai message:root_caijiqi_cuowu_tishi cancelButtonTitle:root_Yes];
                            }else{
                                
                                NSString *errorMsg=[NSString stringWithFormat:@"RegisterError%@",content[@"msg"]];
                                [BaseRequest getAppError:errorMsg useName:[_dataDic objectForKey:@"regUserName"]];
                                
                            }
                            
                        }
                        else {
                         
                            _setDeviceName=content[@"datalogType"];
                            //注册成功
                            [self succeedRegister];
                            [self showAlertViewWithTitle:nil message:root_zhuCe_chengGong  cancelButtonTitle:root_Yes];
                            
                        }
                    }
                    
                } failure:^(NSError *error) {
                    [self hideProgressView];
                    [self showToastViewWithTitle:root_Networking];
                }];
                
                
            }else{
                [self showAlertViewWithTitle:nil message:root_yongHu_yi_shiYong cancelButtonTitle:root_Yes];
              //  [self.navigationController popViewControllerAnimated:NO];
            }
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }
     
     ];


}


-(void)succeedRegister{
    NSString *user=[_dataDic objectForKey:@"regUserName"];
    NSString *pwd=[_dataDic objectForKey:@"regPassword"];
    
    [[UserInfo defaultUserInfo] setUserName:user];
    [[UserInfo defaultUserInfo] setUserPassword:pwd];
      [[NSUserDefaults standardUserDefaults] setObject:@"S" forKey:@"LoginType"];
    
    
    NSString *demoName1=@"ShineWIFI";           //新wifi
    NSString *demoName2=@"ShineLan";            //旧wifi
    NSString *demoName3=@"ShineWifiBox";          //旧wifi
    
    BOOL result1 = [_setDeviceName compare:demoName1 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
    BOOL result2 = [_setDeviceName compare:demoName2 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
    BOOL result3 = [_setDeviceName compare:demoName3 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
    
    if (result1) {
        
        AddDeviceViewController *rootView = [[AddDeviceViewController alloc]init];
        rootView.LogType=@"1";
        rootView.SnString=_SnCode;
        rootView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:rootView animated:YES];
    }else if (result2){
        [self showAlertViewWithTitle:nil message:root_shuaxin_liebiao cancelButtonTitle:root_Yes];
        MainViewController *rootView = [[MainViewController alloc]init];
        [self.navigationController pushViewController:rootView animated:YES];
        
    }else if (result3){
        [self showAlertViewWithTitle:nil message:root_shuaxin_liebiao cancelButtonTitle:root_Yes];
        MainViewController *rootView = [[MainViewController alloc]init];
        [self.navigationController pushViewController:rootView animated:YES];
        
    }else{
        
        [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
        
        loginViewController *goView=[[loginViewController alloc]init];
        goView.LogType=@"1";
        [self.navigationController pushViewController:goView animated:NO];
    }
    
}


-(void)getLanguage{
    //获取本地语言
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *regLanguage = [languages objectAtIndex:0];

    if ([regLanguage hasPrefix:@"en"]) {
        [_dataDic setObject:@"en" forKey:@"regLanguage"];
    }else if ([regLanguage hasPrefix:@"zh-Hans"]){
        [_dataDic setObject:@"zh_cn" forKey:@"regLanguage"];
    }else if ([regLanguage hasPrefix:@"fr"]){
        [_dataDic setObject:@"fr" forKey:@"regLanguage"];
    }
    else if ([regLanguage hasPrefix:@"ja"]){
        [_dataDic setObject:@"ja" forKey:@"regLanguage"];
    }
    else if ([regLanguage hasPrefix:@"it"]){
        [_dataDic setObject:@"it" forKey:@"regLanguage"];
    }
    else if ([regLanguage hasPrefix:@"nl"]){
        [_dataDic setObject:@"ho" forKey:@"regLanguage"];
    }
    else if ([regLanguage hasPrefix:@"tr"]){
        [_dataDic setObject:@"tk" forKey:@"regLanguage"];
    }
    else if ([regLanguage hasPrefix:@"pl"]){
        [_dataDic setObject:@"pl" forKey:@"regLanguage"];
    }
    else if ([regLanguage hasPrefix:@"el"]){
        [_dataDic setObject:@"gk" forKey:@"regLanguage"];
    }
    else if ([regLanguage hasPrefix:@"de"]){
        [_dataDic setObject:@"gm" forKey:@"regLanguage"];
    }else{
        [_dataDic setObject:@"en" forKey:@"regLanguage"];
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
