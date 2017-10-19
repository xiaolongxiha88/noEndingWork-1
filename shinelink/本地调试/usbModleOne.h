//
//  usbModleOne.h
//  ShinePhone
//
//  Created by sky on 2017/10/19.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface usbModleOne : NSObject

@property(nonatomic, assign) BOOL isShowMoreText;

@property(nonatomic, strong) usbModleOne *model;

-(instancetype)initWithDict;

@end
