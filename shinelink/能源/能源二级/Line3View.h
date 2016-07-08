//
//  Line3View.h
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Line3View : UIView
@property(nonatomic,strong)NSString *flag;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) UILabel *energyTitleLabel;
@property (nonatomic, strong) NSString *frameType;
@property (nonatomic, strong) NSString *deviceType;

- (void)refreshLineChartViewWithDataDict:(NSMutableDictionary *)dataDict;

- (void)refreshBarChartViewWithDataDict:(NSMutableDictionary *)dataDict chartType:(NSInteger)type;
@end
