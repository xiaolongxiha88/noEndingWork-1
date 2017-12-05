//
//  usbToWifiWarnList.m
//  ShinePhone
//
//  Created by sky on 2017/12/4.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiWarnList.h"

@interface usbToWifiWarnList ()


@end

@implementation usbToWifiWarnList

- (void)viewDidLoad {
    [super viewDidLoad];
  
}



-(void)getData:(int)faultInt{
    NSString *faultString;
    if (faultInt==1) {
        faultString=@"M3 Receive Main DSP SCI abnormal";
    }else if (faultInt==2) {
        faultString=@"M3 Receive Slave DSP SCI abnormal";
    }else if (faultInt==3) {
        faultString=@"Main DSP Receive M3 SCI abnormal";
    }else if (faultInt==4) {
        faultString=@"Slave DSP Receive M3 SCI abnormal";
    }else if (faultInt==5) {
        faultString=@"Main DSP Receive SPI abnormal";
    }else if (faultInt==6) {
        faultString=@"Slave DSP Receive SPI abnormal";
    }else if (faultInt==9) {
        faultString=@"SPS power fault";
    }else if (faultInt==13) {
        faultString=@"AFCI Fault";
    }else if (faultInt==14) {
        faultString=@"IGBT drive fault";
    }else if (faultInt==15) {
        faultString=@"AFCI Module check fail";
    }else if (faultInt==18) {
        faultString=@"Relay fault";
    }else if (faultInt==22) {
        faultString=@"CPLD abnormal";
    }else if (faultInt==23) {
        faultString=@"Main DSP Bus abnormal";
    }else if (faultInt==24) {
        faultString=@"Slave DSP Bus abnormal";
    }else if (faultInt==25) {
        faultString=@"No AC Connection";
    }else if (faultInt==26) {
        faultString=@"PV Isolation Low";
    }else if (faultInt==27) {
        faultString=@"Leakage current too high";
    }else if (faultInt==28) {
        faultString=@"Output DC current too high";
    }else if (faultInt==29) {
        faultString=@"PV voltage too high";
    }else if (faultInt==30) {
        faultString=@"Grid voltage fault";
    }else if (faultInt==31) {
        faultString=@"Grid frequency fault";
    }else if (faultInt==33) {
        faultString=@"BUS Sample and PV sample inconsistent";
    }else if (faultInt==34) {
        faultString=@"GFCI Sample inconsistent";
    }else if (faultInt==35) {
        faultString=@"ISO Sample inconsistent";
    }else if (faultInt==36) {
        faultString=@"BUS Sample inconsistent";
    }else if (faultInt==37) {
        faultString=@"Grid Sample inconsistent";
    }else{
        faultString=[NSString stringWithFormat:@"Error:%d",faultInt];
    }
    
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
