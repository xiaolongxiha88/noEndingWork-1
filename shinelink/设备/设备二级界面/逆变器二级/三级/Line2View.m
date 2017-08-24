//
//  Line2View.m
//  ShinePhone
//
//  Created by LinKai on 15/5/26.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "Line2View.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"
#import "PNChart.h"

@interface Line2View () <PNChartDelegate>

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger barType;
@property (nonatomic, strong) NSArray *firstValueArray;
@property (nonatomic, strong) NSMutableDictionary *dataDict;

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *moneyTitleLabel;
@property (nonatomic, strong) UILabel *energyLabel;
@property (nonatomic, strong) NSArray *xArray;
@property (nonatomic, strong) NSMutableArray *valuesArray;

@property (nonatomic, assign) NSInteger lineType;

@property (nonatomic, strong) SHLineGraphView *lineChartView;
@property (nonatomic, strong) SHPlot *lineChartPlot;

@property (nonatomic, strong) PNBarChart *barChartView;

@property (nonatomic, strong) UILabel *noDataLabel;

@end

@implementation Line2View

- (void)setDataDict:(NSMutableDictionary *)dataDict {
    self.moneyLabel.text = dataDict[@"plantData"][@"plantMoneyText"];
    self.energyLabel.text = dataDict[@"plantData"][@"currentEnergy"];
    
    NSMutableDictionary *dict = dataDict;
    if (dict.count == 0) {
        self.unitLabel.hidden = NO;
        //[self addSubview:self.noDataLabel];
        dict=[NSMutableDictionary new];
        if (_barType==1) {
            _firstValueArray=[NSArray arrayWithObjects:@"06:30", @"07:30",@"08:30",@"09:30",@"10:30",@"11:30",@"12:30",@"13:30",@"14:30",@"15:30",@"16:30",@"17:30",@"18:30",nil];
        }else if (_barType==2) {
            _firstValueArray=[NSArray arrayWithObjects:@"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",nil];
        }else if (_barType==3) {
            _firstValueArray=[NSArray arrayWithObjects:@"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];
        }else if (_barType==4) {
            _firstValueArray=[NSArray arrayWithObjects:@"2014", @"2015",@"2016",@"2017",nil];
        }
        
        for (int i=0; i<_firstValueArray.count; i++) {
                [dict setObject:@"0.0" forKey:_firstValueArray[i]];
        }
      

    } else {
        if (_noDataLabel) {
            [_noDataLabel removeFromSuperview];
        }
        self.unitLabel.hidden = NO;
    }
    self.xArray = dict.allKeys;
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1, NSString *obj2){
        NSRange range = NSMakeRange(0, obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    self.xArray = [dict.allKeys sortedArrayUsingComparator:sort];
    self.valuesArray = [NSMutableArray array];
    for (NSString *key in self.xArray) {
        [self.valuesArray addObject:dict[key]];
    }
    
    
}

- (UILabel *)noDataLabel {
    if (!_noDataLabel) {
        self.noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100*NOW_SIZE, 30*HEIGHT_SIZE)];
        self.noDataLabel.center = self.center;
        self.noDataLabel.textAlignment = NSTextAlignmentCenter;
        self.noDataLabel.textColor = [UIColor whiteColor];
        self.noDataLabel.font = [UIFont boldSystemFontOfSize:17*HEIGHT_SIZE];
        self.noDataLabel.text = NSLocalizedString(@"No data", @"No data");
    }
    return _noDataLabel;
}

- (void)setType:(NSInteger)type {
    self.lineType = type;
    if (type == 1) {
        self.moneyTitleLabel.text = NSLocalizedString(@"Daily income", @"Daily income");
        self.energyTitleLabel.text = root_Today_Energy;
        self.unitLabel.text = root_Powre;
    } else if (type == 2) {
        self.moneyTitleLabel.text = root_Earnings;
        self.energyTitleLabel.text = root_Month_energy;
        self.unitLabel.text = root_Energy;
    } else if (type == 3) {
        self.moneyTitleLabel.text = root_Earnings;
        self.energyTitleLabel.text = root_Year_energy;
        self.unitLabel.text = root_Energy;
    } else {
        self.moneyTitleLabel.text = root_Earnings;
        self.energyTitleLabel.text = root_Total_energy;
        self.unitLabel.text = root_Energy;
    }
}


