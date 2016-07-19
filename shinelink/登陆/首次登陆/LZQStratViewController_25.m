//
//  LZQStratViewController_25.m
//  SupperSupper
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LZQStratViewController_25.h"
#import "loginViewController.h"

#define SCR_W [UIScreen mainScreen].bounds.size.width
#define SCR_H [UIScreen mainScreen].bounds.size.height


@interface LZQStratViewController_25 () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    
    UIButton *_btn;
}
@end

@implementation LZQStratViewController_25

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSrollView];
  //  [self addTimer];
    
    [self addBtn];
}

- (void)addSrollView{
    //初始化滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H)];
    //设置滚动视图区域
    _scrollView.contentSize = CGSizeMake(SCR_W * 3, SCR_H);
    
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSMutableArray *imageName=[NSMutableArray array];
    
    if ([currentLanguage isEqualToString:@"zh-Hans-CN"]) {
        [imageName addObject:@"first1.jpg"];
        [imageName addObject:@"first1.jpg"];
        [imageName addObject:@"first2.png"];
        [imageName addObject:@"333.png"];
    }else if ([currentLanguage isEqualToString:@"en-CN"]) {
        [imageName addObject:@"11.png"];
         [imageName addObject:@"11.png"];
         [imageName addObject:@"22.png"];
         [imageName addObject:@"33.png"];
      // NSArray *imageName=[NSArray arrayWithObjects:@"11.png",@"11.png",@"22.png",@"33.png", nil];
    }else{
        [imageName addObject:@"11.png"];
        [imageName addObject:@"11.png"];
        [imageName addObject:@"22.png"];
        [imageName addObject:@"33.png"];
    }

    
    
   // NSArray *imageName=[NSArray arrayWithObjects:@"11.png",@"11.png",@"22.png",@"33.png", nil];
    
    
    for (int i = 1; i < 4; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCR_W * (i - 1), 0, SCR_W, SCR_H)];
        imageView.image = [UIImage imageNamed:imageName[i]];
        [_scrollView addSubview:imageView];
    }
    //设置分页显示，一页的宽度是我们视图的宽度
    _scrollView.pagingEnabled = YES;
    //设置滚动风格
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
          //  UIScrollViewIndicatorStyleDefault, // 黑色
          //  UIScrollViewIndicatorStyleBlack,   // 黑色
          //  UIScrollViewIndicatorStyleWhite    // 白色
    
    //隐藏水平导航栏
    _scrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    // 关闭弹簧效果
    // _scrollView.bounces = NO;
    // 关闭滑动效果
    //_scrollView.scrollEnabled = NO;
    
    
    //分页控制器（小圆点－－位置）
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCR_H - 60*HEIGHT_SIZE, SCR_W, 40*HEIGHT_SIZE)];
    _pageControl.backgroundColor = MainColor;
    //设置小圆点个数
    _pageControl.numberOfPages = 3;
    [self.view addSubview:_pageControl];
}

//- (void)addTimer{
//    //添加定时器
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
//    //scheduled--时刻表  interval--间隔  target--目标  repeats-- 重写   Info--信息
//}

//static BOOL reverse = NO;
//reverse -- 相反情况

//- (void)startTimer{
//    NSInteger count = 3;
//    static NSInteger page = 0;
//    
//  //  if (page < count - 1) {
//    
//        page ++;
//        if (page == count) {
//            LZQDidStartViewController_25 *lzqSVC = [[LZQDidStartViewController_25 alloc] init];
//            [self presentViewController:lzqSVC animated:YES completion:nil];
//        }
//    
// //   }
//    CGFloat offSetX = page * SCR_W;
//    CGPoint offset = CGPointMake(offSetX, 0);
//    [_scrollView setContentOffset:offset animated:YES];
//}

- (void)addBtn{
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(SCR_W * 2 + 60*NOW_SIZE,SCR_H - 100*HEIGHT_SIZE, 200*NOW_SIZE, 35*HEIGHT_SIZE);
    //    [goBut.layer setMasksToBounds:YES];
    //    [goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"btn1.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitleColor:MainColor forState:UIControlStateNormal];
    [goBut setTitle:root_liji_tiyan forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    //  goBut.highlighted=[UIColor grayColor];
    [_scrollView addSubview:goBut];
    
//    _btn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_W * 2 + SCR_W / 2, 300, 100, 30)];
//    _btn.backgroundColor = [UIColor redColor];
//    [_btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
//    [_btn setTitle:@"点击计入App" forState:UIControlStateNormal];
//    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_scrollView addSubview:_btn];
}

- (void)clickBtn{
    loginViewController *lzqSVC = [[loginViewController alloc] init];
                [self presentViewController:lzqSVC animated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
#pragma mark - 只要视图滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //设置_pageControl当前小圆点的位置
    _pageControl.currentPage = _scrollView.contentOffset.x / SCR_W;
}

#pragma mark - 移除
- (void)dealloc
{
    // 移除定时器
    [_timer invalidate];
    _timer = nil;
}
@end
