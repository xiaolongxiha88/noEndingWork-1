//
//  ossIntegratorSearch.h
//  ShinePhone
//
//  Created by sky on 2018/5/16.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface ossIntegratorSearch : RootViewController


@property (nonatomic, assign) NSInteger searchType;     //1设备搜索

@property (nonatomic,copy) void(^searchResultBlock)(NSArray* netResultArray);

@end
