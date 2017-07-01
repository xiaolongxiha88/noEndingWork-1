//
//  Model.m
//  ShowMoreText
//
//  Created by yaoshuai on 2017/1/20.
//  Copyright © 2017年 ys. All rights reserved.
//

#import "Model.h"

@implementation Model

- (instancetype)initWithDict:(NSString *)titleName
{
    if (self = [super init])
    {
        self.title = titleName;

        self.isShowMoreText = NO;
    }
    return self;
}

@end
