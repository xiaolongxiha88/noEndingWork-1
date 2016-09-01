//
//  AVViewController.m
//  ShinePhone
//
//  Created by sky on 16/9/1.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "AVViewController.h"
#import "HcdCacheVideoPlayer.h"
#import "UIImage+ImageEffects.h"


@interface AVViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) HcdCacheVideoPlayer *play;
@property (nonatomic, strong)UIButton *backButton;
@end

@implementation AVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor redColor]}];
    self.title = @"视频中心";
    
    //self.view.backgroundColor=MainColor;
    
    
    [self initUI];
    

    
}



-(void)initUI{

     CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,rectStatus.size.height,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width * 0.5625)];
    UIImage *sourceImage = [UIImage imageNamed:@"pic_service.png"];
    //UIImage *lastImage = [sourceImage applyDarkEffect];//一句代码搞定毛玻璃效果
 //   _imageView.image = lastImage;
     _imageView.image = sourceImage;
    [_imageView setUserInteractionEnabled:YES];
    [self.view addSubview:_imageView];

    
    float backButtonSize=35*HEIGHT_SIZE;
      _backButton = [[UIButton alloc] initWithFrame:CGRectMake(5*HEIGHT_SIZE, rectStatus.size.height+5*HEIGHT_SIZE, backButtonSize , backButtonSize)];
       [_backButton addTarget:self action:@selector(gobackAV) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setImage:[UIImage imageNamed:@"backAV.png"] forState:UIControlStateNormal];
    [self.view addSubview:_backButton];
    
    
    float image2Size=0.25*[UIScreen mainScreen].bounds.size.width;
    
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0.5*([UIScreen mainScreen].bounds.size.width-image2Size),0.5*([UIScreen mainScreen].bounds.size.width * 0.5625-image2Size),image2Size,image2Size)];
    _imageView2.image = [UIImage imageNamed:@"AvPlay2.png"];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playAV)];
    [_imageView2 addGestureRecognizer:tap];
    [_imageView2 setUserInteractionEnabled:YES];
    [_imageView addSubview:_imageView2];
    
    
    _scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(0, _imageView.frame.origin.y+_imageView.frame.size.height, SCREEN_Width, SCREEN_Height)];
    _scrollView2.scrollEnabled=YES;
    _scrollView2.contentSize = CGSizeMake(SCREEN_Width,1050*HEIGHT_SIZE);
    [self.view addSubview:_scrollView2];
    
    float imageButtonSiz=20*HEIGHT_SIZE;
    UIImageView *imageButton = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width-imageButtonSiz-20*NOW_SIZE,0+10*HEIGHT_SIZE,imageButtonSiz,imageButtonSiz)];
    imageButton.image = [UIImage imageNamed:@"downloadAV.png"];
    UITapGestureRecognizer *tap2  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downAV)];
    [imageButton addGestureRecognizer:tap2];
    [imageButton setUserInteractionEnabled:YES];
    [_scrollView2 addSubview:imageButton];
    
    float downLableWidth=60*NOW_SIZE;
        UILabel *downLable= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width-downLableWidth,0+10*HEIGHT_SIZE+imageButtonSiz,downLableWidth,imageButtonSiz)];
   downLable.text=@"缓存";
    downLable.textColor=[UIColor blackColor];
    downLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
   downLable.textAlignment = NSTextAlignmentCenter;
  downLable.userInteractionEnabled=YES;
    UITapGestureRecognizer * demo1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(downAV)];
    [downLable addGestureRecognizer:demo1];
    [_scrollView2 addSubview:downLable];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0,15*HEIGHT_SIZE+imageButtonSiz*2,SCREEN_Width,4*HEIGHT_SIZE)];
    line1.backgroundColor=COLOR(194, 195, 204, 0.75);
    [_scrollView2 addSubview:line1];
    
}


-(void)downAV{
    
   _play = [HcdCacheVideoPlayer sharedInstance];
    [HcdCacheVideoPlayer clearAllVideoCache];
    
}


-(void)playAV{
    
    [_imageView removeFromSuperview];
    [_imageView2 removeFromSuperview];
    [_backButton removeFromSuperview];
   CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
        _play = [HcdCacheVideoPlayer sharedInstance];
        UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, rectStatus.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.5625)];
        [self.view addSubview:videoView];
    
        [_play playWithUrl:[NSURL URLWithString:@"http://cdn.growatt.com/app/xpg.mp4"] showView:videoView andSuperView:self.view];
        //[play playWithUrl:[NSURL URLWithString:@"http://pan.baidu.com/s/1c1Y95fy"] showView:videoView andSuperView:self.view];
    
        NSLog(@"getSize=%f", [HcdCacheVideoPlayer allVideoCacheSize]);
    
    
    
}



-(void)gobackAV{

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
