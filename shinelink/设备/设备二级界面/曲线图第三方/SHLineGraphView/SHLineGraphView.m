// SHLineGraphView.m
//
// Copyright (c) 2014 Shan Ul Haq (http://grevolution.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "SHLineGraphView.h"
#import "PopoverView.h"
#import "SHPlot.h"
#import <math.h>
#import "PNColor.h"
#import <objc/runtime.h>

#define LableW  (30.0*NOW_SIZE)

#define BOTTOM_MARGIN_TO_LEAVE (22.0*HEIGHT_SIZE)
#define TOP_MARGIN_TO_LEAVE (30.0*HEIGHT_SIZE)
#define INTERVAL_COUNT 6
#define PLOT_WIDTH (self.bounds.size.width - _leftMarginToLeave-5*HEIGHT_SIZE)

#define kXLabelHeight -10

#define kAssociatedPlotObject @"kAssociatedPlotObject"

@interface SHLineGraphView ()<UIScrollViewDelegate>

@property (nonatomic) CGFloat chartMargin;
@property (nonatomic) CAShapeLayer * chartBottomLine;
@property (nonatomic) CAShapeLayer * chartLeftLine;
@property (nonatomic) BOOL islongTap;
@property (nonatomic) BOOL isTwoTap;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *firstLable;

@property (assign, nonatomic) CGFloat spaceValue;//间距

@property (assign, nonatomic) CGFloat maxScrollW;//最大距离
@property (assign, nonatomic) CGFloat offX;//scrollView偏移
@property (assign, nonatomic) CGFloat lastLableX;

@end


@implementation SHLineGraphView
{
    float _leftMarginToLeave;
    SHPlot *SHPlotValue;
    
    UIView * xDirectrix;
    UIView * yDirectriy;
    UILabel* xyLableValue;
    float DirectriLableH;
}



- (instancetype)init {
    if((self = [super init])) {
        [self loadDefaultTheme];
    }
    return self;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadDefaultTheme];
    }
    return self;
}

- (void)loadDefaultTheme {
    _themeAttributes = @{
                         kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                         kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                         kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                         kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                         kYAxisLabelSideMarginsKey : @10,
                         kPlotBackgroundLineColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                         kDotSizeKey : @10.0
                         };
 
}

