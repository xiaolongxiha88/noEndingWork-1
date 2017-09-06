//
//  AddDeviceViewController.m
//  smartYogurtMaker
//
//  Created by mqw on 15/6/3.
//  Copyright (c) 2015年 mqw. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "DeviceManageViewController.h"
#import "GifConfigViewController.h"
#import "GFWaterView.h"
#import "loginViewController.h"
#import "elian.h"
#import "EasyTimeline.h"
#import "UdpCheckUtl.h"
#import "Toast+UIView.h"
#import "StationCellectViewController.h"
#import "GifNewViewController.h"




#define WifiTime 200




@interface AddDeviceViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) NSTimer * timer;
@property (nonatomic, weak) NSTimer * timerStop;
@property(nonatomic,strong)UIButton *setButton;
@property(nonatomic,strong)NSString *timeLableString;
@property(nonatomic,strong)NSString *firstLableString;
@property(nonatomic,strong)UIView *animationView;
@property(nonatomic,strong)UILabel *timeLable;
@property(nonatomic,strong)NSString *isNewWIFI;

@property(nonatomic,assign)float noticeH;


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
    if (_timeLable) {
         _timeLable.text=@"";
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isNewWIFI=@"noValue";
    
    if (![_OssType isEqualToString:@"1"]) {
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_back style:UIBarButtonItemStylePlain target:self action:@selector(goBackToFirst)];
        rightItem.tag=10;
        self.navigationItem.rightBarButtonItem=rightItem;
    }

    
    
    [self initUI];
    _deviceArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
            self.title = root_peizhi_shinewifi_E;
  

     self.view.backgroundColor=MainColor;
    
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *ssid = [delegate getWifiName];

    
    if(ssid!=nil&&ssid.length>0 )
    {
        self.ipName.text = ssid;
    }else{
        
        [self showAlertViewWithTitle:nil message:root_lianjie_luyouqi cancelButtonTitle:root_OK];
        return;
    }
    
     [self getSignalStrength];
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotDeviceByScan:) name:kOnGotDeviceByScan object:nil];
}

- (void)getSignalStrength{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSString *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    
    int signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] intValue];
    if (signalStrength<2) {
        [self showAlertViewWithTitle:nil message:root_wifi_xinhao_tishi cancelButtonTitle:root_OK];
    }
    
    NSLog(@"signal= %d", signalStrength);
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_ipName resignFirstResponder];
    [_pswd resignFirstResponder];
}

