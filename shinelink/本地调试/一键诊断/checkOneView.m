//
//  checkOneView.m
//  ShinePhone
//
//  Created by sky on 2018/1/27.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "checkOneView.h"
#import "YDChart.h"
#import "YDLineChart.h"
#import "YDLineY.h"
#import "CustomProgress.h"
#import "usbToWifiControlTwo.h"



static float keyOneWaitTime=30.0;

#define k_MainBoundsWidth [UIScreen mainScreen].bounds.size.width
#define k_MainBoundsHeight [UIScreen mainScreen].bounds.size.height

@interface checkOneView ()
{
       CustomProgress *custompro;
        int present;
}
@property (strong, nonatomic) YDLineChart *lineChartYD ;
@property (strong, nonatomic) YDLineChart *lineChartYDOne ;

@property (strong, nonatomic) YDLineY *YlineChartYD ;
@property (strong, nonatomic) YDLineY *YlineChartYDOne ;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGFloat pointGap;
@property (assign, nonatomic) CGFloat firstPointGap;
@property (assign, nonatomic) CGFloat moveDistance;
@property (assign, nonatomic) int Type;
@property (strong, nonatomic)UILabel *lable0;
@property (strong, nonatomic)UILabel *lable01;
@property (nonatomic) BOOL isReadNow;
@property (strong, nonatomic)NSArray *vocArray;
@property (strong, nonatomic)NSArray *colorArray;
@property(nonatomic,strong)wifiToPvOne*ControlOne;

@property (strong, nonatomic)NSArray *allSendDataArray;
@property (strong, nonatomic)NSMutableArray *allDataArray;
@property (assign, nonatomic) int sendDataTime;
@property (assign, nonatomic) int progressNum;
@property (strong, nonatomic)NSTimer *timer;
@end





@implementation checkOneView

- (void)viewDidLoad {
    [super viewDidLoad];
 
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
    }
    
    [self showFirstQuardrant];
    [self initUI];
}


#pragma mark - 数据交互
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveData:) name: @"TcpReceiveOneKey" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFailed) name: @"TcpReceiveOneKeyFailed" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_ControlOne) {
        [_ControlOne disConnect];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveWifiConrolTwo" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveWifiConrolTwoFailed" object:nil];
    
}

-(void)receiveData:(NSNotification*) notification{
    
}
-(void)setFailed{
    
}


-(void)goToReadTcpData{
    _sendDataTime=0;
    
     [_ControlOne goToOneTcp:9 cmdNum:1 cmdType:@"20" regAdd:_allSendDataArray[_sendDataTime] Length:@"125"];

}

-(void)goToReadFirstData{
     [_ControlOne goToOneTcp:9 cmdNum:1 cmdType:@"16" regAdd:@"250" Length:@"1_2_1"];
}

