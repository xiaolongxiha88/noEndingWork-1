//
//  phoneRegisterViewController.m
//  ShinePhone
//
//  Created by sky on 17/2/14.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "phoneRegisterViewController.h"
#import "QCCountdownButton.h"
#import "phoneRegister2ViewController.h"
#import "changManeger.h"

@interface phoneRegisterViewController ()
 @property (nonatomic, strong)  UIImageView *imageView;
 @property (nonatomic, strong)  UITextField *textField;
@property (nonatomic, strong)  UITextField *textField0;
@property (nonatomic, strong)  UITextField *textField2;
@property(nonatomic,strong)UILabel *label2;
@property (nonatomic, strong)  NSMutableString *getPhone;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong)  NSString *getCheckNum;
@property (nonatomic, strong)  NSString *getPhoneNum;
@end

@implementation phoneRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *bgImage = IMAGE(@"bg.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
     self.view.backgroundColor=MainColor;
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:MainColor];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self getInfo];

}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_textField resignFirstResponder];
    [_textField0 resignFirstResponder];
     [_textField2 resignFirstResponder];
}


-(void)getInfo{
    _getPhone=[NSMutableString stringWithString:@"86"];

    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode1 = [currentLocale objectForKey:NSLocaleCountryCode];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"englishCountryJson" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *countryArray1=[NSArray arrayWithArray:result[@"data"]];
    for (int i=0; i<countryArray1.count; i++) {
        if ([countryCode1 isEqualToString:countryArray1[i][@"countryCode"]]) {
            _getPhone=countryArray1[i][@"phoneCode"];
        }
    }
 
    [self initUI];
}


