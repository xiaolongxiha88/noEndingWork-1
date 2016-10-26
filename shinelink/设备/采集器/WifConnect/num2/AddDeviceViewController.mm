//
//  AddDeviceViewController.m
//  smartYogurtMaker
//
//  Created by mqw on 15/6/3.
//  Copyright (c) 2015年 mqw. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "DeviceManageViewController.h"


#import "elian.h"
#import "EasyTimeline.h"
#import "UdpCheckUtl.h"
#import "Toast+UIView.h"
#import "StationCellectViewController.h"


@interface AddDeviceViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) NSTimer * timer;
@end

@implementation AddDeviceViewController{
    EasyTimeline *_timelineConfig;
    
}

NSString* authMode = @"9";
static void *context = NULL;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self stopSearch];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    _deviceArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
            self.title = root_peizhi_shinewifi_E;
  

     self.view.backgroundColor=MainColor;
    
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *ssid = [delegate getWifiName];
    
    if(ssid!=nil&&ssid.length>0 )
    {
        self.ipName.text = ssid;
    }
    //self.pswd.secureTextEntry = true;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotDeviceByScan:) name:kOnGotDeviceByScan object:nil];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_ipName resignFirstResponder];
    [_pswd resignFirstResponder];
}

-(void)initUI{

    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
    
       float sizeH1=10*HEIGHT_SIZE;
    
    UIImageView *pwdBgImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 85*HEIGHT_SIZE, 300*NOW_SIZE,110*HEIGHT_SIZE+sizeH1 )];
    pwdBgImageView2.image = IMAGE(@"addDevice.jpg");
    pwdBgImageView2.userInteractionEnabled = YES;
    [_scrollView addSubview:pwdBgImageView2];
    
    
    UILabel *noticeLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 300*NOW_SIZE,40*HEIGHT_SIZE )];
    noticeLable.text=root_lianjie_luyouqi;
    noticeLable.textAlignment=NSTextAlignmentLeft;
    noticeLable.textColor=[UIColor whiteColor];
    noticeLable.numberOfLines=0;
    noticeLable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:noticeLable];
    
     UILabel *wifiName=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 5*HEIGHT_SIZE, 100*NOW_SIZE,50*HEIGHT_SIZE )];
    wifiName.text=root_peizhi_shinewifi_E_mingzi;
    wifiName.textAlignment=NSTextAlignmentRight;
    wifiName.textColor=[UIColor whiteColor];
    wifiName.numberOfLines=0;
    wifiName.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [pwdBgImageView2 addSubview:wifiName];
    
    self.ipName = [[UITextField alloc] initWithFrame:CGRectMake(105*NOW_SIZE, 5*HEIGHT_SIZE, 180*NOW_SIZE,50*HEIGHT_SIZE )];
    self.ipName.placeholder = root_peizhi_shinewifi_name;
    //self.ssidTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.ipName.secureTextEntry = NO;
    self.ipName.textColor = [UIColor whiteColor];
    self.ipName.tintColor = [UIColor whiteColor];
    [self.ipName setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.ipName setValue:[UIFont systemFontOfSize:9*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.ipName.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [pwdBgImageView2 addSubview:_ipName];
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(105*NOW_SIZE, 50*HEIGHT_SIZE, 180*NOW_SIZE,1*HEIGHT_SIZE )];
    view1.backgroundColor=[UIColor whiteColor];
    [pwdBgImageView2 addSubview:view1];
    
    UILabel *Password=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 60*HEIGHT_SIZE, 100*NOW_SIZE,50*HEIGHT_SIZE )];
    Password.text=root_peizhi_shinewifi_mima;
    Password.textAlignment=NSTextAlignmentRight;
    Password.textColor=[UIColor whiteColor];
    Password.numberOfLines=0;
    Password.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [pwdBgImageView2 addSubview:Password];
    
    self.pswd = [[UITextField alloc] initWithFrame:CGRectMake(105*NOW_SIZE, 60*HEIGHT_SIZE, 180*NOW_SIZE,50*HEIGHT_SIZE )];
    self.pswd.placeholder = root_peizhi_shinewifi_shuru_mima;
    //self.ssidTextField.keyboardType = UIKeyboardTypeASCIICapable;
    //self.pswd.secureTextEntry = NO;
    self.pswd.textColor = [UIColor whiteColor];
    self.pswd.tintColor = [UIColor whiteColor];
    [self.pswd setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.pswd setValue:[UIFont systemFontOfSize:9*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.pswd.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [pwdBgImageView2 addSubview:_pswd];
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(105*NOW_SIZE, 105*HEIGHT_SIZE, 180*NOW_SIZE,1*HEIGHT_SIZE )];
    view2.backgroundColor=[UIColor whiteColor];
    [pwdBgImageView2 addSubview:view2];

    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,250*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    //    [goBut.layer setMasksToBounds:YES];
    //    [goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_set forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut addTarget:self action:@selector(deviceSearchStart) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:goBut];
    
    UIButton *backBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    backBut.frame=CGRectMake(60*NOW_SIZE,310*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    //    [goBut.layer setMasksToBounds:YES];
    //    [goBut.layer setCornerRadius:25.0];
    [backBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [backBut setTitle:root_back forState:UIControlStateNormal];
    backBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [backBut addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:backBut];
    
}



-(void)goBack{
  [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)onDeviceFindResultNotify:(NSNotification*)notify{
//    [self performSelectorOnMainThread:@selector(doDeviceFindResult:) withObject:notify waitUntilDone:NO];
//}





#pragma mark 扫描到设备
//用户登陆成功回调
-(void)onGotDeviceByScan:(NSNotification*)noti{
    NSString* deviceMac = [noti.object objectForKey:@"deviceMac"];
    
    if (![_deviceArray containsObject:deviceMac]) {
        [_deviceArray addObject:deviceMac];
        int count =(int)[_deviceArray count];
        NSLog(@"Countt=%d",count);
          NSLog(@"cellCount0=%ld",(long)self.cellCount0);
        
        myAlertView.title=root_Alet_user;
        
          myAlertView.message = root_peizhi_shinewifi_peizhi_tishi;
        //if (count<=_cellCount) {
            
        //    myAlertView.message = [NSString stringWithFormat:@"查找设备中. 发现设备：%d个",count ];
        //}
       
//        
//         NSString *A8= NSLocalizedString(@"A8", nil);
//        myAlertView.title=A8;
//            NSString *A4= NSLocalizedString(@"A4", nil);
//        
//       int count2=0;
//        
//        if (count<=self.cellCount0) {
//            count2=0;
//            NSLog(@"1");
//        }
//        if (count>self.cellCount0) {
//             count2=count-(int)self.cellCount0;
//             NSLog(@"2");
//        }
//      
//        
//         myAlertView.message = [NSString stringWithFormat:A4,count2 ];
        
        
    }
    
}





//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.ipName resignFirstResponder];
    [self.pswd resignFirstResponder];
}

-(void)OnSend:(unsigned int)flag SSID:(NSString*)ssidName PSWD:(NSString*)pswd{
    const char *ssid = [ssidName cStringUsingEncoding:NSASCIIStringEncoding];
    const char *s_authmode = [authMode cStringUsingEncoding:NSASCIIStringEncoding];
    int authmode = atoi(s_authmode);
    const char *password = [pswd cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char target[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
    
    NSLog(@"OnSend: ssid = %s, authmode = %d, password = %s", ssid, authmode, password);
    if (context)
    {
        
        
        //////// ////////////////// ////////////////////////////////
        //////////////////////   ////////////////////////////注销1
//      elianStop(context);
//      elianDestroy(context);
        
        
        
        context = NULL;
    }
    
    //////// ////////////////// ////////////////////////////////
    //////////////////////   ////////////////////////////注销2
//    context = elianNew(NULL, 0, target, flag);
    
    
    if (context == NULL)
    {
        NSLog(@"OnSend elianNew fail");
        return;
    }
    
    
    
    //////// ////////////////// ////////////////////////////////
    //////////////////////   ////////////////////////////注销3
    
//    elianPut(context, TYPE_ID_AM, (char *)&authmode, 1);
//    elianPut(context, TYPE_ID_SSID, (char *)ssid, strlen(ssid));
//    elianPut(context, TYPE_ID_PWD, (char *)password, strlen(password));
//    elianStart(context);
    
   
}


//开始查找设备
-(void) deviceSearchStart{
    _deviceArray = nil;
    _deviceArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *ssid = [delegate getWifiName];
    
    
    if(ssid == nil )
    {
     //[self showToastViewWithTitle:@"Please connect to the router first"];
        
           [self showAlertViewWithTitle:nil message:root_lianjie_luyouqi cancelButtonTitle:root_Yes];
        return;
    }

   [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    
    
    //添加定时器
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getNET) userInfo:nil repeats:YES];
    }
    
    
    
    
    
     myAlertView = [[SIAlertView alloc] initWithTitle:root_Alet_user andMessage:root_peizhi_shinewifi_peizhi_tishi];
    [myAlertView addButtonWithTitle:root_stop_config
                               type:SIAlertViewButtonTypeDestructive
                            handler:^(SIAlertView *alertView) {
                                [alertView dismissAnimated:YES];
                            }];
    myAlertView.willShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willShowHandler", alertView);
    };
    myAlertView.didShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didShowHandler", alertView);
    };
    myAlertView.willDismissHandler = ^(SIAlertView *alertView) {
       
        //停止扫描
        [self  stopSearch];
        
        if ([_timelineConfig isRunning]) {
            [_timelineConfig stop];
        }
        
    };
    myAlertView.didDismissHandler = ^(SIAlertView *alertView) {
        
        _timer.fireDate=[NSDate distantFuture];
        _timer=nil;
        
        NSLog(@"%@, didDismissHandler", alertView);
    };
    myAlertView.showIndicator = YES;
    [myAlertView show];
    isSearching= true;
    
 
    
    
    [self performSelectorInBackground:@selector(doneSearchDeviceAutoThread) withObject:nil];
}



-(void)getNET{

    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"datalogSn":_SnString} paramarsSite:@"/newDatalogAPI.do?op=getDatalogInfo" sucessBlock:^(id content) {
        
        NSLog(@"getDatalogInfo: %@", content);
        if (content) {
            NSString *LostValue=content[@"lost"];
            
            if ([LostValue intValue]==0) {
                
                [myAlertView dismissAnimated:NO];
                
                _timer.fireDate=[NSDate distantFuture];
                  _timer=nil;
                
                [self  stopSearch];
                
                if ([_timelineConfig isRunning]) {
                    [_timelineConfig stop];
                }
   [self showAlertViewWithTitle:nil message:root_peizhi_chenggong  cancelButtonTitle:root_Yes];
                
            }
            
        }else{
           
        }
        
    } failure:^(NSError *error) {
      
    }];



}


