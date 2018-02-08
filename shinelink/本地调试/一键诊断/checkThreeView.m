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

@end

@implementation checkThreeView

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    _isOneViewEnable=[_isSelectModelArray[0] boolValue];
    _isTwoViewEnable=[_isSelectModelArray[1] boolValue];
    _isThreeViewEnable=[_isSelectModelArray[2] boolValue];
    _isFourViewEnable=[_isSelectModelArray[3] boolValue];
    _isOneViewH=0;
     _isTwoViewH=0;
     _isThreeViewH=0;
     _isFourViewH=0;
    
    lastH=40*HEIGHT_SIZE;
    
    if (_isOneViewEnable) {
        [self initOneView];
        _isOneViewH=SCREEN_Height-lastH-NavigationbarHeight-StatusHeight;
               _viewOne=[[checkOneView alloc]init];
        _viewOne.view.frame=CGRectMake(0,lastH, SCREEN_Width, _isOneViewH);
        [self.view addSubview:_viewOne.view];
     //   [_viewOne viewDidLoad];
        
    }
    
    if (_isTwoViewEnable) {
        [self initTwoView];
            _isTwoViewH=SCREEN_Height-lastH-NavigationbarHeight-StatusHeight;
    }
    
    if (_isThreeViewEnable) {
        [self initThreeView];
        
    }
    
    if (_isFourViewEnable) {
        [self initFourView];
        
    }
}


-(void)initUI{
    
    _isReadNow=NO;
    _progressView = [[CustomProgress alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, lastH)];
    _progressView.maxValue = 100;
    //设置背景色
    _progressView.bgimg.backgroundColor =COLOR(0, 156, 255, 1);
    _progressView.leftimg.backgroundColor =COLOR(53, 177, 255, 1);
    
    _progressView.presentlab.textColor = [UIColor whiteColor];
    _progressView.presentlab.text = @"开始";
    [self.view addSubview:_progressView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goStartRead:)];
    [_progressView addGestureRecognizer:tapGestureRecognizer];
}

-(void)goStartRead:( UITapGestureRecognizer *)tap{
    _isReadNow = !_isReadNow;
    
    if (_isReadNow) {
    
        
        _progressView.presentlab.text = @"取消";
        
    }else{
        
        present=0;
        [_progressView setPresent:present];
        _progressView.presentlab.text = @"开始";
        _timer.fireDate=[NSDate distantFuture];
        
    }
    
}

-(void)initOneView{
    
}


-(void)initTwoView{
    
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