-(void)initUI{
    _noticeH=0;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
 
    [self.view addSubview:_scrollView];
    
    NSArray *noticeName=@[root_lianjie_luyouqi,root_wifi_tishi_2,root_wifi_tishi_3];
    
    for (int i=0; i<noticeName.count; i++) {
        CGRect fcRect = [noticeName[i] boundingRectWithSize:CGSizeMake(300*NOW_SIZE, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12 *HEIGHT_SIZE]} context:nil];
        
        UILabel *noticeLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE+_noticeH, 300*NOW_SIZE,fcRect.size.height)];
        noticeLable.text=[NSString stringWithFormat:@"%d.%@",i+1,noticeName[i]];
        noticeLable.textAlignment=NSTextAlignmentCenter;
        noticeLable.textColor=[UIColor whiteColor];
        noticeLable.numberOfLines=0;
        noticeLable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:noticeLable];
        
        _noticeH=fcRect.size.height+_noticeH+10*HEIGHT_SIZE;
    }
    
    
    

    float lableHeigh=40*HEIGHT_SIZE;
    float twoHeigh=5*HEIGHT_SIZE;
            float sizeH1=_noticeH;
     UILabel *wifiName=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, sizeH1+twoHeigh*4, 100*NOW_SIZE,lableHeigh )];
    wifiName.text=root_peizhi_shinewifi_E_mingzi;
    wifiName.textAlignment=NSTextAlignmentRight;
    wifiName.textColor=[UIColor whiteColor];
    wifiName.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:wifiName];
    
    self.ipName = [[UITextField alloc] initWithFrame:CGRectMake(105*NOW_SIZE, sizeH1+twoHeigh*4, 180*NOW_SIZE,lableHeigh)];
    self.ipName.placeholder = root_peizhi_shinewifi_name;
    //self.ssidTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.ipName.secureTextEntry = NO;
    self.ipName.textColor = [UIColor whiteColor];
    self.ipName.tintColor = [UIColor whiteColor];
    [self.ipName setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.ipName setValue:[UIFont systemFontOfSize:9*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.ipName.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:_ipName];
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(105*NOW_SIZE, sizeH1+twoHeigh*4+lableHeigh-7*HEIGHT_SIZE, 180*NOW_SIZE,LineWidth )];
    view1.backgroundColor=[UIColor lightTextColor];
    [_scrollView addSubview:view1];
    
    UILabel *Password=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, sizeH1+twoHeigh*5+lableHeigh, 100*NOW_SIZE,lableHeigh)];
    Password.text=root_peizhi_shinewifi_mima;
    Password.textAlignment=NSTextAlignmentRight;
    Password.textColor=[UIColor whiteColor];
    Password.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:Password];
    
    self.pswd = [[UITextField alloc] initWithFrame:CGRectMake(105*NOW_SIZE, sizeH1+twoHeigh*5+lableHeigh, 180*NOW_SIZE,lableHeigh)];
    self.pswd.placeholder = root_peizhi_shinewifi_shuru_mima;
    //self.ssidTextField.keyboardType = UIKeyboardTypeASCIICapable;
    //self.pswd.secureTextEntry = NO;
    self.pswd.textColor = [UIColor whiteColor];
    self.pswd.tintColor = [UIColor whiteColor];
    [self.pswd setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.pswd setValue:[UIFont systemFontOfSize:9*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.pswd.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:_pswd];
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(105*NOW_SIZE, sizeH1+twoHeigh*5+lableHeigh*2-7*HEIGHT_SIZE, 180*NOW_SIZE,LineWidth )];
    view2.backgroundColor=[UIColor lightTextColor];
    [_scrollView addSubview:view2];
    
    _animationView=[[UIView alloc]initWithFrame:CGRectMake(0, sizeH1+twoHeigh*5+lableHeigh*2-20*HEIGHT_SIZE+60*HEIGHT_SIZE, SCREEN_Width,200*HEIGHT_SIZE)];
    [_scrollView addSubview:_animationView];

    float animationH=CGRectGetMaxY(_animationView.frame);
    _setButton =  [UIButton buttonWithType:UIButtonTypeCustom];
   _setButton.frame=CGRectMake(60*NOW_SIZE,sizeH1+twoHeigh*5+lableHeigh*2+25*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
//       [_setButton.layer setCornerRadius:_setButton.bounds.size.width/2];
//       [_setButton.layer setMasksToBounds:YES];
   [_setButton setBackgroundImage:IMAGE(@"peizhi_btn.png") forState:UIControlStateNormal];
     [_setButton setBackgroundImage:IMAGE(@"peizhi_btn_click.png") forState:UIControlStateHighlighted];
 [_setButton setTitle:root_set forState:UIControlStateNormal];
  _setButton.titleLabel.font=[UIFont systemFontOfSize: 18*HEIGHT_SIZE];
 [_setButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
   _setButton.selected=NO;
  [_scrollView addSubview:_setButton];
    
      _scrollView.contentSize = CGSizeMake(SCREEN_Width,animationH+160*HEIGHT_SIZE);
    
//    __block GFWaterView *waterView = [[GFWaterView alloc]initWithFrame:CGRectMake(60*NOW_SIZE, 40*HEIGHT_SIZE, 200*NOW_SIZE, 200*NOW_SIZE)];
//    waterView.backgroundColor = [UIColor clearColor];
//    [_animationView addSubview:waterView];
    
    _firstLableString=[NSString stringWithFormat:@"%d",WifiTime];
     _timeLableString=_firstLableString;
   // NSString *setButtonValue=[NSString stringWithFormat:@"%@s",_timeLableString];
    self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(120*NOW_SIZE, 105*HEIGHT_SIZE, 80*NOW_SIZE, 60*HEIGHT_SIZE)];
    self.timeLable.font=[UIFont systemFontOfSize:34*HEIGHT_SIZE];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    self.timeLable.textColor =[UIColor whiteColor];
    // self.timeLable.text =setButtonValue;
    [_animationView addSubview:_timeLable];
    
}


- (void)tapButton:(UIButton *)button{
    
    _setButton.selected = !_setButton.selected;
    if (button.isSelected) {
        [_setButton setBackgroundImage:IMAGE(@"peizhi_btn_2.png") forState:UIControlStateNormal];
        [_setButton setBackgroundImage:IMAGE(@"peizhi_btn_click_2.png") forState:UIControlStateHighlighted];
        [_setButton setTitle:root_stop_config forState:UIControlStateNormal];
        
        _pswd.userInteractionEnabled=NO;
        _ipName.userInteractionEnabled=NO;

        [self configFirst];
    
    }else{
        _pswd.userInteractionEnabled=YES;
        _ipName.userInteractionEnabled=YES;
        
        [_setButton setBackgroundImage:IMAGE(@"peizhi_btn.png") forState:UIControlStateNormal];
        [_setButton setBackgroundImage:IMAGE(@"peizhi_btn_click.png") forState:UIControlStateHighlighted];
        [_setButton setTitle:root_set forState:UIControlStateNormal];
   
        _timeLableString=_firstLableString;
        
      //  NSString *setButtonValue=[NSString stringWithFormat:@"%@s",_timeLableString];
        
 _timeLable.text=@"";
        
        
     
            [self StopTime];
            [self  stopSearch];
            if ([_timelineConfig isRunning]) {
                [_timelineConfig stop];
            }
       
        
        

    }
    
}





