//
//  parameterCNJ.h
//  shinelink
//
//  Created by sky on 16/3/31.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface parameterCNJ : RootViewController
@property (nonatomic, strong) NSString *deviceSN;
@property (nonatomic, strong) NSString *normalPower;
@property (nonatomic, strong) NSMutableDictionary *params2Dict;
@property (nonatomic, strong) NSString *storageType;

@property (nonatomic, strong) NSString *typeNum;   //0、储能机     1、SPF5000   2、Mix

@property (nonatomic, strong) NSString *actAndapparentString;

@end
