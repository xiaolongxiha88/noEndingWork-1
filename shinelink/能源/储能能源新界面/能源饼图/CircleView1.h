//
//  CircleView.h
//  YCT
//
//  Created by 余晋龙 on 16/9/21.
//  Copyright © 2016年 bzjc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView1 : UIView
//饼状图数据array
@property (nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic , copy) NSString *str;
@property(nonatomic , copy) NSDictionary *allDic;
@property(nonatomic , copy) NSString *isSPF5000;

-(instancetype)initWithFrame:(CGRect)frame andUrlStr:(NSString *)str andAllDic:(NSDictionary*)dic;
@end
