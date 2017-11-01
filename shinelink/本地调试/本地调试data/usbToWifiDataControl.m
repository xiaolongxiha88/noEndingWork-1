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
@property(nonatomic,strong)NSData*data03;
@property(nonatomic,strong)NSData*data04_1;
@property(nonatomic,strong)NSData*data04_2;

@end

@implementation usbToWifiDataControl

- (void)viewDidLoad {
    [super viewDidLoad];   
}


-(void)getDataAll:(int)type{
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
         _receiveDic=[NSMutableDictionary new];
          [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFirstData:) name: @"TcpReceiveData" object:nil];
    }
    
    
    
    
    [_ControlOne goToTcpType:type];
    
  
}


-(void)receiveFirstData:(NSNotification*) notification{
    
    NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];

    NSLog(@"receive TCP AllData=%@",firstDic);
    
    _receiveDic=[NSMutableDictionary new];
    _data03=[firstDic objectForKey:@"one"];
    _data04_1=[firstDic objectForKey:@"two"];
     _data04_2=[firstDic objectForKey:@"three"];
    
    [self getFirstViewValue];
}

-(void)getFirstViewValue{
 
    int titleState=(int)[self changeOneRegister:_data04_1 registerNum:0];
    NSArray *titleArray=@[@"Waiting",@"Normal",@"Upgrade",@"Fault"];
    NSString *titleString=titleArray[titleState];
     [_receiveDic setObject:titleString forKey:@"titleView"];
    
        long faultState=(long)[self changeTwoRegister:_data04_1 registerNum:106];
      [_receiveDic setObject:[NSString stringWithFormat:@"%ld",faultState] forKey:@"faultStateView"];
    
    float EacToday=[self changeTwoRegister:_data04_1 registerNum:53];
    float EacTotal=[self changeTwoRegister:_data04_1 registerNum:55];
    float EacputPower=[self changeTwoRegister:_data04_1 registerNum:35];
     float NormalPowerValue=[self changeTwoRegister:_data03 registerNum:6];
      float faultCode=[self changeOneRegister:_data04_1 registerNum:105];
      float warnCode=[self changeTwoRegister:_data04_1 registerNum:110];
    
  //  EacToday=20011;warnCode=2777;
    NSArray *oneViewArray=@[[NSString stringWithFormat:@"%.1fkWh",EacToday/10],[NSString stringWithFormat:@"%.1fkWh",EacTotal/10],[NSString stringWithFormat:@"%.1fW",EacputPower/10],[NSString stringWithFormat:@"%.1fW",NormalPowerValue/10],[NSString stringWithFormat:@"%.f",faultCode],[NSString stringWithFormat:@"%.f",warnCode]];
    
    [_receiveDic setObject:oneViewArray forKey:@"oneView"];
    
    [self getSecondViewValue];
}


