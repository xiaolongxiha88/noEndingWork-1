//
//  YDLineY.m
//  JHChartDemo
//
//  Created by sky on 2018/1/24.
//  Copyright © 2018年 JH. All rights reserved.
//

#import "YDLineY.h"
#define kXandYSpaceForSuperView 20.0
#define P_M(x,y) CGPointMake(x, y)

@interface YDLineY ()<CAAnimationDelegate>

@property (assign, nonatomic)   CGFloat  xLength;
@property (assign , nonatomic)  CGFloat  yLength;
@property (assign , nonatomic)  CGFloat  perXLen ;
@property (assign , nonatomic)  CGFloat  perYlen ;
@property (assign , nonatomic)  CGFloat  perValue ;
@property (nonatomic,strong)    NSMutableArray * drawDataArr;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (assign , nonatomic) BOOL  isEndAnimation ;
@property (nonatomic,strong) NSMutableArray * layerArr;





@end

@implementation YDLineY

-(instancetype)initWithFrame:(CGRect)frame andLineChartType:(JHLineChartTypeYDY)lineChartType{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _lineType = lineChartType;
        _lineWidth = 0.5;
        
        _yLineDataArr  = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
        _xLineDataArr  = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
        _showXDescVertical = NO;
        _xDescriptionAngle = M_PI_2/15;
        _xDescMaxWidth = 20.0;
        _pointNumberColorArr = @[[UIColor redColor]];
        _positionLineColorArr = @[[UIColor darkGrayColor]];
        _pointColorArr = @[[UIColor orangeColor]];
        _xAndYNumberColor = [UIColor darkGrayColor];
        _valueLineColorArr = @[[UIColor redColor]];
        _layerArr = [NSMutableArray array];
        _showYLine = YES;
        _showYLevelLine = NO;
        _showValueLeadingLine = YES;
        _valueFontSize = 8.0;
        _showPointDescription = YES;
        _drawPathFromXIndex = 0;
        _showDoubleYLevelLine = NO;
        self.animationDuration = 2.0;
        //        _contentFillColorArr = @[[UIColor lightGrayColor]];
        [self configChartXAndYLength];
         [self configChartOrigin];
        [self configPerXAndPerY];
    }
    return self;
    
}


/**
 *  获取X与Y轴的长度
 */
- (void)configChartXAndYLength{
    _xLength = CGRectGetWidth(self.frame)-self.contentInsets.left-self.contentInsets.right;
    _yLength = CGRectGetHeight(self.frame)-self.contentInsets.top-self.contentInsets.bottom;
    
}

/**
 *  获取每个X或y轴刻度间距
 */
- (void)configPerXAndPerY{
    
    
    switch (_lineChartQuadrantType) {
        case JHLineChartQuadrantTypeFirstQuardrantYDY:
        {
            _perXLen = (_xLength-kXandYSpaceForSuperView)/(_xLineDataArr.count-1);
            _perYlen = (_yLength-kXandYSpaceForSuperView)/_yLineDataArr.count;
            if (_showDoubleYLevelLine) {
                _perYlen = (_yLength-kXandYSpaceForSuperView)/[_yLineDataArr[0] count];
            }
        }
            break;
        case JHLineChartQuadrantTypeFirstAndSecondQuardrantYDY:
        {
            _perXLen = (_xLength/2-kXandYSpaceForSuperView)/[_xLineDataArr[0] count];
            _perYlen = (_yLength-kXandYSpaceForSuperView)/_yLineDataArr.count;
        }
            break;
        case JHLineChartQuadrantTypeFirstAndFouthQuardrantYDY:
        {
            _perXLen = (_xLength-kXandYSpaceForSuperView)/(_xLineDataArr.count-1);
            _perYlen = (_yLength/2-kXandYSpaceForSuperView)/[_yLineDataArr[0] count];
        }
            break;
        case JHLineChartQuadrantTypeAllQuardrantYDY:
        {
            _perXLen = (_xLength/2-kXandYSpaceForSuperView)/([_xLineDataArr[0] count]);
            _perYlen = (_yLength/2-kXandYSpaceForSuperView)/[_yLineDataArr[0] count];
        }
            break;
            
        default:
            break;
    }
    
}



