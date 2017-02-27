//
//  quickRegisterViewController.m
//  ShinePhone
//
//  Created by sky on 17/2/21.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "quickRegisterViewController.h"
#import "SHBQRView.h"
#import "quickRegister2ViewController.h"

@interface quickRegisterViewController ()<SHBQRViewDelegate>
@property(nonatomic,strong)SHBQRView *qrView;
@property(nonatomic,strong)NSString *SnCode;
@property(nonatomic,strong)NSString *SnCheck;
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
    quickRegister2ViewController *registerRoot=[[quickRegister2ViewController alloc]init];
    [self.navigationController pushViewController:registerRoot animated:YES];
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
       
    }else{
        _SnCode=result;
        _SnCheck=[self getValidCode:result];
        quickRegister2ViewController *registerRoot=[[quickRegister2ViewController alloc]init];
        registerRoot.SnCode=_SnCode;
         registerRoot.SnCheck=_SnCheck;
        [self.navigationController pushViewController:registerRoot animated:YES];
    }
   
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
