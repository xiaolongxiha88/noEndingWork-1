//
//  quickRegisterViewController.m
//  ShinePhone
//
//  Created by sky on 17/2/21.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "quickRegisterViewController.h"
#import "SHBQRView.h"

@interface quickRegisterViewController ()<SHBQRViewDelegate>
@property(nonatomic,strong)SHBQRView *qrView;
@end

@implementation quickRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    
    self.title=@"扫描采集器序列号";
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(nextRegister)];
    rightItem.tag=10;
    self.navigationItem.rightBarButtonItem=rightItem;
    
    [self initUI];
}

-(void)nextRegister{


}

-(void)initUI{
    _qrView = [[SHBQRView alloc] initWithFrame:self.view.bounds];
    _qrView.delegate = self;
    [self.view addSubview:_qrView];


}


- (void)qrView:(SHBQRView *)view ScanResult:(NSString *)result {
    [_qrView stopScan];
    if (result.length!=10) {
           // [self showToastViewWithTitle:@"请扫描正确的采集器序列号"];
         [self showAlertViewWithTitle:nil message:@"请扫描正确的采集器序列号" cancelButtonTitle:root_Yes];
       
    }
   
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
      [_qrView startScan];
    }
    if (buttonIndex==0) {
        [_qrView startScan];
    }
    if (buttonIndex==2) {
        [_qrView startScan];
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