#pragma mark - UI界面
-(void)initUI{
    float lableH=30*HEIGHT_SIZE; float lableW1=40*NOW_SIZE;
    UIView* view0=[[UIView alloc]initWithFrame:CGRectMake(0,5*HEIGHT_SIZE, SCREEN_Width, lableH)];
    view0.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view0];
    
      float _lable01H=20*HEIGHT_SIZE;
    _lable0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT_SIZE,lableW1,_lable01H)];
    _lable0.textColor =COLOR(51, 51, 51, 1);
    _lable0.textAlignment=NSTextAlignmentRight;
    _lable0.text=@"(A)";
    _lable0.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.view addSubview:_lable0];
    
    float buttonW=60*NOW_SIZE;   float buttonH=20*HEIGHT_SIZE;
   UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(160*NOW_SIZE, (lableH-buttonH)/2, buttonW, buttonH);
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setTitleColor:COLOR(242, 242, 242, 1) forState:UIControlStateHighlighted];
    button1.layer.borderWidth=0.8*HEIGHT_SIZE;;
    button1.layer.borderColor=MainColor.CGColor;
   button1.tag = 3000;
    button1.layer.cornerRadius=buttonH/2;
    button1.backgroundColor=MainColor;
    button1.selected=YES;
    button1.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [button1 setTitle:@"I-V" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view0 addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(160*NOW_SIZE+buttonW+10*NOW_SIZE, (lableH-buttonH)/2, buttonW, buttonH);
    [button2 setTitleColor:MainColor forState:UIControlStateNormal];
    [button2 setTitleColor:COLOR(242, 242, 242, 1) forState:UIControlStateHighlighted];
    button2.layer.borderWidth=0.8*HEIGHT_SIZE;
       button2.layer.cornerRadius=buttonH/2;
    button2.layer.borderColor=MainColor.CGColor;
    button2.tag = 3001;
    button2.backgroundColor=[UIColor clearColor];
    button2.selected=NO;
    button2.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [button2 setTitle:@"P-V" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view0 addSubview:button2];
    
    float lastH=40*HEIGHT_SIZE;
     _isReadNow=NO;
    custompro = [[CustomProgress alloc] initWithFrame:CGRectMake(0, ScreenHeight-lastH-NavigationbarHeight-StatusHeight, ScreenWidth, lastH)];
    custompro.maxValue = 100;
    //设置背景色
    custompro.bgimg.backgroundColor =COLOR(0, 156, 255, 1);
    custompro.leftimg.backgroundColor =COLOR(53, 177, 255, 1);

    custompro.presentlab.textColor = [UIColor whiteColor];
    custompro.presentlab.text = @"开始";
    [self.view addSubview:custompro];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goStopRead:)];
    [custompro addGestureRecognizer:tapGestureRecognizer];
    
  
    _lable01 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-lableW1-15*NOW_SIZE, 240*HEIGHT_SIZE,lableW1,_lable01H)];
    _lable01.textColor =COLOR(51, 51, 51, 1);
    _lable01.textAlignment=NSTextAlignmentRight;
    _lable01.text=@"(V)";
    _lable01.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.view addSubview:_lable01];
    
    float view2H=SCREEN_Height-265*HEIGHT_SIZE-lastH-NavigationbarHeight-StatusHeight;
    float everyLalbeH=view2H/8;
    UIView* view2=[[UIView alloc]initWithFrame:CGRectMake(0,255*HEIGHT_SIZE, SCREEN_Width, view2H)];
    view2.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view2];
    
    NSArray *lableNameArray=@[@"MPPT(Voc,Isc)",@"(Vpv,Ipv)"];
    
    CGSize lable1Size=[self getStringSize:14*HEIGHT_SIZE Wsize:(ScreenWidth/2) Hsize:everyLalbeH stringName:lableNameArray[0]];
  //      CGSize lable1Size2=[self getStringSize:14*HEIGHT_SIZE Wsize:(ScreenWidth/2) Hsize:everyLalbeH stringName:lableNameArray[1]];
    
    for (int i=0; i<lableNameArray.count; i++) {
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0+(ScreenWidth/2)*i, 0,ScreenWidth/2,everyLalbeH)];
        titleLable.textColor =MainColor;
        titleLable.textAlignment=NSTextAlignmentCenter;
        titleLable.text=lableNameArray[i];
        titleLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [view2 addSubview:titleLable];
    }
    _vocArray=@[@"100",@"100",@"100",@"100",@"100",@"100",@"100"];
    _colorArray=@[COLOR(208, 107, 107, 1),COLOR(217, 189, 60, 1),COLOR(85, 207, 85, 1),COLOR(85, 122, 207, 1),COLOR(79, 208, 206, 1),COLOR(146, 91, 202, 1),COLOR(161, 177, 55, 1)];
    
    float imageViewH=10*HEIGHT_SIZE; float Wk=5*NOW_SIZE;
    float imageViewx=(ScreenWidth/2-lable1Size.width)/2-imageViewH-Wk;
    for (int i=0; i<_vocArray.count; i++) {
        
//        UIView* view21=[[UIView alloc]initWithFrame:CGRectMake(0,everyLalbeH*(i+1), SCREEN_Width/2, everyLalbeH)];
//        view21.backgroundColor=[UIColor whiteColor];
//        [view2 addSubview:view21];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(0,everyLalbeH*(i+1), SCREEN_Width/2, everyLalbeH);
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setTitleColor:COLOR(242, 242, 242, 1) forState:UIControlStateHighlighted];
        button1.tag = 4000+i;
        button1.backgroundColor=[UIColor whiteColor];
        button1.selected=YES;
        button1.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
        [button1 setTitle:@"" forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(buttonForNum:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:button1];
        
        UIView* imageView=[[UIView alloc]initWithFrame:CGRectMake(imageViewx,(everyLalbeH-imageViewH)/2, imageViewH, imageViewH)];
        imageView.backgroundColor=_colorArray[i];
        imageView.tag=5000+i;
        [button1 addSubview:imageView];
        
        float Lable11x=imageViewx+imageViewH+Wk*2;
        UILabel *Lable11 = [[UILabel alloc]initWithFrame:CGRectMake(Lable11x, 0,ScreenWidth/2-Lable11x,everyLalbeH)];
        Lable11.textColor =COLOR(102, 102, 102, 1);
        Lable11.textAlignment=NSTextAlignmentLeft;
        Lable11.adjustsFontSizeToFitWidth=YES;
        Lable11.text=@"(1000,1000)";
        Lable11.tag=6000+i;
        Lable11.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [button1 addSubview:Lable11];
        
        UIView* view22=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width/2,everyLalbeH*(i+1), SCREEN_Width/2, everyLalbeH)];
        view22.backgroundColor=[UIColor whiteColor];
         [view2 addSubview:view22];
        
      //  UILabel *Lable22 = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/2-lable1Size2.width)/2-Wk, 0,ScreenWidth/2-Lable11x,everyLalbeH)];
          UILabel *Lable22 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth/2,everyLalbeH)];
        Lable22.textColor =COLOR(102, 102, 102, 1);
        Lable22.textAlignment=NSTextAlignmentCenter;
                Lable22.adjustsFontSizeToFitWidth=YES;
        Lable22.text=@"(--,--)";
            Lable22.tag=7000+i;
        Lable22.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [view22 addSubview:Lable22];
        

        
        
    }
    
}

