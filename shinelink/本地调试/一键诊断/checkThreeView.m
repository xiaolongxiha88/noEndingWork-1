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
#import "MCBarChartView.h"
#import "usbToWifiDataControl.h"
#import "wifiToPvOne.h"

@interface checkThreeView ()<MCBarChartViewDataSource, MCBarChartViewDelegate>
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

@property (strong, nonatomic) MCBarChartView *barChartView2;

@property (strong, nonatomic)NSArray* barRightArray;
@property (strong, nonatomic)NSArray* barColorArray;
@property (strong, nonatomic)NSArray*Xtitles2;
@property (strong, nonatomic) NSMutableArray *barDataSource2;  //bar数据的二维数组

@property(nonatomic,strong)wifiToPvOne*ControlOne;
@property (assign, nonatomic) int cmdTimes;
@property (assign, nonatomic) int progressNum;
@property(nonatomic,strong)usbToWifiDataControl*changeDataValue;

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
         _isThreeViewH=everyLalbeH+300*HEIGHT_SIZE+120*HEIGHT_SIZE;
        
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
    
    if (_allCmdModleTime==1) {
        [_viewTwo addNotification];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OneKeyTwoViewGoToStartRead"object:nil];
    }
    
    if (_allCmdModleTime==2) {
        [self cmdThreeModle];
    }
    
    _allCmdModleTime++;
}

-(void)cmdThreeModle{
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
        
    }

    
    _cmdTimes=0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveData:) name: @"TcpReceiveOneKey" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFailed) name: @"TcpReceiveOneKeyFailed" object:nil];
    
    NSString *LENTH=[NSString stringWithFormat:@"1_2_%d",1];
          [_ControlOne goToOneTcp:9 cmdNum:1 cmdType:@"16" regAdd:@"265" Length:LENTH];
}


//定时器更新
-(void)updateProgress{
    _progressNum++;
    

    
    int waitingTime=0;
    if (_cmdTimes==0) {
        waitingTime=60;
    }
    if (_cmdTimes==2) {
          waitingTime=60;
    }
    if (_progressNum>=waitingTime) {
        if (_cmdTimes==0) {
            _cmdTimes++;
              [_ControlOne goToOneTcp:10 cmdNum:1 cmdType:@"20" regAdd:@"6000" Length:@"125"];
        }
        
        
          _timer.fireDate=[NSDate distantFuture];
    }
    
}



-(void)receiveData:(NSNotification*) notification{
    NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
        NSData*data= [firstDic objectForKey:@"one"];
    if (_cmdTimes==0) {
        if (!_timer) {
            _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
        }else{
            _timer.fireDate=[NSDate distantPast];
        }
    }
    
    if (_cmdTimes==1) {
        _barDataSource2=[NSMutableArray array];
        for (int i=0; i<3; i++) {
            int T=1+11*i;
            NSMutableArray *smallArray=[NSMutableArray array];
            for (int K=0; K<10; K++) {
                   float value=([_changeDataValue changeOneRegister:data registerNum:T]);
                [smallArray addObject:[NSString stringWithFormat:@"%.f",value]];
            }
            [_barDataSource2 addObject:smallArray];
        }
        
        _barRightArray=@[[NSString stringWithFormat:@"%d",[_changeDataValue changeOneRegister:data registerNum:0]],[NSString stringWithFormat:@"%d",[_changeDataValue changeOneRegister:data registerNum:1]],[NSString stringWithFormat:@"%d",[_changeDataValue changeOneRegister:data registerNum:2]]];
    }
    
    
}

-(void)setFailed{
    
}

////////////////////I-V/P-V 曲线
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

////////////////////AC曲线
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

    
    
    if (!_barChartView2) {
        _barChartView2 = [[MCBarChartView alloc] initWithFrame:CGRectMake(0, lastH+_isOneViewH+_isTwoViewH, ScreenWidth,  _isThreeViewH)];
        _barChartView2.tag = 222;
        _barChartView2.dataSource = self;
        _barChartView2.delegate = self;
        [_scrollViewAll addSubview:_barChartView2];
    }
    
    //_barChartView2.maxValue = maxyAxisValue;
    _barChartView2.unitOfYAxis = @"";
    _barChartView2.colorOfXAxis =COLOR(153, 153, 153, 1);                                                                      
    _barChartView2.colorOfXText = COLOR(102, 102, 102, 1);
    _barChartView2.colorOfYAxis = COLOR(153, 153, 153, 1);
    _barChartView2.colorOfYText = COLOR(102, 102, 102, 1);
    
    
    [_barChartView2 reloadDataWithAnimate:YES];
    
}



- (NSInteger)numberOfSectionsInBarChartView:(MCBarChartView *)barChartView {
    
    return [_barDataSource2 count];
    
    
}


- (NSInteger)barChartView:(MCBarChartView *)barChartView numberOfBarsInSection:(NSInteger)section {
    if (barChartView.tag == 111) {
        return 1;
    } else {
        return [_barDataSource2[section] count];
    }
}

- (id)barChartView:(MCBarChartView *)barChartView valueOfBarInSection:(NSInteger)section index:(NSInteger)index {
    
    return _barDataSource2[section][index];
    
}

//NSArray *valueLineColorArray0=@[COLOR(255, 217, 35, 1),COLOR(54, 193, 118, 1),COLOR(139, 128, 255, 1),COLOR(14, 239, 246, 1)];
//ppv   sysOut   pacToUser  userLoad

- (UIColor *)barChartView:(MCBarChartView *)barChartView colorOfBarInSection:(NSInteger)section index:(NSInteger)index {
    
    if (_barColorArray.count>index) {
        return _barColorArray[index];
    }else{
        return COLOR(255, 217, 35, 1);
    }
    
}

- (NSString *)barChartView:(MCBarChartView *)barChartView titleOfBarInSection:(NSInteger)section {
    return _Xtitles2[section];
}



- (CGFloat)barWidthInBarChartView:(MCBarChartView *)barChartView {

    float W=10*NOW_SIZE;

    return W;
    
}

- (CGFloat)paddingForSectionInBarChartView:(MCBarChartView *)barChartView {
    
    return 12;
    
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