- (void)drawBorder {
    self.backgroundColor = [UIColor clearColor];
    _chartMargin = BOTTOM_MARGIN_TO_LEAVE;
      float minY=TOP_MARGIN_TO_LEAVE-1.0*HEIGHT_SIZE;
    
    UIColor *lineColor=COLOR(153, 153, 153, 1);
    float lineWidthW=0.8*HEIGHT_SIZE;
    
    
    _chartBottomLine = [CAShapeLayer layer];
    _chartBottomLine.lineCap      = kCALineCapButt;
    _chartBottomLine.fillColor    = lineColor.CGColor;
    _chartBottomLine.lineWidth    = lineWidthW;
    _chartBottomLine.strokeEnd    = 0.0;
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    [progressline moveToPoint:CGPointMake(_chartMargin, self.frame.size.height -minY)];
    [progressline addLineToPoint:CGPointMake(_chartMargin+PLOT_WIDTH,  self.frame.size.height -minY)];
    
    [progressline setLineWidth:lineWidthW];
    [progressline setLineCapStyle:kCGLineCapSquare];
    _chartBottomLine.path = progressline.CGPath;
    
    _chartBottomLine.strokeColor =lineColor.CGColor;
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue = @1.0f;
    [_chartBottomLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    _chartBottomLine.strokeEnd = 1.0;
    
    [self.layer addSublayer:_chartBottomLine];
    
    //Add left Chart Line
    
    
    _chartLeftLine = [CAShapeLayer layer];
    _chartLeftLine.lineCap      = kCALineCapButt;
    _chartLeftLine.fillColor    = lineColor.CGColor;
    _chartLeftLine.lineWidth    = lineWidthW;
    _chartLeftLine.strokeEnd    = 0.0;
    
    UIBezierPath *progressLeftline = [UIBezierPath bezierPath];
    

    [progressLeftline moveToPoint:CGPointMake(_chartMargin, self.frame.size.height -minY)];
    [progressLeftline addLineToPoint:CGPointMake(_chartMargin,  15*HEIGHT_SIZE)];
    
    [progressLeftline setLineWidth:1.0];
    [progressLeftline setLineCapStyle:kCGLineCapSquare];
    _chartLeftLine.path = progressLeftline.CGPath;
    
    
   _chartLeftLine.strokeColor =lineColor.CGColor;
    
    
    CABasicAnimation *pathLeftAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathLeftAnimation.duration = 0.5;
    pathLeftAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathLeftAnimation.fromValue = @0.0f;
    pathLeftAnimation.toValue = @1.0f;
    [_chartLeftLine addAnimation:pathLeftAnimation forKey:@"strokeEndAnimation"];
    
    _chartLeftLine.strokeEnd = 1.0;
    
    [self.layer addSublayer:_chartLeftLine];
}

- (void)addPlot:(SHPlot *)newPlot;
{
    if(nil == newPlot) {
        return;
    }
    
    if(_plots == nil){
        _plots = [NSMutableArray array];
    }
    [_plots addObject:newPlot];
}

- (void)setupTheView
{
  
   // int minSpaceNum=ceil(PLOT_WIDTH/intSpace);
  
        _spaceValue=PLOT_WIDTH/_dirLableValuesY.count;
   
  //  _lableLookNum=6;
    _leftMarginToLeave=BOTTOM_MARGIN_TO_LEAVE;
    
    [self firstToChar];
    
    [self getSpaceValue];
    
    
       [self drawBorder];
    
     [self getDirct];
    
    [self getPlotDraw];
}

-(void)getPlotDraw{
    for(SHPlot *plot in _plots) {

        [self drawYLabels:plot];
        
        [self drawPlotWithPlot:plot];
    }
}

-(void)firstToChar{

    if (_scrollView) {
        [_scrollView removeFromSuperview];
        _scrollView=nil;
    }
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(_leftMarginToLeave, 0, PLOT_WIDTH,  self.bounds.size.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.userInteractionEnabled=YES;
    _scrollView.bounces = NO;
    _scrollView.delegate=self;
    [self addSubview:_scrollView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressAction:)];
    [_scrollView addGestureRecognizer:longPress];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [_scrollView addGestureRecognizer:pinch];
    
    UITapGestureRecognizer *tapPress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPressAction:)];
    [_scrollView addGestureRecognizer:tapPress];

}

#pragma mark - Actual Plot Drawing Methods

- (void)drawPlotWithPlot:(SHPlot *)plot {
   

    
    //draw x-labels
    [self drawXLabels:plot];
    
    //draw the grey lines
    [self drawLines:plot];
    
    /*
     actual plot drawing
     */
[self drawPlot:plot];
    
}

-(void)getDirct{
    xDirectrix = [[UIView alloc] initWithFrame:CGRectZero];
    xDirectrix.hidden = YES;
    xDirectrix.backgroundColor = COLOR(232, 114, 86, 1);
    xDirectrix.alpha = .5f;
    [_scrollView addSubview:xDirectrix];
    
    yDirectriy = [[UIView alloc] initWithFrame:CGRectZero];
    yDirectriy.hidden = YES;
    yDirectriy.backgroundColor = COLOR(232, 114, 86, 1);
    yDirectriy.alpha = .5f;
    [_scrollView addSubview: yDirectriy];
    
    DirectriLableH=20*HEIGHT_SIZE;
    
    xyLableValue=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE, 0*HEIGHT_SIZE, 160*NOW_SIZE, DirectriLableH)];
    xyLableValue.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    xyLableValue.textColor = COLOR(86, 103, 232, 1);
    xyLableValue.adjustsFontSizeToFitWidth=YES;
    [xyLableValue setTextAlignment:NSTextAlignmentCenter];
    [_scrollView addSubview:xyLableValue];
    


}


- (int)getIndexForValue:(NSNumber *)value forPlot:(SHPlot *)plot {
    for(int i=0; i< _xAxisValues.count; i++) {
        NSDictionary *d = [_xAxisValues objectAtIndex:i];
        __block BOOL foundValue = NO;
        [d enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSNumber *k = (NSNumber *)key;
            if([k doubleValue] == [value doubleValue]) {
                foundValue = YES;
                *stop = foundValue;
            }
        }];
        if(foundValue){
            return i;
        }
    }
    return -1;
}

