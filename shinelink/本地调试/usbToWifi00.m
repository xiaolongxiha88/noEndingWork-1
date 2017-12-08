//
//  usbToWifi00.m
//  ShinePhone
//
//  Created by sky on 2017/12/1.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifi00.h"
#import "SHBQRView.h"
#import "useToWifiView1.h"
#import "MMScanViewController.h"

@interface usbToWifi00 ()<SHBQRViewDelegate>
@property(nonatomic,assign) BOOL isFirstLogin;
@property(nonatomic,strong)SHBQRView *qrView;

@end

@implementation usbToWifi00

-(void)viewWillAppear:(BOOL)animated{
    
    if (!_isFirstLogin) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"theToolPasswordOpenEnable"];
    
    self.title=@"扫描获取WiFi名称";
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(goToUsb)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    _isFirstLogin=YES;
    
    [self ScanQR];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [_qrView stopScan];
    [_qrView removeFromSuperview];
    _qrView.delegate =nil;
    _qrView.session=nil;
    self.view=nil;
    _qrView=nil;
    _isFirstLogin=NO;
}

-(void)goToUsb{
    useToWifiView1 *rootView = [[useToWifiView1 alloc]init];
 //   [self.navigationController presentViewController:rootView animated:YES completion:nil];
    
     [self.navigationController pushViewController:rootView animated:YES];
}

-(void)ScanQR{
  
    if (!_qrView) {
        _qrView = [[SHBQRView alloc] initWithFrame:self.view.bounds];
        _qrView.delegate = self;
        [self.view addSubview:_qrView];
    }

    
}


- (void)qrView:(SHBQRView *)view ScanResult:(NSString *)result {
    [_qrView stopScan];
    
    useToWifiView1 *rootView = [[useToWifiView1 alloc]init];
    rootView.isShowScanResult=1;
    rootView.SN=result;
    [self.navigationController pushViewController:rootView animated:YES];
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
