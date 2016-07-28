//
//  EquitGraph2ViewController.h
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface EquitGraph2ViewController : RootViewController
@property (nonatomic, strong) NSString *stationId;
@property (nonatomic, strong) NSString *equipId;
@property (nonatomic, strong) NSDictionary *dictInfo;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSDictionary *dictMonth;
@property (nonatomic, strong) NSDictionary *dictYear;
@property (nonatomic, strong) NSDictionary *dictAll;
@property (nonatomic, strong) NSMutableArray *valueArray;
@property (nonatomic, strong) NSMutableArray *valueName;
@property (nonatomic, strong) NSString *dicType;
@property (nonatomic, strong) NSString *plantID;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *familyEnable;
@end