-(void)buttonForNum:(UIButton*)button{
    button.selected = !button.selected;
    NSInteger tagNum=button.tag-4000;
    
        UIView* view =[self.view viewWithTag:5000+tagNum];
         UILabel* lable =[self.view viewWithTag:6000+tagNum];
    if ( button.selected) {
        view.backgroundColor=_colorArray[tagNum];
        lable.text=@"(1000,1000)";
        
    }else{
        view.backgroundColor=COLOR(151, 151, 151, 1);
        lable.text=@"(--,--)";
    }

}

-(void)goToReadCharData{
    _progressNum=0;
    if (!_allSendDataArray) {
        _allSendDataArray=@[@"0",@"125",@"250",@"375",@"500",@"625",@"750"];
    }
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    }else{
        _timer.fireDate=[NSDate distantPast];
    }
    
}

-(void)goStopRead:( UITapGestureRecognizer *)tap{
    _isReadNow = !_isReadNow;
    [self goToReadFirstData];
    
        if (_isReadNow) {
            custompro.presentlab.text = @"";
       
        }else{
            if (present!=0 || present!=100) {
                         custompro.presentlab.text = @"暂停";
            }
   
        }

}

-(void)updateProgress{
    _progressNum++;
    if (_progressNum>=keyOneWaitTime) {
          _timer.fireDate=[NSDate distantFuture];
        _progressNum=0;
        [self goToReadTcpData];
    }
    
}



-(void)goToGetPercent{
       [custompro setPresent:present];
    
    if (present>=100) {
        present=0;
             custompro.presentlab.text = @"开始";
    }
}

