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
