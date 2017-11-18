//
//  payResultCell.h
//  ShinePhone
//
//  Created by sky on 2017/11/18.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface payResultCell : UITableViewCell

@property (nonatomic, strong) UILabel *lable1;//支付结果
@property (nonatomic, strong) UILabel *lable2;//支付金额
@property (nonatomic, strong) UILabel *lable3;//支付时间
@property (nonatomic, strong) UILabel *lable4;//支付序列号

@property (nonatomic, strong)NSArray *valueArray;

@end
