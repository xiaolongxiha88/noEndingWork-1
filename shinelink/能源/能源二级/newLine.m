//
//  newLine.m
//  shinelink
//
//  Created by sky on 16/3/16.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "newLine.h"
#import "ZFChart.h"
#import "ZFAxisLine.h"

@interface newLine()
@property (nonatomic, strong) NSArray *xArray;
@property (nonatomic, strong) NSMutableArray *valuesArray;
@property (nonatomic, strong) NSMutableArray *valuesArrayLine;
@property (nonatomic, strong) ZFBarChart * barChart ;
@property (nonatomic, strong)    ZFLineChart * lineChart;
@property (nonatomic, strong)   ZFPieChart * pieChart;
@end

@implementation newLine

- (void)setDataDict:(NSMutableDictionary *)dataDict {

    NSMutableDictionary *dict = dataDict;
    if (dict.count == 0) {
        dict=[NSMutableDictionary new];
        [dict setObject:@"0.0" forKey:@"08:30"];
        [dict setObject:@"0.0" forKey:@"09:30"];
        [dict setObject:@"0.0" forKey:@"10:30"];
        [dict setObject:@"0.0" forKey:@"11:30"];
        [dict setObject:@"0.0" forKey:@"12:30"];
        [dict setObject:@"0.0" forKey:@"13:30"];
        [dict setObject:@"0.0" forKey:@"14:30"];
        [dict setObject:@"0.0" forKey:@"15:30"];
        [dict setObject:@"0.0" forKey:@"16:30"];
        [dict setObject:@"0.0" forKey:@"17:30"];
        
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


- (void)showBarChartWithDataDict:(NSMutableDictionary *)dataDict{
     [self setDataDict:dataDict];
    if (_barChart) {
        [_barChart removeFromSuperview];
    }
    if (_lineChart) {
        [_lineChart removeFromSuperview];
    }
     _barChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _barChart.title = @"柱状图";
    _barChart.xLineValueArray = [NSMutableArray arrayWithArray:self.valuesArray];
    _barChart.xLineTitleArray = [NSMutableArray arrayWithArray:self.xArray];
     NSNumber *maxyAxisValue = [_valuesArray valueForKeyPath:@"@max.floatValue"];
    _barChart.yLineMaxValue = maxyAxisValue.floatValue;
    _barChart.yLineSectionCount = 10;
    [self addSubview:_barChart];
    [_barChart strokePath];
}

- (void)showBarAndLineChartWithDataDict:(NSMutableDictionary *)dataDict barDict:(NSMutableDictionary *)barDict{
     [self setDataDict:dataDict];
    if (_barChart) {
        [_barChart removeFromSuperview];
    }
    if (_lineChart) {
        [_lineChart removeFromSuperview];
    }
    self.valuesArrayLine=[NSMutableArray array];
    for (NSString *key in self.xArray) {
        [self.valuesArrayLine addObject:barDict[key]];
    }
    _barChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _barChart.title = @"用电分析";
    _barChart.xLineValueArray = [NSMutableArray arrayWithArray:self.valuesArray];
    _barChart.xLineTitleArray = [NSMutableArray arrayWithArray:self.xArray];
     NSNumber *maxyAxisValue = [_valuesArray valueForKeyPath:@"@max.floatValue"];
    _barChart.yLineMaxValue = maxyAxisValue.floatValue;
    _barChart.yLineSectionCount = 10;
    [self addSubview:_barChart];
    [_barChart strokePath];
    
     _lineChart= [[ZFLineChart alloc] initWithFrame:_barChart.bounds];
    _lineChart.xLineValueArray=[NSMutableArray arrayWithArray:self.valuesArrayLine];
    _lineChart.title=nil;
    _lineChart.xLineTitleArray=[NSMutableArray arrayWithArray:_barChart.xLineTitleArray];
    _lineChart.yLineMaxValue =  _barChart.yLineMaxValue;
    _lineChart.yLineSectionCount = 10;
    _lineChart.lineColor=[UIColor redColor];
    
    [self addSubview:_lineChart];
    [_lineChart strokePath];
}

- (void)showLineChartWithDataDict:(NSMutableDictionary *)dataDict{
     [self setDataDict:dataDict];
    if (_barChart) {
        [_barChart removeFromSuperview];
    }
    if (_lineChart) {
        [_lineChart removeFromSuperview];
    }
    _lineChart = [[ZFLineChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _lineChart.title = @"曲线图";
    _lineChart.xLineValueArray = [NSMutableArray arrayWithArray:self.valuesArrayLine];
    _lineChart.xLineTitleArray =[NSMutableArray arrayWithArray:self.xArray];
    _lineChart.yLineMaxValue = 500;
    _lineChart.yLineSectionCount = 10;
    [self addSubview:_lineChart];
    [_lineChart strokePath];
}

- (void)showPieChartWithDataDict:(NSMutableDictionary *)dataDict{
     [self setDataDict:dataDict];
    if (_barChart) {
        [_barChart removeFromSuperview];
    }
    if (_lineChart) {
        [_lineChart removeFromSuperview];
    }
    _pieChart = [[ZFPieChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)];
    _pieChart.title = @"家庭用电占比";
    
      _pieChart.nameArray = [NSMutableArray array];
    _pieChart.nameArray=(NSMutableArray*)dataDict.allKeys;
    NSMutableArray *value = [NSMutableArray array];
    for (NSString *key in  dataDict) {
        [value addObject:dataDict[key]];
    }
   _pieChart.valueArray = [NSMutableArray arrayWithArray:value];
    _pieChart.colorArray = [NSMutableArray arrayWithObjects:ZFColor(71, 204, 255, 1), ZFColor(253, 203, 76, 1), ZFColor(214, 205, 153, 1), ZFColor(78, 250, 188, 1), ZFColor(16, 140, 39, 1), ZFColor(45, 92, 34, 1), nil];
    _pieChart.percentType = kPercentTypeInteger;
    [self addSubview:_pieChart];
    [_pieChart strokePath];
}


@end
