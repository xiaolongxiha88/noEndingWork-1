//
//  qualityCell.h
//  shinelink
//
//  Created by sky on 16/4/7.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface qualityCell : UITableViewCell

@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *alia;
@property (nonatomic, strong) UILabel *SN;
@property (nonatomic, strong) UILabel *beginTime;
@property (nonatomic, strong) UILabel *overTime;
@property (nonatomic, strong) NSMutableArray *nameArray;

@end
