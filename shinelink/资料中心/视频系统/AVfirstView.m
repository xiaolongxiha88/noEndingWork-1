//
//  AVfirstView.m
//  ShinePhone
//
//  Created by sky on 16/9/2.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "AVfirstView.h"
#import "AVViewController.h"

@interface AVfirstView ()

@end

@implementation AVfirstView

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 110*HEIGHT_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*HEIGHT_SIZE)];
    loginBtn.backgroundColor = [UIColor colorWithRed:149/255.0f green:226/255.0f blue:98/255.0f alpha:1];
    
    [self.view addSubview:loginBtn];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [loginBtn setTitle:root_log_in forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(goAV) forControlEvents:UIControlEventTouchUpInside];
    
    
}




-(void)goAV{
    AVViewController *go=[[AVViewController alloc]init];
    [self.navigationController pushViewController:go animated:YES];
    
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
