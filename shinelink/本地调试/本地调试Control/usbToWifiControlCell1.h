//
//  usbToWifiControlCell1.h
//  ShinePhone
//
//  Created by sky on 2017/10/25.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class usbModleOne;

@interface usbToWifiControlCell1 : UITableViewCell
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *moreTextBtn;
@property(nonatomic,strong) NSString *titleString;
@property(nonatomic,strong) UIView *nameView;
@property(nonatomic,strong) UIView *titleView;
@property(nonatomic, strong) usbModleOne *model;
@property(nonatomic, copy) void(^showMoreBlock)(UITableViewCell *currentCell);
@property(nonatomic,assign) int CellTypy;


+ (CGFloat)defaultHeight;
+ (CGFloat)moreHeight:(int)CellTyoe;

@end
