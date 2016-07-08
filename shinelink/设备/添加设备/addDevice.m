//
//  addDevice.m
//  shinelink
//
//  Created by sky on 16/2/16.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "addDevice.h"
#import "TempViewController.h"
#import "SHBQRView.h"
#import "MainViewController.h"
#import "AddDeviceViewController.h"


@interface addDevice ()<SHBQRViewDelegate>
@property(nonatomic,strong)UITextField *cellectId;
@property(nonatomic,strong)UITextField *cellectNo;

@property(nonatomic,strong)NSString *param1;
@property(nonatomic,strong)NSString *param2;
@property(nonatomic,strong)NSString *param3;
@property(nonatomic,strong)NSString *param1Name;
@property(nonatomic,strong)NSString *param2Name;
@property(nonatomic,strong)NSString *param3Name;
@property (nonatomic, strong) NSString *SetName;

@end

@implementation addDevice
- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *bgImage =  IMAGE(@"bg4.png");
  _param1=@"";
      _param2=@"";
      _param3=@"";
      _param1Name=@"";
    _param2Name=@"";
    _param3Name=@"";
    self.view.backgroundColor=MainColor;
//    self.view.layer.contents = (id)bgImage.CGImage;
  //  self.title=@"配置设备";
    
    [self initUI];
}

