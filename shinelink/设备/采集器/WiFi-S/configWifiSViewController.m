//
//  configWifiSViewController.m
//  ShinePhone
//
//  Created by sky on 2017/7/26.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "configWifiSViewController.h"

#import "ESPTouchTask.h"
#import "ESPTouchResult.h"
#import "ESP_NetUtil.h"
#import "ESPTouchDelegate.h"
#import "GifNewViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "loginViewController.h"
#import "GFWaterView.h"


#define WifiTime 120

@interface EspTouchDelegateImpl : NSObject<ESPTouchDelegate>

@end

@implementation EspTouchDelegateImpl

-(void) dismissAlert:(UIAlertView *)alertView
{
    [alertView dismissWithClickedButtonIndex:[alertView cancelButtonIndex] animated:YES];
}

-(void) showAlertWithResult: (ESPTouchResult *) result
{
 //   NSString *title = nil;
  //  NSString *message = [NSString stringWithFormat:@"%@ is connected to the wifi" , result.bssid];
//    NSTimeInterval dismissSeconds = 3.5;
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    [alertView show];
//    [self performSelector:@selector(dismissAlert:) withObject:alertView afterDelay:dismissSeconds];
}

-(void) onEsptouchResultAddedWithResult: (ESPTouchResult *) result
{
    NSLog(@"EspTouchDelegateImpl onEsptouchResultAddedWithResult bssid: %@", result.bssid);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showAlertWithResult:result];
    });
}

@end

@interface configWifiSViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) NSTimer * timer;
@property (nonatomic, weak) NSTimer * timerStop;
@property(nonatomic,strong)UIButton *setButton;
@property(nonatomic,strong)NSString *timeLableString;
@property(nonatomic,strong)NSString *firstLableString;
@property(nonatomic,strong)UIView *animationView;
@property(nonatomic,strong)UILabel *timeLable;
@property(nonatomic,strong)NSString *isNewWIFI;

@property (nonatomic, assign) BOOL _isConfirmState;
@property (nonatomic, strong) NSCondition *_condition;
@property (atomic, strong) ESPTouchTask *_esptouchTask;
@property(nonatomic,strong)NSString *bssid;
@property (nonatomic, strong) EspTouchDelegateImpl *_esptouchDelegate;

@property (nonatomic, assign) BOOL isFirstConfig;
@property(nonatomic,assign)float noticeH;

@end

@implementation configWifiSViewController


-(void)viewWillDisappear:(BOOL)animated{
     [self cancel];
    if (_timeLable) {
        _timeLable.text=@"";
    }
    
 
    
}

-(void)goBackToFirst{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:MainColor];
  
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_back style:UIBarButtonItemStylePlain target:self action:@selector(goBackToFirst)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    self.title = [NSString stringWithFormat:@"%@ ShineWiFi-S",root_set];
    self.view.backgroundColor=MainColor;
    
    self._condition = [[NSCondition alloc]init];
    self._esptouchDelegate = [[EspTouchDelegateImpl alloc]init];
    
        [self initUI];
    
        _bssid=[[self fetchNetInfo] objectForKey:@"BSSID"];
    
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
    
}