-(void)doneSearchDeviceAutoThread{
    //进行一键配置
    NSLog(@"一键配置开始");
    [self OnSend:(ELIAN_SEND_V1 | ELIAN_SEND_V4) SSID:self.ipName.text PSWD:self.pswd.text];
    
    
    __weak AddDeviceViewController* selfView = self;
    if ( _timelineConfig == nil) {
        _timelineConfig = [[EasyTimeline alloc] init];
    }
    
    _timelineConfig.duration		= 240;
    _timelineConfig.tickPeriod	= 3;
    _timelineConfig.tickBlock		= ^void (NSTimeInterval time, EasyTimeline *timeline) {

        int timers = (int)(time/3.0 + 0.5);
        if ((timers%2 == 0)) {
             //进行一键配置
            NSLog(@"进行一键配置");
            [self OnSend:(ELIAN_SEND_V1 ) SSID:self.ipName.text PSWD:self.pswd.text];
        }else{
            [selfView stopSmartConfig];
             NSLog(@"停止配置，查找设备");
            UdpCheckUtl *udpCheck = [[UdpCheckUtl alloc]init];
            [udpCheck startUdpCheck];
        }

    };
    _timelineConfig.completionBlock = ^void (EasyTimeline *timeline) {
        //查找完成
         NSLog(@"停止配置");
           _timer.fireDate=[NSDate distantFuture];
          _timer=nil;
        
        if (![myAlertView isHidden]) {
            [myAlertView dismissAnimated:YES];
        }
        
        [selfView  stopSearch];
    };

    
    [_timelineConfig start];
    [[NSRunLoop currentRunLoop] run];

}

