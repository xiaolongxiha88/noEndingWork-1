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
    
    NSArray *valueArray=@[_faultString,_faultStateString,_warnString];
    NSArray *nameArray=@[[NSString stringWithFormat:@"故障码:%@",_faultCode],[NSString stringWithFormat:@"具体故障:%@",_faultStatueCode],[NSString stringWithFormat:@"警告码:%@",_warnCode]];
    
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
        
        UILabel *lable6 = [[UILabel alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 15*HEIGHT_SIZE,W0-40*NOW_SIZE,lableH1)];
        lable6.textColor =COLOR(102, 102, 102, 1);
        lable6.textAlignment=NSTextAlignmentLeft;
        lable6.text=valueArray[i];
        lable6.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [V2 addSubview:lable6];
    }
 
    
}


-(void)getData{
    int faultInt=[_faultCode intValue];
     int warnInt=[_warnCode intValue];
    NSArray *nameArray=@[@"Auto Test Failed",@"No AC Connection",@"PV Isolation Low",@"Residual I High",@"Output High DCI",@"PV Voltage High",@"AC V Outrange",@"AC F Outrange",@"Module Hot"];
    if (faultInt>0&&faultInt<24) {
        _faultString=[NSString stringWithFormat:@"Error:%d",faultInt+99];
    }else if (faultInt>23&&faultInt<33) {
        _faultString=nameArray[faultInt-24];
    }
    
    if (warnInt==0x0001) {
        _warnString=@"Fan warning";
    }else if (warnInt==0x0002) {
        _warnString=@"String communication abnormal";
    }else if (warnInt==0x0004) {
        _warnString=@"StrPID config Warning";
    }else if (warnInt==0x0010) {
        _warnString=@"DSP and COM firmware unmatch";
    }else if (warnInt==0x0040) {
        _warnString=@"SPD abnormal";
    }else if (warnInt==0x0080) {
        _warnString=@"GND and N connect abnormal";
    }else if (warnInt==0x0100) {
        _warnString=@"PV1 or PV2 circuit short";
    }else if (warnInt==0x0200) {
        _warnString=@"PV1 or PV2 boost driver broken";
    }
    
    long faultStatueLong=[_faultStatueCode integerValue];
    if (faultStatueLong==0x00000002) {
        _faultStateString=@"Communication error";
    }else if (faultStatueLong==0x00000008) {
        _faultStateString=@"StrReverse or StrShort fault";
    }else if (faultStatueLong==0x00000010) {
        _faultStateString=@"Model Init fault";
    }else if (faultStatueLong==0x00000020) {
        _faultStateString=@"Grid Volt Sample diffirent";
    }else if (faultStatueLong==0x00000040) {
        _faultStateString=@"ISO Sample diffirent";
    }else if (faultStatueLong==0x00000080) {
        _faultStateString=@"GFCI Sample diffirent";
    }else if (faultStatueLong==0x00001000) {
        _faultStateString=@"AFCI Fault";
    }else if (faultStatueLong==0x00004000) {
        _faultStateString=@"AFCI Module fault";
    }else if (faultStatueLong==0x00020000) {
        _faultStateString=@"Relay check fault";
    }else if (faultStatueLong==0x00200000) {
        _faultStateString=@"Communication error";
    }else if (faultStatueLong==0x00400000) {
        _faultStateString=@"Bus Voltage error";
    }else if (faultStatueLong==0x00800000) {
        _faultStateString=@"AutoTest fail";
    }else if (faultStatueLong==0x01000000) {
        _faultStateString=@"No Utility";
    }else if (faultStatueLong==0x02000000) {
        _faultStateString=@"PV Isolation Low";
    }else if (faultStatueLong==0x04000000) {
        _faultStateString=@"Residual I High";
    }else if (faultStatueLong==0x08000000) {
        _faultStateString=@"Output High DCI";
    }else if (faultStatueLong==0x10000000) {
        _faultStateString=@"PV Voltage high";
    }else if (faultStatueLong==0x20000000) {
        _faultStateString=@"AC V Outrange";
    }else if (faultStatueLong==0x40000000) {
        _faultStateString=@"AC F Outrange";
    }else if (faultStatueLong==0x80000000) {
        _faultStateString=@"TempratureHigh";
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
