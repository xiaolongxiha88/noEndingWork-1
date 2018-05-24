//
//  deviceViewController.h
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Kwidth [UIScreen mainScreen].bounds.size.width

@interface deviceViewController : RootViewController

- (instancetype)initWithDataDict:(NSMutableArray *)stationID stationName:(NSMutableArray *)stationName;
@property (nonatomic, strong) NSString *adNumber;

@property (nonatomic, strong) NSMutableArray *pvHeadDataArray;
@property (nonatomic, strong) NSMutableArray *pvHeadDataUnitArray;
@property (nonatomic, strong) NSMutableArray *pvHeadNameArray;

@property (nonatomic, strong) NSMutableArray *stationID;
@property (nonatomic, strong) NSMutableArray *stationName;

@property (nonatomic, assign) NSInteger LogOssNum;    //1设备页 2、用户管理  3、电站管理

@property (nonatomic, assign) NSInteger LogTypeForOSS; 
@end