- (void)getSignalStrength{
    UIApplication *app = [UIApplication sharedApplication];
   // NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    
    NSArray *subviews;
    if ([[app valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        subviews = [[[[app valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    } else {
        subviews = [[[app valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    }
    
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
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    
    [self.view addSubview:_scrollView];
    
    
    NSArray *noticeName=@[root_lianjie_luyouqi,root_wifi_tishi_2];
    
    UILabel *noticeLable=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 20*HEIGHT_SIZE, 30*NOW_SIZE,20*HEIGHT_SIZE)];
    noticeLable.text=@"*";
    noticeLable.textAlignment=NSTextAlignmentRight;
    noticeLable.textColor=[UIColor whiteColor];
    noticeLable.numberOfLines=0;
    noticeLable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:noticeLable];
    
    for (int i=0; i<noticeName.count; i++) {
        float W=260*NOW_SIZE;
        CGRect fcRect = [noticeName[i] boundingRectWithSize:CGSizeMake(W, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12 *HEIGHT_SIZE]} context:nil];
        
        UILabel *noticeLable=[[UILabel alloc]initWithFrame:CGRectMake(40*NOW_SIZE, 20*HEIGHT_SIZE+_noticeH, W,fcRect.size.height)];
        noticeLable.text=[NSString stringWithFormat:@"%d.%@",i+1,noticeName[i]];
        noticeLable.textAlignment=NSTextAlignmentLeft;
        noticeLable.textColor=[UIColor whiteColor];
        noticeLable.numberOfLines=0;
        noticeLable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:noticeLable];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(40*NOW_SIZE, 20*HEIGHT_SIZE+_noticeH+fcRect.size.height+5*HEIGHT_SIZE, W,LineWidth)];
        lineView.backgroundColor=COLOR(255, 255, 255, 0.6);
        [_scrollView addSubview:lineView];
        
        _noticeH=fcRect.size.height+_noticeH+10*HEIGHT_SIZE;
    }
    
    
    
    
    float lableHeigh=40*HEIGHT_SIZE;
    float twoHeigh=5*HEIGHT_SIZE;
  float sizeH1=_noticeH+10*HEIGHT_SIZE;
  
    
    UILabel *wifiName=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, sizeH1+twoHeigh*4, 100*NOW_SIZE,lableHeigh )];
    wifiName.text=root_peizhi_shinewifi_E_mingzi;
    wifiName.textAlignment=NSTextAlignmentRight;
    wifiName.textColor=[UIColor whiteColor];
    wifiName.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:wifiName];
    
    self.ipName = [[UITextField alloc] initWithFrame:CGRectMake(105*NOW_SIZE, sizeH1+twoHeigh*4, 180*NOW_SIZE,lableHeigh)];
    self.ipName.placeholder = root_peizhi_shinewifi_name;
    //self.ssidTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.ipName.secureTextEntry = NO;
    self.ipName.textColor = [UIColor whiteColor];
    self.ipName.tintColor = [UIColor whiteColor];
    [self.ipName setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.ipName setValue:[UIFont systemFontOfSize:9*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.ipName.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:_ipName];
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(105*NOW_SIZE, sizeH1+twoHeigh*4+lableHeigh-7*HEIGHT_SIZE, 180*NOW_SIZE,LineWidth )];
    view1.backgroundColor=[UIColor lightTextColor];
    [_scrollView addSubview:view1];
    
    UILabel *Password=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, sizeH1+twoHeigh*5+lableHeigh, 100*NOW_SIZE,lableHeigh)];
    Password.text=root_peizhi_shinewifi_mima;
    Password.textAlignment=NSTextAlignmentRight;
    Password.textColor=[UIColor whiteColor];
    Password.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:Password];
    
    self.pswd = [[UITextField alloc] initWithFrame:CGRectMake(105*NOW_SIZE, sizeH1+twoHeigh*5+lableHeigh, 180*NOW_SIZE,lableHeigh)];
    self.pswd.placeholder = root_peizhi_shinewifi_shuru_mima;
    //self.ssidTextField.keyboardType = UIKeyboardTypeASCIICapable;
    //self.pswd.secureTextEntry = NO;
    self.pswd.textColor = [UIColor whiteColor];
    self.pswd.tintColor = [UIColor whiteColor];
    [self.pswd setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.pswd setValue:[UIFont systemFontOfSize:9*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.pswd.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
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
        
        _isFirstConfig=YES;
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
        
            self._isConfirmState=NO;
            [self cancel];
           [self StopTime];
        
    }
    
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
        if (_SnString==nil || _SnString==NULL||([_SnString isEqual:@""] )){
        
        }else{
          _timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getNET) userInfo:nil repeats:YES];
        }
      
    }
    
    if (!_timerStop) {
        _timerStop = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clickAnimation:) userInfo:nil repeats:YES];
    }
    
    
        self._isConfirmState=YES;
        [self tapConfirmForResults];
 
    
    
}



-(void)StopConfigerUI{
    _pswd.userInteractionEnabled=YES;
    _ipName.userInteractionEnabled=YES;
    
    [_setButton setBackgroundImage:IMAGE(@"peizhi_btn.png") forState:UIControlStateNormal];
    [_setButton setBackgroundImage:IMAGE(@"peizhi_btn_click.png") forState:UIControlStateHighlighted];
    [_setButton setTitle:root_set forState:UIControlStateNormal];
    
    _timeLableString=_firstLableString;
    
    //  NSString *setButtonValue=[NSString stringWithFormat:@"%@s",_timeLableString];
    
    _timeLable.text=@"";
     [self cancel];
    [self StopTime];
  

}

