//
//  pvLogTableViewCell.h
//  shinelink
//
//  Created by sky on 16/4/1.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pvLogTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *scrollView;
@property (nonatomic, strong) UILabel *SN;
@property (nonatomic, strong) UILabel *SNText;
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UILabel *typtText;
@property (nonatomic, strong) UILabel *event;
@property (nonatomic, strong) UILabel *eventText;
@property (nonatomic, strong) UILabel *Log;
@property (nonatomic, strong) UILabel *LogText;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)NSString *content;

@end
