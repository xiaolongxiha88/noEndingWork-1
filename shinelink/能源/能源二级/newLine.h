//
//  newLine.h
//  shinelink
//
//  Created by sky on 16/3/16.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newLine : UIView

- (void)showBarChartWithDataDict:(NSMutableDictionary *)dataDict;
- (void)showBarAndLineChartWithDataDict:(NSMutableDictionary *)dataDict barDict:(NSMutableDictionary *)barDict;
- (void)showLineChartWithDataDict:(NSMutableDictionary *)dataDic;
- (void)showPieChartWithDataDict:(NSMutableDictionary *)dataDict;

@end