- (void)drawPlot:(SHPlot *)plot {
    
    SHPlotValue=plot;
    
    NSDictionary *theme = plot.plotThemeAttributes;
    
    //
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.frame = self.bounds;
    backgroundLayer.fillColor = ((UIColor *)theme[kPlotFillColorKey]).CGColor;
    backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
    [backgroundLayer setStrokeColor:[UIColor clearColor].CGColor];
    [backgroundLayer setLineWidth:((NSNumber *)theme[kPlotStrokeWidthKey]).intValue];
    
   
    
    //
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = self.bounds;
    circleLayer.fillColor = ((UIColor *)theme[kPlotPointFillColorKey]).CGColor;
    circleLayer.backgroundColor = [UIColor clearColor].CGColor;
    [circleLayer setStrokeColor:((UIColor *)theme[kPlotPointFillColorKey]).CGColor];
    [circleLayer setLineWidth:((NSNumber *)theme[kPlotStrokeWidthKey]).intValue];
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    
    //
    CAShapeLayer *graphLayer = [CAShapeLayer layer];
    graphLayer.frame = self.bounds;
    graphLayer.fillColor = [UIColor clearColor].CGColor;
    graphLayer.backgroundColor = [UIColor clearColor].CGColor;
    [graphLayer setStrokeColor:((UIColor *)theme[kPlotStrokeColorKey]).CGColor];
    [graphLayer setLineWidth:((NSNumber *)theme[kPlotStrokeWidthKey]).intValue];
    
 
    
    double yRange = [_yAxisRange doubleValue]; // this value will be in dollars
    double yIntervalValue = yRange / INTERVAL_COUNT;
    
    //logic to fill the graph path, ciricle path, background path.
    [plot.plottingValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        
        __block NSNumber *_key = nil;
        __block NSNumber *_value = nil;
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            _key = (NSNumber *)key;
            _value = (NSNumber *)obj;
        }];
        
        int xIndex = [self getIndexForValue:_key forPlot:plot];
        
        //x value
        double height = self.bounds.size.height - TOP_MARGIN_TO_LEAVE;
        double y = height - ((height / ([_yAxisRange doubleValue] + yIntervalValue)) * [_value doubleValue]);
        (plot.xPoints[xIndex]).x = ceil((plot.xPoints[xIndex]).x);
        (plot.xPoints[xIndex]).y = ceil(y);
        
    }];
    
    
      //  CGMutablePathRef graphPath = CGPathCreateMutable();
     UIBezierPath *graphPath = [UIBezierPath bezierPath];
     UIBezierPath *backgroundPath =[UIBezierPath bezierPath];
    
    //move to initial point for path and background.
    
     [graphPath moveToPoint:CGPointMake(0,  plot.xPoints[0].y)];
     [backgroundPath moveToPoint:CGPointMake(0,  plot.xPoints[0].y)];
  //  CGPathMoveToPoint(graphPath, NULL, _leftMarginToLeave, plot.xPoints[0].y);
 //   CGPathMoveToPoint(backgroundPath, NULL, 0, plot.xPoints[0].y);
    
    int count = (int)_xAxisValues.count;
    for(int i=0; i< count; i++){
         CGPoint point = plot.xPoints[i];
        CGPoint prePoint ;
        if (i>0) {
        prePoint = plot.xPoints[(i-1)];
        }else{
         prePoint = plot.xPoints[i];
        }
       
           [graphPath addCurveToPoint:point controlPoint1:CGPointMake((point.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((point.x+prePoint.x)/2, point.y)];
             [backgroundPath addCurveToPoint:point controlPoint1:CGPointMake((point.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((point.x+prePoint.x)/2, point.y)];
       
      //  CGPathAddLineToPoint(graphPath, NULL, point.x, point.y);
      //  CGPathAddLineToPoint(backgroundPath, NULL, point.x, point.y);
        CGFloat dotsSize = [_themeAttributes[kDotSizeKey] floatValue];
        CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - dotsSize/2.0f, point.y - dotsSize/2.0f, dotsSize, dotsSize));
    }
    
    float LastW=_maxScrollW;
    //move to initial point for path and background.
   // CGPathAddLineToPoint(graphPath, NULL, _leftMarginToLeave + PLOT_WIDTH, plot.xPoints[count -1].y);
         [graphPath addLineToPoint:CGPointMake(LastW, plot.xPoints[count -1].y)];
    [backgroundPath addLineToPoint:CGPointMake(LastW, plot.xPoints[count -1].y)];
    
   // CGPathAddLineToPoint(backgroundPath, NULL, LastW, plot.xPoints[count - 1].y);
    
    //additional points for background.
    
      [backgroundPath addLineToPoint:CGPointMake(LastW, self.bounds.size.height - TOP_MARGIN_TO_LEAVE)];
     [backgroundPath addLineToPoint:CGPointMake( 0, self.bounds.size.height - TOP_MARGIN_TO_LEAVE)];
    [backgroundPath closePath];
//    CGPathAddLineToPoint(backgroundPath, NULL, LastW, self.bounds.size.height - TOP_MARGIN_TO_LEAVE);
//    CGPathAddLineToPoint(backgroundPath, NULL, 0, self.bounds.size.height - TOP_MARGIN_TO_LEAVE);
//    CGPathCloseSubpath(backgroundPath);
    
    backgroundLayer.path = backgroundPath.CGPath;
  //  graphLayer.path = graphPath;
     graphLayer.path = graphPath.CGPath;
    circleLayer.path = circlePath;
    
    //animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.5;
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    [graphLayer addAnimation:animation forKey:@"strokeEnd"];
    
    backgroundLayer.zPosition = 0;
    graphLayer.zPosition = 1;
    circleLayer.zPosition = 2;
    
    [_scrollView.layer addSublayer:graphLayer];
    [_scrollView.layer addSublayer:circleLayer];
    [_scrollView.layer addSublayer:backgroundLayer];
    
    _islongTap=NO;
    

    

    
}


-(void)getSpaceValue{

    if (_spaceValue*_dirLableValuesY.count>PLOT_WIDTH) {
         _scrollView.contentSize = CGSizeMake(_spaceValue*_dirLableValuesY.count, 0);
        _maxScrollW=_spaceValue*_dirLableValuesY.count;
    }else{
      _scrollView.contentSize = CGSizeMake(PLOT_WIDTH, 0);
           _maxScrollW=PLOT_WIDTH;
    }
    
    
  
    
}


- (void)drawXLabels:(SHPlot *)plot {
    
    int xIntervalCount =(int) _dirLableValuesX.count;
    
    plot.xPoints = calloc(sizeof(CGPoint), xIntervalCount);
    
    CAShapeLayer *linesLayer = [CAShapeLayer layer];
    linesLayer.frame = self.bounds;
    linesLayer.fillColor = [UIColor blueColor].CGColor;
    linesLayer.backgroundColor = [UIColor clearColor].CGColor;
    linesLayer.strokeColor = ((UIColor *)_themeAttributes[kPlotBackgroundLineColorKey]).CGColor;
    linesLayer.lineWidth = 0.5*HEIGHT_SIZE;
    
    CGMutablePathRef linesPath = CGPathCreateMutable();
    
    
    for(int i=0; i < xIntervalCount; i++){
             float xLabelFrameW=LableW;
        
        CGPoint currentLabelPoint = CGPointMake((_spaceValue * i)-xLabelFrameW/2, _scrollView.bounds.size.height - TOP_MARGIN_TO_LEAVE);
      CGRect xLabelFrame = CGRectMake(currentLabelPoint.x, currentLabelPoint.y, xLabelFrameW, TOP_MARGIN_TO_LEAVE);
        
        plot.xPoints[i] = CGPointMake((int) xLabelFrame.origin.x + (xLabelFrame.size.width /2) , (int) 0);
        
        UILabel *xAxisLabel = [[UILabel alloc] initWithFrame:xLabelFrame];
        xAxisLabel.backgroundColor = [UIColor clearColor];
        xAxisLabel.font = (UIFont *)_themeAttributes[kXAxisLabelFontKey];
        xAxisLabel.textColor = (UIColor *)_themeAttributes[kXAxisLabelColorKey];
        xAxisLabel.textAlignment = NSTextAlignmentCenter;
          xAxisLabel.adjustsFontSizeToFitWidth=YES;
      //  [xAxisLabel sizeToFit];
        NSString *A=[NSString stringWithFormat:@"%@",_dirLableValuesX[i]];
        xAxisLabel.text=A;
      
            if (i!=0) {
                if (currentLabelPoint.x>(_lastLableX+40*NOW_SIZE)) {
                    _lastLableX=currentLabelPoint.x;
                      [_scrollView addSubview:xAxisLabel];
                    
                    CGPoint currentLinePoint = CGPointMake(currentLabelPoint.x+xLabelFrameW/2, currentLabelPoint.y);
                    CGPathMoveToPoint(linesPath, NULL, currentLinePoint.x, currentLinePoint.y);
                    CGPathAddLineToPoint(linesPath, NULL, currentLinePoint.x , 15*HEIGHT_SIZE);
                    
                }
               
            }else{
                _lastLableX=-xLabelFrameW/2;
                xAxisLabel.frame=CGRectMake(currentLabelPoint.x+_leftMarginToLeave, currentLabelPoint.y, xLabelFrameW, TOP_MARGIN_TO_LEAVE);
                if (_firstLable) {
                    [_firstLable removeFromSuperview];
                    _firstLable=nil;
                }
                _firstLable=xAxisLabel;
              [self addSubview:_firstLable];
            }
        
    }
    
    
    linesLayer.path = linesPath;
    [_scrollView.layer addSublayer:linesLayer];
    
}

- (void)drawYLabels:(SHPlot *)plot {
    double yRange = [_yAxisRange doubleValue]; // this value will be in dollars
    
    double yIntervalValue = yRange / _lableLookNum;
    double intervalInPx = (self.bounds.size.height - TOP_MARGIN_TO_LEAVE ) / (_lableLookNum +1);
    
    NSMutableArray *labelArray = [NSMutableArray array];
    float maxWidth = 0;
    
    for(int i= (int)_lableLookNum + 1; i >= 0; i--){
        CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave, i * intervalInPx);
        CGRect lableFrame = CGRectMake(0, currentLinePoint.y - (intervalInPx / 2), _leftMarginToLeave, intervalInPx);
        
        if(i != 0) {
            UILabel *yAxisLabel = [[UILabel alloc] initWithFrame:lableFrame];
            yAxisLabel.backgroundColor = [UIColor clearColor];
            yAxisLabel.font = (UIFont *)_themeAttributes[kYAxisLabelFontKey];
            yAxisLabel.textColor = (UIColor *)_themeAttributes[kYAxisLabelColorKey];
            yAxisLabel.textAlignment = NSTextAlignmentCenter;
            yAxisLabel.adjustsFontSizeToFitWidth=YES;
            float val = (yIntervalValue * ((_lableLookNum +1) - i));
            if(val > 0){
                yAxisLabel.text = [NSString stringWithFormat:@"%.0f%@", val, _yAxisSuffix];
            } else {
                yAxisLabel.text = [NSString stringWithFormat:@"%.0f", val];
            }
            [yAxisLabel sizeToFit];
            CGRect newLabelFrame = CGRectMake(0, currentLinePoint.y - (yAxisLabel.layer.frame.size.height / 2), yAxisLabel.frame.size.width, yAxisLabel.layer.frame.size.height);
            yAxisLabel.frame = newLabelFrame;
            
            if(newLabelFrame.size.width > maxWidth) {
                maxWidth = newLabelFrame.size.width;
            }
            
            [labelArray addObject:yAxisLabel];
            [self addSubview:yAxisLabel];
        }
    }
    
   //_leftMarginToLeave = maxWidth + [_themeAttributes[kYAxisLabelSideMarginsKey] doubleValue];
    
    for( UILabel *l in labelArray) {
        CGSize newSize = CGSizeMake(_leftMarginToLeave, l.frame.size.height);
        CGRect newFrame = l.frame;
        newFrame.size = newSize;
        l.frame = newFrame;
    }
}

