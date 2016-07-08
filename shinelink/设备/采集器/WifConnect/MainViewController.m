//
//  UDPViewController.m
//  udp
//
//  Created by Jakey on 15/1/12.
//  Copyright (c) 2015年 jakey. All rights reserved.
//

#import "MainViewController.h"
#import "UINavigationController+CustomNavigation.h"
#import "AppMacro.h"
#import "InfoSend.h"
#include "JDStatusBarNotification.h"
#import "Reachability.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CommonCrypto/CommonDigest.h>
#import "StationCellectViewController.h"

@interface MainViewController()
@property (nonatomic, strong) UIScrollView *scrollView;

@end


@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor=MainColor;
    self.title=root_peizhi_shinewifi;
    
    //网络状态
    [self initUI];
    
    [self connectUDP];
    
   // [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:UIBarMetricsDefault];
    _ssidTextField.delegate = self;
    _wskeyTextField.delegate = self;
    _wakeyTextField2.delegate = self;
    
//    UITapGestureRecognizer *wskeyImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wskeyImageViewClick)];
//    [_wskeyShowImageView addGestureRecognizer:wskeyImageViewTap];
//    UITapGestureRecognizer *wakeyImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wakeyImageViewClick)];
//    [_wakeyShowImageView addGestureRecognizer:wakeyImageViewTap];
}


-(void)initUI{
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];

    float sizeH1=10*HEIGHT_SIZE;
    
    UIImageView *pwdBgImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 15*HEIGHT_SIZE, 300*NOW_SIZE,60*HEIGHT_SIZE )];
    pwdBgImageView1.image = IMAGE(@"main1.jpg");
    pwdBgImageView1.userInteractionEnabled = YES;
    [_scrollView addSubview:pwdBgImageView1];

    
   _connectWifiLabel=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 300*NOW_SIZE,50*HEIGHT_SIZE )];
    _connectWifiLabel.text=root_peizhi_shinewifi_yi;
    _connectWifiLabel.textAlignment=NSTextAlignmentLeft;
    _connectWifiLabel.textColor=[UIColor whiteColor];
    _connectWifiLabel.numberOfLines=0;
    _connectWifiLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
//    _connectWifiLabel.layer.borderWidth=1;
//    _connectWifiLabel.layer.cornerRadius=5;
//    _connectWifiLabel.layer.borderColor=[UIColor whiteColor].CGColor;
    [pwdBgImageView1 addSubview:_connectWifiLabel];
    
    UIImageView *pwdBgImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 85*HEIGHT_SIZE, 300*NOW_SIZE,100*HEIGHT_SIZE+sizeH1 )];
    pwdBgImageView2.image = IMAGE(@"222.jpg");
    pwdBgImageView2.userInteractionEnabled = YES;
    [_scrollView addSubview:pwdBgImageView2];
    
    
    _connectModemLabel=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 300*NOW_SIZE,40*HEIGHT_SIZE )];
    _connectModemLabel.text=root_peizhi_shinewifi_er;
    _connectModemLabel.textAlignment=NSTextAlignmentLeft;
    _connectModemLabel.textColor=[UIColor whiteColor];
    _connectModemLabel.numberOfLines=0;
    _connectModemLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
