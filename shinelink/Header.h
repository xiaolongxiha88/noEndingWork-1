//
//  Header.h
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import "UserInfo.h"
#import "BaseRequest.h"
#import "MBProgressHUD.h"
#import "RootViewController.h"
#import "CoreDataManager.h"

#define ManagerObjectModelFileName @"deviceCore" //数据库名字

#define IMAGE(_NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:_NAME]]
#define COLOR(_R,_G,_B,_A) [UIColor colorWithRed:_R / 255.0f green:_G / 255.0f blue:_B / 255.0f alpha:_A]
#define NOW_SIZE [UIScreen mainScreen].bounds.size.width/320
#define HEIGHT_SIZE [UIScreen mainScreen].bounds.size.height/560

#define NavigationbarHeight  self.navigationController.navigationBar.frame.size.height

#define MainColor COLOR(17, 183, 243, 1)
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define colorGary COLOR(212, 212, 212, 1)
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
#define kiPhone6 ([UIScreen mainScreen].bounds.size.width==375)
#define frameMake(a,b,c,d) CGRectMake(a*NOW_SIZE,b*NOW_SIZE,c*NOW_SIZE,d*NOW_SIZE)
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define KNOTIFICATION_LOGINCHANGE                      @"loginStateChange"

 #define Demo_Name  @"guest"
 #define Demo_password  @"123456"

 //#define HEAD_URL_Demo  @"http://test.growatt.com"
#define HEAD_URL_Demo  @"http://server.growatt.com"


#define HEAD_URL  [UserInfo defaultUserInfo].server
//#define HEAD_URL  @"http://192.168.3.32:8080/ShineServer_2016"



//#define HEAD_URL  @"http://192.168.3.32:8081/ShineServer"
//#define HEAD_URL  @"http://server-cn.growatt.com"
//#define HEAD_URL  @"http://192.168.3.98:8081/ShineServer_2016"

#define mainColor [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1]



#endif /* Header_h */