-(void)getSecondViewValue{
    NSMutableArray *voltArray=[NSMutableArray new];
    NSMutableArray *currArray=[NSMutableArray new];
     NSMutableArray *eactTodayArray=[NSMutableArray new];
    NSMutableArray *eacTotalArray=[NSMutableArray new];
    
    for (int i=0; i<8; i++) {
       int K=3+4*i;
            float volt=[self changeOneRegister:_data04_1 registerNum:K];
          float curr=[self changeOneRegister:_data04_1 registerNum:K+1];
        [voltArray addObject:[NSString stringWithFormat:@"%.1f",volt/10]];
           [currArray addObject:[NSString stringWithFormat:@"%.1f",curr/10]];
        
           int T=59+4*i;   int T1=61+4*i;
         float eacToday=[self changeTwoRegister:_data04_1 registerNum:T];
         float eacTotal=[self changeTwoRegister:_data04_1 registerNum:T1];
        
        [eactTodayArray addObject:[NSString stringWithFormat:@"%.1f",eacToday/10]];
        [eacTotalArray addObject:[NSString stringWithFormat:@"%.1f",eacTotal/10]];
        
    }
    
    NSArray *ViewArray=@[voltArray,currArray,eactTodayArray,eacTotalArray];
    
    
    

    ///////////////////////// 2-2
    NSMutableArray *chuanVoltArray=[NSMutableArray new];
    NSMutableArray *chuanCurrArray=[NSMutableArray new];
    for (int i=0; i<16; i++) {
        int K=142-125+2*i;
        float volt=[self changeOneRegister:_data04_2 registerNum:K];
        [chuanVoltArray addObject:[NSString stringWithFormat:@"%.1f",volt/10]];
        
        float curr=[self changeOneRegister:_data04_2 registerNum:K+1];
        
        if (curr<32768) {
            [chuanCurrArray addObject:[NSString stringWithFormat:@"%.1f",curr/10]];
        }else{
            curr=65535-curr+1;
            [chuanCurrArray addObject:[NSString stringWithFormat:@"-%.1f",curr/10]];
        }
        
    }
    NSArray *ViewArray2=@[chuanVoltArray,chuanCurrArray];

    
    ///////////////////////// 2-3
    NSMutableArray *AcVoltArray=[NSMutableArray new];
    NSMutableArray *AcCurrArray=[NSMutableArray new];
    
     for (int i=0; i<3; i++) {
           int K=38+4*i;
               float volt=[self changeOneRegister:_data04_1 registerNum:K];
           float curr=[self changeOneRegister:_data04_1 registerNum:K];
           [AcVoltArray addObject:[NSString stringWithFormat:@"%.1f",volt/10]];
           [AcCurrArray addObject:[NSString stringWithFormat:@"%.1f",curr/10]];
    }
    
     for (int i=0; i<3; i++) {
            int K=50+i;
             float volt=[self changeOneRegister:_data04_1 registerNum:K];
         [AcVoltArray addObject:[NSString stringWithFormat:@"%.1f",volt/10]];
         [AcCurrArray addObject:[NSString stringWithFormat:@""]];
    }
    NSArray *ViewArray3=@[AcVoltArray,AcCurrArray];
  
    
    ///////////////////////// 2-4
    NSMutableArray *PIDvoltArray=[NSMutableArray new];
    NSMutableArray *PIDcurrArray=[NSMutableArray new];
    for (int i=0; i<8; i++) {
        int K=0+2*i;
        float volt=[self changeOneRegister:_data04_2 registerNum:K];
        [PIDvoltArray addObject:[NSString stringWithFormat:@"%.1f",volt/10]];
        
        float curr=[self changeOneRegister:_data04_2 registerNum:K+1];
        
        if (curr<32768) {
            [PIDcurrArray addObject:[NSString stringWithFormat:@"%.1f",curr/10]];
        }else{
            curr=65535-curr+1;
            [PIDcurrArray addObject:[NSString stringWithFormat:@"-%.1f",curr/10]];
        }
        
    }
    NSArray *ViewArray4=@[PIDvoltArray,PIDcurrArray];
    
    NSArray *View2AllArray=@[ViewArray,ViewArray2,ViewArray3,ViewArray4];
    
    [_receiveDic setObject:View2AllArray forKey:@"twoView2"];
    
    [self getThreeViewValue];
}


