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

@end
