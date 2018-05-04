//
//  AnotherSearchViewController.h
//  HCSortAndSearchDemo
//
//  Created by Caoyq on 16/3/29.
//  Copyright (c) 2016年 Caoyq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedItem)(NSString *item);
typedef void(^rightItemBlock)();

@interface AnotherSearchViewController : UIViewController

@property (strong, nonatomic) SelectedItem block;
@property (strong, nonatomic) rightItemBlock rightItemBlock;
@property (assign, nonatomic) BOOL isNeedRightItem;

@property (strong, nonatomic) NSArray *dataSource;/**<排序前的整个数据源*/

- (void)didSelectedItem:(SelectedItem)block;
@end
