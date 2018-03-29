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
    float lineRW=1.0;

    float ViewH=H-Per;
    float viewAllH=ViewH-(2.0*lineW);
     float PerKH=(1/22.0)*H;
    float PerViewH=(viewAllH-(PerKH*6.0))/5.0;
    float PerUnit=PerKH+PerViewH;
    
    int Count=0;   //电池格数
    
       UIColor *V0Color=COLOR(0, 169, 17, 1);
    
  
    if (_batValue<15) {
        Count=0;
        V0Color=[UIColor redColor];
    }else{
        if ((_batValue<26) && (_batValue>=15)) {
            Count=1;
        }else if ((_batValue<46) && (_batValue>=26)) {
            Count=2;
        }else if ((_batValue<66) && (_batValue>=46)) {
            Count=3;
        }else if ((_batValue<86) && (_batValue>=66)) {
            Count=4;
        }else if ((_batValue<=100) && (_batValue>=86)) {
            Count=5;
        }
        
        
    }
    
    
    
 
    UIView *V0 = [[UIView alloc] initWithFrame:CGRectMake(0, Per, W, ViewH)];
    V0.layer.borderWidth=lineW;
    V0.layer.borderColor=V0Color.CGColor;
     V0.layer.cornerRadius=lineRW;
    [self addSubview:V0];
    
    float V2W=(2/5.0)*W;
    float V2x=(W-V2W)/2;
    UIView *V2 = [[UIView alloc] initWithFrame:CGRectMake(V2x, Per-PerViewH*0.8, V2W, PerViewH*0.9)];
    V2.layer.borderWidth=lineW;
    V2.layer.borderColor=V0Color.CGColor;
    //V2.layer.cornerRadius=lineRW;
    V2.backgroundColor=V0Color;
    [self addSubview:V2];
    
    for (int i=0; i<Count; i++) {
        UIView *V1 = [[UIView alloc] initWithFrame:CGRectMake(PerKW, ViewH-(PerUnit*0.1)-PerUnit*(i+1), PerView2, PerViewH)];
        V1.backgroundColor=[UIColor greenColor];
     //   V1.layer.borderWidth=lineW;
         //V1.layer.cornerRadius=lineRW;
        V1.layer.borderColor=COLOR(0, 169, 17, 1).CGColor;
        [V0 addSubview:V1];
    }

    
    
}



@end