/**
 *  构建折线图原点
 */
- (void)configChartOrigin{
    
    switch (_lineChartQuadrantType) {
        case JHLineChartQuadrantTypeFirstQuardrantYDY:
        {
            self.chartOrigin = CGPointMake(self.contentInsets.left, self.frame.size.height-self.contentInsets.bottom);
        }
            break;
        case JHLineChartQuadrantTypeFirstAndSecondQuardrantYDY:
        {
            self.chartOrigin = CGPointMake(self.contentInsets.left+_xLength/2, CGRectGetHeight(self.frame)-self.contentInsets.bottom);
        }
            break;
        case JHLineChartQuadrantTypeFirstAndFouthQuardrantYDY:
        {
            self.chartOrigin = CGPointMake(self.contentInsets.left, self.contentInsets.top+_yLength/2);
        }
            break;
        case JHLineChartQuadrantTypeAllQuardrantYDY:
        {
            self.chartOrigin = CGPointMake(self.contentInsets.left+_xLength/2, self.contentInsets.top+_yLength/2);
        }
            break;
            
        default:
            break;
    }
    
}



-(void)setValueArr:(NSArray *)valueArr{
    
    _valueArr = valueArr;
    
    [self updateYScale];
    
    
}

/**
 *  更新Y轴的刻度大小
 */
- (void)updateYScale{
    switch (_lineChartQuadrantType) {
        case JHLineChartQuadrantTypeFirstAndFouthQuardrantYDY:{
            
            NSInteger max = 0;
            NSInteger min = 0;
            //            if (_valueArr.count==0) {
            //                _valueArr=@[@[@"10",@"20",@"30",@"40",@"50"]];
            //            }
            
            for (NSArray *arr in _valueArr) {
                for (NSString * numer  in arr) {
                    NSInteger i = [numer integerValue];
                    if (i>=max) {
                        max = i;
                    }
                    if (i<=min) {
                        min = i;
                    }
                }
                
            }
            
            min = labs(min);
            max = (min<max?(max):(min));
            if (max%5==0) {
                max = max;
            }else
                max = (max/5+1)*5;
            NSMutableArray *arr = [NSMutableArray array];
            NSMutableArray *minArr = [NSMutableArray array];
            if (max>0 && max<=5) {
                for (NSInteger i = 0; i<5; i++) {
                    
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*1]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*1]];
                }
            }
            
            if (max<=10&&max>5) {
                for (NSInteger i = 0; i<5; i++) {
                    
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*2]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*2]];
                }
                
            }else if(max>10&&max<=100){
                
                
                for (NSInteger i = 0; i<max/5; i++) {
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*5]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*5]];
                }
                
            }else{
                
                NSInteger Ynum=6;
                NSInteger count = max / (Ynum);
                if (count==0) {
                    count=1;
                }
                
                for (NSInteger i = 0; i<Ynum; i++) {
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*count]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*count]];
                }
                
            }
            _yLineDataArr = @[[arr copy],[minArr copy]];
            
            
            [self setNeedsDisplay];
            
            
        }break;
        case JHLineChartQuadrantTypeAllQuardrantYDY:{
            
            NSInteger max = 0;
            NSInteger min = 0;
            
            
            for (NSArray *arr in _valueArr) {
                for (NSString * numer  in arr) {
                    NSInteger i = [numer integerValue];
                    if (i>=max) {
                        max = i;
                    }
                    if (i<=min) {
                        min = i;
                    }
                }
                
            }
            
            
            min = labs(min);
            max = (min<max?(max):(min));
            if (max%5==0) {
                max = max;
            }else
                max = (max/5+1)*5;
            NSMutableArray *arr = [NSMutableArray array];
            NSMutableArray *minArr = [NSMutableArray array];
            if (max<=5) {
                for (NSInteger i = 0; i<5; i++) {
                    
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*1]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*1]];
                }
            }
            
            if (max<=10&&max>5) {
                
                
                for (NSInteger i = 0; i<5; i++) {
                    
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*2]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*2]];
                    
                }
                
            }else if(max>10&&max<=100){
                
                
                for (NSInteger i = 0; i<max/5; i++) {
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*5]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*5]];
                }
                
            }else{
                
                NSInteger count = max / 10;
                
                for (NSInteger i = 0; i<11; i++) {
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*count]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*count]];
                }
                
            }
            
            _yLineDataArr = @[[arr copy],[minArr copy]];
            
            [self setNeedsDisplay];
        }break;
        default:{
            if (_valueArr.count) {
                
                NSInteger max=0;
                
                for (NSArray *arr in _valueArr) {
                    for (NSString * numer  in arr) {
                        NSInteger i = [numer integerValue];
                        if (i>=max) {
                            max = i;
                        }
                        
                    }
                    
                }
                
                
                if (max%5==0) {
                    max = max;
                }else
                    max = (max/5+1)*5;
                _yLineDataArr = nil;
                NSMutableArray *arr = [NSMutableArray array];
                if (max<=5) {
                    for (NSInteger i = 0; i<5; i++) {
                        
                        [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*1]];
                        
                    }
                }
                
                if (max<=10&&max>5) {
                    
                    
                    for (NSInteger i = 0; i<5; i++) {
                        
                        [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*2]];
                        
                    }
                    
                }else if(max>10&&max<=50){
                    
                    for (NSInteger i = 0; i<max/5+1; i++) {
                        [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*5]];
                        
                        
                    }
                    
                }else if(max<=100){
                    
                    for (NSInteger i = 0; i<max/10; i++) {
                        [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*10]];
                        
                        
                    }
                    
                }else if(max > 100){
                    
                    NSInteger count = max / 10;
                    
                    for (NSInteger i = 0; i<10+1; i++) {
                        [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*count]];
                        
                    }
                }
                
                
                _yLineDataArr = [arr copy];
                
                [self setNeedsDisplay];
                
                
            }
            
        }
            break;
    }
    
    
    
}




