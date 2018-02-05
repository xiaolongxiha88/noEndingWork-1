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

//获取一个寄存器高8位的值
-(int)changeHighRegister:(NSData*)data registerNum:(int)registerNum;

//获取一个寄存器低8位的值
-(int)changeLowRegister:(NSData*)data registerNum:(int)registerNum;

-(void)removeTheTcp;

@property(nonatomic,assign)NSInteger cmdType;            //1、



@end
