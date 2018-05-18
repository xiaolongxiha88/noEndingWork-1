//
//  ossNewDeviceCell.h
//  ShinePhone
//
//  Created by sky on 2018/4/26.
//  Copyright © 2018年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ossNewDeviceCell : UITableViewCell

@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *nameValueArray;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSString *statusNameString;

@property (nonatomic, assign) NSInteger deviceType;      //1、逆变器  2、储能机   3、mix

@end
