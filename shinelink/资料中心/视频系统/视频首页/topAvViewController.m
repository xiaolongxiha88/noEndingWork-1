//
//  topAvViewController.m
//  ShinePhone
//
//  Created by sky on 16/9/5.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "topAvViewController.h"
#import "AVViewController.h"
#import "MRNavigationLabel.h"
#import "AVfirstView.h"


#define MRScreenW [UIScreen mainScreen].bounds.size.width;
#define MRScreenH [UIScreen mainScreen].bounds.size.height;

@interface topAvViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *titleScrollView;

@property (strong, nonatomic) UIScrollView *contentScrollView;
@property(nonatomic,strong)NSMutableArray *DataCollectionNameArray;
@end

@implementation topAvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _DataCollectionNameArray=[NSMutableArray arrayWithObjects:@"我是大大大蝴蝶花", @"我是大大大大大蝴蝶花",@"我是大大大大大大大花",@"我是大大大蝴蝶花",@"我是大大大蝴蝶花",nil];
     float   cellWidth=SCREEN_Width/2-6*NOW_SIZE;
    
    
    _titleScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0*HEIGHT_SIZE, SCREEN_Width, 40*HEIGHT_SIZE)];
    _titleScrollView.delegate=self;
    _titleScrollView.userInteractionEnabled=YES;
    [self.view addSubview:_titleScrollView];
    
    float contenY=CGRectGetMaxY(_titleScrollView.frame);
    _contentScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,contenY,SCREEN_Width, SCREEN_Height*2)];
    _contentScrollView.contentSize=CGSizeMake(SCREEN_Width, (cellWidth*9/16+45*HEIGHT_SIZE)*_DataCollectionNameArray.count+270*HEIGHT_SIZE);
    _contentScrollView.delegate=self;
    [self.view addSubview:_contentScrollView];
    
    // 取消系统自动设置第一个子scrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 添加子控制器
    [self addChildViewControllers];
    
    // 添加标签栏
    [self addNavigationLabels];
    
    // 默认滑动到第一个tab, 显示第一个控制器view
    [self scrollViewDidEndScrollingAnimation: self.contentScrollView];
    
}


/**
 *  添加子控制器
 */
- (void)addChildViewControllers {
    
    AVfirstView *vc1 = [[AVfirstView alloc] init];
    vc1.title = @"逆变器";
    [self addChildViewController:vc1];
    
    AVfirstView *vc2 = [[AVfirstView alloc] init];
    vc2.title = @"售后";
    [self addChildViewController:vc2];
    
    AVfirstView *vc3 = [[AVfirstView alloc] init];
    vc3.title = @"储能机";
    [self addChildViewController:vc3];
    
    AVfirstView *vc4 = [[AVfirstView alloc] init];
    vc4.title = @"推荐";
    [self addChildViewController:vc4];
    
    AVfirstView *vc5 = [[AVfirstView alloc] init];
    vc5.title = @"市场宣传";
    [self addChildViewController:vc5];
    
    AVfirstView *vc6 = [[AVfirstView alloc] init];
    vc6.title = @"我的产品";
    [self addChildViewController:vc6];
    
    AVfirstView *vc7 = [[AVfirstView alloc] init];
    vc7.title = @"更多产品";
    [self addChildViewController:vc7];
    
    
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * size.width, size.height);
    
    self.contentScrollView.pagingEnabled = YES;
    
    self.contentScrollView.bounces = NO;
}


/**
 *  添加导航标签栏
 */
- (void)addNavigationLabels {
    
    
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/5;
    
    CGFloat height = self.titleScrollView.frame.size.height;
    
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        
        MRNavigationLabel *navigationLabel = [[MRNavigationLabel alloc] init];
        
        navigationLabel.tag = i;
        
        navigationLabel.frame = CGRectMake(i * width, 0, width, height);
        
        navigationLabel.text = [self.childViewControllers[i] title];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [navigationLabel addGestureRecognizer:tap];
        
        [_titleScrollView addSubview:navigationLabel];
        
        if(i == 0) {    // 第一个Label标签
            navigationLabel.scale = 1.0;
        }
    }
    
    self.titleScrollView.contentSize = CGSizeMake(width * self.childViewControllers.count, height);
    
    self.titleScrollView.bounces = NO;
}


/**
 *  手势事件
 */
- (void)tap:(UITapGestureRecognizer *)tap {
    
    NSInteger index = tap.view.tag;
    
    // 定位到指定位置
    CGPoint offset = self.contentScrollView.contentOffset;
    
    offset.x = index * MRScreenW;
    
    [self.contentScrollView setContentOffset:offset animated:YES];
}


#pragma mark - <UIScrollViewDelegate>

/**
 *  当scrollView进行动画结束的时候会调用这个方法, 例如调用[self.contentScrollView setContentOffset:offset animated:YES];方法的时候
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 一些临时变量
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 当前控制器需要显示的控制器的索引
    NSInteger index = offsetX / width;
    
    // 让对应的顶部标题居中显示
    MRNavigationLabel *label = self.titleScrollView.subviews[index];
    CGPoint titleOffsetX = self.titleScrollView.contentOffset;
    titleOffsetX.x = label.center.x - width/2;
    // 左边偏移量边界
    if(titleOffsetX.x < 0) {
        titleOffsetX.x = 0;
    }
    
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - width;
    // 右边偏移量边界
    if(titleOffsetX.x > maxOffsetX) {
        titleOffsetX.x = maxOffsetX;
    }
    
    // 修改偏移量
    self.titleScrollView.contentOffset = titleOffsetX;
    
    // 取出需要显示的控制器
    UIViewController *willShowVc = self.childViewControllers[index];
    
    // 如果当前位置的控制器已经显示过了，就直接返回，不需要重复添加控制器的view
    if([willShowVc isViewLoaded]) return;
    
    // 如果你没有显示过，则将控制器的view添加到contentScrollView上
    willShowVc.view.frame = CGRectMake(index * width, 0, width, height);
    
    [scrollView addSubview:willShowVc.view];
}


/**
 *  当手指抬起停止减速的时候会调用这个方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


/**
 *  scrollView滚动时调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 获取需要操作的的左边的Label
    NSInteger leftIndex = scale;
    MRNavigationLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    
    // 获取需要操作的右边的Label
    NSInteger rightIndex = scale + 1;
    MRNavigationLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count) ?  nil : self.titleScrollView.subviews[rightIndex];
    
    // 右边的比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1- rightScale;
    
    // 设置Label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
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
