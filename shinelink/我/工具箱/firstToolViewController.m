//
//  firstToolViewController.m
//  ShinePhone
//
//  Created by sky on 16/10/17.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "firstToolViewController.h"
#import "meConfigerViewController.h"
#import "WiFiSignalViewController.h"

@interface firstToolViewController ()

@end

@implementation firstToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}



-(void)initUI{
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,80*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_tongGuo_xuLieHao forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(SetWIFI) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
    UIButton *goSignal =  [UIButton buttonWithType:UIButtonTypeCustom];
    goSignal.frame=CGRectMake(60*NOW_SIZE,180*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goSignal setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goSignal.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goSignal setTitle:root_tongGuo_xuLieHao forState:UIControlStateNormal];
    [goSignal addTarget:self action:@selector(getWIFI) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goSignal];

}


-(void)SetWIFI{
    
    meConfigerViewController *aboutView = [[meConfigerViewController alloc]init];

    [self.navigationController pushViewController:aboutView animated:NO];
    
}



-(void)getWIFI{

    WiFiSignalViewController *aboutView = [[WiFiSignalViewController alloc]init];
    
    [self.navigationController pushViewController:aboutView animated:NO];

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
