//
//  AppDelegate.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "AppDelegate.h"

#import "findViewController.h"
#import "energyViewController.h"
#import "deviceViewController.h"
#import "meViewController.h"
#import "loginViewController.h"
#import "countryViewController.h"
#import "LZQStratViewController_25.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CommonCrypto/CommonDigest.h>
#import "JDStatusBarNotification.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import "listViewController.h"
#import "MessageCeterTableViewController.h"
#import "meViewController.h"
#import "LZPageViewController.h"
#import "energyDemo.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSString *devicetToken;
@property (nonatomic, strong) NSMutableDictionary *messegeDic;
@end

@implementation AppDelegate

//-(void)applicationWillEnterForeground:(UIApplication *)application{
//
//
//    
//}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
      [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:NO];
    
       self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
   
    NSUserDefaults *picName1=[NSUserDefaults standardUserDefaults];
    NSString *picName=[picName1 objectForKey:@"firstPic"];
    
    if ([picName length]==0) {
             [[UserInfo defaultUserInfo]setFirstPic:@"OK"];
        LZQStratViewController_25 *lzqStartViewController = [[LZQStratViewController_25 alloc] init];
      
        self.window.rootViewController = lzqStartViewController;
   
    }else{
    
    loginViewController *root=[[loginViewController alloc]init];
    


    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:root];//先将root添加在navigation上
  
    self.window.rootViewController=nav;
    }
    
     [self.window makeKeyAndVisible];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //网络状态
    self.reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    [_reach startNotifier];
    
    
    //极光推送
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    //Required
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    
    
    return YES;
}

//当网络状态改变时回调
- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (status == NotReachable) {
        [JDStatusBarNotification showWithStatus:@"No Internet Connection!" dismissAfter:2.0 styleName:JDStatusBarStyleWarning];
    }
}

-(NSString *)getWifiName
{
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            //            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    CFRelease(wifiInterfaces);
    return wifiName;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
   NSLog(@"\n ===> 程序进入前台 !");
    [self netRequest];
    
}


//获取deviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    _devicetToken=[NSString stringWithFormat:@"%@",deviceToken];
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

//获取推送内容
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
   
    NSDateFormatter *format=[[ NSDateFormatter alloc]init];
     _messegeDic=[NSMutableDictionary new];
    
    if ([userInfo[@"type"] intValue]==0) {
        format. dateFormat = @"yyyy-MM-dd hh:mm:ss" ;
        NSDate *date1=[ NSDate date ];
        NSString *date=[format stringFromDate:date1];
        
        
        [_messegeDic setValue:userInfo[@"content"] forKeyPath:@"content"];
        [_messegeDic setValue:userInfo[@"title"] forKeyPath:@"title"];
        [_messegeDic setValue:date forKeyPath:@"time"];
        
         NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
          [userDefaultes setObject:_messegeDic forKey:@"MessageDic"];
        
//        MessageCeterTableViewController *center=[[MessageCeterTableViewController alloc]init];
//        center.messageDic=_messegeDic;
//        
//        loginViewController *root=[[loginViewController alloc]init];
//        
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:root];//先将root添加在navigation上
//        self.window.rootViewController=nav;
//        
//        
//        [nav pushViewController:center animated:NO];
        
    }else if ([userInfo[@"type"] intValue]==1){
    
//        loginViewController *root=[[loginViewController alloc]init];
//        
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:root];//先将root添加在navigation上
//             self.window.rootViewController=nav;
//        listViewController *list=[[listViewController alloc]init];
//    
//        [self.window.rootViewController presentViewController:list animated:NO completion:nil];
   
       
    }
    
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "YD.shinelink" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"shinelink" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"shinelink.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


-(void)netRequest{
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *reUsername=[ud objectForKey:@"userName"];
    NSString *rePassword=[ud objectForKey:@"userPassword"];
    
     if (!(reUsername==nil || reUsername==NULL||([reUsername isEqual:@""] ))){

    [BaseRequest requestWithMethod:HEAD_URL paramars:@{@"userName":reUsername, @"password":[self MD5:rePassword]} paramarsSite:@"/newLoginAPI.do" sucessBlock:^(id content) {
        
        NSLog(@"loginIn:%@",content);
        if (content) {
            if ([content[@"success"] integerValue] == 0) {
                //登陆失败
                if ([content[@"msg"] integerValue] == 501) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"User name or password is blank" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
                    [alertView show];
                }
                if ([content[@"msg"] integerValue] ==502) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"username password error" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
                    [alertView show];
                }
                if ([content[@"msg"] integerValue] ==503) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"server error" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
                    [alertView show];
                }
            }            
            
        }
        
    } failure:^(NSError *error) {
        
        
         }];
     }
}

- (NSString *)MD5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        NSString *tStr = [NSString stringWithFormat:@"%x", digest[i]];
        if (tStr.length == 1) {
            [result appendString:@"c"];
        }
        [result appendFormat:@"%@", tStr];
    }
    return result;
}


@end
