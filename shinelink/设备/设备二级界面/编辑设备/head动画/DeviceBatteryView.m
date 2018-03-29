//
//  DeviceBatteryView.m
//  HQBatteryGauge
//
//  Created by sky on 2018/3/28.
//  Copyright © 2018年 judian. All rights reserved.
//

#import "DeviceBatteryView.h"

@implementation DeviceBatteryView

- (void)initBatteryView0{
    float H=self.frame.size.height;
    float W=self.frame.size.width;
    float Per=(1/6.0)*H;
    
        float PerKW=(1/10.0)*W;
    
    
   
    float PerView2=W-(2.0*PerKW);
    
    float lineW=1.0;
    float lineRW=2.0;

    float ViewH=H-Per;
    float viewAllH=ViewH-(2.0*lineW);
     float PerKH=(1/18.0)*H;
    float PerViewH=(viewAllH-(PerKH*6.0))/5.0;
    float PerUnit=PerKH+PerViewH;
    
    UIView *V0 = [[UIView alloc] initWithFrame:CGRectMake(0, Per, W, ViewH)];
    V0.layer.borderWidth=lineW;
    V0.layer.borderColor=[UIColor greenColor].CGColor;
     V0.layer.cornerRadius=lineRW;
    [self addSubview:V0];
    
    float V2W=(2/5.0)*W;
    float V2x=(W-V2W)/2;
    UIView *V2 = [[UIView alloc] initWithFrame:CGRectMake(V2x, Per-PerViewH*0.8, V2W, PerViewH*0.8)];
    V2.layer.borderWidth=lineW;
    V2.layer.borderColor=[UIColor greenColor].CGColor;
    V2.layer.cornerRadius=lineRW;
    V2.backgroundColor=[UIColor greenColor];
    [self addSubview:V2];
    
    for (int i=0; i<5; i++) {
        UIView *V1 = [[UIView alloc] initWithFrame:CGRectMake(PerKW, ViewH-PerUnit*(i+1), PerView2, PerViewH)];
        V1.backgroundColor=[UIColor greenColor];
        V1.layer.borderWidth=lineW;
          V1.layer.cornerRadius=lineRW;
        V1.layer.borderColor=[UIColor greenColor].CGColor;
        [V0 addSubview:V1];
    }

    
    
}



@end
