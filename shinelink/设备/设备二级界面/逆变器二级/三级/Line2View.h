//
//  Line2View.h
//  ShinePhone
//
//  Created by ZML on 15/6/4.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Line2View : UIView

@property(nonatomic,strong)NSString *flag;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) UILabel *energyTitleLabel;
@property (nonatomic, strong) NSString *frameType;
@property(nonatomic,strong)NSString *unitLaleName;

@property(nonatomic,assign)int barTypeNum;
@property (assign, nonatomic) BOOL isStorage;//间距数量

- (void)refreshLineChartViewWithDataDict:(NSMutableDictionary *)dataDict;

- (void)refreshBarChartViewWithDataDict:(NSMutableDictionary *)dataDict chartType:(NSInteger)type;

@end
