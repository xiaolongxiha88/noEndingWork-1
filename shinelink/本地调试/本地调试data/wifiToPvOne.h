//
//  wifiToPvOne.h
//  GCDAsyncSocketManagerDemo
//
//  Created by sky on 2017/9/20.
//  Copyright © 2017年 宫城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"

@interface wifiToPvOne : NSObject

typedef void(^receiveDataTwoBlock)(NSData*);


@property (nonatomic, strong) GCDAsyncSocket *socket;

-(void)goToTcpType:(int)type;

-(void)goToOneTcp:(int)type cmdNum:(int)cmdNum cmdType:(NSString*)cmdType regAdd:(NSString*)regAdd Length:(NSString*)Length;

-(void)disConnect;

@end
