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
//    UIImage *bgImage = IMAGE(@"bg.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
     self.view.backgroundColor=MainColor;
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:MainColor];
    
    UIButton *byEmail =  [UIButton buttonWithType:UIButtonTypeCustom];
    byEmail.frame=CGRectMake(60*NOW_SIZE,100*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    // [byEmail.layer setMasksToBounds:YES];
    //[byEmail.layer setCornerRadius:25.0];
    [byEmail setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    byEmail.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [byEmail setTitle:root_tongguo_youxiang forState:UIControlStateNormal];
    [byEmail addTarget:self action:@selector(bymail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:byEmail];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
        goBut.frame=CGRectMake(60*NOW_SIZE,180*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
        // [goBut.layer setMasksToBounds:YES];
        //[goBut.layer setCornerRadius:25.0];
        [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
        goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
        [goBut setTitle:root_tongguo_shoujihao forState:UIControlStateNormal];
        [goBut addTarget:self action:@selector(byPhone) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:goBut];
        
        UILabel *alertLable= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE,220*HEIGHT_SIZE, 300*NOW_SIZE, 30*HEIGHT_SIZE)];
        NSString *alertText1=root_jinggong_yijianjianzhan_yonghu;
        NSString *alertText=[NSString stringWithFormat:@"(%@)",alertText1];
        alertLable.text=alertText;
        alertLable.textColor=COLOR(255, 255, 255, 0.5);
        alertLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        alertLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:alertLable];

    }
    
    
}


-(void)bymail{
    forgetViewController *goView=[[forgetViewController alloc]init];
    [self.navigationController pushViewController:goView animated:YES];
    
    
}

-(void)byPhone{
    phoneRegisterViewController *goView=[[phoneRegisterViewController alloc]init];
    goView.goViewType=@"1";
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
