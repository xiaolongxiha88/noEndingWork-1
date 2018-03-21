//
//  checkTwoView.h
//  ShinePhone
//
//  Created by sky on 2018/1/27.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "RootViewController.h"
#import "YDChart.h"
#import "YDLineChart.h"
#import "YDLineY.h"

typedef void (^OneViewOverBlock)(NSArray*);
typedef void (^TwoViewReadFailedBlock)();

@interface checkTwoView : RootViewController

@property (assign, nonatomic) int charType;    //1故障滤波  //2实时滤波  //3一键诊断


@property (nonatomic, copy) OneViewOverBlock oneViewOverBlock;

@property (nonatomic, copy) TwoViewReadFailedBlock TwoViewReadFailedBlock;
    
-(void)addNotification;


@property (strong, nonatomic) YDLineChart *lineChartYD ;
//@property (strong, nonatomic) YDLineChart *lineChartYDOne ;

@property (strong, nonatomic) YDLineY *YlineChartYD ;
//@property (strong, nonatomic) YDLineY *YlineChartYDOne ;

@property (assign, nonatomic) float waitingTimeFor3;

@end
