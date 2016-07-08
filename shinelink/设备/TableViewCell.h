//
//  TableViewCell.h
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UILabel *state;
@property (nonatomic, strong) UILabel *stateValue;
@property (nonatomic, strong) UILabel *power;
@property (nonatomic, strong) UILabel *powerValue;
@property (nonatomic, strong) UILabel *electric;
@property (nonatomic, strong) UILabel *electricValue;
@property (nonatomic, strong) UIImageView *stateView;

@end
