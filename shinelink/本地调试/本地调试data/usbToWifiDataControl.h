//
//  usbToWifiDataControl.h
//  ShinePhone
//
//  Created by sky on 2017/10/20.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface usbToWifiDataControl : RootViewController

typedef void(^receiveDataBlock)(NSDictionary*);

-(void)getDataAll:(int)type;

@end
