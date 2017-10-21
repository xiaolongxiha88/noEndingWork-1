//
//  wifiToPvOne.h
//  GCDAsyncSocketManagerDemo
//
//  Created by sky on 2017/9/20.
//  Copyright © 2017年 宫城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wifiToPvOne : NSObject

typedef void(^receiveDataTwoBlock)(NSData*);

-(void)goToGetData:(NSString*)cmdType RegAdd:(NSString*)regAdd Length:(NSString*)length;

-(void)goToTcpType:(int)type;


@end
