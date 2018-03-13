//
//  checkOneView.h
//  ShinePhone
//
//  Created by sky on 2018/1/27.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "RootViewController.h"

typedef void (^OneViewOverBlock)(NSArray*);

@interface checkOneView : RootViewController

@property (assign, nonatomic) int oneCharType;     //1 I-V曲线检测    2 一键诊断

@property (nonatomic, copy) OneViewOverBlock oneViewOverBlock;

@property (assign, nonatomic) float waitingTimeFor3;

-(void)addNotification;

@end
