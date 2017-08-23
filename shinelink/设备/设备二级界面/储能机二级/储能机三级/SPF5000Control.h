//
//  SPF5000Control.h
//  ShinePhone
//
//  Created by sky on 2017/8/23.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface SPF5000Control : RootViewController
@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSString *CnjSN;
@property (nonatomic, strong) NSString *controlType;     //OSS是2
@property (nonatomic, strong) NSArray *choiceNumArray;
@property (nonatomic, strong) NSString *titleString;

@end