#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        
        self.unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 120*HEIGHT_SIZE, 100*NOW_SIZE, 30*HEIGHT_SIZE)];
        self.unitLabel.font = [UIFont boldSystemFontOfSize:10*HEIGHT_SIZE];
        self.unitLabel.textColor = COLOR(102, 102, 102, 1);
        [self addSubview:self.unitLabel];
        
    }
    return self;
}


#pragma mark - line chart
- (SHLineGraphView *)lineChartView {
    if (!_lineChartView) {

        NSString *test=@"test";
        NSLog(@"TEST:%@",[_valuesArray[0] class]);

        
        int i=0;
        int j=5;
        if ([_valuesArray[0] class]!=[test class]) {
            if (![_flag isEqual:@"1"]) {
                for (NSNumber *number in _valuesArray) {
                    if ([[number stringValue] length]>i) {
                        i=(int)[[number stringValue] length];
                        NSLog(@"TEST:%@",number);
                    }
                }
                NSLog(@"TEST:%d",i);
                j=[self changeLineY:i];
            }
        }
        
        float fontW=8*HEIGHT_SIZE;
        UIColor *fontColor=COLOR(102, 102, 102, 1);
        
        if ([_frameType isEqualToString:@"1"]) {
             self.lineChartView = [[SHLineGraphView alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, 320*NOW_SIZE, 220*HEIGHT_SIZE)];
            NSDictionary *_themeAttributes = @{
                                               kXAxisLabelColorKey : fontColor,
                                               kXAxisLabelFontKey : [UIFont systemFontOfSize:fontW],
                                               kYAxisLabelColorKey : fontColor,
                                               kYAxisLabelFontKey : [UIFont systemFontOfSize:fontW],
                                               //                                           kYAxisLabelSideMarginsKey : @(j*NOW_SIZE),
                                               kPlotBackgroundLineColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                               kDotSizeKey : @0
                                               };
            self.lineChartView.themeAttributes = _themeAttributes;
        }else {
        self.lineChartView = [[SHLineGraphView alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 135*HEIGHT_SIZE, 320*NOW_SIZE, 250*HEIGHT_SIZE)];
        NSDictionary *_themeAttributes = @{
                                           kXAxisLabelColorKey :fontColor,
                                           kXAxisLabelFontKey : [UIFont systemFontOfSize:fontW],
                                           kYAxisLabelColorKey : fontColor,
                                           kYAxisLabelFontKey : [UIFont systemFontOfSize:fontW],
//                                           kYAxisLabelSideMarginsKey : @(j*NOW_SIZE),
                                           kPlotBackgroundLineColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                           kDotSizeKey : @0
                                           };
            self.lineChartView.themeAttributes = _themeAttributes;
        }
       
        NSLog(@"TEST:%d",j);
        BOOL isNoZero=NO;
        for (int i=0; i<_valuesArray.count; i++) {
            NSString *value=[NSString stringWithFormat:@"%@",_valuesArray[i]];
            if (![value isEqualToString:@"0"]) {
                isNoZero=YES;
                break;
            }
        }
        if (isNoZero) {
            NSMutableArray *newXarray=[NSMutableArray arrayWithArray:_xArray];
            NSMutableArray *newYarray=[NSMutableArray arrayWithArray:_valuesArray];
            
            for (int i=0; i<_valuesArray.count; i++) {
                if (i<_valuesArray.count-1) {
                    NSString *value1=[NSString stringWithFormat:@"%@",_valuesArray[i+1]];
                    if (![value1 isEqualToString:@"0"]) {
                        break;
                    }
                }
                
                NSString *value=[NSString stringWithFormat:@"%@",_valuesArray[i]];
                if ([value isEqualToString:@"0"]) {
                    [newYarray removeObjectAtIndex:0];
                    [newXarray removeObjectAtIndex:0];
                    
                }else{
                    break;
                }
            }
            
            for (int i=(int)(_valuesArray.count-1); i>-1; i--) {
                NSString *value=[NSString stringWithFormat:@"%@",_valuesArray[i]];
                if (i>1) {
                    NSString *value1=[NSString stringWithFormat:@"%@",_valuesArray[i-1]];
                    if (![value1 isEqualToString:@"0"]) {
                        break;
                    }
                }
                
                if ([value isEqualToString:@"0"]) {
                    [newYarray removeLastObject];
                    [newXarray removeLastObject];
                }else{
                    break;
                }
            }
            
            _xArray=[NSArray arrayWithArray:newXarray];
            _valuesArray=[NSMutableArray arrayWithArray:newYarray];
        }

        
        NSMutableArray *tempXArr = [NSMutableArray array];
        if (_xArray.count > 0) {
            NSString *flag = [[NSMutableString stringWithString:_xArray[0]] substringWithRange:NSMakeRange(1, 1)];
            if ([flag isEqualToString:@":"]) {
                //从偶数统计
                for (int i = 1; i <= _xArray.count; i++) {
                    if (i % 2 == 0) {
                        NSString *tempStr = [[NSMutableString stringWithString:_xArray[i-1]] substringToIndex:2];
                        NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: [NSString stringWithFormat:@"%d", [tempStr intValue]]};
                        [tempXArr addObject:tempDict];
                    } else {
                        NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: @""};
                        [tempXArr addObject:tempDict];
                    }
                }
            } else {
                //从奇数统计
                for (int i = 1; i <= _xArray.count; i++) {
                    if (i % 2 != 0) {
                        NSString *tempStr = [[NSMutableString stringWithString:_xArray[i-1]] substringToIndex:2];
                        NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: [NSString stringWithFormat:@"%d", [tempStr intValue]]};
                        [tempXArr addObject:tempDict];
                    } else {
                        NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: @""};
                        [tempXArr addObject:tempDict];
                    }
                }
            }
        }
        
        self.lineChartView.xAxisValues = tempXArr;
        self.lineChartView.dirLableValuesX=[NSArray arrayWithArray:_xArray];
          self.lineChartView.dirLableValuesY=[NSArray arrayWithArray:_valuesArray];
        
        self.lineChartPlot = [[SHPlot alloc] init];
        if ([_frameType isEqualToString:@"1"]) {
        NSDictionary *_plotThemeAttributes = @{
                                               kPlotFillColorKey : COLOR(89, 225, 151, 0.6),
                                               kPlotStrokeWidthKey : [NSString stringWithFormat:@"%.1f",1*HEIGHT_SIZE],
                                               kPlotStrokeColorKey : COLOR(89, 225, 151, 1),
                                               kPlotPointFillColorKey : COLOR(89, 225, 151, 0.6),
                                               kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10*HEIGHT_SIZE]
                                               };
            self.lineChartPlot.plotThemeAttributes = _plotThemeAttributes;
          }else{
              NSDictionary *_plotThemeAttributes = @{
                                                     kPlotFillColorKey : COLOR(89, 225, 151, 0.6),
                                                     kPlotStrokeWidthKey : [NSString stringWithFormat:@"%.1f",1*HEIGHT_SIZE],
                                                     kPlotStrokeColorKey : COLOR(89, 225, 151, 1),
                                                     kPlotPointFillColorKey : COLOR(89, 225, 151, 0.6),
                                                     kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10*HEIGHT_SIZE]
                                                     };
              self.lineChartPlot.plotThemeAttributes = _plotThemeAttributes;
            
            }
        
    }
    return _lineChartView;
}

