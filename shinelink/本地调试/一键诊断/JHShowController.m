//
//  JHShowController.m
//  JHChartDemo
//
//  Created by cjatech-简豪 on 16/4/12.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHShowController.h"

#import "YDChart.h"
#import "YDLineChart.h"
#import "YDLineY.h"

#define k_MainBoundsWidth [UIScreen mainScreen].bounds.size.width
#define k_MainBoundsHeight [UIScreen mainScreen].bounds.size.height
@interface JHShowController ()

@property (strong, nonatomic) YDLineChart *lineChartYD ;
@property (strong, nonatomic) YDLineChart *lineChartYDOne ;

@property (strong, nonatomic) YDLineY *YlineChartYD ;
@property (strong, nonatomic) YDLineY *YlineChartYDOne ;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGFloat pointGap;
@property (assign, nonatomic) CGFloat firstPointGap;
@property (assign, nonatomic) CGFloat moveDistance;
@property (assign, nonatomic) int Type;

@end

@implementation JHShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
 
    
}


//第一象限折线图
- (void)showFirstQuardrant{
    
    float Wx=40.0;   float Yy=60.0; float allH=300;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(Wx, Yy, k_MainBoundsWidth-Wx, allH)];
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
    _lineChartYDOne.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
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
      _lineChartYDOne.yDescTextFontSize = _lineChartYD.xDescTextFontSize = 9.0;
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
     _lineChartYDOne.animationDuration=0.01;
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
    _YlineChartYDOne.contentInsets = UIEdgeInsetsMake(0, 40, 0, 10);
       _YlineChartYDOne.showXDescVertical = NO;
    /* X和Y轴的颜色 默认暗黑色 */
    _YlineChartYDOne.xAndYLineColor = [UIColor darkGrayColor];
    _YlineChartYDOne.backgroundColor = [UIColor whiteColor];
    /* XY轴的刻度颜色 m */
    _YlineChartYDOne.xAndYNumberColor = [UIColor darkGrayColor];
    _YlineChartYDOne.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrantYD;
    _YlineChartYDOne.valueArr = YLineDataArr;
    _YlineChartYDOne.yDescTextFontSize = _lineChartYD.xDescTextFontSize = 8.0;
    [self.view addSubview:_YlineChartYDOne];
    [_YlineChartYDOne showAnimation];
    
    
    // 2. 捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [_lineChartYDOne addGestureRecognizer:pinch];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressAction:)];
    [_lineChartYDOne addGestureRecognizer:longPress];
    
    
    
}


//第一四象限
- (void)showFirstAndFouthQuardrant{
        float Wx=40.0;   float Yy=60.0; float allH=300;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(Wx, Yy, k_MainBoundsWidth-Wx-10, allH)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    NSArray *XLineDataArr=@[@"",@"二月份",@"三月份",@"四月份",@"五月份",@"六月份",@"七月份",@"八月份"];
     NSArray *YLineDataArr=@[@[@"5",@"-220",@"170",@"(-4)",@25,@5,@6,@9],@[@"1",@"-121",@"1",@6,@4,@(-8),@6,@7],@[@"5",@"-14",@"63",@6,@4,@(-8),@12,@17],@[@"13",@"-17",@"8",@63,@4,@(-183),@18,@8]];
    

    _lineChartYD = [[YDLineChart alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) andLineChartType:JHChartLineValueNotForEveryXYD];
    _lineChartYD.xLineDataArr = XLineDataArr;
    _lineChartYD.lineChartQuadrantType = JHLineChartQuadrantTypeFirstAndFouthQuardrantYD;
    _lineChartYD.valueArr = YLineDataArr;
    _lineChartYD.yDescTextFontSize = _lineChartYD.xDescTextFontSize = 9.0;
    _lineChartYD.valueFontSize = 9.0;
    /* 值折线的折线颜色 默认暗黑色*/
    _lineChartYD.valueLineColorArr =@[ [UIColor redColor], [UIColor greenColor], [UIColor greenColor], [UIColor greenColor]];
    _lineChartYD.showPointDescription = NO;
    /* 值点的颜色 默认橘黄色*/
    _lineChartYD.pointColorArr = @[[UIColor orangeColor],[UIColor yellowColor],[UIColor yellowColor],[UIColor yellowColor]];
    _lineChartYD.showXDescVertical = YES;
    _lineChartYD.xDescMaxWidth = 15.0;
    /*        是否展示Y轴分层线条 默认否        */
    _lineChartYD.showYLevelLine = NO;
    _lineChartYD.showValueLeadingLine = NO;
    _lineChartYD.showYLevelLine = YES;
    _lineChartYD.showYLine = NO;
    //从下标为1的点开始绘制 默认从下标为0的点开始绘制
    _lineChartYD.drawPathFromXIndex = 0;
    _lineChartYD.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    /* X和Y轴的颜色 默认暗黑色 */
    _lineChartYD.xAndYLineColor = [UIColor darkGrayColor];
    _lineChartYD.backgroundColor = [UIColor whiteColor];
    /* XY轴的刻度颜色 m */
    _lineChartYD.xAndYNumberColor = [UIColor darkGrayColor];
    _lineChartYD.animationDuration=0.01;
    _lineChartYD.contentFill = NO;
    
    _lineChartYD.pathCurve = YES;
  
    
//    lineChart.contentFillColorArr = @[[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.386],[UIColor colorWithRed:0.000 green:1 blue:0 alpha:0.472]];
    
    [self.view addSubview:_lineChartYD];
    [_lineChartYD showAnimation];
    
    self.pointGap= (_lineChartYD.frame.size.width)/(_lineChartYD.xLineDataArr.count-1);
    _lineChartYD.pointGap= (_lineChartYD.frame.size.width)/(_lineChartYD.xLineDataArr.count-1);
    _firstPointGap=(_lineChartYD.frame.size.width)/(_lineChartYD.xLineDataArr.count-1);

    [_scrollView addSubview:_lineChartYD];
    
    _scrollView.contentSize = _lineChartYD.frame.size;
    
    
    _YlineChartYD = [[YDLineY alloc] initWithFrame:CGRectMake(0, Yy, Wx, allH) andLineChartType:JHChartLineValueNotForEveryXYDY];
    _YlineChartYD.xLineDataArr = XLineDataArr;
    _YlineChartYD.contentInsets = UIEdgeInsetsMake(0, 35, 0, 10);
    /* X和Y轴的颜色 默认暗黑色 */
    _YlineChartYD.xAndYLineColor = [UIColor darkGrayColor];
    _YlineChartYD.backgroundColor = [UIColor whiteColor];
    /* XY轴的刻度颜色 m */
    _YlineChartYD.xAndYNumberColor = [UIColor darkGrayColor];
    _YlineChartYD.lineChartQuadrantType = JHLineChartQuadrantTypeFirstAndFouthQuardrantYD;
    _YlineChartYD.valueArr = YLineDataArr;
    _YlineChartYD.yDescTextFontSize = _lineChartYD.xDescTextFontSize = 9.0;
    [self.view addSubview:_YlineChartYD];
    [_YlineChartYD showAnimation];
    
    
    // 2. 捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [_lineChartYD addGestureRecognizer:pinch];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressAction:)];
    [_lineChartYD addGestureRecognizer:longPress];
    
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
































@end
