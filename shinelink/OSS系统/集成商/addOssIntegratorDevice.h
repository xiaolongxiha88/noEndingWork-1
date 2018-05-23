//
//  addOssIntegratorDevice.h
//  ShinePhone
//
//  Created by sky on 2018/5/7.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface addOssIntegratorDevice : RootViewController

@property (nonatomic, assign)float deviceType;

@property (nonatomic, assign)NSInteger cmdType;

@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong) NSString *serverID;

@property (nonatomic,copy) void(^addSuccessBlock)();

@end
