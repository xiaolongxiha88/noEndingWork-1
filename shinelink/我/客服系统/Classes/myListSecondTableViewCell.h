//
//  myListSecondTableViewCell.h
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myListSecondTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong) UIWebView* contentLabel;
//@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIImageView *picLabel;
@property (nonatomic, strong) UIImageView *image;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)NSMutableArray *picArray;

@property(nonatomic,strong)NSString *WebContent;

@end
