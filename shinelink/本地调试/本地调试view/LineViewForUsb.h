//
//  LineViewForUsb.h
//  ShinePhone
//
//  Created by sky on 2017/12/6.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineViewForUsb : UIView

@property(nonatomic,strong)NSString *flag;
@property (nonatomic, strong) UILabel *unitLabel;

@property (nonatomic, strong) UILabel *energyTitleLabel;
@property (nonatomic, strong) NSString *frameType;
@property(nonatomic,strong)NSString *unitLaleName;   
@property (nonatomic,strong) NSString* xLableName;


@property(nonatomic,assign)int barTypeNum;
@property (assign, nonatomic) BOOL isStorage;//间距数量

- (void)refreshLineChartViewWithDataDict:(NSMutableDictionary *)dataDict;

- (void)refreshBarChartViewWithDataDict:(NSMutableDictionary *)dataDict chartType:(NSInteger)type;


@end