//WIFI-E 配置

-(void)StopConfigerUI{
    _pswd.userInteractionEnabled=YES;
    _ipName.userInteractionEnabled=YES;
    
    [_setButton setBackgroundImage:IMAGE(@"peizhi_btn.png") forState:UIControlStateNormal];
    [_setButton setBackgroundImage:IMAGE(@"peizhi_btn_click.png") forState:UIControlStateHighlighted];
    [_setButton setTitle:root_set forState:UIControlStateNormal];
    
    _timeLableString=_firstLableString;
    
    //  NSString *setButtonValue=[NSString stringWithFormat:@"%@s",_timeLableString];
    
    _timeLable.text=@"";
    
    [self StopTime];
    [self  stopSearch];
    if ([_timelineConfig isRunning]) {
        [_timelineConfig stop];
    }


}


- (void)clickAnimation:(id)sender {
    
    if ([_timeLableString intValue]>0) {
        _timeLableString=[NSString stringWithFormat:@"%d", [_timeLableString intValue]-1];
    }
    
    if ([_timeLableString intValue]==0) {
         _setButton.selected = !_setButton.selected;
        [_setButton setBackgroundImage:IMAGE(@"peizhi_btn.png") forState:UIControlStateNormal];
        [_setButton setBackgroundImage:IMAGE(@"peizhi_btn_click.png") forState:UIControlStateHighlighted];
        [_setButton setTitle:root_set forState:UIControlStateNormal];
        
        _timeLableString=_firstLableString;

      
        
        [self StopTime];
        [self  stopSearch];
        if ([_timelineConfig isRunning]) {
            [_timelineConfig stop];
               }

          _timeLable.text=@"";
        
          [self showAlertViewWithTitle:nil message:root_wifi_tiaozhuan_tishi cancelButtonTitle:root_Yes];
        
        
        
   // _isNewWIFI=@"0";
        
        
        if ([_isNewWIFI isEqualToString:@"1"]) {
            GifNewViewController *get=[[GifNewViewController alloc]init];
            [self.navigationController pushViewController:get animated:NO];
        }else{
            GifConfigViewController *get=[[GifConfigViewController alloc]init];
            [self.navigationController pushViewController:get animated:NO];
        }
        
       
        
    }
    
    
    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateInactive) {
        //iOS6锁屏事件
        NSLog(@"Sent to background by locking screen");
        [self StopConfigerUI];
    } else if (state == UIApplicationStateBackground) {
        CGFloat screenBrightness = [[UIScreen mainScreen] brightness];
        NSLog(@"Screen brightness: %f", screenBrightness);
        if (screenBrightness > 0.0) {
            //iOS6&iOS7 Home事件
            NSLog(@"Sent to background by home button/switching to other app");
        } else {
            //iOS7锁屏事件
                [self StopConfigerUI];
            NSLog(@"Sent to background by locking screen");
        }
    }

   
    
    NSString *setButtonValue=[NSString stringWithFormat:@"%@s",_timeLableString];
    _timeLable.text=setButtonValue;
    
 
    __block GFWaterView *waterView = [[GFWaterView alloc]initWithFrame:CGRectMake(60*NOW_SIZE, 40*HEIGHT_SIZE, 200*NOW_SIZE, 200*NOW_SIZE)];
    
    waterView.backgroundColor = [UIColor clearColor];
    
    [_animationView addSubview:waterView];
    //    self.waterView = waterView;
    
    [UIView animateWithDuration:2 animations:^{
        
        waterView.transform = CGAffineTransformScale(waterView.transform, 2, 2);
        
        waterView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [waterView removeFromSuperview];

    }];
    
 
    
}





