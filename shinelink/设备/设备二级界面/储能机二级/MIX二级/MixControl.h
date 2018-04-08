//
//  MixControl.h
//  ShinePhone
//
//  Created by sky on 2017/11/17.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface MixControl : RootViewController
@property (nonatomic, assign) int setType;
@property (nonatomic, strong) NSString *CnjSN;
@property (nonatomic, strong) NSString *controlType;     //OSS是2
@property (nonatomic, strong) NSArray *choiceNumArray;
@property (nonatomic, strong) NSString *titleString;

@property (nonatomic, strong) NSDictionary *getOldDic;

@end