//    _connectModemLabel.layer.borderWidth=1;
//    _connectModemLabel.layer.cornerRadius=5;
//    _connectModemLabel.layer.borderColor=[UIColor whiteColor].CGColor;
    [pwdBgImageView2 addSubview:_connectModemLabel];
    
    _ssidLabel=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 50*HEIGHT_SIZE, 100*NOW_SIZE,20*HEIGHT_SIZE )];
    _ssidLabel.text=@"SSID:";
    _ssidLabel.textAlignment=NSTextAlignmentRight;
    _ssidLabel.textColor=[UIColor whiteColor];
    _ssidLabel.numberOfLines=0;
    _ssidLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView2 addSubview:_ssidLabel];
    
    self.ssidTextField = [[UITextField alloc] initWithFrame:CGRectMake(105*NOW_SIZE, 50*HEIGHT_SIZE, 180*NOW_SIZE,20*HEIGHT_SIZE )];
    self.ssidTextField.placeholder = root_peizhi_shinewifi_name;
    //self.ssidTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.ssidTextField.secureTextEntry = NO;
    self.ssidTextField.textColor = [UIColor whiteColor];
    self.ssidTextField.tintColor = [UIColor whiteColor];
    [self.ssidTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.ssidTextField setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.ssidTextField.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView2 addSubview:_ssidTextField];

    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(105*NOW_SIZE, 70*HEIGHT_SIZE, 180*NOW_SIZE,1*HEIGHT_SIZE )];
    view1.backgroundColor=[UIColor whiteColor];
    [pwdBgImageView2 addSubview:view1];
    
    _wskeyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 75*HEIGHT_SIZE, 100*NOW_SIZE,20*HEIGHT_SIZE )];
    _wskeyLabel.text=root_peizhi_shinewifi_mima;
    _wskeyLabel.textAlignment=NSTextAlignmentRight;
    _wskeyLabel.textColor=[UIColor whiteColor];
    _wskeyLabel.numberOfLines=0;
    _wskeyLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView2 addSubview:_wskeyLabel];
    
    self.wskeyTextField = [[UITextField alloc] initWithFrame:CGRectMake(105*NOW_SIZE, 75*HEIGHT_SIZE, 180*NOW_SIZE,20*HEIGHT_SIZE )];
    self.wskeyTextField.placeholder = root_peizhi_shinewifi_shuru_mima;
    //self.ssidTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.wskeyTextField.secureTextEntry = NO;
    self.wskeyTextField.textColor = [UIColor whiteColor];
    self.wskeyTextField.tintColor = [UIColor whiteColor];
    [self.wskeyTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.wskeyTextField setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.wskeyTextField.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView2 addSubview:_wskeyTextField];
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(105*NOW_SIZE, 95*HEIGHT_SIZE, 180*NOW_SIZE,1*HEIGHT_SIZE )];
    view2.backgroundColor=[UIColor whiteColor];
    [pwdBgImageView2 addSubview:view2];
    
    
    UIImageView *pwdBgImageView3= [[UIImageView alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 195*HEIGHT_SIZE+sizeH1, 300*NOW_SIZE,70*HEIGHT_SIZE )];
    pwdBgImageView3.image = IMAGE(@"333.jpg");
    pwdBgImageView3.userInteractionEnabled = YES;
    [_scrollView addSubview:pwdBgImageView3];
    

    UILabel *wifi=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 300*NOW_SIZE,25*HEIGHT_SIZE)];
    wifi.text=root_peizhi_shinewifi_xiugai_mima;
    wifi.textAlignment=NSTextAlignmentLeft;
    wifi.textColor=[UIColor whiteColor];
    wifi.numberOfLines=0;
    wifi.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
