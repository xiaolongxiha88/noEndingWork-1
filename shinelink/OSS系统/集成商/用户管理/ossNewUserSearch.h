//
//  ossNewUserSearch.h
//  ShinePhone
//
//  Created by sky on 2018/5/22.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface ossNewUserSearch : RootViewController


@property (nonatomic, assign) NSInteger searchType;     //1设备搜索

@property (nonatomic,copy) void(^searchResultBlock)(NSArray* netResultArray);
@property (nonatomic,copy) void(^searchDicBlock)(NSDictionary* netDic);

@property (nonatomic, strong) NSArray *oldSearchValueArray;

@end
