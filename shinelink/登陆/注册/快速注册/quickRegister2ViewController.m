//
//  quickRegister2ViewController.m
//  ShinePhone
//
//  Created by sky on 17/2/21.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "quickRegister2ViewController.h"

@interface quickRegister2ViewController ()
@property (nonatomic, strong)  UITextField *textField;
@property (nonatomic, strong)  UITextField *textField2;
@property (nonatomic, strong)  NSString *getCountry;
@property (nonatomic, strong)  NSString *getZone;
@end

@implementation quickRegister2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    self.title=@"一键注册";
     [self initUI];
    [self getInfo];
}

-(void)getInfo{
    _getCountry=@"initC";
    _getZone=@"initZ";
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode1 = [currentLocale objectForKey:NSLocaleCountryCode];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"englishCountryJson" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *countryArray1=[NSArray arrayWithArray:result[@"data"]];
    for (int i=0; i<countryArray1.count; i++) {
        if ([countryCode1 isEqualToString:countryArray1[i][@"countryCode"]]) {
            _getCountry=countryArray1[i][@"countryName"];
            _getZone=countryArray1[i][@"zone"];
        }
    }
    
    if ([_getCountry isEqualToString:@"initC"]) {
        _getCountry=@"Other";
         _getZone=@"1";
    }
    
    if ([_getZone isEqualToString:@"initZ"]) {
        //获取时区
        NSTimeZone *regTimeZone1 = [NSTimeZone systemTimeZone];
        NSInteger regTimeZone = [regTimeZone1 secondsFromGMT]/3600;
        _getCountry=@"Other";
        _getZone=[NSString stringWithFormat:@"%ld",(long)regTimeZone];
    }
    
}

-(void)initUI{

    float H1=20*HEIGHT_SIZE;
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE,70*HEIGHT_SIZE-H1,220*HEIGHT_SIZE, 25*HEIGHT_SIZE)];
    _textField.placeholder =root_Enter_phone_number;
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
    _textField.textAlignment = NSTextAlignmentCenter;
    [_textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_textField];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(50*NOW_SIZE,98*HEIGHT_SIZE-H1,220*HEIGHT_SIZE, 1*HEIGHT_SIZE)];
    line.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE,128*HEIGHT_SIZE-H1,220*HEIGHT_SIZE, 25*HEIGHT_SIZE)];
    _textField2.placeholder =root_Alet_user_pwd;
    _textField2.textColor = [UIColor whiteColor];
    _textField2.tintColor = [UIColor whiteColor];
    _textField2.textAlignment = NSTextAlignmentCenter;
    [_textField2 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField2 setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_textField2];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(50*NOW_SIZE,156*HEIGHT_SIZE-H1,220*HEIGHT_SIZE, 1*HEIGHT_SIZE)];
    line1.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line1];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,200*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:20.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_register forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(PresentGo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
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