-(void)stopSmartConfig{
    if (context!=nil) {
        
        
        
        //////// ////////////////// ////////////////////////////////
        //////////////////////   ////////////////////////////注销4
//    elianStop(context);
//     elianDestroy(context);
        
        
    }
   
    context = NULL;
}


-(void)stopSearch{
    
    if (_timelineConfig!=nil &&[_timelineConfig hasStarted]) {
        
        [_timelineConfig stop];
         _timelineConfig = nil;
    }
    if(isSearching){
        if (context)
        {
            NSLog(@"查找完成");
            
           
          //////// ////////////////// ////////////////////////////////
         //////////////////////   ////////////////////////////注销5
//            elianStop(context);
//           elianDestroy(context);
            
            
            context = NULL;
        }
        
        NSLog(@"OnStop");
    }
   

}



-(void)viewDidDisappear:(BOOL)animated{

_timer.fireDate=[NSDate distantFuture];
    _timer=nil;
    
}




#pragma mark UDP检测


//- (IBAction)pullBack:(id)sender {
//    
//     [self.navigationController popToRootViewControllerAnimated:YES];
//    
//  //  StationCellectViewController *backView=[[StationCellectViewController alloc]init];
//  //  [self presentViewController:backView animated:YES completion:nil];
//    
//}


@end

