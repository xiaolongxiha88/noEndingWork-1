//
//  testDemoViewController.m
//  shinelink
//
//  Created by sky on 16/6/2.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "testDemoViewController.h"
#import "AddressPickView.h"

@interface testDemoViewController ()
@property(nonatomic,strong)UILabel *label;

@end

@implementation testDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self getAddress];
     self.title=root_huoqu_wufuqi_dizhi;
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30*NOW_SIZE,50*HEIGHT_SIZE, 80*NOW_SIZE, 30*HEIGHT_SIZE)];
    label.text=root_country;
    label.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(110*NOW_SIZE,50*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    _label.layer.borderWidth=1;
    _label.layer.cornerRadius=5;
    _label.layer.borderColor=[UIColor whiteColor].CGColor;
    _label.text =root_country_alet;
    _label.textColor = [UIColor lightTextColor];
    //textField.tintColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_label];
    _label.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickadress)];
    [_label addGestureRecognizer:tap];
    
}

-(void)getAddress{

    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"admin":@"admin"} paramarsSite:@"/newCountryCityAPI.do?op=getCountryCity" sucessBlock:^(id content) {
        
        NSLog(@"getCountryCity: %@", content);
        if (content) {
            
            
            
        }else{
            [self hideProgressView];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];

    
}

//-(void)pickadress{
//    if(_provinceArray.count>0){
//        AddressPickView *addressPickView = [AddressPickView shareInstance];
//        addressPickView.provinceArray=_provinceArray;
//        [self.view addSubview:addressPickView];
//        addressPickView.block = ^(NSString *province){
//            // [self.dataDic setObject:city forKey:@"regCountry"];
//            // [self.dataDic setObject:town forKey:@"regCity"];
//            _label.text = [NSString stringWithFormat:@"%@",province] ;
//            _country=province;
//        };
//    }else{
//        [self showToastViewWithTitle:root_country_huoQu];
//        return;
//        
//    }
//}



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
