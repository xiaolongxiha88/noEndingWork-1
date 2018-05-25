//
//  ossNewDeviceControl.h
//  ShinePhone
//
//  Created by sky on 2018/5/21.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface ossNewDeviceControl : RootViewController

@property (nonatomic, assign) NSInteger deviceType;

@property (nonatomic, strong) NSString* deviceSn;

@property (nonatomic, strong) NSString* serverID;

@property (nonatomic, strong) NSString* userName;

@property (nonatomic,copy) void(^delectSuccessBlock)();

@end


