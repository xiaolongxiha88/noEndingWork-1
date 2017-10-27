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

//获取一个寄存器值
-(int)changeOneRegister:(NSData*)data registerNum:(int)registerNum;


//获取高低寄存器值
-(int)changeTwoRegister:(NSData*)data registerNum:(int)registerNum;
    

//获取字符串寄存器值
-(NSString*)changeToASCII:(NSData*)data beginRegister:(int)beginRegister length:(int)length;

@end
