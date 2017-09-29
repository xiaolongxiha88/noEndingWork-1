//
//  UINavigationBar+for11.m
//  ShinePhone
//
//  Created by sky on 2017/9/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "UINavigationBar+for11.h"

@implementation UINavigationBar (for11)


- (void)changBarFor11{
    [super layoutSubviews];
    
    
 //   float statusBarHeight=UI_STATUS_BAR_HEIGHT+UI_NAVIGATION_BAR_HEIGHT;
    //注意导航栏及状态栏高度适配
//    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), statusBarHeight);
//    for (UIView *view in self.subviews) {
//        if([NSStringFromClass([view class]) containsString:@"Background"]) {
//            view.frame = self.bounds;
//        }
//        else if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
//            CGRect frame = view.frame;
//            frame.origin.y = statusBarHeight;
//            frame.size.height = self.bounds.size.height - frame.origin.y;
//            view.frame = frame;
//        }
//    }
    
   
    for (UIView *aView in self.subviews) {
        if ([@[@"_UINavigationBarBackground", @"_UIBarBackground"] containsObject:NSStringFromClass([aView class])]) {
             aView.frame = CGRectMake(0, -CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)+CGRectGetMinY(self.frame));
        }
            
        }
    
}





@end
