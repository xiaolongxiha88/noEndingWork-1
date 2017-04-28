//
//  AddCellectViewController.m
//  ShinePhone
//
//  Created by ZML on 15/5/26.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "AddCellectViewController.h"
#import "TempViewController.h"
#import "SHBQRView.h"
#import "loginViewController.h"
#import "MainViewController.h"
#import "AddDeviceViewController.h"

@interface AddCellectViewController ()<SHBQRViewDelegate>
@property(nonatomic,strong)UITextField *cellectId;
@property(nonatomic,strong)UITextField *cellectNo;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) NSString *setDeviceName;
@end

@implementation AddCellectViewController

- (instancetype)initWithDataDict:(NSMutableDictionary *)dataDict {
    if (self = [super init]) {
        self.dataDic = [NSMutableDictionary dictionaryWithDictionary:dataDict];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=root_CJQ_tianjia;
//    UIImage *bgImage = IMAGE(@"bg.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
   // self.title=@"配置设备";
    self.view.backgroundColor=MainColor;
    [self initUI];
}

-(void)buttonPressed{
    
[self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//self.navigationItem.title = @"配置设备";
}



-(void)initUI{
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    //数据采集器序列号
    UIImageView *userBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 50*HEIGHT_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*HEIGHT_SIZE)];
    userBgImageView.userInteractionEnabled = YES;
    userBgImageView.image = IMAGE(@"圆角矩形空心.png");
    [self.view addSubview:userBgImageView];
    
    _cellectId = [[UITextField alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 0, CGRectGetWidth(userBgImageView.frame) , 45*HEIGHT_SIZE)];
    _cellectId.placeholder = root_caiJiQi;
    _cellectId.textColor = [UIColor whiteColor];
    _cellectId.tintColor = [UIColor whiteColor];
     _cellectId.textAlignment = NSTextAlignmentCenter;
    [_cellectId setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_cellectId setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _cellectId.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [userBgImageView addSubview:_cellectId];
    
    //数据采集器效验码
    UIImageView *pwdBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 110*HEIGHT_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*HEIGHT_SIZE)];
    pwdBgImageView.image = IMAGE(@"圆角矩形空心.png");
    pwdBgImageView.userInteractionEnabled = YES;
    [self.view addSubview:pwdBgImageView];
    
    _cellectNo = [[UITextField alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 0, CGRectGetWidth(pwdBgImageView.frame), 45*HEIGHT_SIZE)];
    _cellectNo.placeholder = root_jiaoYanMa;
    _cellectNo.textColor = [UIColor whiteColor];
    _cellectNo.tintColor = [UIColor whiteColor];
     _cellectNo.textAlignment = NSTextAlignmentCenter;
    [_cellectNo setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_cellectNo setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _cellectNo.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView addSubview:_cellectNo];
    
 
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(40*NOW_SIZE,300*HEIGHT_SIZE, 240*NOW_SIZE, 40*HEIGHT_SIZE);
    //[goBut.layer setMasksToBounds:YES];
    //[goBut.layer setCornerRadius:25.0];
     [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_register forState:UIControlStateNormal];
     goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
    
    UIButton *QR=[[UIButton alloc]initWithFrame:CGRectMake(40*NOW_SIZE,180*HEIGHT_SIZE , 240*NOW_SIZE, 40*HEIGHT_SIZE)];
    [QR setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [QR setTitle:root_erWeiMa forState:UIControlStateNormal];
    QR.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [QR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [QR addTarget:self action:@selector(ScanQR) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QR];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_cellectNo resignFirstResponder];
    [_cellectId resignFirstResponder];
    
}

-(void)ScanQR{
   // TempViewController *temp = [[TempViewController alloc] init];
   // [self.navigationController pushViewController:temp animated:true];
    
    SHBQRView *qrView = [[SHBQRView alloc] initWithFrame:self.view.bounds];
    qrView.delegate = self;
    [self.view addSubview:qrView];
}

