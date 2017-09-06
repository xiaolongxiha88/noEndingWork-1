//
//  GifNewViewController.m
//  ShinePhone
//
//  Created by sky on 17/3/1.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "GifNewViewController.h"

@interface GifNewViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic,strong) UIWebView* GifViewNo;
@end

@implementation GifNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.backgroundColor=MainColor;
    
    [self getUI];
}

-(void)getUI{

    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    
    float gifH=130*HEIGHT_SIZE;   float gifwidth=100*HEIGHT_SIZE;
    for (int i=0; i<4; i++) {
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(15*NOW_SIZE,10*HEIGHT_SIZE+gifH*i,290*NOW_SIZE, LineWidth)];
        line.backgroundColor=COLOR(255, 255, 255, 0.5);
        [self.view addSubview:line];
    }
   
    for (int i=0; i<3; i++) {
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(18*NOW_SIZE+gifwidth,35*HEIGHT_SIZE+gifH*i,1*NOW_SIZE, 80*HEIGHT_SIZE)];
        line.backgroundColor=COLOR(255, 255, 255, 0.5);
        [self.view addSubview:line];
    }
    
    NSArray *gifName=[NSArray arrayWithObjects:@"ledred",@"ledgreen", @"ledblue",  nil];
  
    for (int i=0; i<gifName.count; i++) {
        NSData *data = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[gifName objectAtIndex:i] ofType:@"gif"]];
        UIWebView* GifViewNo =[[UIWebView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 15*HEIGHT_SIZE+10*HEIGHT_SIZE+gifH*i, gifwidth, gifwidth)];
        [GifViewNo loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
        GifViewNo.delegate = self;
        GifViewNo.scrollView.bounces=NO;
        GifViewNo.userInteractionEnabled=NO;
        GifViewNo.opaque=NO;
        GifViewNo.scalesPageToFit = YES;
        GifViewNo.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:GifViewNo];
    }

    
    NSArray *noticeArray1=[NSArray arrayWithObjects:root_new_wifi_tishi_1_hongdeng, root_new_wifi_tishi_2_lvdeng, root_new_wifi_tishi_3_landeng, nil];
       NSArray *noticeArray2=[NSArray arrayWithObjects:root_new_wifi_tishi_1_hongdeng_yuanyin, root_new_wifi_tishi_2_lvdeng_yuanyin, root_new_wifi_tishi_3_landeng_yuanyin, nil];
    
    for (int i=0; i<noticeArray1.count; i++) {
        float LableW=(320*NOW_SIZE-25*NOW_SIZE-gifwidth-10*NOW_SIZE);
        CGRect fcRect = [[noticeArray1 objectAtIndex:i] boundingRectWithSize:CGSizeMake(LableW, 200*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11 *HEIGHT_SIZE]} context:nil];
        float sizeH1=fcRect.size.height;
        CGRect fcRect2 = [[noticeArray2 objectAtIndex:i] boundingRectWithSize:CGSizeMake(LableW, 200*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11 *HEIGHT_SIZE]} context:nil];
        float sizeH2=fcRect2.size.height;
        
        float HH;
        if (i==0) {
               HH=(gifH-sizeH1-sizeH2-15*HEIGHT_SIZE-LableW*0.092)/2+10*HEIGHT_SIZE;
            
            UIImageView *pwdBgImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(28*NOW_SIZE+gifwidth, HH+16*HEIGHT_SIZE+sizeH1+sizeH2, LableW,LableW*0.092 )];
            pwdBgImageView2.image = IMAGE(@"singal.png");
            pwdBgImageView2.userInteractionEnabled = YES;
            [_scrollView addSubview:pwdBgImageView2];
            
            
        }else{
         HH=(gifH-sizeH1-sizeH2-15*HEIGHT_SIZE)/2+10*HEIGHT_SIZE;
        }
        
        UILabel *noticeLable=[[UILabel alloc]initWithFrame:CGRectMake(28*NOW_SIZE+gifwidth, HH+gifH*i, LableW,sizeH1)];
        noticeLable.text=[noticeArray1 objectAtIndex:i];
        noticeLable.textAlignment=NSTextAlignmentLeft;
        noticeLable.textColor=[UIColor whiteColor];
        noticeLable.numberOfLines=0;
        noticeLable.font = [UIFont systemFontOfSize:11*HEIGHT_SIZE];
        [_scrollView addSubview:noticeLable];
        
        UILabel *noticeLable2=[[UILabel alloc]initWithFrame:CGRectMake(28*NOW_SIZE+gifwidth, HH+15*HEIGHT_SIZE+gifH*i+sizeH1, LableW,sizeH2)];
        noticeLable2.text=[noticeArray2 objectAtIndex:i];
        noticeLable2.textAlignment=NSTextAlignmentLeft;
        noticeLable2.textColor=COLOR(255, 255, 255, 0.8);;
        noticeLable2.numberOfLines=0;
        noticeLable2.font = [UIFont systemFontOfSize:11*HEIGHT_SIZE];
        [_scrollView addSubview:noticeLable2];

    }
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,20*HEIGHT_SIZE+gifH*3, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_wifi_chongxin_peizhi forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(GoSet) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:goBut];
    
    
}

- (void)GoSet{
    [self.navigationController popViewControllerAnimated:YES];
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