- (void)drawLines:(SHPlot *)plot {
    
    CAShapeLayer *linesLayer = [CAShapeLayer layer];
    linesLayer.frame = self.bounds;
    linesLayer.fillColor = [UIColor blueColor].CGColor;
    linesLayer.backgroundColor = [UIColor clearColor].CGColor;
    linesLayer.strokeColor = ((UIColor *)_themeAttributes[kPlotBackgroundLineColorKey]).CGColor;
    linesLayer.lineWidth = 0.5*HEIGHT_SIZE;
    
    CGMutablePathRef linesPath = CGPathCreateMutable();
    
    double intervalInPx = (self.bounds.size.height - TOP_MARGIN_TO_LEAVE) / (_lableLookNum + 1);
    for(int i= ((int)_lableLookNum + 1); i > 0; i--){
        
        CGPoint currentLinePoint = CGPointMake(0, (i * intervalInPx));
        
        CGPathMoveToPoint(linesPath, NULL, currentLinePoint.x, currentLinePoint.y);
        CGPathAddLineToPoint(linesPath, NULL, currentLinePoint.x + _maxScrollW, currentLinePoint.y);
    }
    
    linesLayer.path = linesPath;
    [_scrollView.layer addSublayer:linesLayer];
}


- (void)event_longPressAction:(UILongPressGestureRecognizer *)longPress {
    
           if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state) {
            
                 CGPoint location = [longPress locationInView:_scrollView];
               [self getPointToShow:location];
        }
    

    
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        
       [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0f];
    }
}