- (void)refreshLineChartViewWithDataDict:(NSMutableDictionary *)dataDict {
 
    _barType=1;
    [self setDataDict:dataDict];
    
    if (![_frameType isEqualToString:@"1"]) {
     [self setType:1];
    }

    
    if (_barChartView) {
        [_barChartView removeFromSuperview];
    }
    
    if (_xArray.count == 0) {
        [_lineChartView removeFromSuperview];
        _lineChartView = nil;
        return;
    }
    
    if (_lineChartView) {
        [_lineChartView removeFromSuperview];
        _lineChartView = nil;
        
        [self addSubview:self.lineChartView];
    } else {
        [self addSubview:self.lineChartView];
    }
    
    if (_valuesArray.count > 0) {
        //
        NSNumber *avg = [_valuesArray valueForKeyPath:@"@avg.floatValue"];
        if ([avg floatValue] != 0) {
            NSNumber *maxyAxisValue = [_valuesArray valueForKeyPath:@"@max.floatValue"];
            float getY0=[maxyAxisValue floatValue]/6;
            int getY1=ceil(getY0);
            if ((0<getY1)&&(getY1<10)) {
                maxyAxisValue=[NSNumber numberWithInt:getY1*6];
            }else if ((10<getY1)&&(getY1<100)) {
                getY1=ceil(getY0/5)*5;
                maxyAxisValue=[NSNumber numberWithInt:getY1*6];
            }else if ((100<getY1)&&(getY1<1000)) {
                getY1=ceil(getY0/50)*50;
                maxyAxisValue=[NSNumber numberWithInt:getY1*6];
            }else if ((1000<getY1)&&(getY1<10000)) {
                getY1=ceil(getY0/500)*500;
                maxyAxisValue=[NSNumber numberWithInt:getY1*6];
            }else if ((10000<getY1)&&(getY1<100000)) {
                getY1=ceil(getY0/5000)*5000;
                maxyAxisValue=[NSNumber numberWithInt:getY1*6];
            }
            
            if (_isStorage) {
                self.lineChartView.lableLookNum=5;
                 self.lineChartView.yAxisRange = [NSNumber numberWithInt:100];
            }else{
                 self.lineChartView.lableLookNum=6;
                   self.lineChartView.yAxisRange = maxyAxisValue;
            }
            
         
            self.lineChartView.yAxisSuffix = @"";
            
            NSMutableArray *tempValuesArray = [NSMutableArray array];
            for (int i = 0; i < _valuesArray.count; i++) {
                NSDictionary *tempDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:[_valuesArray[i] floatValue]]forKey:[NSNumber numberWithInt:(i+1)]];
                [tempValuesArray addObject:tempDict];
            }
            
            self.lineChartPlot.plottingValues = tempValuesArray;
            self.lineChartPlot.plottingPointsLabels = _valuesArray;
            
            [self.lineChartView addPlot:self.lineChartPlot];
            [self.lineChartView setupTheView];
        } else {
            self.lineChartView.yAxisRange = @100;
               self.lineChartView.lableLookNum=5;
            self.lineChartView.yAxisSuffix = @"";
            
            NSMutableArray *tempValuesArray = [NSMutableArray array];
            for (int i = 0; i < _valuesArray.count; i++) {
                if (i == 0) {
                    NSDictionary *tempDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1]forKey:[NSNumber numberWithInt:(i+1)]];
                    [tempValuesArray addObject:tempDict];
                } else {
                    NSDictionary *tempDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:[_valuesArray[i] floatValue]]forKey:[NSNumber numberWithInt:(i+1)]];
                    [tempValuesArray addObject:tempDict];
                }
            }
            
            self.lineChartPlot.plottingValues = tempValuesArray;
            self.lineChartPlot.plottingPointsLabels = _valuesArray;
            
            [self.lineChartView addPlot:self.lineChartPlot];
            [self.lineChartView setupTheView];
        }
    }
}


