//
//  storageHead.h
//  ShinePhone
//
//  Created by sky on 2017/8/17.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface storageHead : UIView<CAAnimationDelegate>

@property (nonatomic, strong) NSMutableDictionary *pcsDataDic;

 @property (nonatomic, assign)  NSInteger animationNumber;


-(void)initUI;

@end
