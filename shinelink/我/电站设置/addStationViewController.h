//
//  addStationViewController.h
//  ShineLink
//
//  Created by sky on 16/8/8.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface addStationViewController : RootViewController

@property (nonatomic,copy) void(^addSuccessBlock)();
@property (nonatomic, assign)NSInteger cmdType;


@end