#pragma mark - bar chart
- (PNBarChart *)barChartView {
    if (!_barChartView) {
        self.barChartView = [[PNBarChart alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 135*HEIGHT_SIZE, 310*NOW_SIZE, 300*HEIGHT_SIZE)];
        self.barChartView.backgroundColor = [UIColor clearColor];
        self.barChartView.barBackgroundColor = [UIColor clearColor];
        [self.barChartView setStrokeColor:COLOR(122, 230, 129, 1)];
        [self.barChartView setLabelTextColor:COLOR(102, 102, 102, 1)];
        self.barChartView.yChartLabelWidth = 26*HEIGHT_SIZE;
        self.barChartView.chartMargin = 30*HEIGHT_SIZE;
        self.barChartView.yLabelFormatter = ^(CGFloat yValue){
            CGFloat yValueParsed = yValue;
            NSString *labelText = [NSString stringWithFormat:@"%.0f",yValueParsed];
            return labelText;
        };
        self.barChartView.labelMarginTop = 5*HEIGHT_SIZE;
        self.barChartView.showChartBorder = YES;
        
    }
    return _barChartView;
}

- (void)refreshBarChartViewWithDataDict:(NSMutableDictionary *)dataDict chartType:(NSInteger)type {
    _barType=type;
    NSArray *keysArray=[NSArray arrayWithArray:[dataDict allKeys]];
    NSMutableArray *newkeysArray=[NSMutableArray new];
    for (int i=0; i<keysArray.count; i++) {
        [newkeysArray addObject:[NSString stringWithFormat:@"%@",keysArray[i]]];
    }
    
    
    NSMutableDictionary *dataDict0=[NSMutableDictionary dictionaryWithDictionary:dataDict];
    
    for (int i=0; i<keysArray.count; i++) {
        NSString *key=[NSString stringWithFormat:@"%@",keysArray[i]];
        if (key.length>1) {
            if ([key hasPrefix:@"0"]) {
                NSString *key1=[key substringFromIndex:1];
                NSString *value=[dataDict0 objectForKey:key];
                [dataDict0 setObject:value forKey:key1];
                [dataDict0 removeObjectForKey:key];
            }
        }
        
    }
    
    NSArray *newkeysArray2=[NSArray arrayWithArray:[dataDict0 allKeys]];
    NSNumber *maxX = [newkeysArray2 valueForKeyPath:@"@max.intValue"];
    int xMax=[maxX intValue];
    
    if ((_barType==2)||(_barType==3)) {
        for (int i=xMax; i>0; i--) {
            if (![newkeysArray2 containsObject:[NSString stringWithFormat:@"%d",i]]) {
                [dataDict0 setObject:@"0" forKey:[NSString stringWithFormat:@"%d",i]];
            }
        }
    }
    
  
    
    [self setDataDict:dataDict0];
    [self setType:type];
    
    if (_lineChartView) {
        [_lineChartView removeFromSuperview];
    }
    
    if (_xArray.count == 0) {
        [_barChartView removeFromSuperview];
        _barChartView = nil;
        return;
    }
    
    if (_barChartView) {
        [_barChartView removeFromSuperview];
        _barChartView = nil;
    }
    
    NSNumber *maxyAxisValue = [_valuesArray valueForKeyPath:@"@max.floatValue"];
    if ([maxyAxisValue floatValue]==0) {
        maxyAxisValue=[NSNumber numberWithInt:120];
    }
    float getY0=[maxyAxisValue floatValue]/6;
    int getY1=ceil(getY0);
    if ((0<getY1)&&(getY1<10)) {
        maxyAxisValue=[NSNumber numberWithInt:getY1*6];
    }else if ((10<getY1)&&(getY1<100)) {
        getY1=ceil(getY0/5)*5;
        maxyAxisValue=[NSNumber numberWithInt:getY1*6];
    }else if ((100<getY1)&&(getY1<1000)) {
        getY1=ceil(getY0/50)*50;
        maxyAxisValue=[NSNumber numberWithInt:getY1*6];
    }else if ((1000<getY1)&&(getY1<10000)) {
        getY1=ceil(getY0/500)*500;
        maxyAxisValue=[NSNumber numberWithInt:getY1*6];
    }else if ((10000<getY1)&&(getY1<100000)) {
        getY1=ceil(getY0/5000)*5000;
        maxyAxisValue=[NSNumber numberWithInt:getY1*6];
    }else if ((100000<getY1)&&(getY1<1000000)) {
        getY1=ceil(getY0/50000)*50000;
        maxyAxisValue=[NSNumber numberWithInt:getY1*6];
    }
    self.barChartView.everyYvalue=getY1;
     self.barChartView.maxYvalue=[maxyAxisValue floatValue];
    

    if (type == 2) {
        //当展示月时，x轴只显示偶数
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSString *str in _xArray) {
            if ([str integerValue] % 2 == 0) {
                [tempArr addObject:str];
            } else {
                [tempArr addObject:@""];
            }
        }
        self.barChartView.xValues=[NSArray arrayWithArray:_xArray];
        
        if (_xArray.count>12) {
             [self.barChartView setXLabels:tempArr];
        }else{
           [self.barChartView setXLabels:_xArray];
        }
       
    } else {
         self.barChartView.xValues=[NSArray arrayWithArray:_xArray];
        [self.barChartView setXLabels:_xArray];
    }
    
    [self.barChartView setYValues:_valuesArray];
    [self.barChartView strokeChart];
    
    self.barChartView.delegate = self;
    
    [self addSubview:self.barChartView];
    
}

-(int)changeLineY:(int)sender{
    int i=0;
    if (sender==1) {
        i=23;
    }else if (sender==2){
        i=22;
    }else if (sender==3){
        i=21;
    }else if (sender==4){
        i=20;
    }else if (sender==5){
        i=18;
    }else if (sender==6){
        i=13;
    }else if (sender==7){
        i=8;
    }else if (sender==8){
        i=5;
    }else if (sender==9){
        i=3;
    }else if (sender==10){
        i=2;
    }else if (sender==17||sender==18){
        i=24;
    }else{
        i=1;
    }
    return i;
}

@end
