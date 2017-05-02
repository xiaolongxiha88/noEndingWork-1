//
//  GifConfigViewController.m
//  ShinePhone
//
//  Created by sky on 16/11/1.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "GifConfigViewController.h"

@interface GifConfigViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView* GifViewNo;
@property (nonatomic,strong) UIWebView* GifViewNo2;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation GifConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=MainColor;
      [self showProgressView];
    [self initUI];
}


-(void)initUI{
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
  
    CGRect fcRect = [root_wifi_kandeng boundingRectWithSize:CGSizeMake(300*NOW_SIZE, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16 *HEIGHT_SIZE]} context:nil];
    float sizeH1=fcRect.size.height;
    
    UILabel *noticeLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 300*NOW_SIZE,sizeH1)];
    noticeLable.text=root_wifi_kandeng;
    noticeLable.textAlignment=NSTextAlignmentLeft;
    noticeLable.textColor=[UIColor whiteColor];
    noticeLable.numberOfLines=0;
    noticeLable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    noticeLable.adjustsFontSizeToFitWidth=YES;
    [_scrollView addSubview:noticeLable];
    
 NSData *data = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"connected-ok" ofType:@"gif"]];
    float gifwidth=140*NOW_SIZE;
    _GifViewNo =[[UIWebView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE+sizeH1+10*HEIGHT_SIZE, gifwidth, gifwidth*1.11)];
    [_GifViewNo loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    _GifViewNo.delegate = self;
    _GifViewNo.scrollView.bounces=NO;
    _GifViewNo.userInteractionEnabled=NO;
    _GifViewNo.opaque=NO;
         _GifViewNo.scalesPageToFit = YES;
    _GifViewNo.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_GifViewNo];
    
     NSData *data2 = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"connected-failed" ofType:@"gif"]];
    _GifViewNo2 =[[UIWebView alloc]initWithFrame:CGRectMake(30*NOW_SIZE+gifwidth, 10*HEIGHT_SIZE+sizeH1+10*HEIGHT_SIZE, gifwidth, gifwidth*1.11)];
    [_GifViewNo2 loadData:data2 MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    _GifViewNo2.delegate = self;
    _GifViewNo2.scrollView.bounces=NO;
    _GifViewNo2.userInteractionEnabled=NO;
    _GifViewNo2.opaque=NO;
    _GifViewNo2.scalesPageToFit = YES;
    _GifViewNo2.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_GifViewNo2];
    
     float GifViewNoH=CGRectGetMaxY(_GifViewNo.frame);
    
    UILabel *wifiOK=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 5*HEIGHT_SIZE+GifViewNoH, 140*NOW_SIZE,30*HEIGHT_SIZE)];
     NSString *okName=[NSString stringWithFormat:@"A.%@",root_wifi_lianjie_ok];
    wifiOK.text=okName;
    wifiOK.textAlignment=NSTextAlignmentCenter;
    wifiOK.textColor=COLOR(149, 226, 98, 1);
    wifiOK.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:wifiOK];
    
    UILabel *wifiFailed=[[UILabel alloc]initWithFrame:CGRectMake(170*NOW_SIZE, 5*HEIGHT_SIZE+GifViewNoH, 140*NOW_SIZE,30*HEIGHT_SIZE)];
    NSString *failedName=[NSString stringWithFormat:@"B.%@",root_wifi_lianjie_failed];
    wifiFailed.text=failedName;
    wifiFailed.textAlignment=NSTextAlignmentCenter;
    wifiFailed.textColor=COLOR(237, 93, 93, 1);
    wifiFailed.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:wifiFailed];
    
    CGRect fcRect1 = [root_wifi_chenggong_xinxi boundingRectWithSize:CGSizeMake(300*NOW_SIZE, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18*HEIGHT_SIZE]} context:nil];
    float sizeH2=fcRect1.size.height;
    UILabel *alertOK=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 45*HEIGHT_SIZE+GifViewNoH, 300*NOW_SIZE,sizeH2)];
    alertOK.text=root_wifi_chenggong_xinxi;
    alertOK.numberOfLines=0;
    alertOK.textAlignment=NSTextAlignmentLeft;
    alertOK.textColor=[UIColor whiteColor];
    alertOK.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:alertOK];

    float alertOKH=CGRectGetMaxY(alertOK.frame);
    CGRect fcRect2 = [root_wifi_shibai_xinxi boundingRectWithSize:CGSizeMake(300*NOW_SIZE, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*HEIGHT_SIZE]} context:nil];
    float sizeH3=fcRect2.size.height;
    UILabel *alertFailed=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, alertOKH+10*HEIGHT_SIZE, 300*NOW_SIZE,sizeH3)];
    alertFailed.text=root_wifi_shibai_xinxi;
    alertFailed.numberOfLines=0;
    alertFailed.textAlignment=NSTextAlignmentLeft;
    alertFailed.textColor=[UIColor whiteColor];
    alertFailed.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:alertFailed];
    
    UILabel *alertFailed1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, alertOKH+15*HEIGHT_SIZE+sizeH3, 300*NOW_SIZE,20*HEIGHT_SIZE)];
    alertFailed1.text=root_wifi_shibai_xinxi_1;
    alertFailed1.numberOfLines=0;
    alertFailed1.textAlignment=NSTextAlignmentLeft;
    alertFailed1.textColor=[UIColor whiteColor];
    alertFailed1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_scrollView addSubview:alertFailed1];
    
        UIImageView *pwdBgImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(30*NOW_SIZE, alertOKH+45*HEIGHT_SIZE+sizeH3, 260*NOW_SIZE,260*NOW_SIZE*0.092 )];
        pwdBgImageView2.image = IMAGE(@"singal.png");
        pwdBgImageView2.userInteractionEnabled = YES;
        [_scrollView addSubview:pwdBgImageView2];
    
      float imageH=CGRectGetMaxY(pwdBgImageView2.frame);
    UILabel *alertFailed2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, imageH+5*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE)];
    alertFailed2.text=root_wifi_shibai_xinxi_2;
    alertFailed2.numberOfLines=0;
    alertFailed2.textAlignment=NSTextAlignmentLeft;
    alertFailed2.textColor=[UIColor whiteColor];
    alertFailed2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_scrollView addSubview:alertFailed2];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,imageH+35*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_wifi_chongxin_peizhi forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(GoSet) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:goBut];
    
         _scrollView.contentSize = CGSizeMake(SCREEN_Width,imageH+130*HEIGHT_SIZE);
    
}

- (void)GoSet{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
 
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [self hideProgressView];
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