//    wifi.layer.borderWidth=1;
//    wifi.layer.cornerRadius=5;
   // wifi.layer.borderColor=[UIColor whiteColor].CGColor;
    [pwdBgImageView3 addSubview:wifi];

    
    UILabel *wifiName=[[UILabel alloc]initWithFrame:CGRectMake(2*NOW_SIZE, 35*HEIGHT_SIZE, 105*NOW_SIZE,20*HEIGHT_SIZE )];
    wifiName.text=root_peizhi_shinewifi_xin_mima;
    wifiName.textAlignment=NSTextAlignmentRight;
    wifiName.textColor=[UIColor whiteColor];
    wifiName.numberOfLines=0;
    wifiName.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView3 addSubview:wifiName];
    
    self.wakeyTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(110*NOW_SIZE, 35*HEIGHT_SIZE, 180*NOW_SIZE,20*HEIGHT_SIZE )];
    self.wakeyTextField2.placeholder = root_peizhi_shinewifi_shuru_wifi_mima;
    //self.ssidTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.wakeyTextField2.secureTextEntry = NO;
    self.wakeyTextField2.textColor = [UIColor whiteColor];
    self.wakeyTextField2.tintColor = [UIColor whiteColor];
    [self.wakeyTextField2 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.wakeyTextField2 setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.wakeyTextField2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView3 addSubview:_wakeyTextField2];
    
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(110*NOW_SIZE, 55*HEIGHT_SIZE, 180*NOW_SIZE,1*HEIGHT_SIZE )];
    view3.backgroundColor=[UIColor whiteColor];
    [pwdBgImageView3 addSubview:view3];
    
    UIImageView *pwdBgImageView4= [[UIImageView alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 275*HEIGHT_SIZE+sizeH1, 300*NOW_SIZE,95*HEIGHT_SIZE )];
    pwdBgImageView4.image = IMAGE(@"444.jpg");
    pwdBgImageView4.userInteractionEnabled = YES;
    [_scrollView addSubview:pwdBgImageView4];
    
    UILabel *SN=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 300*NOW_SIZE,25*HEIGHT_SIZE)];
    SN.text=root_peizhi_shinewifi_shuru_chaxun_xinxi;
    SN.textAlignment=NSTextAlignmentLeft;
    SN.textColor=[UIColor whiteColor];
    SN.numberOfLines=0;
    SN.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    //    wifi.layer.borderWidth=1;
    //    wifi.layer.cornerRadius=5;
    // wifi.layer.borderColor=[UIColor whiteColor].CGColor;
    [pwdBgImageView4 addSubview:SN];
    
    
    UILabel *SnName=[[UILabel alloc]initWithFrame:CGRectMake(2*NOW_SIZE, 35*HEIGHT_SIZE, 105*NOW_SIZE,20*HEIGHT_SIZE )];
    SnName.text=root_peizhi_shinewifi_xuliehao;
    SnName.textAlignment=NSTextAlignmentRight;
    SnName.textColor=[UIColor whiteColor];
    SnName.numberOfLines=0;
    SnName.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView4 addSubview:SnName];
    
    _moduleNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(110*NOW_SIZE, 35*HEIGHT_SIZE, 180*NOW_SIZE,20*HEIGHT_SIZE )];
    //_moduleNameLabel.text=@"Serial number:";
    _moduleNameLabel.textAlignment=NSTextAlignmentLeft;
    _moduleNameLabel.textColor=[UIColor whiteColor];
    _moduleNameLabel.numberOfLines=0;
    _moduleNameLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView4 addSubview:_moduleNameLabel];
    
    UILabel *codeName=[[UILabel alloc]initWithFrame:CGRectMake(2*NOW_SIZE, 60*HEIGHT_SIZE, 105*NOW_SIZE,20*HEIGHT_SIZE )];
    codeName.text=root_peizhi_shinewifi_jiaoyanma;
    codeName.textAlignment=NSTextAlignmentRight;
    codeName.textColor=[UIColor whiteColor];
    codeName.numberOfLines=0;
    codeName.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView4 addSubview:codeName];
    
    _checkCodeLabel=[[UILabel alloc]initWithFrame:CGRectMake(110*NOW_SIZE, 60*HEIGHT_SIZE, 180*NOW_SIZE,20*HEIGHT_SIZE )];
    //_moduleNameLabel.text=@"Serial number:";
    _checkCodeLabel.textAlignment=NSTextAlignmentLeft;
    _checkCodeLabel.textColor=[UIColor whiteColor];
    _checkCodeLabel.numberOfLines=0;
    _checkCodeLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [pwdBgImageView4 addSubview:_checkCodeLabel];
    
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,400*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    //    [goBut.layer setMasksToBounds:YES];
    //    [goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_set forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut addTarget:self action:@selector(clickSetButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:goBut];


}



-(void)connectUDP{
    NSError *error = nil;
    if (!_udpSocket)
    {
        _udpSocket=nil;
    }
    _udpSocket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [ConnetService shareConnetService].udpSocket = _udpSocket;
    [ConnetService shareConnetService].delegate = self;
    
    if (error!=nil) {
        NSLog(@"连接失败：%@",error);
    }else{
        NSLog(@"连接成功");
    }
    if (![_udpSocket bindToPort:PORT error:&error]) {
        NSLog(@"Error starting server (bind): %@", error);
        return;
    }
    if (![_udpSocket enableBroadcast:YES error:&error]) {
        NSLog(@"Error enableBroadcast (bind): %@", error);
        return;
    }
    if (![_udpSocket beginReceiving:&error]) {
        [_udpSocket close];
        NSLog(@"Error starting server (recv): %@", error);
        return;
    }
}

