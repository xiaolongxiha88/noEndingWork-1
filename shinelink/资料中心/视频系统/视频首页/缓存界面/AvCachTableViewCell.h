//
//  AvCachTableViewCell.h
//  ShinePhone
//
//  Created by sky on 16/9/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvCachTableViewCell : UITableViewCell

@property (strong, nonatomic)  UILabel *numLabel;
@property (strong, nonatomic)  UILabel *textLabels;
+(instancetype)creatWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) UILabel *CellName;

@end