-(void)getPointToShow:(CGPoint)touchPoint{
    

    double yRange = [_yAxisRange doubleValue]; // this value will be in dollars
    double yIntervalValue = yRange / INTERVAL_COUNT;
    int ShCount=(int)SHPlotValue.plottingValues.count;
    
    [SHPlotValue.plottingValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        
        __block NSNumber *_key = nil;
        __block NSNumber *_value = nil;
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            _key = (NSNumber *)key;
            _value = (NSNumber *)obj;
        }];
        
        int xIndex = [self getIndexForValue:_key forPlot:SHPlotValue];
        
        //x value
        double height = self.bounds.size.height - TOP_MARGIN_TO_LEAVE;
        double y = height - ((height / ([_yAxisRange doubleValue] + yIntervalValue)) * [_value doubleValue]);
        (SHPlotValue.xPoints[xIndex]).x = ceil((SHPlotValue.xPoints[xIndex]).x);
        (SHPlotValue.xPoints[xIndex]).y = ceil(y);
        
    }];
    
    int dirInt=0;
    
    for (int k=0; k<ShCount; k++) {
        
        float plotX1=(SHPlotValue.xPoints[k]).x;
        float plotX2=(SHPlotValue.xPoints[k+1]).x;
        float plot0=touchPoint.x;
        if( (plotX1<plot0)&&(plotX2>plot0) ){
            
            if ((plot0-plotX1)>(plotX2-plot0)) {
                dirInt=k+1;
            }else{
                dirInt=k;
            }
        }
        
    }
    
    if (dirInt<ShCount) {
        float xDirectrixX=(SHPlotValue.xPoints[dirInt]).x;
        double xDirectrixY = self.bounds.size.height - TOP_MARGIN_TO_LEAVE-DirectriLableH;
        xDirectrix.frame = CGRectMake(xDirectrixX,DirectriLableH,1*NOW_SIZE, xDirectrixY);
        xDirectrix.hidden = NO;
        [_scrollView bringSubviewToFront:xDirectrix];
        
        float yDirectrixY=(SHPlotValue.xPoints[dirInt]).y;
        yDirectriy.frame = CGRectMake(_offX,  yDirectrixY,_scrollView.contentSize.width, 1*NOW_SIZE);
        yDirectriy.hidden = NO;
        [_scrollView bringSubviewToFront: yDirectriy];
        
        NSString *xDirY0=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dirLableValuesY[dirInt]] floatValue]];
        NSString*xLableValue=[NSString stringWithFormat:@"%@",_dirLableValuesX[dirInt]];
        NSString* xyLableText=[NSString stringWithFormat:@"%@:%@  %@:%@",root_shijian,xLableValue,root_shuzhi,xDirY0];
        
        xyLableValue.frame=CGRectMake(140*NOW_SIZE+_offX, 0*HEIGHT_SIZE, 160*NOW_SIZE, DirectriLableH);
        xyLableValue.text=xyLableText;
        
    }
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float x= scrollView.contentOffset.x; //获取横向滑动的距离
      // NSLog(@"x=%.1f",x);
    _offX=x;
    
    if (x==0) {
        _firstLable.hidden=NO;
    }else{
     _firstLable.hidden=YES;
    }
    
}


