//
//  productViewController.m
//  shinelink
//
//  Created by sky on 16/4/27.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "productViewController.h"
#import "imageBig.h"

  #define  headH 200*HEIGHT_SIZE
//  #define  headH2 120*HEIGHT_SIZE
#define Kwidth [UIScreen mainScreen].bounds.size.width
@interface productViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *imageArrayName;
@property(nonatomic,strong)NSMutableArray *imageArrayCount;
@property (nonatomic, strong) UILabel *title1;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UILabel *detail2;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, strong) UIButton *dayButton;
@property (nonatomic, strong) UIButton *monthButton;
@property (nonatomic, strong) UIImageView *imageView;
@property(nonatomic,strong)NSMutableArray *paramsArray;
@end

@implementation productViewController
{
    UITableView *_tableView;
    UIPageControl *_pageControl;
    UIScrollView *_scrollerView;
    NSString *_indenty;
    
    float  headH2;
    
    NSArray *arrayImage;
    NSArray *arrayName;
    //全局变量 用来控制偏移量
    NSInteger pageName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     CGRect fcRect = [_feature2 boundingRectWithSize:CGSizeMake(300*NOW_SIZE, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12 *HEIGHT_SIZE]} context:nil];
    
    headH2=fcRect.size.height;
    
    [self initUI];
}

-(void)initUI{
  [self netProduct];
    [self uiOne];
     [self createHeaderView];
    [self uiTwo];
    [self uiThree];
  
}

-(void)netProduct{
    
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
      NSString *_languageValue ;
    
    if ([currentLanguage isEqualToString:@"zh-Hans-CN"]) {
        _languageValue=@"0";
    }else if ([currentLanguage isEqualToString:@"en-CN"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }

//    
//    NSString *imageURL=[NSString stringWithFormat:@"%@/%@",HEAD_URL,_paramImage];
//    UIImage * resultImage;
//    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
//    
//    if (data) {
//        resultImage = [UIImage imageWithData:data];
//       _paramsArray=[NSMutableArray arrayWithObject:resultImage];
//   
//    }

    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *imageURL=[NSString stringWithFormat:@"%@/%@",HEAD_URL,_paramImage];
        UIImage * resultImage;
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        
        if (data!= nil) {
            resultImage = [UIImage imageWithData:data];
            _paramsArray=[NSMutableArray arrayWithObject:resultImage];
            
            
            
        }
    });

    
    
    
//    [BaseRequest requestImageWithMethodByGet:HEAD_URL paramars:@{@"imageName":_paramImage,@"language":_languageValue} paramarsSite:@"/newProductAPI.do?op=getProductParamImage" sucessBlock:^(id content2) {
//
//        [self hideProgressView];
//        NSLog(@"getProductParamImage=: %@", content2);
//        if (content2) {
//            _paramsArray=[NSMutableArray arrayWithObject:content2];
//            }
//            
//        
//        
//    } failure:^(NSError *error) {
//        [self hideProgressView];
//    }];
}


-(void)uiOne{
   
    _scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView2.scrollEnabled=YES;
    _scrollView2.contentSize = CGSizeMake(SCREEN_Width,1000*NOW_SIZE);
    [self.view addSubview:_scrollView2];
    
    _title1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*HEIGHT_SIZE+headH, 300*NOW_SIZE,25*HEIGHT_SIZE )];
    _title1.text=_name2;
    _title1.textAlignment=NSTextAlignmentCenter;
    _title1.textColor=COLOR(0, 0, 0, 1);
    _title1.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
    [_scrollView2 addSubview:_title1];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*HEIGHT_SIZE+30*HEIGHT_SIZE+headH, 300*NOW_SIZE,1*HEIGHT_SIZE )];
    line3.backgroundColor=[UIColor grayColor];
    [_scrollView2 addSubview:line3];
    
    
    
    _detail=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,50*HEIGHT_SIZE+headH, 300*NOW_SIZE,headH2)];
    _detail.text=_feature2;
     //_detail.editable=NO;
    _detail.textAlignment=NSTextAlignmentLeft;
    _detail.numberOfLines=0;
    _detail.textColor=COLOR(60, 60, 60, 1);
    _detail.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_scrollView2 addSubview:_detail];
    
    UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,55*HEIGHT_SIZE+headH+headH2, 300*NOW_SIZE,1*HEIGHT_SIZE )];
    line4.backgroundColor=[UIColor grayColor];
    [_scrollView2 addSubview:line4];
    
}

-(void)uiTwo{
    self.dayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dayButton.frame = CGRectMake(0 * SCREEN_Width/4, 60*HEIGHT_SIZE+headH+headH2, SCREEN_Width/2, 20*HEIGHT_SIZE);
    [self.dayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(47, 200, 255, 1) rect:CGRectMake(0, 0, SCREEN_Width/2, 20*HEIGHT_SIZE)] forState:UIControlStateNormal];
   [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/2, 20*HEIGHT_SIZE)] forState:UIControlStateHighlighted];
   [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/2, 20*HEIGHT_SIZE)] forState:UIControlStateSelected];
    self.dayButton.tag = 1000;
    [self.dayButton setTitle:root_ME_gaisu forState:UIControlStateNormal];
   self.dayButton.selected = YES;
    [self.dayButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView2 addSubview:self.dayButton];
    
    self.monthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.monthButton.frame = CGRectMake(1 * SCREEN_Width/2, 60*HEIGHT_SIZE+headH+headH2, SCREEN_Width/2, 20*HEIGHT_SIZE);
    [self.monthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(47, 200, 255, 1) rect:CGRectMake(0, 0, SCREEN_Width/2, 20*HEIGHT_SIZE)] forState:UIControlStateNormal];
   [self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/2, 20*HEIGHT_SIZE)] forState:UIControlStateHighlighted];