- (void)qrView:(SHBQRView *)view ScanResult:(NSString *)result {
    [view stopScan];
  
    _cellectNo.text=[self getValidCode:result];
    NSLog(@"_cellectNo.text=%@",_cellectNo.text);
    _cellectId.text=result;
    NSLog(@"_cellectId.text=%@",_cellectId.text);
    [_dataDic setObject:_cellectId.text forKey:@"regDataLoggerNo"];
    [_dataDic setObject:_cellectNo.text forKey:@"regValidateCode"];
    
    NSDictionary *userCheck=[NSDictionary dictionaryWithObject:[_dataDic objectForKey:@"regUserName"] forKey:@"regUserName"];
    [BaseRequest requestWithMethod:HEAD_URL paramars:userCheck paramarsSite:@"/newRegisterAPI.do?op=checkUserExist" sucessBlock:^(id content) {
        NSLog(@"checkUserExist: %@", content);
        [self hideProgressView];
        if (content) {
            if ([content[@"success"] integerValue] == 0) {
                [BaseRequest requestWithMethod:HEAD_URL paramars:_dataDic paramarsSite:@"/newRegisterAPI.do?op=creatAccount" sucessBlock:^(id content) {
                    NSLog(@"creatAccount: %@", content);
                    [self hideProgressView];
                    if (content) {
                        if ([content[@"success"] integerValue] == 0) {
                            //注册失败
                            if ([content[@"msg"] isEqual:@"501"]) {
                                [self showAlertViewWithTitle:nil message:root_chaoChu_shuLiang cancelButtonTitle:root_Yes];
                            }else if ([content[@"msg"] isEqual:@"server error."]){
                                
                                [self showAlertViewWithTitle:nil message:root_fuWuQi_cuoWu cancelButtonTitle:root_Yes];
                            }
                            else if ([content[@"msg"] isEqual:@"602"]){
                                
                                [self showAlertViewWithTitle:nil message:root_zhuCe_cuoWu cancelButtonTitle:root_Yes];
                            }else if ([content[@"msg"] isEqual:@"506"]){
                                
                                [self showAlertViewWithTitle:nil message:root_caijiqi_cuowu cancelButtonTitle:root_Yes];
                            }else if ([content[@"msg"] isEqual:@"error_agentCodeNotExist"]){
                                
                                [self showAlertViewWithTitle:nil message:root_dailishang_cuowu cancelButtonTitle:root_Yes];
                            }else if ([content[@"msg"] isEqual:@"604"]){
                                
                                [self showAlertViewWithTitle:nil message:root_dailishang_cuowu cancelButtonTitle:root_Yes];
                            }else if ([content[@"msg"] isEqual:@"605"]){
                                
                                [self showAlertViewWithTitle:nil message:root_xuliehao_yijing_cunzai cancelButtonTitle:root_Yes];
                            }
                            
                            
                              [self.navigationController popViewControllerAnimated:NO];
                        }
                        else {
                            
                            _setDeviceName=content[@"datalogType"];
                            //注册成功
                            [self succeedRegister];
                            [self showAlertViewWithTitle:nil message:root_zhuCe_chengGong  cancelButtonTitle:root_Yes];
                            // [self showAlertViewWithTitle:nil message:root_shuaxin_liebiao cancelButtonTitle:root_Yes];
                        }
                    }
                    
                } failure:^(NSError *error) {
                    [self hideProgressView];
                    [self showToastViewWithTitle:root_Networking];
                }];
                
                
            }else{
                [self showAlertViewWithTitle:nil message:root_yongHu_yi_shiYong cancelButtonTitle:root_Yes];
                   [self.navigationController popViewControllerAnimated:NO];
            }
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
    
    [self showProgressView];
    
  //  [self presentViewController:alert animated:true completion:nil];
}

-(void)delButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString*)getValidCode:(NSString*)serialNum{
    if (serialNum==NULL||serialNum==nil) {
        return @"";
    }
    NSData *testData = [serialNum dataUsingEncoding: NSUTF8StringEncoding];
      int sum=0;
    Byte *snBytes=(Byte*)[testData bytes];
    for(int i=0;i<[testData length];i++)
    {
        sum+=snBytes[i];
    }
    NSInteger B=sum%8;
    NSString *B1= [NSString stringWithFormat: @"%ld", (long)B];
    int C=sum*sum;
   NSString *text = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1x",C]];
    int length = [text length];
    NSString *resultTemp;
    NSString *resultTemp3;
    NSString *resultTemp1=[text substringWithRange:NSMakeRange(0, 2)];
     NSString *resultTemp2=[text substringWithRange:NSMakeRange(length - 2, 2)];
   resultTemp3= [resultTemp1 stringByAppendingString:resultTemp2];
    resultTemp=[resultTemp3 stringByAppendingString:B1];
    NSString *result = @"";
    char *charArray = [resultTemp cStringUsingEncoding:NSASCIIStringEncoding];
    for (int i=0; i<[resultTemp length]; i++) {
        if (charArray[i]==0x30||charArray[i]==0x4F||charArray[i]==0x4F) {
            charArray[i]++;
        }
        result=[result stringByAppendingFormat:@"%c",charArray[i]];
    }
    return [result uppercaseString];
}



-(void)addButtonPressed{
    
//    if ([_cellectId.text isEqual:@""]) {
//        [self showAlertViewWithTitle:nil message:root_caiJiQi cancelButtonTitle:root_OK ];
//        return;
//    }
//    if ([_cellectNo.text isEqual:@""]) {
//        [self showAlertViewWithTitle:nil message:root_jiaoYanMa_zhengQue cancelButtonTitle:root_OK];
//        return;
//    }
    
     [_dataDic setObject:_cellectId.text forKey:@"regDataLoggerNo"];
     [_dataDic setObject:_cellectNo.text forKey:@"regValidateCode"];
    
    NSDictionary *userCheck=[NSDictionary dictionaryWithObject:[_dataDic objectForKey:@"regUserName"] forKey:@"regUserName"];
 
    [self showProgressView];
 [BaseRequest requestWithMethod:HEAD_URL paramars:userCheck paramarsSite:@"/newRegisterAPI.do?op=checkUserExist" sucessBlock:^(id content) {
     NSLog(@"checkUserExist: %@", content);
     [self hideProgressView];
     if (content) {
         if ([content[@"success"] integerValue] == 0) {
             [BaseRequest requestWithMethod:HEAD_URL paramars:_dataDic paramarsSite:@"/newRegisterAPI.do?op=creatAccount" sucessBlock:^(id content) {
                 NSLog(@"creatAccount: %@", content);
                 [self hideProgressView];
                 
 
                 
                 if (content) {
                     if ([content[@"success"] integerValue] == 0) {
 
//                         else if ([content[@"msg"] isEqual:@"server error."]){
//                             
//                             [self showAlertViewWithTitle:nil message:root_fuWuQi_cuoWu cancelButtonTitle:root_Yes];
//                         }
//                         else if ([content[@"msg"] isEqual:@"602"]){
//                             
//                             [self showAlertViewWithTitle:nil message:root_zhuCe_cuoWu cancelButtonTitle:root_Yes];
//                         }
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
                [self.navigationController popViewControllerAnimated:NO];
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
    

    
    NSString *demoName1=@"ShineWIFI";           //新wifi
    NSString *demoName2=@"ShineLan";            //旧wifi
    NSString *demoName3=@"ShineWifiBox";          //旧wifi
    
    BOOL result1 = [_setDeviceName compare:demoName1 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
    BOOL result2 = [_setDeviceName compare:demoName2 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
    BOOL result3 = [_setDeviceName compare:demoName3 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
    
    if (result1) {

        AddDeviceViewController *rootView = [[AddDeviceViewController alloc]init];
        rootView.LogType=@"1";
        rootView.SnString=_cellectId.text;
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





@end