-(void)goBackToFirst{
 [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 扫描到设备
//用户登陆成功回调
-(void)onGotDeviceByScan:(NSNotification*)noti{
    NSString* deviceMac = [noti.object objectForKey:@"deviceMac"];
    
    if (![_deviceArray containsObject:deviceMac]) {
        [_deviceArray addObject:deviceMac];
   //     int count =(int)[_deviceArray count];
       // NSLog(@"Countt=%d",count);
          NSLog(@"cellCount0=%ld",(long)self.cellCount0);
        
    }
    
}





//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.ipName resignFirstResponder];
    [self.pswd resignFirstResponder];
}


-(void)configFirst{

    if ([[_pswd text] isEqual:@""]) {
        _pswd.userInteractionEnabled=YES;
        _ipName.userInteractionEnabled=YES;
        _setButton.selected = !_setButton.selected;
        [_setButton setBackgroundImage:IMAGE(@"peizhi_btn.png") forState:UIControlStateNormal];
        [_setButton setBackgroundImage:IMAGE(@"peizhi_btn_click.png") forState:UIControlStateHighlighted];
        [_setButton setTitle:root_set forState:UIControlStateNormal];
        
        [self showAlertViewWithTitle:nil message:root_Enter_your_pwd cancelButtonTitle:root_Yes];
        return;
    }
    
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *ssid = [delegate getWifiName];
    
    
    //////// ////////////////// ////////////////////////////////
    //////////////////////   ////////////////////////////注销0
    
    if(ssid == nil )
    {
        _pswd.userInteractionEnabled=YES;
        _ipName.userInteractionEnabled=YES;
        _setButton.selected = !_setButton.selected;
        [_setButton setBackgroundImage:IMAGE(@"peizhi_btn.png") forState:UIControlStateNormal];
        [_setButton setBackgroundImage:IMAGE(@"peizhi_btn_click.png") forState:UIControlStateHighlighted];
        [_setButton setTitle:root_set forState:UIControlStateNormal];
        [self showAlertViewWithTitle:nil message:root_lianjie_luyouqi cancelButtonTitle:root_Yes];
        return;
    }
    
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(StopConfigerUI) name:@"StopConfigerUI" object:nil];
    
    //添加定时器
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getNET) userInfo:nil repeats:YES];
    }
    
    if (!_timerStop) {
        _timerStop = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clickAnimation:) userInfo:nil repeats:YES];
    }
    

        [self deviceSearchStart];
  
    
    
}

//开始查找设备
-(void) deviceSearchStart{
    
    _deviceArray = nil;
    _deviceArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    isSearching= true;
    [self performSelectorInBackground:@selector(doneSearchDeviceAutoThread) withObject:nil];
}




-(void)StopTime{

    _timer.fireDate=[NSDate distantFuture];
    _timer=nil;

    _timerStop.fireDate=[NSDate distantFuture];
    _timerStop=nil;
    
    

    
}




-(void)getNET{

    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"datalogSn":_SnString} paramarsSite:@"/newDatalogAPI.do?op=getDatalogInfo" sucessBlock:^(id content) {
        
        NSLog(@"getDatalogInfo: %@", content);
        if (content) {
            NSString *LostValue=content[@"lost"];
            _isNewWIFI=[NSString stringWithFormat:@"%@",content[@"isNewWIFI"]];
            //_isNewWIFI=content[@"isNewWIFI"];
            
            if ([LostValue intValue]==0) {
                
           
                _pswd.userInteractionEnabled=YES;
                _ipName.userInteractionEnabled=YES;
                _setButton.selected = !_setButton.selected;
                [_setButton setBackgroundImage:IMAGE(@"peizhi_btn.png") forState:UIControlStateNormal];
                [_setButton setBackgroundImage:IMAGE(@"peizhi_btn_click.png") forState:UIControlStateHighlighted];
                [_setButton setTitle:root_set forState:UIControlStateNormal];
                
               
                [self  stopSearch];
                
                if ([_timelineConfig isRunning]) {
                    [_timelineConfig stop];
                }
                
                _timeLableString=_firstLableString;
             _timeLable.text=@"";
                
                [self StopTime];
 

                
                
                if ([_LogType isEqualToString:@"1"]) {
                             [self showAlertViewWithTitle:root_peizhi_chenggong message:root_shuaxin_liebiao cancelButtonTitle:root_Yes];
                     [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
                    loginViewController *goView=[[loginViewController alloc]init];
                    goView.LogType=@"1";
                    [self.navigationController pushViewController:goView animated:NO];
                    
                }else{
                
                  [self showAlertViewWithTitle:root_peizhi_chenggong message:root_shuaxin_liebiao cancelButtonTitle:root_Yes];
                }
                
              
                
            }
            
        }else{
           
        }
        
    } failure:^(NSError *error) {
      
    }];



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
        //////////////////////   ////////////////////////////注销1  2
//       elianStop(context);
//        elianDestroy(context);
        
        
        
        context = NULL;
    }
    
    //////// ////////////////// ////////////////////////////////
    //////////////////////   ////////////////////////////注销2  1
 //context = elianNew(NULL, 0, target, flag);
    
    
    if (context == NULL)
    {
        NSLog(@"OnSend elianNew fail");
        return;
    }
    
    
    
    //////// ////////////////// ////////////////////////////////
    //////////////////////   ////////////////////////////注销3  4
    
//    elianPut(context, TYPE_ID_AM, (char *)&authmode, 1);
//    elianPut(context, TYPE_ID_SSID, (char *)ssid, strlen(ssid));
//    elianPut(context, TYPE_ID_PWD, (char *)password, strlen(password));
//    elianStart(context);

    
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
        //////////////////////   ////////////////////////////注销4  2
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
         //////////////////////   ////////////////////////////注销5  2
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

