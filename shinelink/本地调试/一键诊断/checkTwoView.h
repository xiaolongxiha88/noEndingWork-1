//
//  checkTwoView.h
//  ShinePhone
//
//  Created by sky on 2018/1/27.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "RootViewController.h"

typedef void (^OneViewOverBlock)(void);

@interface checkTwoView : RootViewController

@property (assign, nonatomic) int charType;    //1故障滤波  //2实时滤波  //3一键诊断


@property (nonatomic, copy) OneViewOverBlock oneViewOverBlock;

-(void)addNotification;

@end
