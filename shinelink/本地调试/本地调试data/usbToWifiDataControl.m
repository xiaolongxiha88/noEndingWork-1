//
//  usbToWifiDataControl.m
//  ShinePhone
//
//  Created by sky on 2017/10/20.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiDataControl.h"
#import "wifiToPvOne.h"


@interface usbToWifiDataControl ()
@property(nonatomic,strong)wifiToPvOne*ControlOne;
@property(nonatomic,strong)NSMutableDictionary*receiveDic;
@end

@implementation usbToWifiDataControl

- (void)viewDidLoad {
    [super viewDidLoad];   
}


-(void)getDataAll:(int)type receiveDataBlock:(receiveDataBlock)receiveDataBlock{
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
         _receiveDic=[NSMutableDictionary new];
    }
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFirstData:) name: @"TcpReceiveData" object:nil];
    
    
    [_ControlOne goToTcpType:1];
    
  
}


-(void)receiveFirstData:(NSNotification*) notification{
    
    _receiveDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];

    NSLog(@"receive TCP AllData=%@",_receiveDic);
    
    NSData *dataValue=[_receiveDic objectForKey:@"one"];
    [self getFirstViewValue:dataValue];
}

-(void)getFirstViewValue:(NSData*)data{
    int value8=[self changeOneRegister:data registerNum:8];
    int value6_7=[self changeTwoRegister:data registerNum:6];
    NSString *versionString=[self changeToASCII:data beginRegister:34 length:8];
    NSLog(@"receive versionStringa=%@",versionString);
    
    
}


//获取一个寄存器值
-(int)changeOneRegister:(NSData*)data registerNum:(int)registerNum{
     Byte *dataArray=(Byte*)[data bytes];
        int registerValue=(dataArray[2*registerNum]<<8)+dataArray[2*registerNum+1];
    
    return registerValue;
}

//获取高低寄存器值
-(int)changeTwoRegister:(NSData*)data registerNum:(int)registerNum{
    Byte *dataArray=(Byte*)[data bytes];
         int registerValue=(dataArray[2*registerNum]<<24)+(dataArray[2*registerNum+1]<<16)+(dataArray[2*registerNum+2]<<8)+dataArray[2*registerNum+3];

    return registerValue;
}


//获取字符串寄存器值
-(NSString*)changeToASCII:(NSData*)data beginRegister:(int)beginRegister length:(int)length{
    NSString*getString;

      NSData *data1=[data subdataWithRange:NSMakeRange(beginRegister*2, length*2)];
    getString=[[NSString alloc]initWithData:data1 encoding:NSASCIIStringEncoding];
    
    return getString;
}


-(void)receiveData:(receiveDataBlock)receiveDataBlock{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