-(void)buttonPressed{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = root_tianjia_shebei;
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
    
    _cellectId = [[UITextField alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 0, CGRectGetWidth(userBgImageView.frame), 45*HEIGHT_SIZE)];
    _cellectId.placeholder = root_caiJiQi;
    _cellectId.textColor = [UIColor whiteColor];
    _cellectId.tintColor = [UIColor whiteColor];
     _cellectId.textAlignment = NSTextAlignmentCenter;
    [_cellectId setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_cellectId setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
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
    [_cellectNo setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _cellectNo.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView addSubview:_cellectNo];
    
    
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(40*NOW_SIZE,210*HEIGHT_SIZE, 240*NOW_SIZE, 40*HEIGHT_SIZE);
//    [goBut.layer setMasksToBounds:YES];
//    [goBut.layer setCornerRadius:25.0];
    //goBut.backgroundColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
      [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_OK forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];

    [goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
    UIButton *QR=[[UIButton alloc]initWithFrame:CGRectMake(40*NOW_SIZE,300*HEIGHT_SIZE , 240*NOW_SIZE, 60*HEIGHT_SIZE)];
    [QR setBackgroundImage:IMAGE(@"按钮2.png") forState:0];
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
    
    [self showProgressView];
    
    NSMutableDictionary *userCheck=[NSMutableDictionary dictionaryWithObject:_cellectId.text forKey:@"dataLogSn"];
    [userCheck setObject:_cellectNo.text forKey:@"validateCode"];
    
    _param1=_stationId;
    _param3=_cellectNo.text;
    _param2=_cellectId.text;
    _param1Name=@"plantId";
    _param2Name=@"datalogSN";
    _param3Name=@"validCode";
    
 [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{_param1Name:_param1,_param2Name:_param2,_param3Name:_param3}  paramarsSite:@"/newDatalogAPI.do?op=addDatalog" sucessBlock:^(id content) {
        
        [self hideProgressView];
        NSLog(@"addDatalog: %@", content);
     
        
        if (content) {
                id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            
            if ([[jsonObj objectForKey:@"success"] integerValue] ==0) {
                if ([[jsonObj objectForKey:@"msg"]integerValue]==501) {
                    [self showAlertViewWithTitle:nil message:root_tianjia_chucuo cancelButtonTitle:root_Yes];
                }
                else if ([[jsonObj objectForKey:@"msg"]integerValue]==502) {
                    [self showAlertViewWithTitle:nil message:root_meiyou_quanxian cancelButtonTitle:root_Yes];
                }
                else if ([[jsonObj objectForKey:@"msg"]integerValue]==503) {
                    [self showAlertViewWithTitle:nil message:root_xuliehao_cuowu cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==504) {
                    [self showAlertViewWithTitle:nil message:root_zongti_shuliang_chaochu_xianzhi cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==505) {
                    [self showAlertViewWithTitle:nil message:root_danGe_shuliang_chaochu_xianzhi cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==506) {
                    [self showAlertViewWithTitle:nil message:root_xuliehao_yijing_cunzai cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==507) {
                    [self showAlertViewWithTitle:nil message:root_xuliehao_jiaoyanMa_bupipei cancelButtonTitle:root_Yes];
                }
            }else{
                
                _SetName=jsonObj[@"datalogType"];
                NSString *demoName1=@"ShineWIFI";           //新wifi
                NSString *demoName2=@"ShineLan";            //旧wifi
                NSString *demoName3=@"ShineWifiBox";          //旧wifi
                
                BOOL result1 = [_SetName compare:demoName1 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
                BOOL result2 = [_SetName compare:demoName2 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
                BOOL result3 = [_SetName compare:demoName3 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
                
                if (result1) {
                    AddDeviceViewController *rootView = [[AddDeviceViewController alloc]init];
                    
                    [self.navigationController pushViewController:rootView animated:YES];
                }else if (result2){
                    MainViewController *rootView = [[MainViewController alloc]init];
                    [self.navigationController pushViewController:rootView animated:YES];
                    
                }else if (result3){
                    MainViewController *rootView = [[MainViewController alloc]init];
                    [self.navigationController pushViewController:rootView animated:YES];
                    
                }else{
                    [self showAlertViewWithTitle:nil message:root_shebei_tianjia_chenggong cancelButtonTitle:root_Yes];
                       }
             }
        }
        
    }failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
    
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
    NSString *B1= [NSString stringWithFormat: @"%ld", B];
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
    if ([_cellectId.text isEqual:@""]) {
        [self showAlertViewWithTitle:nil message:root_caiJiQi_zhengque cancelButtonTitle:root_OK];
        return;
    }
    if ([_cellectNo.text isEqual:@""]) {
        [self showAlertViewWithTitle:nil message:root_jiaoYanMa_zhengQue cancelButtonTitle:root_OK];
        return;
    }
    [self showProgressView];
    NSMutableDictionary *userCheck=[NSMutableDictionary dictionaryWithObject:_cellectId.text forKey:@"datalogSN"];
    [userCheck setObject:_cellectNo.text forKey:@"validCode"];
    [userCheck setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"plantID"] forKey:@"plantId"];
    
    _param1=_stationId;
    _param3=_cellectNo.text;
    _param2=_cellectId.text;
    _param1Name=@"plantId";
    _param2Name=@"datalogSN";
    _param3Name=@"validCode";
    
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{_param1Name:_param1,_param2Name:_param2,_param3Name:_param3}  paramarsSite:@"/newDatalogAPI.do?op=addDatalog" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"addDatalog: %@", content);
          id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if (content) {
            if ([[jsonObj objectForKey:@"success"] integerValue] ==0) {
                if ([[jsonObj objectForKey:@"msg"]integerValue]==501) {
                    [self showAlertViewWithTitle:nil message:root_tianjia_chucuo cancelButtonTitle:root_Yes];
                }
                else if ([[jsonObj objectForKey:@"msg"]integerValue]==502) {
                    [self showAlertViewWithTitle:nil message:root_meiyou_quanxian cancelButtonTitle:root_Yes];
                }
                else if ([[jsonObj objectForKey:@"msg"]integerValue]==503) {
                    [self showAlertViewWithTitle:nil message:root_xuliehao_cuowu cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==504) {
                    [self showAlertViewWithTitle:nil message:root_zongti_shuliang_chaochu_xianzhi cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==505) {
                    [self showAlertViewWithTitle:nil message:root_danGe_shuliang_chaochu_xianzhi cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==506) {
                    [self showAlertViewWithTitle:nil message:root_xuliehao_yijing_cunzai cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==507) {
                    [self showAlertViewWithTitle:nil message:root_xuliehao_jiaoyanMa_bupipei cancelButtonTitle:root_Yes];
                }
            }else{
                
                _SetName=jsonObj[@"datalogType"];
                NSString *demoName1=@"ShineWIFI";           //新wifi
                NSString *demoName2=@"ShineLan";            //旧wifi
                NSString *demoName3=@"ShineWifiBox";          //旧wifi
                
                BOOL result1 = [_SetName compare:demoName1 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
                BOOL result2 = [_SetName compare:demoName2 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
                BOOL result3 = [_SetName compare:demoName3 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
                
                if (result1) {
                    AddDeviceViewController *rootView = [[AddDeviceViewController alloc]init];
                    
                    [self.navigationController pushViewController:rootView animated:YES];
                }else if (result2){
                    MainViewController *rootView = [[MainViewController alloc]init];
                    [self.navigationController pushViewController:rootView animated:YES];
                    
                }else if (result3){
                    MainViewController *rootView = [[MainViewController alloc]init];
                    [self.navigationController pushViewController:rootView animated:YES];
                    
                }else{
                    [self showAlertViewWithTitle:nil message:root_shebei_tianjia_chenggong cancelButtonTitle:root_Yes];
                }
                
            }
        }
    }failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
    
    
    
    
}

@end
