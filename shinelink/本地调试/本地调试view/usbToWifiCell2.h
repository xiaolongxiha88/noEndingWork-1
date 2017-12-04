//
//  usbToWifiCell2.h
//  ShinePhone
//
//  Created by sky on 2017/10/20.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class usbModleOne;

@interface usbToWifiCell2 : UITableViewCell

+ (CGFloat)moreHeight:(int)CellTyoe;
+ (CGFloat)defaultHeight;

@property(nonatomic, strong) usbModleOne *model;

@property(nonatomic,strong) UIView *AllView;
@property(nonatomic,strong) NSArray *lable1Array;

@property(nonatomic,strong) UIView *titleView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *moreTextBtn;
@property(nonatomic,assign) NSInteger indexRow;

@property(nonatomic, copy) void(^showMoreBlock)(UITableViewCell *currentCell);

@end