- (void)tapPressAction:(UITapGestureRecognizer *)recognizer
{
    
        CGPoint location = [recognizer locationInView:_scrollView];
        [self getPointToShow:location];
 
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:3.0f];
   
}



// 捏合手势监听方法
- (void)pinchGesture:(UIPinchGestureRecognizer *)recognizer
{

    if (recognizer.state==UIGestureRecognizerStateBegan || recognizer.state==UIGestureRecognizerStateChanged)
    {
//        UIView *view=[recognizer view];
//    view.transform=CGAffineTransformScale(view.transform, recognizer.scale, 1);
//        float Scale=recognizer.scale;
//        recognizer.scale=1;
        
        CGFloat currentIndex,leftMagin;
        if( recognizer.numberOfTouches == 2 ) {
            
           
            if ((recognizer.scale>1.3)||(recognizer.scale<0.7)) {
                //2.获取捏合中心点 -> 捏合中心点距离scrollviewcontent左侧的距离
                CGPoint p1 = [recognizer locationOfTouch:0 inView:_scrollView];
                CGPoint p2 = [recognizer locationOfTouch:1 inView:_scrollView];
                CGFloat centerX = (p1.x+p2.x)/2;
                leftMagin = centerX - self.scrollView.contentOffset.x;
                
                currentIndex = centerX / _spaceValue;
                //            NSLog(@"currentIndex = %f",currentIndex);
                
               
                float maxSpaceValue=LableW*1.5;
                _spaceValue= recognizer.scale*_spaceValue;
                _spaceValue = _spaceValue > maxSpaceValue ? maxSpaceValue :_spaceValue;
                
                if ((_spaceValue*_dirLableValuesY.count)<PLOT_WIDTH) {
                      _spaceValue=PLOT_WIDTH/_dirLableValuesY.count;
                    leftMagin=0;
                }
                
                float offW=currentIndex*_spaceValue;
                 NSLog(@"offW = %f",offW);
                  NSLog(@"leftMagin = %f",leftMagin);
                 NSLog(@" self.scrollView.contentOffset.x = %f", self.scrollView.contentOffset.x);
                
                    [self refreshUI];
                
                if (recognizer.scale >1) {
                      self.scrollView.contentOffset = CGPointMake(currentIndex*_spaceValue-leftMagin, 0);
                }
                
                recognizer.scale = 1.0;
                
            
                
            
                
            }
  
        }
        
    }
    
}


-(void)refreshUI{
    [self firstToChar];
    
    [self getSpaceValue];
    
    [self getDirct];
    
    for(SHPlot *plot in _plots) {
   [self drawPlotWithPlot:plot];
    }

}



-(void)delayMethod{
   xDirectrix.hidden = YES;
      yDirectriy.hidden = YES;
     xyLableValue.text=nil;
}





#pragma mark - Theme Key Extern Keys

NSString *const kXAxisLabelColorKey         = @"kXAxisLabelColorKey";
NSString *const kXAxisLabelFontKey          = @"kXAxisLabelFontKey";
NSString *const kYAxisLabelColorKey         = @"kYAxisLabelColorKey";
NSString *const kYAxisLabelFontKey          = @"kYAxisLabelFontKey";
NSString *const kYAxisLabelSideMarginsKey   = @"kYAxisLabelSideMarginsKey";
NSString *const kPlotBackgroundLineColorKey = @"kPlotBackgroundLineColorKey";
NSString *const kDotSizeKey                 = @"kDotSizeKey";

@end
