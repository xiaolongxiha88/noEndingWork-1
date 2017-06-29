//
//  orderCellTwo.h
//  ShinePhone
//
//  Created by sky on 2017/6/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderCellTwo : UITableViewCell

@property(nonatomic,strong) UIView *titleView;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *titleImage;

@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UIButton *moreTextBtn;
@property(nonatomic, assign) BOOL isShowMoreText;

@property(nonatomic,strong)NSString *titleString;
@property(nonatomic,strong)NSString *contentString;
@property(nonatomic)CGFloat cellFirstH;

@property(nonatomic, copy) void(^showMoreBlock)(UITableViewCell *currentCell);

@property(nonatomic, copy) void(^showMoreData)(NSArray *dataArray);

/**
 默认高度
 
 @param model 模型
 @return 默认高度
 */
+ (CGFloat)defaultHeight;

/**
 展开高度
 
 @param model 模型
 @return 展开高度
 */
+ (CGFloat)moreHeight:(NSString *)content;


@end
