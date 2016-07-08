//
//  loginViewController.h
//  shinelink
//
//  Created by sky on 16/2/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : RootViewController<UITextFieldDelegate,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabbar;
@end