[self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/2, 20*HEIGHT_SIZE)] forState:UIControlStateSelected];
    self.monthButton.tag = 1001;
    [self.monthButton setTitle:root_ME_canshu forState:UIControlStateNormal];
    [self.monthButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView2 addSubview:self.monthButton];
}

- (void)buttonDidClicked:(UIButton *)sender {

    if (sender.tag == 1000) {
        self.dayButton.selected = YES;
        self.monthButton.selected = NO;
        
     
        if (_imageView) {
            [_imageView removeFromSuperview];
        }
        
        [self uiThree];
    }else if(sender.tag == 1001){
        self.dayButton.selected = NO;
        self.monthButton.selected = YES;
        
        
        if (_detail2) {
             [_detail2 removeFromSuperview];
        }
        [self uiFour];
    }
}

-(void)uiThree{

    CGRect fcRect1 = [_outline2 boundingRectWithSize:CGSizeMake(300*NOW_SIZE, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12 *HEIGHT_SIZE]} context:nil];
    
    _detail2=nil;
    if (!_detail2) {
        
//        if (fcRect1.size.height<400*HEIGHT_SIZE) {
//            _detail2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,60*HEIGHT_SIZE+headH+headH2+25*HEIGHT_SIZE, 300*NOW_SIZE,400*HEIGHT_SIZE)];
//        }else{
        
        
            _detail2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,60*HEIGHT_SIZE+headH+headH2+25*HEIGHT_SIZE, 300*NOW_SIZE,fcRect1.size.height)];
        

        
        _detail2.text=_outline2;
        // _detail2.editable=NO;
        _detail2.numberOfLines=0;
        _detail2.textAlignment=NSTextAlignmentLeft;
        _detail2.textColor=COLOR(60, 60, 60, 1);
        _detail2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView2 addSubview:_detail2];
    }

    
}

-(void)uiFour{
    
    _imageView=nil;
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*NOW_SIZE,60*HEIGHT_SIZE+headH+headH2+25*HEIGHT_SIZE, 300*NOW_SIZE,400*HEIGHT_SIZE)];
        if (_paramsArray.count>0) {
            _imageView.image = _paramsArray[0];
            UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage)];
            [self.imageView addGestureRecognizer:tap];
        }
        
        [_imageView setUserInteractionEnabled:YES];
        [_scrollView2 addSubview:_imageView];
     
    }
 
}

- (void)magnifyImage
{
    NSLog(@"局部放大");
    [imageBig showImage:self.imageView];//调用方法
}



- (void)createHeaderView{
    
  
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,Kwidth,headH)];
    
  //  [_imageArray addObject:[UIImage imageNamed:@"MTL.png"]];
    
    
    if (_imageArray) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE,0,240*NOW_SIZE,_scrollerView.bounds.size.height)];
        imageView.image = _imageArray[0];
        [_scrollerView addSubview:imageView];
    }else{
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE,0,240*NOW_SIZE,_scrollerView.bounds.size.height)];
        imageView.image =[UIImage imageNamed:@"pic_service.png"];
        [_scrollerView addSubview:imageView];

    
    }
    
    
    
    
    
//    if (_imageArray) {
//        for (int i=0; i<_imageArray.count; i++) {
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Kwidth*i,0,Kwidth,_scrollerView.bounds.size.height)];
//            imageView.image = _imageArray[i];
//            [_scrollerView addSubview:imageView];
//            
//            _scrollerView.contentSize = CGSizeMake(Kwidth*_imageArray.count,headH);
//            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,headH-20,Kwidth,20)];
//            _pageControl.numberOfPages = _imageArray.count;
//        }
//    }else{
//        NSArray *imgArray = @[@"1.jpg",
//                              @"2.jpg"];
//        for (int i=0; i<imgArray.count; i++) {
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Kwidth*i,0,Kwidth,_scrollerView.bounds.size.height)];
//            imageView.image = [UIImage imageNamed:imgArray[i]];
//            
//            
//            
//            [_scrollerView addSubview:imageView];
//            
//            _scrollerView.contentSize = CGSizeMake(Kwidth*imgArray.count,headH);
//            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,headH-20,Kwidth,20)];
//            _pageControl.numberOfPages = imgArray.count;
//        }
//    }
    
    
    _scrollerView.pagingEnabled = YES;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.delegate = self;
    [self.scrollView2 addSubview:_scrollerView];
    
    //创建分页视图
    
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView2 addSubview:_pageControl];
}

#pragma mark pageAction的实现方法
- (void)pageAction:(UIPageControl *)control {
    NSInteger page = control.currentPage;
    [_scrollerView setContentOffset:CGPointMake(Kwidth*page,0) animated:YES];
}


#pragma mark _scrollerView的协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat x = scrollView.contentOffset.x / Kwidth;
    _pageControl.currentPage = x;
}

#pragma mark 定时器方法
- (void)circulate:(NSTimer *)timer {
    
    pageName++;
    
    [_scrollerView setContentOffset:CGPointMake(Kwidth*pageName, 0) animated:YES];
    _pageControl.currentPage = pageName;
    
    if (pageName == 2) {
        pageName = -1;
    }
    
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
