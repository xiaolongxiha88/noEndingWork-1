//
//  payMoneyFirst.m
//  ShinePhone
//
//  Created by sky on 2017/11/7.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "payMoneyFirst.h"
#import <AlipaySDK/AlipaySDK.h>


@interface payMoneyFirst ()

@end

@implementation payMoneyFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

-(void)initUI{
    
    UIButton *registerUser =  [UIButton buttonWithType:UIButtonTypeCustom];
    registerUser.frame=CGRectMake((SCREEN_Width-150*NOW_SIZE)/2,100*HEIGHT_SIZE, 150*NOW_SIZE, 40*HEIGHT_SIZE);
    [registerUser.layer setMasksToBounds:YES];
    [registerUser.layer setCornerRadius:20.0*HEIGHT_SIZE];
    registerUser.backgroundColor = COLOR(98, 226, 149, 1);
    registerUser.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [registerUser setTitle:root_WO_zhuxiao_zhanhao forState:UIControlStateNormal];
    //[goBut setTintColor:[UIColor colorWithRed:130/ 255.0f green:200 / 255.0f blue:250 / 255.0f alpha:1]];
    [registerUser setTitleColor: [UIColor whiteColor]forState:UIControlStateNormal];
    [registerUser addTarget:self action:@selector(goToPay) forControlEvents:UIControlEventTouchUpInside];
    //  goBut.highlighted=[UIColor grayColor];
    [self.view addSubview:registerUser];
    
}


-(void)goToPay{
    
    NSString *orderString =@"alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2017110409716742&biz_content=%7B%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22out_trade_no%22%3A%22growatt_order_20171107003%22%2C%22product_code%22%3A%22GPRS%E7%BB%AD%E8%B4%B95%E5%B9%B4%22%2C%22subject%22%3A%22App%E6%94%AF%E4%BB%98%E6%B5%8B%E8%AF%95Java%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%220.01%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2F47.91.176.158%2Fcommon%2Fnotify&sign=Vjx95nXWBbIIZnhmdSC49Dyi69D1Rlft4OTKCeFSvjWFsv9je%2FeiH5XuWE5OgJ%2BgP8pumODBDoFeUgFwTI8rfF1xogzAUVYSi2xCVj5e%2Bdv0tXnew5SHjhjrGgOKZhpGfLsrEbmjdqYucEMfo4CHqhW4pCaVQa%2F8vTECqC44ifbMQszSFT0naBKQnQ%2Bx08Jjk6V%2FnwfNpH%2B%2F3INJ5xfQTWEtW4EnhqnzkKTqsSJHCdlj07iWSM2SuzyzEOoAYiVfHTf0m%2FXFyMUX9zGT5zUcBYLAoRNYMq7aTpG5t58hQF97%2FpGx5BsHczvBn1cABV34vvKvKXGspGUTpRmt6Eh2kw%3D%3D&sign_type=RSA2&timestamp=2017-11-07+16%3A08%3A32&version=1.0";
    
     NSString *appScheme = @"ShinePhoneAlipay";
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSLog(@"reslut1212 = %@",resultDic);
    }];
    
    
    
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
