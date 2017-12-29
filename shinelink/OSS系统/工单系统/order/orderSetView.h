//
//  orderSetView.h
//  ShinePhone
//
//  Created by sky on 2017/12/26.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface orderSetView : RootViewController

@property (nonatomic, copy) void(^getSetValue)(NSDictionary*setValueDic);

@property (nonatomic, assign) int setType;

@end