-(void)buttonDidClicked:(UIButton*)button{
    NSInteger tagNum=button.tag;

    present=present+10;
    [self goToGetPercent];
    
        button.selected=YES;
    button.backgroundColor=MainColor;
    [button setTitleColor:COLOR(242, 242, 242, 1) forState:UIControlStateNormal];
    
        for (int i=3000; i<3002; i++) {
            if (i!=tagNum) {
                UIButton *buttonOther=[self.view viewWithTag:i];
                buttonOther.selected=NO;
                    buttonOther.backgroundColor=[UIColor clearColor];
                    [buttonOther setTitleColor:MainColor forState:UIControlStateNormal];
            }
        }
  
    
}

#pragma mark - 曲线图
- (void)showFirstQuardrant{
    
    float Wx=30*NOW_SIZE;   float Yy=40*HEIGHT_SIZE; float allH=200*HEIGHT_SIZE;
    float Wx2=5*NOW_SIZE;
    float sizeFont=8*HEIGHT_SIZE;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(Wx, Yy, k_MainBoundsWidth-Wx-Wx2, allH)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    NSDictionary *dic1=@{@"10":@"23",@"14":@"23",@"16":@"18",@"18":@"56",@"19":@"40",@"21":@"52",@"24":@"33",@"26":@"16",@"30":@"24",@"32":@"35",@"35":@"23",@"37":@"12"};
    
    NSDictionary *dic2=@{@"9":@"23",@"11":@"23",@"15":@"18",@"18":@"56",@"19":@"40",@"23":@"15",@"24":@"33",@"26":@"16",@"30":@"24",@"32":@"35",@"37":@"21",@"45":@"14"};
    
    
    NSArray *allDicArray=@[dic1,dic2];
    
    NSMutableArray *XLineDataArr0=[NSMutableArray array];
    for (int i=0; i<allDicArray.count; i++) {
        NSDictionary *dic=[NSDictionary dictionaryWithDictionary:allDicArray[i]];
        for (int i=0; i<dic.allKeys.count; i++) {
            if (![XLineDataArr0 containsObject:dic.allKeys[i]]) {
                [XLineDataArr0 addObject:dic.allKeys[i]];
            }
        }
    }
    
    
    NSSortDescriptor *sortDescripttor1 = [NSSortDescriptor sortDescriptorWithKey:@"intValue" ascending:YES];
    NSArray *XLineDataArr = [XLineDataArr0 sortedArrayUsingDescriptors:@[sortDescripttor1]];
    
    
    
    // NSArray *XLineDataArr=@[@"一月份",@"二月份",@"三月份",@"四月份",@"五月份",@"六月份",@"七月份",@"八月份"];
    NSArray *YLineDataArr=@[dic1.allValues,dic2.allValues];
    
    /*     Create object        */
    _lineChartYDOne = [[YDLineChart alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) andLineChartType:JHChartLineValueNotForEveryXYD];
    
    _Type=1;
    _lineChartYDOne.MaxX=[[XLineDataArr valueForKeyPath:@"@max.floatValue"] integerValue];
    _lineChartYDOne.xLineDataArr = XLineDataArr;
    _lineChartYDOne.contentInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    /* The different types of the broken line chart, according to the quadrant division, different quadrant correspond to different X axis scale data source and different value data source. */
    
    _lineChartYDOne.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrantYD;
    _lineChartYDOne.allDicArray=[NSArray arrayWithArray:allDicArray];
    _lineChartYDOne.valueArr = YLineDataArr;
    _lineChartYDOne.valueBaseRightYLineArray = @[@[@"3",@"1",@"2",@1,@2,@3,@2,@5]];
    _lineChartYDOne.showYLevelLine = YES;
    _lineChartYDOne.showYLine = YES;
    // _lineChartYDOne.yLineDataArr = @[@[@5,@10,@15,@20,@25,@30],@[@1,@2,@3,@4,@5,@6]];
    //    lineChart.yLineDataArr = @[@5,@10,@15,@20,@25,@30];
    //    lineChart.drawPathFromXIndex = 1;
    _lineChartYDOne.animationDuration = 2.0;
    _lineChartYDOne.showDoubleYLevelLine = NO;
    _lineChartYDOne.showValueLeadingLine = NO;
    _lineChartYDOne.yDescTextFontSize = _lineChartYD.xDescTextFontSize = sizeFont;
    _lineChartYDOne.valueFontSize = 9.0;
    _lineChartYDOne.backgroundColor = [UIColor whiteColor];
    _lineChartYDOne.showPointDescription = NO;
    _lineChartYDOne.showXDescVertical = YES;
    _lineChartYDOne.xDescMaxWidth = 40;
    /* Line Chart colors */
    _lineChartYDOne.valueLineColorArr =@[ [UIColor greenColor], [UIColor orangeColor]];
    /* Colors for every line chart*/
    _lineChartYDOne.pointColorArr = @[[UIColor orangeColor],[UIColor yellowColor]];
    /* color for XY axis */
    _lineChartYDOne.xAndYLineColor = [UIColor blackColor];
    /* XY axis scale color */
    _lineChartYDOne.xAndYNumberColor = [UIColor darkGrayColor];
    /* Dotted line color of the coordinate point */
    _lineChartYDOne.positionLineColorArr = @[[UIColor blueColor],[UIColor greenColor]];
    /*        Set whether to fill the content, the default is False         */
    _lineChartYDOne.contentFill = NO;
    /*        Set whether the curve path         */
    _lineChartYDOne.pathCurve = YES;
    /*        Set fill color array         */
    _lineChartYDOne.animationDuration=0.001;
    _lineChartYD.xDescMaxWidth = 15.0;
    
    _lineChartYDOne.contentFillColorArr = @[[UIColor colorWithRed:0 green:1 blue:0 alpha:0.468],[UIColor colorWithRed:1 green:0 blue:0 alpha:0.468]];
    [_scrollView addSubview:_lineChartYDOne];
    /*       Start animation        */
    [_lineChartYDOne showAnimation];
    
    
    self.pointGap= (_lineChartYDOne.frame.size.width)/(_lineChartYDOne.MaxX-1);
    _lineChartYDOne.pointGap= (_lineChartYDOne.frame.size.width)/(_lineChartYDOne.MaxX-1);
    _firstPointGap=(_lineChartYDOne.frame.size.width)/(_lineChartYDOne.MaxX-1);
    
    [_scrollView addSubview:_lineChartYDOne];
    
    _scrollView.contentSize =CGSizeMake(_lineChartYDOne.frame.size.width+10, 0);
    
    
    _YlineChartYDOne = [[YDLineY alloc] initWithFrame:CGRectMake(0, Yy, Wx, allH) andLineChartType:JHChartLineValueNotForEveryXYDY];
    _YlineChartYDOne.xLineDataArr = XLineDataArr;
    _YlineChartYDOne.contentInsets = UIEdgeInsetsMake(10, Wx, 0, 10);
    _YlineChartYDOne.showXDescVertical = NO;
    /* X和Y轴的颜色 默认暗黑色 */
    _YlineChartYDOne.xAndYLineColor = [UIColor darkGrayColor];
    _YlineChartYDOne.backgroundColor = [UIColor whiteColor];
    /* XY轴的刻度颜色 m */
    _YlineChartYDOne.xAndYNumberColor = [UIColor darkGrayColor];
    _YlineChartYDOne.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrantYD;
    _YlineChartYDOne.valueArr = YLineDataArr;
    _YlineChartYDOne.yDescTextFontSize = _lineChartYD.xDescTextFontSize = sizeFont;
    [self.view addSubview:_YlineChartYDOne];
    [_YlineChartYDOne showAnimation];
    
    
    // 2. 捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [_lineChartYDOne addGestureRecognizer:pinch];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressAction:)];
    [_lineChartYDOne addGestureRecognizer:longPress];
    
    
    
}




