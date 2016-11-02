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
@end

@implementation GifConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [self showProgressView];
    [self initUI];
}


-(void)initUI{
    
 NSData *data = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"WifiDisconnected" ofType:@"gif"]];
    
    float gifwidth=140*NOW_SIZE;
    _GifViewNo =[[UIWebView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, gifwidth, gifwidth*1.95)];
    [_GifViewNo loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    _GifViewNo.delegate = self;
    _GifViewNo.scrollView.bounces=NO;
    _GifViewNo.userInteractionEnabled=NO;
    _GifViewNo.opaque=NO;
         _GifViewNo.scalesPageToFit = YES;
    _GifViewNo.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_GifViewNo];
    
     NSData *data2 = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"wifiConnected" ofType:@"gif"]];
    
    _GifViewNo2 =[[UIWebView alloc]initWithFrame:CGRectMake(30*NOW_SIZE+gifwidth, 10*HEIGHT_SIZE, gifwidth, gifwidth*1.95)];
    [_GifViewNo2 loadData:data2 MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    _GifViewNo2.delegate = self;
    _GifViewNo2.scrollView.bounces=NO;
    _GifViewNo2.userInteractionEnabled=NO;
    _GifViewNo2.opaque=NO;
    _GifViewNo2.scalesPageToFit = YES;
    _GifViewNo2.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_GifViewNo2];
    

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
