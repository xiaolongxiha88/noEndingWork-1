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

@property (nonatomic, strong) NSString *oldName;
@property (nonatomic, strong) NSString *oldPassword;

@property (nonatomic, strong) NSString *LogType;

@property (nonatomic, strong) NSString *demoName;
@property (nonatomic, strong) NSString *demoPassword;

@property (nonatomic, strong) NSString *demoServerURL;

@property (nonatomic, assign) NSInteger LogTypeForOSS;   //1就是模拟登陆
@property (nonatomic,assign) BOOL isFirstLogin;

@property (nonatomic, assign) NSInteger LogOssNum;   //1设备页 2、用户管理  3、电站管理
@property (nonatomic, assign) NSString *demoPlantID;  

@end