/**
 *  动画展示路径
 */
-(void)showAnimation{
    [self configChartXAndYLength];

    [self configPerXAndPerY];
    

    [self configChartOrigin];
//    [self configValueDataArray];
//    [self drawAnimation];
}


- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawXAndYLineWithContext:context];
    
    
    if (!_isEndAnimation) {
        return;
    }
    

}

/* 绘制x与y轴 */
- (void)drawXAndYLineWithContext:(CGContextRef)context{
    
    switch (_lineChartQuadrantType) {
        case JHLineChartQuadrantTypeFirstQuardrantYDY:{
            
//            [self drawLineWithContext:context andStarPoint:self.chartOrigin andEndPoint:P_M(self.contentInsets.left+_xLength, self.chartOrigin.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
            
            if (_showYLine) {
                [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x,self.chartOrigin.y-kXandYSpaceForSuperView) andEndPoint:P_M(self.chartOrigin.x,self.chartOrigin.y-_yLength) andIsDottedLine:NO andColor:self.xAndYLineColor];
            }
            
            if (_showDoubleYLevelLine) {
                [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x+_xLength, self.chartOrigin.y) andEndPoint:P_M(self.chartOrigin.x + _xLength,self.chartOrigin.y-_yLength) andIsDottedLine:NO andColor:self.xAndYLineColor];
            }
            
       
            if (_xLineDataArr.count>0) {
                CGFloat xPace = (_xLength-kXandYSpaceForSuperView)/(_xLineDataArr.count-1);
                
                for (NSInteger i = 0; i<_xLineDataArr.count;i++ ) {
                    CGPoint p = P_M(i*xPace+self.chartOrigin.x, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%@",_xLineDataArr[i]]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y+2, contentSize.width, contentSize.height)];
                        label.text = [NSString stringWithFormat:@"%@",_xLineDataArr[i]];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.numberOfLines = 0;
                        label.transform = CGAffineTransformRotate(label.transform, _xDescriptionAngle);
                      //  [self addSubview:label];
                        
                    }else{
//                        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.xDescTextFontSize aimString:_xLineDataArr[i]].width;
//                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
//
//                        [self drawText:[NSString stringWithFormat:@"%@",_xLineDataArr[i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
                
                
                
            }
            
            
            if (_showDoubleYLevelLine) {
                NSArray *leftArray = nil;
                NSArray *rightArray = nil;
                NSAssert(_yLineDataArr.count == 2 && [_yLineDataArr[0] isKindOfClass:[NSArray class]] && [_yLineDataArr[1] isKindOfClass:[NSArray class]] , @"when property showDoubleYLevelLine is true,you must define yLineDataArr as @[@[@1,@2,@3],@[@5,@10,@10]]");
                leftArray = _yLineDataArr[0];
                rightArray = _yLineDataArr[1];
                NSAssert(leftArray.count == rightArray.count && leftArray.count > 0, @"when property showDoubleYLevelLine is true,leftArray.count == rightArray.count");
                if(leftArray.count == rightArray.count && leftArray.count > 0){
                    CGFloat yPace = (_yLength - kXandYSpaceForSuperView)/(leftArray.count);
                    for (NSInteger i = 0; i<leftArray.count; i++) {
                        CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y - (i+1)*yPace);
                        
                        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:leftArray[i]].width;
                        CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:leftArray[i]].height;
                        if (_showYLevelLine) {
                            [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(self.contentInsets.left+_xLength, p.y) andIsDottedLine:YES andColor:self.xAndYLineColor];
                            
                        }else{
                            [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        }
                        [self drawText:[NSString stringWithFormat:@"%@",leftArray[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                        
                        p = P_M(self.chartOrigin.x + _xLength, p.y);
                        len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:rightArray[i]].width;
                        hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:rightArray[i]].height;
                        
                        [self drawText:[NSString stringWithFormat:@"%@",rightArray[i]] andContext:context atPoint:P_M(p.x + 3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                        
                        
                        
                    }
                }
                
            }else{
                if (_yLineDataArr.count>0) {
                    CGFloat yPace = (_yLength - kXandYSpaceForSuperView)/(_yLineDataArr.count);
                    for (NSInteger i = 0; i<_yLineDataArr.count; i++) {
                        CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y- kXandYSpaceForSuperView - (i+1)*yPace);
                        
                        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:_yLineDataArr[i]].width;
                        CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:_yLineDataArr[i]].height;
                        if (_showYLevelLine) {
//                            [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(self.contentInsets.left+_xLength, p.y) andIsDottedLine:YES andColor:self.xAndYLineColor];
                            
                        }else{
                            [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        }
                        [self drawText:[NSString stringWithFormat:@"%@",_yLineDataArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                    }
                }
            }
            
            
            
        }break;
        case JHLineChartQuadrantTypeFirstAndSecondQuardrantYDY:{
            [self drawLineWithContext:context andStarPoint:P_M(self.contentInsets.left, self.chartOrigin.y) andEndPoint:P_M(self.contentInsets.left+_xLength, self.chartOrigin.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
            
            if (_showYLine) {
                [self drawLineWithContext:context andStarPoint:self.chartOrigin andEndPoint:P_M(self.chartOrigin.x,self.chartOrigin.y-_yLength) andIsDottedLine:NO andColor:self.xAndYLineColor];
            }
            
            if (_xLineDataArr.count == 2) {
                NSArray * rightArr = _xLineDataArr[1];
                NSArray * leftArr = _xLineDataArr[0];
                
                CGFloat xPace = (_xLength/2-kXandYSpaceForSuperView)/(rightArr.count-1);
                
                for (NSInteger i = 0; i<rightArr.count;i++ ) {
                    CGPoint p = P_M(i*xPace+self.chartOrigin.x, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%@",rightArr[i]]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y+2, contentSize.width, contentSize.height)];
                        label.text = [NSString stringWithFormat:@"%@",rightArr[i]];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.numberOfLines = 0;
                        label.transform = CGAffineTransformRotate(label.transform, _xDescriptionAngle);
                        [self addSubview:label];
                    }else{
                        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.xDescTextFontSize aimString:rightArr[i]].width;
                        
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        
                        [self drawText:[NSString stringWithFormat:@"%@",rightArr[i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
                
                for (NSInteger i = 0; i<leftArr.count;i++ ) {
                    CGPoint p = P_M(self.chartOrigin.x-(i+1)*xPace, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%@",leftArr[i]]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y+2, contentSize.width, contentSize.height)];
                        label.text = [NSString stringWithFormat:@"%@",leftArr[i]];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.numberOfLines = 0;
                        label.transform = CGAffineTransformRotate(label.transform, _xDescriptionAngle);
                        [self addSubview:label];
                    }else{
                        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.xDescTextFontSize aimString:leftArr[i]].width;
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        [self drawText:[NSString stringWithFormat:@"%@",leftArr[leftArr.count-1-i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
                
            }
            if (_yLineDataArr.count>0) {
                CGFloat yPace = (_yLength - kXandYSpaceForSuperView)/(_yLineDataArr.count);
                for (NSInteger i = 0; i<_yLineDataArr.count; i++) {
                    CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y - (i+1)*yPace);
                    CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:_yLineDataArr[i]].width;
                    CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:_yLineDataArr[i]].height;
                    if (_showYLevelLine) {
                        [self drawLineWithContext:context andStarPoint:P_M(self.contentInsets.left, p.y) andEndPoint:P_M(self.contentInsets.left+_xLength, p.y) andIsDottedLine:YES andColor:self.xAndYLineColor];
                    }else
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",_yLineDataArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                }
            }
            
        }break;
        case JHLineChartQuadrantTypeFirstAndFouthQuardrantYDY:{
            [self drawLineWithContext:context andStarPoint:self.chartOrigin andEndPoint:P_M(self.contentInsets.left+_xLength, self.chartOrigin.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
            
            if (_showYLine) {
                [self drawLineWithContext:context andStarPoint:P_M(self.contentInsets.left,CGRectGetHeight(self.frame)-self.contentInsets.bottom) andEndPoint:P_M(self.contentInsets.left,self.contentInsets.top) andIsDottedLine:NO andColor:self.xAndYLineColor];
            }
            
            if (_xLineDataArr.count>0) {
                CGFloat xPace = (_xLength-kXandYSpaceForSuperView)/(_xLineDataArr.count-1);
                
                for (NSInteger i = 0; i<_xLineDataArr.count;i++ ) {
                    CGPoint p = P_M(i*xPace+self.chartOrigin.x, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%@",_xLineDataArr[i]]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y+2, contentSize.width, contentSize.height)];
                        label.text = [NSString stringWithFormat:@"%@",_xLineDataArr[i]];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.numberOfLines = 0;
                        label.transform = CGAffineTransformRotate(label.transform, _xDescriptionAngle);
                        [self addSubview:label];
                    }else{
//                        CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.xDescTextFontSize aimString:_xLineDataArr[i]].width;
//                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x    , p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
//
//                        if (i==0) {
//                            len = -2;
//                        }
//
//                        [self drawText:[NSString stringWithFormat:@"%@",_xLineDataArr[i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
            }
            
            if (_yLineDataArr.count == 2) {
                
                NSArray * topArr = _yLineDataArr[0];
                NSArray * bottomArr = _yLineDataArr[1];
                CGFloat yPace = (_yLength/2 - kXandYSpaceForSuperView)/([_yLineDataArr[0] count]);
                _perYlen = yPace;
                for (NSInteger i = 0; i<topArr.count; i++) {
                    CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y - (i+1)*yPace);
                    CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.yDescTextFontSize aimString:topArr[i]].width;
                    CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:topArr[i]].height;
                    if (_showYLevelLine) {
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(self.contentInsets.left+_xLength, p.y) andIsDottedLine:YES andColor:self.xAndYLineColor];
                    }else
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",topArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                    
                }
                
                
                for (NSInteger i = 0; i<bottomArr.count; i++) {
                    CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y + (i+1)*yPace);
                    CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.yDescTextFontSize aimString:bottomArr[i]].width;
                    CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:bottomArr[i]].height;
                    
                    if (_showYLevelLine) {
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(self.contentInsets.left+_xLength, p.y) andIsDottedLine:YES andColor:self.xAndYLineColor];
                    }else{
                        
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                    }
                    [self drawText:[NSString stringWithFormat:@"%@",bottomArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                }
                
                
            }
            
        }break;
        case JHLineChartQuadrantTypeAllQuardrantYDY:{
            [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x-_xLength/2, self.chartOrigin.y) andEndPoint:P_M(self.chartOrigin.x+_xLength/2, self.chartOrigin.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
            
            if (_showYLine) {
                [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x,self.chartOrigin.y+_yLength/2) andEndPoint:P_M(self.chartOrigin.x,self.chartOrigin.y-_yLength/2) andIsDottedLine:NO andColor:self.xAndYLineColor];
            }
            
            
            
            if (_xLineDataArr.count == 2) {
                NSArray * rightArr = _xLineDataArr[1];
                NSArray * leftArr = _xLineDataArr[0];
                
                CGFloat xPace = (_xLength/2-kXandYSpaceForSuperView)/(rightArr.count-1);
                
                for (NSInteger i = 0; i<rightArr.count;i++ ) {
                    CGPoint p = P_M(i*xPace+self.chartOrigin.x, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%@",rightArr[i]]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y+2, contentSize.width, contentSize.height)];
                        label.text = [NSString stringWithFormat:@"%@",rightArr[i]];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.numberOfLines = 0;
                        label.transform = CGAffineTransformRotate(label.transform, _xDescriptionAngle);
                        [self addSubview:label];
                    }else{
                        CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.xDescTextFontSize aimString:rightArr[i]].width;
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        
                        [self drawText:[NSString stringWithFormat:@"%@",rightArr[i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
                for (NSInteger i = 0; i<leftArr.count;i++ ) {
                    CGPoint p = P_M(self.chartOrigin.x-(i+1)*xPace, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%@",leftArr[i]]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y+2, contentSize.width, contentSize.height)];
                        label.text = [NSString stringWithFormat:@"%@",leftArr[i]];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.numberOfLines = 0;
                        label.transform = CGAffineTransformRotate(label.transform, _xDescriptionAngle);
                        [self addSubview:label];
                    }else{
                        CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.xDescTextFontSize aimString:leftArr[i]].width;
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        
                        [self drawText:[NSString stringWithFormat:@"%@",leftArr[leftArr.count-1-i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
                
            }
            
            
            if (_yLineDataArr.count == 2) {
                
                NSArray * topArr = _yLineDataArr[0];
                NSArray * bottomArr = _yLineDataArr[1];
                CGFloat yPace = (_yLength/2 - kXandYSpaceForSuperView)/([_yLineDataArr[0] count]);
                _perYlen = yPace;
                for (NSInteger i = 0; i<topArr.count; i++) {
                    CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y - (i+1)*yPace);
                    CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.yDescTextFontSize aimString:topArr[i]].width;
                    CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:topArr[i]].height;
                    
                    [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",topArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                    
                }
                
                
                for (NSInteger i = 0; i<bottomArr.count; i++) {
                    CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y + (i+1)*yPace);
                    CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.yDescTextFontSize aimString:bottomArr[i]].width;
                    CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:bottomArr[i]].height;
                    
                    [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",bottomArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                }
                
                
            }
            
        }break;
            
        default:
            break;
    }
    
    
}


/**
 *  清除图标内容
 */
-(void)clear{
    
    _valueArr = nil;
    _drawDataArr = nil;
    
    for (CALayer *layer in _layerArr) {
        
        [layer removeFromSuperlayer];
    }
    [self showAnimation];
    
}


/**
 *  绘制线段
 *
 *  @param context  图形绘制上下文
 *  @param start    起点
 *  @param end      终点
 *  @param isDotted 是否是虚线
 *  @param color    线段颜色
 */
- (void)drawLineWithContext:(CGContextRef )context andStarPoint:(CGPoint )start andEndPoint:(CGPoint)end andIsDottedLine:(BOOL)isDotted andColor:(UIColor *)color{
    
    
    //    移动到点
    CGContextMoveToPoint(context, start.x, start.y);
    //    连接到
    CGContextAddLineToPoint(context, end.x, end.y);
    
    
    CGContextSetLineWidth(context, 0.3);
    
    
    [color setStroke];
    
    if (isDotted) {
        CGFloat ss[] = {1.5,2};
        
        CGContextSetLineDash(context, 0, ss, 2);
    }
    CGContextMoveToPoint(context, end.x, end.y);
    
    CGContextDrawPath(context, kCGPathFillStroke);
}


/**
 *  绘制文字
 *
 *  @param text    文字内容
 *  @param context 图形绘制上下文
 *  @param rect    绘制点
 *  @param color   绘制颜色
 */
- (void)drawText:(NSString *)text andContext:(CGContextRef )context atPoint:(CGPoint )rect WithColor:(UIColor *)color andFontSize:(CGFloat)fontSize{
    
    
    [[NSString stringWithFormat:@"%@",text] drawAtPoint:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:color}];

    [color setFill];
    
    CGContextDrawPath(context, kCGPathFill);
    
}


- (void)drawText:(NSString *)text context:(CGContextRef )context atPoint:(CGRect )rect WithColor:(UIColor *)color font:(UIFont*)font{
    
    
    //    [[NSString stringWithFormat:@"%@",text] drawAtPoint:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    
    [[NSString stringWithFormat:@"%@",text] drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    
    [color setFill];
    
    
    CGContextDrawPath(context, kCGPathFill);
    
}
/**
 *  判断文本宽度
 *
 *  @param text 文本内容
 *
 *  @return 文本宽度
 */
- (CGFloat)getTextWithWhenDrawWithText:(NSString *)text{
    
    CGSize size = [[NSString stringWithFormat:@"%@",text] boundingRectWithSize:CGSizeMake(100, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:7]} context:nil].size;
    
    return size.width;
}


/**
 *  绘制长方形
 *
 *  @param color  填充颜色
 *  @param p      开始点
 *  @param contex 图形上下文
 */
- (void)drawQuartWithColor:(UIColor *)color andBeginPoint:(CGPoint)p andContext:(CGContextRef)contex{
    
    CGContextAddRect(contex, CGRectMake(p.x, p.y, 10, 10));
    [color setFill];
    [color setStroke];
    CGContextDrawPath(contex, kCGPathFillStroke);
    
    
}


- (void)drawPointWithRedius:(CGFloat)redius andColor:(UIColor *)color andPoint:(CGPoint)p andContext:(CGContextRef)contex{
    
    CGContextAddArc(contex, p.x, p.y, redius, 0, M_PI * 2, YES);
    [color setFill];
    CGContextDrawPath(contex, kCGPathFill);
    
}

/**
 *  返回字符串的占用尺寸
 *
 *  @param maxSize   最大尺寸
 *  @param fontSize  字号大小
 *  @param aimString 目标字符串
 *
 *  @return 占用尺寸
 */
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(CGFloat)fontSize aimString:(NSString *)aimString{
    
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
}

@end
