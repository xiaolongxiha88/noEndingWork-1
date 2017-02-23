//
//  forgetOneViewController.m
//  ShinePhone
//
//  Created by sky on 17/2/23.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "forgetOneViewController.h"
#import "forgetViewController.h"
#import "emailViewController.h"
#import "phoneRegisterViewController.h"

@interface forgetOneViewController ()

@end

@implementation forgetOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=root_zhaohui_mima;
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    
    UIButton *byEmail =  [UIButton buttonWithType:UIButtonTypeCustom];
    byEmail.frame=CGRectMake(60*NOW_SIZE,100*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    // [byEmail.layer setMasksToBounds:YES];
    //[byEmail.layer setCornerRadius:25.0];
    [byEmail setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    byEmail.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [byEmail setTitle:@"通过邮箱" forState:UIControlStateNormal];
    [byEmail addTarget:self action:@selector(bymail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:byEmail];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,180*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    // [goBut.layer setMasksToBounds:YES];
    //[goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:@"通过手机号" forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(byPhone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];

}


-(void)bymail{
    forgetViewController *goView=[[forgetViewController alloc]init];
    [self.navigationController pushViewController:goView animated:YES];
    
    
}

-(void)byPhone{
    phoneRegisterViewController *goView=[[phoneRegisterViewController alloc]init];
    [self.navigationController pushViewController:goView animated:YES];
    
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
