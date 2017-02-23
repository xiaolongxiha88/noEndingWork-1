//
//  phoneRegisterViewController.m
//  ShinePhone
//
//  Created by sky on 17/2/14.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "phoneRegisterViewController.h"
#import "QCCountdownButton.h"

@interface phoneRegisterViewController ()
 @property (nonatomic, strong)  UIImageView *imageView;
 @property (nonatomic, strong)  UITextField *textField;
@property (nonatomic, strong)  UITextField *textField0;
@property (nonatomic, strong)  UITextField *textField2;
@property(nonatomic,strong)UILabel *label2;
@property (nonatomic, strong)  NSString *getPhone;
@end

@implementation phoneRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    
    [self getInfo];

}

-(void)getInfo{
    _getPhone=@"86";

    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode1 = [currentLocale objectForKey:NSLocaleCountryCode];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"englishCountryJson" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *countryArray1=[NSArray arrayWithArray:result[@"data"]];
    for (int i=0; i<countryArray1.count; i++) {
        if ([countryCode1 isEqualToString:countryArray1[i][@"countryCode"]]) {
            _getPhone=countryArray1[i][@"phoneCode"];
        }
    }
 
    [self initUI];
}


-(void)initUI{

    _textField0 = [[UITextField alloc] initWithFrame:CGRectMake(30*NOW_SIZE,82*HEIGHT_SIZE,40*NOW_SIZE, 25*HEIGHT_SIZE)];
    _textField0.placeholder =_getPhone;
    _textField0.textColor = [UIColor whiteColor];
    _textField0.tintColor = [UIColor whiteColor];
    _textField0.textAlignment = NSTextAlignmentCenter;
    [_textField0 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField0 setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField0.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.view addSubview:_textField0];
    
    UIView *line0=[[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,108*HEIGHT_SIZE,40*NOW_SIZE, 1*HEIGHT_SIZE)];
    line0.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line0];
    
    UIView *line01=[[UIView alloc]initWithFrame:CGRectMake(75*NOW_SIZE,82*HEIGHT_SIZE,1*NOW_SIZE, 25*HEIGHT_SIZE)];
    line01.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line01];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(80*NOW_SIZE,82*HEIGHT_SIZE,155*NOW_SIZE, 25*HEIGHT_SIZE)];
    _textField.placeholder =root_Enter_phone_number;
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
      _textField.textAlignment = NSTextAlignmentCenter;
    [_textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
   [self.view addSubview:_textField];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(80*NOW_SIZE,108*HEIGHT_SIZE,155*NOW_SIZE, 1*HEIGHT_SIZE)];
    line.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(80*NOW_SIZE,130*HEIGHT_SIZE,155*NOW_SIZE, 25*HEIGHT_SIZE)];
    _textField2.placeholder =@"输入短信校验码";
    _textField2.textColor = [UIColor whiteColor];
    _textField2.tintColor = [UIColor whiteColor];
    _textField2.textAlignment = NSTextAlignmentCenter;
    [_textField2 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField2 setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.view addSubview:_textField2];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(80*NOW_SIZE,156*HEIGHT_SIZE,155*NOW_SIZE, 1*HEIGHT_SIZE)];
    line1.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line1];
    
    QCCountdownButton *btn = [QCCountdownButton countdownButton];
    btn.title = @"获取验证码";   
    [btn setFrame:CGRectMake(235*NOW_SIZE,80*HEIGHT_SIZE,70*NOW_SIZE, 29*HEIGHT_SIZE)];
     btn.titleLabelFont = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
       btn.nomalBackgroundColor = COLOR(144, 195, 32, 1);
     btn.disabledBackgroundColor = [UIColor grayColor];
    btn.totalSecond = 10;
    [self.view addSubview:btn];
    
    //进度b
    [btn processBlock:^(NSUInteger second) {
        btn.title = [NSString stringWithFormat:@"%lis", second] ;
    } onFinishedBlock:^{  // 倒计时完毕
        btn.title = @"获取验证码";
    }];
    

    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,230*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:20.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_next_go forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(PresentGo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
}


-(void)fetchLocation{
    
    
    
}


-(void)PresentGo{



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
