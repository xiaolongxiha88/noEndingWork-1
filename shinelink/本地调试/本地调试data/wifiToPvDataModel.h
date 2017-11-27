//
//  wifiToPvDataModel.h
//  GCDAsyncSocketManagerDemo
//
//  Created by sky on 2017/9/20.
//  Copyright © 2017年 宫城. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^modbusDataBlock)(NSData*);

@interface wifiToPvDataModel : NSObject

@property (nonatomic, strong) NSString* wifiName;

-(NSData*)ModbusCmdData:(NSString*)cmdType RegAdd:(NSString*)regAdd Length:(NSString*)length;

-(NSData*)CmdData:(NSString*)cmdType RegAdd:(NSString*)regAdd Length:(NSString*)length modbusBlock:(modbusDataBlock)modbusBlock;

-(NSData*)getCrc16:(NSData*)data ;

@end
