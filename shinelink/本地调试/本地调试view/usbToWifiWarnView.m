//
//  usbToWifiWarnView.m
//  ShinePhone
//
//  Created by sky on 2017/11/1.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiWarnView.h"

@interface usbToWifiWarnView ()

@property(nonatomic,strong)NSString *faultString;
@property(nonatomic,strong)NSString *faultStateString;
@property(nonatomic,strong)NSString *warnString;

@end

@implementation usbToWifiWarnView

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor=COLOR(242, 242, 242, 1);
    _faultString=@""; _faultStateString=@""; _warnString=@"";
    [self getData];
}

-(void)initUI{
    float W1=5*NOW_SIZE; float W0=SCREEN_Width-2*W1;
    float H=150*HEIGHT_SIZE;
    
    NSArray *valueArray=@[_faultString,_warnString];
    NSArray *nameArray=@[[NSString stringWithFormat:@"故障码:%@",_faultCode],[NSString stringWithFormat:@"警告码:%@",_warnCode]];
    
    for (int i=0; i<valueArray.count; i++) {
        UIView *_secondView=[[UIView alloc]initWithFrame:CGRectMake(W1, 5*HEIGHT_SIZE+H*i, W0, H)];
        _secondView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:_secondView];
        
        
        UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(1*NOW_SIZE, 3*HEIGHT_SIZE, 3*NOW_SIZE, 14*HEIGHT_SIZE)];
        V1.backgroundColor=MainColor;
        [_secondView addSubview:V1];
        
        float lableH1=20*HEIGHT_SIZE;
        UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(7*NOW_SIZE, 0,200*NOW_SIZE,lableH1)];
        lable5.textColor =COLOR(51, 51, 51, 1);
        lable5.textAlignment=NSTextAlignmentLeft;
        lable5.text=nameArray[i];
        lable5.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_secondView addSubview:lable5];
        
        UIView *V2=[[UIView alloc]initWithFrame:CGRectMake(0, lableH1+5*HEIGHT_SIZE, SCREEN_Width, 115*HEIGHT_SIZE)];
        V2.backgroundColor=[UIColor whiteColor];
        [_secondView addSubview:V2];
        
        UILabel *lable6 = [[UILabel alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 5*HEIGHT_SIZE,W0-40*NOW_SIZE,100*HEIGHT_SIZE)];
        lable6.textColor =COLOR(102, 102, 102, 1);
        lable6.textAlignment=NSTextAlignmentLeft;
        lable6.text=valueArray[i];
        lable6.numberOfLines=0;
        lable6.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [V2 addSubview:lable6];
    }
 
    
}


-(void)getData{
    int faultInt=[_faultCode intValue];
     int warnInt=[_warnCode intValue];
 
    if (faultInt==101) {
          _faultString=@"1.STM32 doesn't receive data from control board over 10s  2.28075 OR 28067 doesn't receive data from COM board over 5s  3.SPI Connected 28075 and 28067 if fail over 1s";
    }else if (faultInt==102) {
        _faultString=@"冗余采样异常保护，PV采样，正负bus采样，三相AC电压采样，GFCI，ISO采样在 主DSP28075和副DSP28067之间相差太大时报错。";
    }else if (faultInt==108) {
         _faultString=@"主SPS供电异常";
    }else if (faultInt==112) {
        _faultString=@"AFCI弧判断错误 ";
    }else if (faultInt==113) {
        _faultString=@"IGBT驱动错误（驱动电压异常、IGBT短路）";
    }else if (faultInt==114) {
        _faultString=@"AFCI模块检测失败";
    }else if (faultInt==117) {
        _faultString=@"AC侧继电器异常";
    }else if (faultInt==119) {
        _faultString=@"GFCI模块损坏 ";
    }else if (faultInt==121) {
        _faultString=@"CPLD芯片检测异常 ";
    }else if (faultInt==122) {
        _faultString=@"BUS过压或者欠压";
    }else if (faultInt==124) {
        _faultString=@"Grid disconnect or connect unormal";
    }else if (faultInt==125) {
        _faultString=@"PV input insulation impedance too low";
    }else if (faultInt==126) {
        _faultString=@"Leakage current too high.(protect enable when the GFCI module is normal)";
    }else if (faultInt==127) {
        _faultString=@"Output DC current too high ";
    }else if (faultInt==128) {
        _faultString=@"PV voltage over 1000V";
    }else if (faultInt==129) {
        _faultString=@"Grid voltage is outrange ";
    }else if (faultInt==130) {
        _faultString=@"Grid Freq. is outrange";
    }else{
         _faultString=[NSString stringWithFormat:@"Error:%d",faultInt];
    }
    
    
    if (warnInt==100) {
        _warnString=@"fan fail";
    }else if (warnInt==106) {
        _warnString=@"防雷器发生故障";
    }else if (warnInt==107) {
        _warnString=@"NE检测异常，N线、地线之间压差过大";
    }else if (warnInt==108) {
        _warnString=@"PV1至PV6 短路异常 ";
    }else if (warnInt==109) {
        _warnString=@"PV1至PV6 boost驱动异常";
    }else if (warnInt==110) {
        _warnString=@"12路组串中有组串出现反接或短路 ";
    }else if (warnInt==111) {
        _warnString=@"U盘过流保护 ";
    }else{
        _warnString=[NSString stringWithFormat:@"Warning:%d",warnInt];
    }
      
    [self initUI];
    
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
