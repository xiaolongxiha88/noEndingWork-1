//
//  ossGetPassWordView.m
//  ShinePhone
//
//  Created by sky on 2017/12/6.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "ossGetPassWordView.h"

#import "MMScanViewController.h"
#import "useToWifiView1.h"

@interface ossGetPassWordView ()
@property(nonatomic,strong)UIButton *goBut;
@property(nonatomic,strong)UITextField *textField2;
@end

@implementation ossGetPassWordView

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"本地调试工具" style:UIBarButtonItemStylePlain target:self action:@selector(goToTool)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    [self initUI];
}

-(void)goToTool{
    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeAll onFinish:^(NSString *result, NSError *error) {
        if (error) {
            NSLog(@"error: %@",error);
        } else {
            
            useToWifiView1 *rootView = [[useToWifiView1 alloc]init];
            rootView.isShowScanResult=1;
            rootView.SN=result;
             rootView.isOSS=YES;
            [self.navigationController pushViewController:rootView animated:NO];
            
            NSLog(@"扫描结果：%@",result);
            
        }
    }];
    scanVc.titleString=root_scan_242;
    scanVc.scanBarType=1;
         scanVc.isOSS=YES;
    [self.navigationController pushViewController:scanVc animated:YES];
    
//    usbToWifi00 *go=[[usbToWifi00 alloc]init];
//    [self.navigationController pushViewController:go animated:YES];
}

-(void)initUI{
    
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 50*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    PV2Lable.text=@"设置本地调试工具密码";
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=COLOR(102, 102, 102, 1);
    PV2Lable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    PV2Lable.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:PV2Lable];
    
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 80*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textField2.layer.borderWidth=1;
    _textField2.layer.cornerRadius=5;
    _textField2.tag=2000;
    _textField2.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
    _textField2.textColor = COLOR(102, 102, 102, 1);
    _textField2.tintColor = COLOR(102, 102, 102, 1);
    _textField2.textAlignment=NSTextAlignmentCenter;
    _textField2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_textField2];
    
    
    _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(60*NOW_SIZE,180*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:root_MAX_371 forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_goBut];
}



-(void)finishSet{
    if (_textField2.text==nil || [_textField2.text isEqualToString:@""]) {
        [self showToastViewWithTitle:root_MAX_301];
        return;
    }
    NSString *password=_textField2.text;
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"theToolPassword"];
    
    NSString *alertString=[NSString stringWithFormat:@"%@:%@",root_MAX_302,password];
    [self showAlertViewWithTitle:root_MAX_303 message:alertString cancelButtonTitle:root_OK];
    
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