// 捏合手势监听方法
- (void)pinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    UIView *recognizerView = recognizer.view;
    if (recognizer.state == 3) {
        
        if (recognizerView.frame.size.width <= self.scrollView.frame.size.width) { //当缩小到小于屏幕宽时，松开回复屏幕宽度
            
            CGFloat scale = self.scrollView.frame.size.width / (recognizerView.frame.size.width);
            
            self.pointGap *= scale;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                CGRect frame = recognizerView.frame;
                frame.size.width = self.scrollView.frame.size.width;
                recognizerView.frame = frame;
            }];
            
            ((YDLineChart*)recognizerView).perXLen=_firstPointGap;
        }
        
        ((YDLineChart*)recognizerView).pointGap = self.pointGap;
        
    }else{
        
        CGFloat currentIndex,leftMagin;
        if( recognizer.numberOfTouches == 2 ) {
            //2.获取捏合中心点 -> 捏合中心点距离scrollviewcontent左侧的距离
            CGPoint p1 = [recognizer locationOfTouch:0 inView:recognizerView];
            CGPoint p2 = [recognizer locationOfTouch:1 inView:recognizerView];
            CGFloat centerX = (p1.x+p2.x)/2;
            leftMagin = centerX - self.scrollView.contentOffset.x;
            //            NSLog(@"centerX = %f",centerX);
            //            NSLog(@"self.scrollView.contentOffset.x = %f",self.scrollView.contentOffset.x);
            //            NSLog(@"leftMagin = %f",leftMagin);
            
            
            currentIndex = centerX / self.pointGap;
            //            NSLog(@"currentIndex = %f",currentIndex);
            
            
            
            self.pointGap *= recognizer.scale;
            //            self.pointGap = self.pointGap > _defaultSpace ? _defaultSpace : self.pointGap;
            //            if (self.pointGap == _defaultSpace) {
            //
            //                [SVProgressHUD showErrorWithStatus:@"已经放至最大"];
            //            }
            
            ((YDLineChart*)recognizerView).pointGap = self.pointGap;
            
            
            ((YDLineChart*)recognizerView).perXLen=((YDLineChart*)recognizerView).perXLen* recognizer.scale;
            
            if (_Type==1) {
                recognizerView.frame = CGRectMake(((YDLineChart*)recognizerView).frame.origin.x, ((YDLineChart*)recognizerView).frame.origin.y, (((YDLineChart*)recognizerView).MaxX-1)* ((YDLineChart*)recognizerView).perXLen, ((YDLineChart*)recognizerView).frame.size.height);
            }else{
                recognizerView.frame = CGRectMake(((YDLineChart*)recognizerView).frame.origin.x, ((YDLineChart*)recognizerView).frame.origin.y, (((YDLineChart*)recognizerView).xLineDataArr.count-1)* ((YDLineChart*)recognizerView).perXLen, ((YDLineChart*)recognizerView).frame.size.height);
            }
            
            
            self.scrollView.contentOffset = CGPointMake(currentIndex*self.pointGap-leftMagin, 0);
            //            NSLog(@"contentOffset = %f",self.scrollView.contentOffset.x);
            
            recognizer.scale = 1.0;
        }
        
        
        
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake(((YDLineChart*)recognizerView).frame.size.width, 0);
    
    
}



- (void)event_longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    UIView *recognizerView = longPress.view;
    
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state) {
        
        CGPoint location = [longPress locationInView:recognizerView];
        
        //相对于屏幕的位置
        CGPoint screenLoc = CGPointMake(location.x - self.scrollView.contentOffset.x, location.y);
        [((YDLineChart*)recognizerView) setScreenLoc:screenLoc];
        
        //ABS  绝对值
        if (ABS(location.x - _moveDistance) > self.pointGap) {
            
        }//不能长按移动一点点就重新绘图  要让定位的点改变了再重新绘图
        
        
        [((YDLineChart*)recognizerView) setIsLongPress:YES];
        ((YDLineChart*)recognizerView).currentLoc = location;
        _moveDistance = location.x;
        
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        _moveDistance = 0;
        //恢复scrollView的滑动
        [((YDLineChart*)recognizerView) setIsLongPress:NO];
        
        
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