-(void)StopTime{
    
    _timer.fireDate=[NSDate distantFuture];
    _timer=nil;
    
    _timerStop.fireDate=[NSDate distantFuture];
    _timerStop=nil;
     
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
        
        
         [self cancel];
        [self StopTime];
  
        
        _timeLable.text=@"";
        
        [self showAlertViewWithTitle:nil message:root_wifi_tiaozhuan_tishi cancelButtonTitle:root_Yes];
        
        //  _isNewWIFI=@"1";
     
            GifNewViewController *get=[[GifNewViewController alloc]init];
            [self.navigationController pushViewController:get animated:NO];

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


//WIFI-S 配置


- (void) tapConfirmForResults
{
    // do confirm
    if (self._isConfirmState)
    {
        // [self._spinner startAnimating];
        // [self enableCancelBtn];
        NSLog(@"ESPViewController do confirm action...");
        dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSLog(@"ESPViewController do the execute work...");
            // execute the task
            NSArray *esptouchResultArray = [self executeForResults];
            // show the result to the user in UI Main Thread
            dispatch_async(dispatch_get_main_queue(), ^{
                //   [self._spinner stopAnimating];
                //     [self enableConfirmBtn];
                
                ESPTouchResult *firstResult = [esptouchResultArray objectAtIndex:0];
                // check whether the task is cancelled and no results received
                if (!firstResult.isCancelled)
                {
                    NSMutableString *mutableStr = [[NSMutableString alloc]init];
                    NSUInteger count = 0;
                    // max results to be displayed, if it is more than maxDisplayCount,
                    // just show the count of redundant ones
                    const int maxDisplayCount = 5;
                    if ([firstResult isSuc])
                    {
                        
                        for (int i = 0; i < [esptouchResultArray count]; ++i)
                        {
                            ESPTouchResult *resultInArray = [esptouchResultArray objectAtIndex:i];
                            [mutableStr appendString:[resultInArray description]];
                            [mutableStr appendString:@"\n"];
                            count++;
                            if (count >= maxDisplayCount)
                            {
                                break;
                            }
                        }
                        
                        if (count < [esptouchResultArray count])
                        {
                            [mutableStr appendString:[NSString stringWithFormat:@"\nthere's %lu more result(s) without showing\n",(unsigned long)([esptouchResultArray count] - count)]];
                        }
     //   [[[UIAlertView alloc]initWithTitle:@"Execute Result" message:mutableStr delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil]show];
                        [self showToastViewWithTitle:root_wifi_lianjie_luyouqi];
                        
                    }else{
//                        [[[UIAlertView alloc]initWithTitle:@"Execute Result" message:@"Esptouch fail" delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil]show];
                        
                        if (_isFirstConfig) {
                         [self tapConfirmForResults];
                            _isFirstConfig=NO;
                        }
                        
                    }
                }
                
            });
        });
    }
    // do cancel
    else
    {
        //  [self._spinner stopAnimating];
        //   [self enableConfirmBtn];
        NSLog(@"ESPViewController do cancel action...");
        //  [self cancel];
    }
}

- (void) cancel
{
    [self._condition lock];
    if (self._esptouchTask != nil)
    {
        [self._esptouchTask interrupt];
    }
    [self._condition unlock];
}

#pragma mark - the example of how to use executeForResults
- (NSArray *) executeForResults
{
    [self._condition lock];
    NSString *apSsid = self.ipName.text;
    NSString *apPwd = self.pswd.text;
    NSString *apBssid = self.bssid;
    //  int taskCount = [self._taskResultCountTextView.text intValue];
    int taskCount = 1;
    self._esptouchTask =[[ESPTouchTask alloc]initWithApSsid:apSsid andApBssid:apBssid andApPwd:apPwd];
    // set delegate
    [self._esptouchTask setEsptouchDelegate:self._esptouchDelegate];
    [self._condition unlock];
    NSArray * esptouchResults = [self._esptouchTask executeForResults:taskCount];
    NSLog(@"ESPViewController executeForResult() result is: %@",esptouchResults);
    return esptouchResults;
}





- (NSDictionary *)fetchNetInfo
{
    NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
    //    NSLog(@"%s: Supported interfaces: %@", __func__, interfaceNames);
    
    NSDictionary *SSIDInfo;
    for (NSString *interfaceName in interfaceNames) {
        SSIDInfo = CFBridgingRelease(
                                     CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
        //        NSLog(@"%s: %@ => %@", __func__, interfaceName, SSIDInfo);
        
        BOOL isNotEmpty = (SSIDInfo.count > 0);
        if (isNotEmpty) {
            break;
        }
    }
    return SSIDInfo;
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
                
                
       
                
                _timeLableString=_firstLableString;
                _timeLable.text=@"";
                
                 [self cancel];
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
