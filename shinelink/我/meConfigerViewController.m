//
//  meConfigerViewController.m
//  ShinePhone
//
//  Created by sky on 16/10/11.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "meConfigerViewController.h"
#import "TempViewController.h"
#import "SHBQRView.h"
#import "AddDeviceViewController.h"
#import "configWifiSViewController.h"


@interface meConfigerViewController ()<SHBQRViewDelegate>
@property(nonatomic,strong)UITextField *cellectId;
@property(nonatomic,strong)UITextField *cellectNo;
@property(nonatomic,strong)NSString *serverAddress;
@property(nonatomic,assign)NSInteger wifiType;
@end

@implementation meConfigerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *bgImage = IMAGE(@"bg.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
    self.title=root_gongju;
    self.view.backgroundColor=MainColor;
    _wifiType=2;
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
    float H=60*HEIGHT_SIZE;
    
    UIView *V0=[[UIView alloc]initWithFrame:CGRectMake(0, 10*HEIGHT_SIZE, SCREEN_Width, HEIGHT_SIZE*230+H)];
    V0.backgroundColor=COLOR(4, 55, 85, 0.1);
    [self.view addSubview:V0];
    
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(0, 0*HEIGHT_SIZE, SCREEN_Width, HEIGHT_SIZE*30)];
    V1.backgroundColor=COLOR(4, 55, 85, 0.1);
    [V0 addSubview:V1];
    
    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(0, 0*HEIGHT_SIZE, 320*NOW_SIZE, HEIGHT_SIZE*30)];
    VL1.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    VL1.textAlignment = NSTextAlignmentCenter;
    VL1.text=root_wifi_peizhi;
    VL1.textColor =[UIColor whiteColor];
    [V1 addSubview:VL1];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
    CGSize size = [root_wifi_peizhi boundingRectWithSize:CGSizeMake(MAXFLOAT, 14*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_Width-size.width)/2-30*HEIGHT_SIZE, 5*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE)];
        [VM1 setImage:[UIImage imageNamed:@"wifi_icon.png"]];
        [V1 addSubview:VM1];
    
    
    //数据采集器序列号
    UIImageView *userBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 40*HEIGHT_SIZE+H, SCREEN_Width - 80*NOW_SIZE, 40*HEIGHT_SIZE)];
    userBgImageView.userInteractionEnabled = YES;
    userBgImageView.image = IMAGE(@"圆角矩形空心.png");
    [V0 addSubview:userBgImageView];
    
    _cellectId = [[UITextField alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 0, CGRectGetWidth(userBgImageView.frame) , 40*HEIGHT_SIZE)];
    _cellectId.placeholder = root_caiJiQi;
    _cellectId.textColor = [UIColor whiteColor];
    _cellectId.tintColor = [UIColor whiteColor];
    _cellectId.textAlignment = NSTextAlignmentCenter;
    [_cellectId setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_cellectId setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _cellectId.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [userBgImageView addSubview:_cellectId];
    
   
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(40*NOW_SIZE,160*HEIGHT_SIZE+H, 240*NOW_SIZE, 40*HEIGHT_SIZE);
    // [goBut.layer setMasksToBounds:YES];
    // [goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_next_go forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [V0 addSubview:goBut];
    
    UIButton *QR=[[UIButton alloc]initWithFrame:CGRectMake(40*NOW_SIZE,100*HEIGHT_SIZE+H , 240*NOW_SIZE, 40*HEIGHT_SIZE)];
    [QR setBackgroundImage:IMAGE(@"按钮2.png") forState:0];
    QR.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [QR setTitle:root_erWeiMa forState:UIControlStateNormal];
    [QR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [QR addTarget:self action:@selector(ScanQR) forControlEvents:UIControlEventTouchUpInside];
    [V0 addSubview:QR];
    
    NSArray *nameArray=@[@"ShineWiFi",@"ShineWiFi-S"];
    float buttonH=30*HEIGHT_SIZE;
    for (int i=0; i<2; i++) {
    UIButton *getDeviceButton=[[UIButton alloc]initWithFrame:CGRectMake(20*NOW_SIZE+160*NOW_SIZE*i, 45*HEIGHT_SIZE, 120*NOW_SIZE, buttonH)];
        [getDeviceButton setBackgroundImage:[self createImageWithColor:[UIColor whiteColor] rect:CGRectMake(40*NOW_SIZE+160*NOW_SIZE*i, 40*HEIGHT_SIZE, 80*NOW_SIZE, buttonH)] forState:UIControlStateNormal];
        getDeviceButton.backgroundColor=COLOR(255, 255, 255, 0.6);
        getDeviceButton.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
        [getDeviceButton setTitle:nameArray[i] forState:UIControlStateNormal];
        [getDeviceButton setTitleColor:MainColor forState:UIControlStateNormal];
         [getDeviceButton.layer setMasksToBounds:YES];
         [getDeviceButton.layer setCornerRadius:buttonH/2];
        getDeviceButton.tag=2000+i;
        [getDeviceButton addTarget:self action:@selector(changeButtonStatues:) forControlEvents:UIControlEventTouchUpInside];
        [V0 addSubview:getDeviceButton];
    }
    
    
}



-(void)changeButtonStatues:(UIButton*)button{
    for (int i=0; i<2; i++) {
        if (button.tag==2000+i) {
            [button setSelected:YES];
             button.backgroundColor=COLOR(255, 255, 255, 1);
              [button setTitleColor:MainColor forState:UIControlStateNormal];
        }else{
            UIButton *button2=[self.view viewWithTag:2000+i];
            [button2 setSelected:NO];
                   button2.backgroundColor=COLOR(255, 255, 255, 0.6);
             [button2 setTitleColor:MainColor forState:UIControlStateNormal];

        }
    }

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
    
    for (int i=0; i<2; i++) {
        UIButton *button2=[self.view viewWithTag:2000+i];
        if (button2.isSelected) {
            _wifiType=i;
        }
    }
    if (_wifiType==2) {
        [self showToastViewWithTitle:root_5000Chart_179];
        return;
    }

    
    if (_wifiType==0) {
        AddDeviceViewController *rootView = [[AddDeviceViewController alloc]init];
        rootView.SnString=result;
        rootView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:rootView animated:YES];
    }else{
        configWifiSViewController *rootView = [[configWifiSViewController alloc]init];
        rootView.SnString=result;
        rootView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:rootView animated:YES];
    }
    
}

-(void)delButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)addButtonPressed{
    if ([_cellectId.text isEqual:@""]) {
        [self showAlertViewWithTitle:nil message:root_caiJiQi cancelButtonTitle:root_OK];
        return;
    }
    for (int i=0; i<2; i++) {
        UIButton *button2=[self.view viewWithTag:2000+i];
        if (button2.isSelected) {
            _wifiType=i;
        }
    }
    if (_wifiType==2) {
        [self showToastViewWithTitle:root_5000Chart_179];
        return;
    }
    
    NSString *SnID=_cellectId.text;

    if (_wifiType==0) {
        AddDeviceViewController *rootView = [[AddDeviceViewController alloc]init];
        rootView.SnString=SnID;
        rootView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:rootView animated:YES];
    }else{
        configWifiSViewController *rootView = [[configWifiSViewController alloc]init];
        rootView.SnString=SnID;
        rootView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:rootView animated:YES]; 
    }
    

    
    
    
    
}

@end
