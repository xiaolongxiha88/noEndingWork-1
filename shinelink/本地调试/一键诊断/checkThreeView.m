//
//  checkThreeView.m
//  ShinePhone
//
//  Created by sky on 2018/1/27.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "checkThreeView.h"
#import "checkOneView.h"
#import "checkTwoView.h"
#import "CustomProgress.h"


@interface checkThreeView ()
{
  
    int present;
    CGSize lable1Size2;
    float everyLalbeH;
    float Lable11x;
    float lastH;
      float everyModelKongH;
   
}
@property (strong, nonatomic) checkOneView *viewOne;
@property (strong, nonatomic) checkTwoView *viewTwo;
 @property (strong, nonatomic)  CustomProgress *progressView;
@property (nonatomic) BOOL isReadNow;

@property (nonatomic) BOOL isReadfirstDataOver;
@property (strong, nonatomic)NSTimer *timer;

@property (nonatomic) BOOL isOneViewEnable;
@property (nonatomic) BOOL isTwoViewEnable;
@property (nonatomic) BOOL isThreeViewEnable;
@property (nonatomic) BOOL isFourViewEnable;

@property (nonatomic) int isOneViewH;
@property (nonatomic) int isTwoViewH;
@property (nonatomic) int isThreeViewH;
@property (nonatomic) int isFourViewH;

@property (strong, nonatomic)NSMutableArray *allReadChartEnableArray;
@property (nonatomic) int allCmdModleTime;
@property (strong, nonatomic) UIScrollView *scrollViewAll;

@end

@implementation checkThreeView

- (void)viewDidLoad {
    [super viewDidLoad];


    
    _isOneViewEnable=[_isSelectModelArray[0] boolValue];
    _isTwoViewEnable=[_isSelectModelArray[1] boolValue];
    _isThreeViewEnable=[_isSelectModelArray[2] boolValue];
    _isFourViewEnable=[_isSelectModelArray[3] boolValue];
    _isOneViewH=0;
     _isTwoViewH=0;
     _isThreeViewH=0;
     _isFourViewH=0;
    everyModelKongH=10*HEIGHT_SIZE;
    everyLalbeH=30*HEIGHT_SIZE;
    
    lastH=40*HEIGHT_SIZE;
    
        [self initUI];
    
    if (_isOneViewEnable) {
            _isOneViewH=SCREEN_Height-lastH-NavigationbarHeight+everyLalbeH+everyModelKongH*2;
        [self initOneView];
    
    }
    
    if (_isTwoViewEnable) {
                    _isTwoViewH=SCREEN_Height-lastH-NavigationbarHeight+everyLalbeH+everyModelKongH*2-20*HEIGHT_SIZE;
        
        [self initTwoView];

    }
    
    if (_isThreeViewEnable) {
        [self initThreeView];
        
    }
    
    if (_isFourViewEnable) {
        [self initFourView];
        
    }
    
    _scrollViewAll.contentSize=CGSizeMake(ScreenWidth, _isOneViewH+_isTwoViewH+_isThreeViewH+_isFourViewH+200*HEIGHT_SIZE);
    
}


-(void)initUI{
    _scrollViewAll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, SCREEN_Height)];
    _scrollViewAll.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_scrollViewAll];
    
    _isReadNow=NO;
    if (!_progressView) {
        _progressView = [[CustomProgress alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, lastH)];
        _progressView.maxValue = 100;
        //设置背景色
        _progressView.bgimg.backgroundColor =COLOR(0, 156, 255, 1);
        _progressView.leftimg.backgroundColor =COLOR(53, 177, 255, 1);
        
        _progressView.presentlab.textColor = [UIColor whiteColor];
        _progressView.presentlab.text = @"开始";
        [_scrollViewAll addSubview:_progressView];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goStartRead:)];
        [_progressView addGestureRecognizer:tapGestureRecognizer];
    }
   
}

-(void)goStartRead:( UITapGestureRecognizer *)tap{
    _isReadNow = !_isReadNow;
    
    if (_isReadNow) {
        _allCmdModleTime=0;
        [self goToReadAllChart];
        _progressView.presentlab.text = @"取消";
        
    }else{
        
        present=0;
        [_progressView setPresent:present];
        _progressView.presentlab.text = @"开始";
        _timer.fireDate=[NSDate distantFuture];
        
    }
    
}



-(void)goToReadAllChart{
    if (_allCmdModleTime==0) {
                [_viewOne addNotification];
           [[NSNotificationCenter defaultCenter] postNotificationName:@"OneKeyOneViewGoToStartRead"object:nil];
    }
    
    _allCmdModleTime++;
}


-(void)initOneView{
    if (!_viewOne) {
        UIView* view1=[[UIView alloc]initWithFrame:CGRectMake(0,lastH, SCREEN_Width, everyLalbeH)];
        view1.backgroundColor=[UIColor whiteColor];
        [_scrollViewAll addSubview:view1];
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0,0, SCREEN_Width, everyLalbeH)];
        titleLable.textColor =MainColor;
        titleLable.textAlignment=NSTextAlignmentCenter;
        titleLable.text=@"I-V/P-V 曲线";
        titleLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [view1 addSubview:titleLable];
        
        _viewOne=[[checkOneView alloc]init];
        _viewOne.oneCharType=2;
        _viewOne.view.frame=CGRectMake(0,lastH+everyLalbeH, SCREEN_Width, _isOneViewH-everyLalbeH-everyModelKongH*2);

       __weak typeof(self) weakSelf = self;
        _viewOne.oneViewOverBlock=^{
            [weakSelf goToReadAllChart];
        };
        [_scrollViewAll addSubview:_viewOne.view];
        
        UIView* view0=[[UIView alloc]initWithFrame:CGRectMake(0,lastH+_isOneViewH-everyModelKongH, SCREEN_Width, everyModelKongH)];
        view0.backgroundColor=COLOR(242, 242, 242, 1);
        [_scrollViewAll addSubview:view0];
        
    
        
    }
    
    
}


-(void)initTwoView{
    if (!_viewTwo) {
        UIView* view1=[[UIView alloc]initWithFrame:CGRectMake(0,lastH+_isOneViewH, SCREEN_Width, everyLalbeH)];
        view1.backgroundColor=[UIColor whiteColor];
        [_scrollViewAll addSubview:view1];
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0,0, SCREEN_Width, everyLalbeH)];
        titleLable.textColor =MainColor;
        titleLable.textAlignment=NSTextAlignmentCenter;
        titleLable.text=@"AC曲线";
        titleLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [view1 addSubview:titleLable];
        
        _viewTwo=[[checkTwoView alloc]init];
        _viewTwo.charType=3;
        _viewTwo.view.frame=CGRectMake(0,lastH+_isOneViewH+everyLalbeH, SCREEN_Width, _isTwoViewH-everyLalbeH-everyModelKongH*2);
        [_viewTwo addNotification];
        __weak typeof(self) weakSelf = self;
        _viewTwo.oneViewOverBlock=^{
            [weakSelf goToReadAllChart];
        };
        [_scrollViewAll addSubview:_viewTwo.view];
        
        UIView* view0=[[UIView alloc]initWithFrame:CGRectMake(0,lastH+_isOneViewH+_isTwoViewH-everyModelKongH, SCREEN_Width, everyModelKongH)];
        view0.backgroundColor=COLOR(242, 242, 242, 1);
        [_scrollViewAll addSubview:view0];
        
        
        
    }
}

-(void)initThreeView{
    
}

-(void)initFourView{
    
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
