//
//  MixHead.h
//  ShinePhone
//
//  Created by sky on 2017/11/10.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MixHead : UIView<CAAnimationDelegate>

-(void)initUI;

@property (nonatomic, assign)  BOOL isBatToRight;
@property (nonatomic, assign)  BOOL isGridToUp;

@end