-(void)getThreeViewValue{
    int OneCMDregisterNum=125;
    
     NSString *SnString=[self changeToASCII:_data03 beginRegister:23 length:5];
    NSString *companyString=[self changeToASCII:_data03 beginRegister:34 length:8];
    
    
     float pvPower=[self changeTwoRegister:_data04_1 registerNum:1]/10;
    NSString *pvPower1=[NSString stringWithFormat:@"%.1fW",pvPower];
     float Epv=[self changeTwoRegister:_data04_1 registerNum:91]/10;
        NSString *Epv1=[NSString stringWithFormat:@"%.1fkWh",Epv];
    
      NSString *versionOutString=[self changeToASCII:_data03 beginRegister:9 length:6];
    NSString *versionInString=[self changeToASCII:_data03 beginRegister:82 length:6];
    
      float totalTime=[self changeTwoRegister:_data04_1 registerNum:47]/2;
    NSString *totalTime1=[NSString stringWithFormat:@"%.1fs",totalTime];
    float acHZ=[self changeTwoRegister:_data04_1 registerNum:37]/100;
    NSString *acHZ1=[NSString stringWithFormat:@"%.fHz",acHZ];
    
       float pvTem=[self changeOneRegister:_data04_1 registerNum:93]/10;
       NSString *pvTem1=[NSString stringWithFormat:@"%.1fC",pvTem];
   float boostTem=[self changeOneRegister:_data04_1 registerNum:95]/10;
     NSString *boostTem1=[NSString stringWithFormat:@"%.1fC",boostTem];
    
     float IPMtTem=[self changeOneRegister:_data04_1 registerNum:94]/10;
         NSString *IPMtTem1=[NSString stringWithFormat:@"%.1fC",IPMtTem];
    float IPF=[self changeOneRegister:_data04_1 registerNum:100];
    NSString *IPF1=[NSString stringWithFormat:@"%.f",IPF];
    
      float p_bus=[self changeOneRegister:_data04_1 registerNum:98]/10;
    NSString *p_bus1=[NSString stringWithFormat:@"%.1fV",p_bus];
      float n_bus=[self changeOneRegister:_data04_1 registerNum:99]/10;
        NSString *n_bus1=[NSString stringWithFormat:@"%.1fV",n_bus];
    
    float maxOutPower=[self changeTwoRegister:_data04_1 registerNum:102]/10;
    NSString *maxOutPower1=[NSString stringWithFormat:@"%.1fW",maxOutPower];
    float reallyPercent=[self changeOneRegister:_data04_1 registerNum:101];
    NSString *reallyPercent1=[NSString stringWithFormat:@"%.fW",reallyPercent];
    
    float deratingMode=[self changeOneRegister:_data04_1 registerNum:104];
    NSString *deratingMode1=[NSString stringWithFormat:@"%.f",deratingMode];
    float unMatch=[self changeOneRegister:_data04_2 registerNum:174-OneCMDregisterNum];
    NSString *unMatch1=[NSString stringWithFormat:@"%.f",unMatch];
    
    float disconnectString=[self changeOneRegister:_data04_2 registerNum:176-OneCMDregisterNum];
    NSString *disconnectString1=[NSString stringWithFormat:@"%.f",disconnectString];
    float unbanlanceString=[self changeOneRegister:_data04_2 registerNum:175-OneCMDregisterNum];
    NSString *unbanlanceString1=[NSString stringWithFormat:@"%.f",unbanlanceString];
    
    float pidFault=[self changeOneRegister:_data04_2 registerNum:177-OneCMDregisterNum];
    NSString *pidFault1=[NSString stringWithFormat:@"%.f",pidFault];
    
    float pidStatus=[self changeOneRegister:_data04_2 registerNum:141-OneCMDregisterNum];
    NSString *pidStatus1=[NSString stringWithFormat:@"%.f",pidStatus];
    
     NSArray *ViewArray5=@[
                           SnString,companyString,
                           pvPower1,Epv1,
                           versionOutString,versionInString,
                           totalTime1,acHZ1,
                           pvTem1,boostTem1,
                           IPMtTem1, IPF1,
                           p_bus1,n_bus1,
                           maxOutPower1,reallyPercent1,
                           deratingMode1,unMatch1,
                           disconnectString1,unbanlanceString1,
                           pidFault1,pidStatus1
                           ];
    
      [_receiveDic setObject:ViewArray5 forKey:@"twoView3"];
    
           [[NSNotificationCenter defaultCenter] postNotificationName:@"recieveReceiveData"object:_receiveDic];
    
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





-(void)removeTheTcp{
    if (_ControlOne) {
        [_ControlOne disConnect];
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
