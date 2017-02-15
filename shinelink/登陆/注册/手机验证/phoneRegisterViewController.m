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
@property (nonatomic, strong)  UITextField *textField2;
@property(nonatomic,strong)UILabel *label2;
@end

@implementation phoneRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    
    [self initUI];
}

-(void)initUI{
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(50*NOW_SIZE,80*HEIGHT_SIZE,25*HEIGHT_SIZE, 25*HEIGHT_SIZE)];
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    _imageView.clipsToBounds=YES;
    _imageView.image=[UIImage imageNamed:@"iconfont-shouji.png"];
    [self.view addSubview:_imageView];

    _textField = [[UITextField alloc] initWithFrame:CGRectMake(85*NOW_SIZE,80*HEIGHT_SIZE,200*HEIGHT_SIZE, 25*HEIGHT_SIZE)];
    _textField.placeholder =root_Enter_phone_number;
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
      _textField.textAlignment = NSTextAlignmentLeft;
    [_textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
   [self.view addSubview:_textField];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(50*NOW_SIZE,108*HEIGHT_SIZE,220*HEIGHT_SIZE, 1*HEIGHT_SIZE)];
    line.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(85*NOW_SIZE,128*HEIGHT_SIZE,200*HEIGHT_SIZE, 25*HEIGHT_SIZE)];
    _textField2.placeholder =root_Enter_phone_number;
    _textField2.textColor = [UIColor whiteColor];
    _textField2.tintColor = [UIColor whiteColor];
    _textField2.textAlignment = NSTextAlignmentLeft;
    [_textField2 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField2 setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_textField2];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(50*NOW_SIZE,156*HEIGHT_SIZE,185*HEIGHT_SIZE, 1*HEIGHT_SIZE)];
    line1.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line1];
    
    QCCountdownButton *btn = [QCCountdownButton countdownButton];
    btn.title = @"获取验证码";   
    [btn setFrame:CGRectMake(235*NOW_SIZE,80*HEIGHT_SIZE,70*HEIGHT_SIZE, 29*HEIGHT_SIZE)];
     btn.titleLabelFont = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
       btn.nomalBackgroundColor = COLOR(144, 195, 32, 1);
     btn.disabledBackgroundColor = [UIColor grayColor];
    btn.totalSecond = 10;
    [self.view addSubview:btn];
    
    //进度b
    [btn processBlock:^(NSUInteger second) {
        btn.title = [NSString stringWithFormat:@"(%lis)后重新获取", second] ;
    } onFinishedBlock:^{  // 倒计时完毕
        btn.title = @"获取验证码";
    }];
    
   // float lable2W=100*NOW_SIZE;
    _label2=[[UILabel alloc]initWithFrame:CGRectMake(60*NOW_SIZE,210*HEIGHT_SIZE, 200*NOW_SIZE, 20*HEIGHT_SIZE)];
    _label2.text =@"邮箱注册";
    _label2.textColor = [UIColor whiteColor];
    //textField.tintColor = [UIColor whiteColor];
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.view addSubview:_label2];
    _label2.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fetchLocation)];
    [_label2 addGestureRecognizer:tap2];
    float _label2X=(SCREEN_Width)/2;
          [_label2 sizeToFit];
       _label2.center=CGPointMake(_label2X, 200*HEIGHT_SIZE);
    
    
    UILabel *Lable3=[[UILabel alloc]initWithFrame:CGRectMake(60*NOW_SIZE,180*HEIGHT_SIZE, 200*NOW_SIZE, 20*HEIGHT_SIZE)];
    Lable3.text =@"使用其他方式注册";
    Lable3.textColor = COLOR(255, 255, 255, 0.5);
    //textField.tintColor = [UIColor whiteColor];
    Lable3.textAlignment = NSTextAlignmentCenter;
    Lable3.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [Lable3 sizeToFit];
    Lable3.center=CGPointMake(_label2X, 180*HEIGHT_SIZE);
    [self.view addSubview:Lable3];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
    CGSize size = [_label2.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    float lineW=30*NOW_SIZE;
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake((SCREEN_Width-size.width)/2-lineW-5*NOW_SIZE,200*HEIGHT_SIZE,lineW, 1*HEIGHT_SIZE)];
    line2.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line2];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake((SCREEN_Width+size.width)/2+5*NOW_SIZE,200*HEIGHT_SIZE,lineW, 1*HEIGHT_SIZE)];
    line3.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line3];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,260*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
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