-(void)initUI{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    _textField0 = [[UITextField alloc] initWithFrame:CGRectMake(30*NOW_SIZE,82*HEIGHT_SIZE,40*NOW_SIZE, 25*HEIGHT_SIZE)];
    _textField0.placeholder =_getPhone;
    _textField0.textColor = [UIColor whiteColor];
    _textField0.tintColor = [UIColor whiteColor];
    _textField0.textAlignment = NSTextAlignmentCenter;
    [_textField0 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField0 setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField0.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.view addSubview:_textField0];
    
    UIView *line0=[[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,108*HEIGHT_SIZE,40*NOW_SIZE, 1*HEIGHT_SIZE)];
    line0.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line0];
    
    UIView *line01=[[UIView alloc]initWithFrame:CGRectMake(75*NOW_SIZE,82*HEIGHT_SIZE,1*NOW_SIZE, 25*HEIGHT_SIZE)];
    line01.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line01];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(80*NOW_SIZE,82*HEIGHT_SIZE,155*NOW_SIZE, 25*HEIGHT_SIZE)];
    _textField.placeholder =root_Enter_phone_number;
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
      _textField.textAlignment = NSTextAlignmentCenter;
    [_textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
       [_textField setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    }else {
      [_textField setValue:[UIFont systemFontOfSize:8*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    }
  
    _textField.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
   [self.view addSubview:_textField];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(80*NOW_SIZE,108*HEIGHT_SIZE,155*NOW_SIZE, 1*HEIGHT_SIZE)];
    line.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(80*NOW_SIZE,130*HEIGHT_SIZE,155*NOW_SIZE, 25*HEIGHT_SIZE)];
    _textField2.placeholder =root_shuru_duanxin_jiaoyanma;
    _textField2.textColor = [UIColor whiteColor];
    _textField2.tintColor = [UIColor whiteColor];
    _textField2.textAlignment = NSTextAlignmentCenter;
    [_textField2 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        [_textField2 setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    }else {
        [_textField2 setValue:[UIFont systemFontOfSize:8*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    }
  
    _textField2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.view addSubview:_textField2];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(80*NOW_SIZE,156*HEIGHT_SIZE,155*NOW_SIZE, 1*HEIGHT_SIZE)];
    line1.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line1];
    
    QCCountdownButton *btn = [QCCountdownButton countdownButton];
    btn.title =root_fasong_yanzhengma;
    

    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
          [btn setFrame:CGRectMake(235*NOW_SIZE,80*HEIGHT_SIZE,70*NOW_SIZE, 29*HEIGHT_SIZE)];
            btn.titleLabelFont = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    }else {
         [btn setFrame:CGRectMake(217*NOW_SIZE,80*HEIGHT_SIZE,100*NOW_SIZE, 29*HEIGHT_SIZE)];
            btn.titleLabelFont = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    }
    
 
       btn.nomalBackgroundColor = COLOR(144, 195, 32, 1);
     btn.disabledBackgroundColor = [UIColor grayColor];
    btn.totalSecond = 180;
      [btn addTarget:self action:@selector(registerFrist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //进度b
    [btn processBlock:^(NSUInteger second) {
        btn.phoneNum=[_textField text];
        btn.title = [NSString stringWithFormat:@"%lis", second] ;
    } onFinishedBlock:^{  // 倒计时完毕
        btn.title = root_fasong_yanzhengma;
    }];
    

    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,230*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:20.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_next_go forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(PresentGo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
}

-(void)getCode0{
    
   
    NSString *A1=[_textField0 text];
    if (A1==nil || A1==NULL||([A1 isEqual:@""] ) ) {
    }else{
    _getPhone=[NSMutableString stringWithString:A1];
    }
    
    NSCharacterSet *setToRemove =
    [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789 "]
     invertedSet ];
    
    _getPhone =[NSMutableString stringWithString:[[_getPhone componentsSeparatedByCharactersInSet:setToRemove]
                                                  componentsJoinedByString:@""]];
    
    
    NSString *A=@"+";
    if ([_getPhone containsString:A]) {
        [_getPhone deleteCharactersInRange:[_getPhone rangeOfString:A]];
        }

    _getPhone=[self getTheCorrectNum:_getPhone];
    
    if (_getPhone.length>5) {
        [self showToastViewWithTitle:root_guoji_quhao_cuowu];
        return;
    }
    
    if ([[_textField text] isEqual:@""]) {
        [self showToastViewWithTitle:root_Enter_phone_number];
        return;
    }
    
   
        [self getCode];
       
}



-(NSMutableString*) getTheCorrectNum:(NSString*)tempString
{
    while ([tempString hasPrefix:@"0"])
        
    {
        tempString = [tempString substringFromIndex:1];
        
      //  NSLog(@"压缩之后的tempString:%@",tempString);
    }
    NSMutableString *goString=[NSMutableString stringWithString:tempString];
    return goString;
}


-(void)registerFrist{
    [self showProgressView];
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"userName":[_textField text]} paramarsSite:@"/newLoginAPI.do?op=getUserServerUrl" sucessBlock:^(id content) {
         [self hideProgressView];
        NSLog(@"getUserServerUrl: %@", content);
        if (content) {
            if ([content[@"success"]intValue]==1) {
                NSString *server1=content[@"msg"];
                NSString *server2=@"http://";
                NSString *server=[NSString stringWithFormat:@"%@%@",server2,server1];
                [[UserInfo defaultUserInfo] setServer:server];
                [self getCode0];
            }else{
                [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
                [self getCode0];
            }
        }else{
            [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
            [self getCode0];
        }
        
    } failure:^(NSError *error) {
        [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
        [self getCode0];
    }];
    
}



-(void)getCode{
    _dataDic=[NSMutableDictionary new];
    [_dataDic setObject:[_textField text] forKey:@"phoneNum"];
    [_dataDic setObject:_getPhone forKey:@"areaCode"];
        [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:_dataDic paramarsSite:@"/newForgetAPI.do?op=smsVerification" sucessBlock:^(id content) {
        [self hideProgressView];
        id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"smsVerification: %@", jsonObj);
        if (jsonObj) {
            if ([jsonObj[@"result"] intValue]==1) {
                if ((jsonObj[@"obj"]==nil)||(jsonObj[@"obj"]==NULL)||([jsonObj[@"obj"] isEqual:@""])) {
                    
                }else{
                   
                        _getCheckNum=jsonObj[@"obj"][@"validate"];
                        _getPhoneNum=[_textField text];
                    
                }
            }else{
                if ([jsonObj[@"msg"] intValue]==501) {
                  [self showAlertViewWithTitle:root_fasongduanxin_yanzhengma_buchenggong message:root_fasongduanxin_yanzhengma_buchenggong cancelButtonTitle:root_Yes];
                }else if ([jsonObj[@"msg"] intValue]==502) {
                    [self showAlertViewWithTitle:root_fasongduanxin_yanzhengma_buchenggong message:root_Enter_phone_number cancelButtonTitle:root_Yes];
                }else if ([jsonObj[@"msg"] intValue]==503) {
                    [self showAlertViewWithTitle:root_fasongduanxin_yanzhengma_buchenggong message:root_gaishoujihao_meiyou_zhuce_yonghu cancelButtonTitle:root_Yes];
                }else if ([jsonObj[@"msg"] intValue]==9003) {
                    [self showAlertViewWithTitle:root_fasongduanxin_yanzhengma_buchenggong message:root_shouji_geshi_cuowu cancelButtonTitle:root_Yes];
                }else if ([jsonObj[@"msg"] intValue]==9004) {
                    [self showAlertViewWithTitle:root_fasongduanxin_yanzhengma_buchenggong message:root_shouji_yanzhengma_shixiao cancelButtonTitle:root_Yes];
                }else {
                    [self showAlertViewWithTitle:root_fasongduanxin_yanzhengma_buchenggong message:jsonObj[@"msg"] cancelButtonTitle:root_Yes];
                }
            
            }
            
        }
        
    } failure:^(NSError *error) {
        
       }
     ];

}


-(void)PresentGo{

  
    if ([_getCheckNum isEqualToString:[_textField2 text]]) {
     
        if ([_goViewType isEqualToString:@"1"]) {
            phoneRegister2ViewController *goView=[[phoneRegister2ViewController alloc]init];
            goView.PhoneNum=_getPhoneNum;
            goView.PhoneCheck=_getCheckNum;
            [self.navigationController pushViewController:goView animated:YES];
        }
        if ([_goViewType isEqualToString:@"2"]) {
         changManeger *go=[[changManeger alloc]init];
               go.type=@"1";
            [self.navigationController pushViewController:go animated:YES];
        }
        
    }else{
       [self showToastViewWithTitle:root_qingshuru_zhengque_jiaoyanma];
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