- (void)clickSetButton:(id)sender {
    BOOL isEmptySSID = _ssidTextField.text.length==0;
    BOOL isEmptyWskey = _wskeyTextField.text.length==0;
    BOOL isEmptyWakey = _wakeyTextField2.text.length==0;
    if (isEmptySSID && isEmptyWskey && isEmptyWakey) {
        [ConnetService shareConnetService].type = k_connect_module;
    }else if (isEmptyWakey && !isEmptySSID){
        if (!isEmptyWskey && _wskeyTextField.text.length > 7) {
            [ConnetService shareConnetService].type = k_connect_wsss;
        }else{
            [JDStatusBarNotification showWithStatus:NSLocalizedString(@"Prog_SetPwdFail",nil) dismissAfter:2.0 styleName:JDStatusBarStyleWarning];
            return;
        }
    }else if (!isEmptyWakey){
        if (!isEmptySSID && !isEmptyWskey && _wskeyTextField.text.length > 7 && _wakeyTextField2.text.length > 7) {
            [ConnetService shareConnetService].type = k_reset_passwork;
        }else{
            [JDStatusBarNotification showWithStatus:NSLocalizedString(@"Prog_SetPwdFail",nil) dismissAfter:2.0 styleName:JDStatusBarStyleWarning];
            return;
        }
    }
    [[ConnetService shareConnetService] beginSetup];
}




//-(void)wskeyImageViewClick{
//    _wskeyShowImageView.highlighted = !_wskeyShowImageView.highlighted;
//    _wskeyTextField.secureTextEntry = !_wskeyShowImageView.highlighted;
//}
//
//-(void)wakeyImageViewClick{
//    _wakeyShowImageView.highlighted = !_wakeyShowImageView.highlighted;
//    _wakeyTextField2.secureTextEntry = !_wakeyShowImageView.highlighted;
// 
//}


#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]){
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (_ssidTextField == textField){
        if ([toBeString length] > 25) {
            textField.text = [toBeString substringToIndex:25];
            return NO;
        }
    }
    if (_wskeyTextField == textField){
        if ([toBeString length] > 22){
            textField.text = [toBeString substringToIndex:22];
            return NO;
        }
    }
    if (_wakeyTextField2 == textField){
        if ([toBeString length] > 22){
            textField.text = [toBeString substringToIndex:22];
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark GCDAsyncUdpSocketDelegate
-(void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address
{
    NSError *error = nil;
    NSLog(@"Message didConnectToAddress: %@",[[NSString alloc]initWithData:address encoding:NSUTF8StringEncoding]);
    [_udpSocket beginReceiving:&error];
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError *)error
{
    NSLog(@"Message didNotConnect: %@",error);
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"Message didNotSendDataWithTag: %@",error);
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    NSString *receiveString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Message didReceiveData :%@", receiveString);
    
    InfoSend *infoSend = [[InfoSend alloc] init];
    infoSend.wsssid = _ssidTextField.text;
    infoSend.wskey = [NSString stringWithFormat:@"WPA2PSK,AES,%@",_wskeyTextField.text];
    infoSend.wakey = [NSString stringWithFormat:@"WPA2PSK,AES,%@",_wakeyTextField2.text];
    [[ConnetService shareConnetService] reciveData:data infoSend:infoSend];
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"Message didSendDataWithTag");
}

-(void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error
{
    [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleGray];
    [JDStatusBarNotification showWithStatus:error.localizedDescription dismissAfter:2.0 styleName:JDStatusBarStyleWarning];
    NSLog(@"Message withError: %@",error);
}

#pragma mark ConnetServiceDelegate
-(void)updateModuleInfo:(ModuleInfo *)moduleInfo{
    NSLog(@"%@,%@",moduleInfo.name,moduleInfo.checkCode);
    if (moduleInfo.name.length > 0) {
        _moduleNameLabel.text = moduleInfo.name;
    }
    if (moduleInfo.checkCode.length > 0) {
        _checkCodeLabel.text = moduleInfo.checkCode;
    }
}



@end
