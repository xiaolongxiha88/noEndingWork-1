//
//  energyTableViewCell.h
//  shinelink
//
//  Created by sky on 16/3/8.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface energyTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UILabel *state;//日
@property (nonatomic, strong) UILabel *stateValue;
@property (nonatomic, strong) UILabel *electric;//月
@property (nonatomic, strong) UILabel *electricValue;

@end
