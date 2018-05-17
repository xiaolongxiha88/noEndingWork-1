//
//  ossNewDeviceList.h
//  ShinePhone
//
//  Created by sky on 2018/4/26.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface ossNewDeviceList : RootViewController

@property (nonatomic, strong) NSDictionary *netDic;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger deviceStatusType;
@property (nonatomic, assign) NSInteger deviceType;      //1、逆变器  2、储能机   3、mix
@property (nonatomic, strong) NSDictionary *parameterDic;

@end


