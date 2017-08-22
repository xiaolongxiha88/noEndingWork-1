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

@property (nonatomic, strong) NSString *head11;
@property (nonatomic, strong) NSString *head12;
@property (nonatomic, strong) NSString *head13;
@property (nonatomic, strong) NSString *head21;
@property (nonatomic, strong) NSString *head22;
@property (nonatomic, strong) NSString *head23;
@property (nonatomic, strong) NSString *head31;
@property (nonatomic, strong) NSString *head32;
@property (nonatomic, strong) NSString *head33;

@end
