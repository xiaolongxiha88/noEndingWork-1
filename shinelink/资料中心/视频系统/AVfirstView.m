//
//  AVfirstView.m
//  ShinePhone
//
//  Created by sky on 16/9/2.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "AVfirstView.h"
#import "AVViewController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

#define Width [UIScreen mainScreen].bounds.size.width

@interface AVfirstView ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UILabel *indicateLabel;
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@property(nonatomic,strong)UILabel *label;
@end

@implementation AVfirstView

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initData];
 
    [self setupUI];
    
}


- (void)setupUI {
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,0*HEIGHT_SIZE, 300*NOW_SIZE, 30*HEIGHT_SIZE)];
        _label.layer.borderWidth=1;
        _label.layer.cornerRadius=15*HEIGHT_SIZE;
        _label.layer.borderColor=MainColor.CGColor;
    _label.text =@"搜索";
    _label.textColor = MainColor;
    //textField.tintColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_label];
    _label.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchAV)];
    [_label addGestureRecognizer:tap];
    
    
    
    _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 30*HEIGHT_SIZE, Width, (Width - 84) * 9 / 16 + 24)];
    _pageFlowView.backgroundColor = [UIColor whiteColor];
    _pageFlowView.delegate = self;
    _pageFlowView.dataSource = self;
    _pageFlowView.minimumPageAlpha = 0.8;
    _pageFlowView.minimumPageScale = 0.92;
    _pageFlowView.autoTime=5;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.size.height - 24 - 8, Width, 8)];
    _pageFlowView.pageControl = pageControl;
    [_pageFlowView addSubview:pageControl];
      [_pageFlowView startTimer];
    [self.view addSubview:_pageFlowView];
    
    //添加到主view上
    [self.view addSubview:self.indicateLabel];
    
}



-(void)initData{

    for (int index = 0; index < 5; index++) {
        UIImage *image = [UIImage imageNamed:@"pic_service.png"];
        [self.imageArray addObject:image];
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(Width - 84, (Width - 84) * 9 / 16);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.imageArray.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Width - 84, (Width - 84) * 9 / 16)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    //    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = self.imageArray[index];
    bannerView.allCoverButton.tag = index;
    [bannerView.allCoverButton addTarget:self action:@selector(didSelectBannerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return bannerView;
}


-(void)searchAV{


}



#pragma mark --点击轮播图
- (void)didSelectBannerButtonClick:(UIButton *) sender {
    
    NSInteger index = sender.tag;
    
    NSLog(@"点击了第%ld张图",(long)index + 1);
    
    self.indicateLabel.text = [NSString stringWithFormat:@"点击了第%ld张图",(long)index + 1];
    
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"滚动到了第%ld页",(long)pageNumber);
}

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UILabel *)indicateLabel {
    
    if (_indicateLabel == nil) {
        _indicateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*HEIGHT_SIZE+_pageFlowView.frame.size.height, Width, 16)];
        _indicateLabel.textColor = [UIColor blueColor];
        _indicateLabel.font = [UIFont systemFontOfSize:16.0];
        _indicateLabel.textAlignment = NSTextAlignmentCenter;
        _indicateLabel.text = @"指示Label";
    }
    
    return _indicateLabel;
}





-(void)goAV{
    AVViewController *go=[[AVViewController alloc]init];
    [self.navigationController pushViewController:go animated:YES];
    
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
