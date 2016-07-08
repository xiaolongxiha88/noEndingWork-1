//
//  listTableViewCell.h
//  shinelink
//
//  Created by sky on 16/2/29.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface listTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)UIView *view1;

@property(nonatomic,strong)NSString *content;
@property (nonatomic, strong) UIImageView *coverImageView;

@end
