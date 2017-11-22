//
//  payResultView.h
//  ShinePhone
//
//  Created by sky on 2017/11/18.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface payResultView : RootViewController

@property(nonatomic,strong)NSString *moneyString;
@property(nonatomic,strong)NSString *noticeString;

@property(nonatomic,assign)BOOL isShowAlert;

-(NSString*)changeResult:(NSString*)result;

@end
