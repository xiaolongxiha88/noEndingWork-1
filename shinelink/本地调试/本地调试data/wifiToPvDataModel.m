//
//  wifiToPvDataModel.m
//  GCDAsyncSocketManagerDemo
//
//  Created by sky on 2017/9/20.
//  Copyright © 2017年 宫城. All rights reserved.
//

#import "wifiToPvDataModel.h"
#import <SystemConfiguration/CaptiveNetwork.h> 




@implementation wifiToPvDataModel


-(NSData*)CmdData:(NSString*)cmdType RegAdd:(NSString*)regAdd Length:(NSString*)length modbusBlock:(modbusDataBlock)modbusBlock{
    NSData*modbusData=[self ModbusCmdData:cmdType RegAdd:regAdd Length:length];
    NSData*tcpData=[self tcpCmdData:modbusData];
    modbusBlock(modbusData);
    return tcpData;
}

-(NSData*)ModbusCmdData:(NSString*)cmdType RegAdd:(NSString*)regAdd Length:(NSString*)length{
   Byte target[] = {0x01, 0x03, 0x00, 0x2b, 0x00, 0x01,0x00,0x00};
 
 //  unsigned int regAddInt=strtoul([regAdd UTF8String],0,16);
  //  unsigned int lengthInt=strtoul([length UTF8String],0,16);
    
      unsigned int cmdTypeInt=[cmdType intValue];
    unsigned int regAddInt=[regAdd intValue];
    unsigned int lengthInt=[length intValue];
       target[1]=(cmdTypeInt & 0x00ff);
    target[2]=(regAddInt & 0xff00)>>8;
     target[3]=(regAddInt & 0x00ff);
    target[4]=(lengthInt & 0xff00)>>8;
    target[5]=(lengthInt & 0x00ff);
    
    NSData *targetData=[[NSData alloc] initWithBytes:target length:6];
    NSData *CRC=[self getCrc16:targetData];
    Byte *CRCArray=(Byte*)[CRC bytes];
    target[6]=CRCArray[0];
      target[7]=CRCArray[1];
  
     NSData *cmdData=[[NSData alloc]initWithBytes:target length:sizeof(target)];
    return cmdData;
}


-(NSData*)tcpCmdData:(NSData*)mobbusData{
    unsigned long modbusLength=[mobbusData length];
    unsigned long dataLength=modbusLength+14;
    unsigned long allLength=dataLength+6;
    Byte tcpArray[allLength];
    if ((_wifiName==nil)||([_wifiName isEqualToString:@""])) {
        _wifiName=[self getWifiName];
    }
    
    int dataLength1=(dataLength & 0xff00)>>8;
    int dataLength2=(dataLength & 0x00ff);
    
    Byte headData[] = {0x00, 0x01, 0x00, 0x03, dataLength1, dataLength2,0x01,0x17};
    for (int i=0; i<sizeof(headData); i++) {
        tcpArray[i]=headData[i];
    }
    NSString *demoString=@"0000000000";
    for (int i=0; i<demoString.length; i++) {
        tcpArray[8+i]=[demoString characterAtIndex:i];
    }
    
//    for (int i=0; i<wifiName.length; i++) {
//        tcpArray[8+i]=[wifiName characterAtIndex:i];
//    }
    
    tcpArray[18]=(modbusLength & 0xff00)>>8;
      tcpArray[19]=(modbusLength & 0x00ff);
    
    Byte *modbusByte=(Byte*)[mobbusData bytes];
    
    for (int i=0; i<modbusLength; i++) {
        tcpArray[20+i]=modbusByte[i];
    }
    
    NSData *cmdTcpData=[[NSData alloc]initWithBytes:tcpArray length:sizeof(tcpArray)];
    return cmdTcpData;
}



- (NSString *)getWifiName
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
            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
    
}



-(NSData*)getCrc16:(NSData*)data {
    int crcWord = 0x0000ffff;
    Byte *dataArray=(Byte*)[data bytes];
    for (int i=0; i <data.length; i++) {
        Byte byte=dataArray[i];
        crcWord ^=(int)byte & 0x000000ff;
        for (int j=0; j<8; j++) {
            if ((crcWord & 0x00000001)==1) {
                crcWord=crcWord>>1;
                crcWord=crcWord^0x0000A001;
            }else{
                crcWord=(crcWord>>1);
            }
        }
    }
    Byte crcH =(Byte)0xff&(crcWord>>8);
    Byte crcL=(Byte)0xff&crcWord;
    Byte arraycrc[]={crcL,crcH};
    NSData *datacrc=[[NSData alloc]initWithBytes:arraycrc length:sizeof(arraycrc)];
    return datacrc;
}


- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}



@end
