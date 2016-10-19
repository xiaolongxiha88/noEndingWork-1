//
//  aliasViewController.m
//  shinelink
//
//  Created by sky on 16/3/17.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "aliasViewController.h"

@interface aliasViewController ()
@property(nonatomic,strong)UITextField *cellectId;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@end

@implementation aliasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(void)initUI{
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    
    UIImageView *userBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 50*HEIGHT_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*HEIGHT_SIZE)];
    userBgImageView.userInteractionEnabled = YES;
    userBgImageView.image = IMAGE(@"圆角矩形空心.png");
    [self.view addSubview:userBgImageView];
    
    _cellectId = [[UITextField alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 0, CGRectGetWidth(userBgImageView.frame) , 45*HEIGHT_SIZE)];
    _cellectId.placeholder = root_bieMing;
    _cellectId.textColor = [UIColor whiteColor];
    _cellectId.tintColor = [UIColor whiteColor];
     _cellectId.textAlignment = NSTextAlignmentCenter;
    [_cellectId setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_cellectId setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _cellectId.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [userBgImageView addSubview:_cellectId];
    
//    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
//    goBut.frame=CGRectMake(40*NOW_SIZE,140*HEIGHT_SIZE, 240*NOW_SIZE, 40*HEIGHT_SIZE);
////    [goBut.layer setMasksToBounds:YES];
////    [goBut.layer setCornerRadius:25.0];
//    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
//    [goBut setTitle:root_OK forState:UIControlStateNormal];
//    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
//    [goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:goBut];
    
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(40*NOW_SIZE,160*HEIGHT_SIZE, 240*NOW_SIZE, 40*HEIGHT_SIZE);
    //    [goBut.layer setMasksToBounds:YES];
    //    [goBut.layer setCornerRadius:25.0];
    //goBut.backgroundColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_OK forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    
    [goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
}

-(void)addButtonPressed{
    if ([_cellectId.text isEqual:@""]) {
        [self showAlertViewWithTitle:nil message:root_bieMing cancelButtonTitle:root_OK];
        return;
    }
    _dataDic=[NSMutableDictionary dictionaryWithObject:_cellectId.text forKey:@"alias"];
    [_dataDic setObject:_deviceSN forKey:_deviceSnKey];
    [_dataDic setObject:@"" forKey:@"image"];
   // NSMutableDictionary *data1=[NSMutableDictionary dictionaryWithObject:@"" forKey:@"image"];
    [self showProgressView];
    [BaseRequest uplodImageWithMethod:HEAD_URL paramars:_dataDic paramarsSite:_netType dataImageDict:nil sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"updateInvInfo: %@", content);
         id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if (content1) {
            if ([content1[@"success"] integerValue] == 0) {
                if ([content1[@"msg"] integerValue] ==501) {
                    [self showAlertViewWithTitle:nil message:root_xiTong_CuoWu cancelButtonTitle:root_Yes];
                }
            }else{
                
               [self showAlertViewWithTitle:nil message:root_xiuGai_chengGong cancelButtonTitle:root_Yes];
                  //[[NSNotificationCenter defaultCenter] postNotificationName:@"changeName" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
