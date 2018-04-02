//
//  usbToWifiLoginOSS.m
//  ShinePhone
//
//  Created by sky on 2017/12/7.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiLoginOSS.h"

@interface usbToWifiLoginOSS ()
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UITextField *textField2;
@property(nonatomic,strong)UITextField *textField3;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,assign)BOOL isFirstAlert;
@property(nonatomic,strong)NSString*roleNum;

@end

@implementation usbToWifiLoginOSS

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=root_MAX_294;
    
    _isFirstAlert=YES;
    [self initUI];
}



-(void)initUI{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0*HEIGHT_SIZE, ScreenWidth,SCREEN_Height)];
        _scrollView.backgroundColor =[UIColor clearColor];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.contentSize=CGSizeMake(SCREEN_Width, SCREEN_Height*1.4);
        [self.view addSubview:_scrollView];
    }
    
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 20*HEIGHT_SIZE, 100*NOW_SIZE,30*HEIGHT_SIZE )];
    PV2Lable.text=[NSString stringWithFormat:@"%@:",root_MAX_295];
    PV2Lable.textAlignment=NSTextAlignmentRight;
    PV2Lable.textColor=COLOR(102, 102, 102, 1);
    PV2Lable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    PV2Lable.adjustsFontSizeToFitWidth=YES;
    [_scrollView addSubview:PV2Lable];
    
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(110*NOW_SIZE, 20*HEIGHT_SIZE, 170*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textField.layer.borderWidth=1;
    _textField.layer.cornerRadius=5;
    _textField.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
    _textField.textColor = COLOR(102, 102, 102, 1);
    _textField.tintColor = COLOR(102, 102, 102, 1);
    _textField.textAlignment=NSTextAlignmentCenter;
    _textField.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_scrollView addSubview:_textField];
    
    UILabel *PV2Lable1=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 60*HEIGHT_SIZE, 100*NOW_SIZE,30*HEIGHT_SIZE )];
    PV2Lable1.text=[NSString stringWithFormat:@"OSS%@:",root_Mima];
    PV2Lable1.textAlignment=NSTextAlignmentRight;
    PV2Lable1.textColor=COLOR(102, 102, 102, 1);
    PV2Lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    PV2Lable1.adjustsFontSizeToFitWidth=YES;
    [_scrollView addSubview:PV2Lable1];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(110*NOW_SIZE, 60*HEIGHT_SIZE, 170*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textField2.layer.borderWidth=1;
    _textField2.layer.cornerRadius=5;
    _textField2.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
    _textField2.textColor = COLOR(102, 102, 102, 1);
    _textField2.tintColor = COLOR(102, 102, 102, 1);
    _textField2.textAlignment=NSTextAlignmentCenter;
    _textField2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_scrollView addSubview:_textField2];
    
   UIButton* _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(60*NOW_SIZE,120*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:root_log_in forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(loginOSS) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_goBut];
}

-(void)initUiTwo{
    

    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 180*HEIGHT_SIZE, 100*NOW_SIZE,30*HEIGHT_SIZE )];
    PV2Lable.text=[NSString stringWithFormat:@"%@:",root_MAX_296];
    PV2Lable.textAlignment=NSTextAlignmentRight;
    PV2Lable.textColor=COLOR(102, 102, 102, 1);
    PV2Lable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    PV2Lable.adjustsFontSizeToFitWidth=YES;
    [_scrollView addSubview:PV2Lable];
    
    
    _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(110*NOW_SIZE, 180*HEIGHT_SIZE, 170*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textField3.layer.borderWidth=1;
    _textField3.layer.cornerRadius=5;
    _textField3.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
    _textField3.textColor = COLOR(102, 102, 102, 1);
    _textField3.tintColor = COLOR(102, 102, 102, 1);
    _textField3.textAlignment=NSTextAlignmentCenter;
    _textField3.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_scrollView addSubview:_textField3];
    

    UIButton* _goBut1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut1.frame=CGRectMake(60*NOW_SIZE,240*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_goBut1 setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut1 setTitle:root_MAX_297 forState:UIControlStateNormal];
    _goBut1.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_goBut1 addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_goBut1];
}

-(void)loginOSS{
    if (_isFirstAlert) {
        _isFirstAlert=NO;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:root_MAX_298 message:[NSString stringWithFormat:@"%@?",root_MAX_299] delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_MAX_300, nil];
        alertView.tag = 1005;
        [alertView show];
    }else{
             [self loginOssNet];
    }
  
    
}

-(void)finishSet{
    if (_textField3.text==nil || [_textField3.text isEqualToString:@""]) {
        [self showToastViewWithTitle:root_MAX_301];
        return;
    }
    NSString *password=_textField3.text;
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"theToolPassword"];
    
    NSString *alertString=[NSString stringWithFormat:@"%@:%@",root_MAX_302,password];
    [self showAlertViewWithTitle:root_MAX_303 message:alertString cancelButtonTitle:root_OK];
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex) {
        if( (alertView.tag == 1005) || (alertView.tag == 1002) || (alertView.tag == 1003)){
            if (deviceSystemVersion>10) {
                NSURL *url = [NSURL URLWithString:@"App-Prefs:root=WIFI"];
                if ([[UIApplication sharedApplication]canOpenURL:url]) {
                    [[UIApplication sharedApplication]openURL:url];
                }
            }else{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
            }
            
        }
        
     
        
    }else{
        if(alertView.tag == 1005){
            [self loginOssNet];
        }
    }
    
}


-(void)loginOssNet{
   
    NSString* nameString=_textField.text;
     NSString* passwordString=_textField2.text;
    if (nameString==nil || [nameString isEqualToString:@""]) {
        [self showToastViewWithTitle:root_Alet_user_messge];
        return;
    }
    if (passwordString==nil || [passwordString isEqualToString:@""]) {
        [self showToastViewWithTitle:root_Alet_user_pwd];
        return;
    }
    
     [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL_Demo paramars:@{@"userName":nameString, @"password":[self MD5:passwordString]} paramarsSite:@"/api/v2/login" sucessBlock:^(id content) {
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
                            if ([userType isEqualToString:@"0"]) {          //监控账户
                                
                            }else{                     //OSS账户
                                
                                   _roleNum=[NSString stringWithFormat:@"%@",objDic[@"user"][@"role"]];
                                     [self showToastViewWithTitle:root_MAX_304];
                                [self initUiTwo];
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
                    if ([allDic.allKeys containsObject:@"msg"]) {
                          [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",allDic[@"msg"]]];
                    }
                  
                }
                
            }
            
            
            
            
        }
        
    } failure:^(NSError *error) {
        
   [self showToastViewWithTitle:root_Networking];
        [self hideProgressView];
        
        
    }];
    
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
 
    if (_textField) {
        [_textField resignFirstResponder];
    }
    if (_textField2) {
        [_textField2 resignFirstResponder];
    }
    if (_textField3) {
        [_textField3 resignFirstResponder];
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
