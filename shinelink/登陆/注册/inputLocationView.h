//
//  inputLocationView.h
//  ShinePhone
//
//  Created by sky on 2018/4/9.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "RootViewController.h"

typedef void (^locationArrayBlock)(NSArray*);


@interface inputLocationView : RootViewController

@property (nonatomic, copy) locationArrayBlock locationArrayBlock;

@end
