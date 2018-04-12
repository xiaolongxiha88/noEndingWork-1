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
@property(nonatomic,assign)int cmdTpye;
@property(nonatomic,strong)NSData*data03_2;

@property(nonatomic,assign)BOOL isFirstAutoData;

@end

@implementation usbToWifiDataControl

- (void)viewDidLoad {
    [super viewDidLoad];   
}


-(void)getDataAll:(int)type{        //type=1 获取全部   =2 获取前125个
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
         _receiveDic=[NSMutableDictionary new];
          [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFirstData:) name: @"TcpReceiveData" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveSecondData:) name: @"TcpReceiveDataForViewOne" object:nil];
        
    }
    
    _cmdType=type;

    
    if (type==1) {
          [_ControlOne goToTcpType:type];
    }else if (type==2){
        _isFirstAutoData=YES;
           [_ControlOne goToTcpNoDelay:8 cmdNum:1 cmdType:@"4" regAdd:@"0" Length:@"125"];
    }else if (type==3){
        [_ControlOne goToTcpNoDelay:8 cmdNum:1 cmdType:@"3" regAdd:@"125" Length:@"10"];
    }
    
}



-(void)receiveSecondData:(NSNotification*)notification{
    NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
   
    if (_cmdType==2) {
        if (_isFirstAutoData) {
            _data04_1=[NSData new];
            _data04_1=[firstDic objectForKey:@"one"];
            _isFirstAutoData=NO;
            [_ControlOne goToTcpNoDelay:8 cmdNum:1 cmdType:@"4" regAdd:@"125" Length:@"125"];
        }else{
            _data04_2=[NSData new];
            _data04_2=[firstDic objectForKey:@"one"];
            _isFirstAutoData=YES;
                  [self getFirstViewValue];
        }
   
    }
    
    if (_cmdType==3) {
            _data03_2=[NSData new];
        _data03_2=[firstDic objectForKey:@"one"];
          [self getFirstViewValue];
    }
    
    
    
    
//    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
//    NSMutableDictionary *oldDic=[ud objectForKey:@"maxSecondData"];

}


-(void)receiveFirstData:(NSNotification*)notification{
    
    NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];

    NSLog(@"receive TCP AllData=%@",firstDic);
    
    _receiveDic=[NSMutableDictionary new];
    _data03=[NSData new];
    _data04_1=[NSData new];
    _data04_2=[NSData new];
    _data03=[firstDic objectForKey:@"one"];
    _data04_1=[firstDic objectForKey:@"two"];
     _data04_2=[firstDic objectForKey:@"three"];
    
   //  [[NSUserDefaults standardUserDefaults] setObject:firstDic forKey:@"maxSecondData"];
    
    [self getFirstViewValue];
}

-(void)getFirstViewValue{
 
    int titleState=(int)[self changeOneRegister:_data04_1 registerNum:0];
    NSString *titleString;
    NSArray *titleArray=@[@"Waiting",@"Normal",@"Upgrade",@"Fault"];
    if ((titleState<4)&&(titleState>-1) ) {
        titleString=titleArray[titleState];
    }else{
        titleString=[NSString stringWithFormat:@"状态:%d",titleState];
    }
    
     [_receiveDic setObject:titleString forKey:@"titleView"];
    
        long faultState=(long)[self changeOneRegister:_data04_1 registerNum:112];
      [_receiveDic setObject:[NSString stringWithFormat:@"%ld",faultState] forKey:@"faultStateView"];
    
    float EacToday=[self changeTwoRegister:_data04_1 registerNum:53];
    float EacTotal=[self changeTwoRegister:_data04_1 registerNum:55];
    float EacputPower=[self changeTwoRegister:_data04_1 registerNum:35];
     float NormalPowerValue=[self changeTwoRegister:_data03 registerNum:6];
      float faultCode=[self changeOneRegister:_data04_1 registerNum:105];      //故障
      float warnCode=[self changeOneRegister:_data04_1 registerNum:112];       //警告
    
  
    NSArray *oneViewArray=@[[NSString stringWithFormat:@"%.1fkWh",EacToday/10],[NSString stringWithFormat:@"%.1fkWh",EacTotal/10],[NSString stringWithFormat:@"%.1fW",EacputPower/10],[NSString stringWithFormat:@"%.1fW",NormalPowerValue/10],[NSString stringWithFormat:@"%.f",faultCode+99],[NSString stringWithFormat:@"%.f",warnCode+99]];
    
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
    
    NSArray *ViewArray=@[voltArray,currArray];
    
    
    

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
      NSMutableArray *AcHzArray=[NSMutableArray new];
    NSMutableArray *AcCurrArray=[NSMutableArray new];
    NSMutableArray *AcPowerArray=[NSMutableArray new];
    
     for (int i=0; i<3; i++) {
        
         int T=50+i;
         float volt=[self changeOneRegister:_data04_1 registerNum:T];
         [AcVoltArray addObject:[NSString stringWithFormat:@"%.1f",volt/10]];
         
          int K=38+4*i;
            float curr=[self changeOneRegister:_data04_1 registerNum:K+1];
           [AcCurrArray addObject:[NSString stringWithFormat:@"%.1f",curr/10]];
         
         float acHZ=[self changeOneRegister:_data04_1 registerNum:37]/100;
               [AcHzArray addObject:[NSString stringWithFormat:@"%.1f",acHZ]];          //电网频率
         
         
         float Pac=[self changeTwoRegister:_data04_1 registerNum:K+2];
                  [AcPowerArray addObject:[NSString stringWithFormat:@"%.1f",Pac/10]];
    }
    

    NSArray *ViewArray3=@[AcVoltArray,AcCurrArray,AcPowerArray,AcHzArray];
  
    
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
    
  
    
    NSString *companyString=[self changeToASCII:_data03 beginRegister:34 length:8];     //厂商信息
    NSString *PvTypy; //机器型号
    if (_data03_2.length>8) {
       PvTypy=[self changeToASCII:_data03_2 beginRegister:0 length:8];
    }else{
        PvTypy=@"";
    }
  
    
    NSString *SnString=[self changeToASCII:_data03 beginRegister:23 length:5];     //序列号
       NSString *totalTime1=[self getModelString:_data03];          //Model号
    
    NSString *versionOutString=[self changeToASCII:_data03 beginRegister:9 length:6];          //固件(外部)版本
    NSString *versionInString=[self changeToASCII:_data03 beginRegister:82 length:6];              //固件(内部)版本
    
    float maxOutPower=[self changeOneRegister:_data04_1 registerNum:114];
    NSString *maxOutPower1=[NSString stringWithFormat:@"%.fs",maxOutPower];             //并网倒计时
    float reallyPercent=[self changeOneRegister:_data04_1 registerNum:113];
    NSString *reallyPercent1=[NSString stringWithFormat:@"%.f%%",reallyPercent];                   //实际输出功率百分比
    
    float IPF=[self changeOneRegister:_data04_1 registerNum:100];
    NSString *IPF1=[NSString stringWithFormat:@"%.2f",(IPF-10000)/10000];                          //IPF
    float pvTem=[self changeOneRegister:_data04_1 registerNum:93]/10;
    NSString *pvTem1=[NSString stringWithFormat:@"%.1f℃",pvTem];                //内部环境温度
    
    float boostTem=[self changeOneRegister:_data04_1 registerNum:95]/10;
    NSString *boostTem1=[NSString stringWithFormat:@"%.1f℃",boostTem];          //Boost温度
    float IPMtTem=[self changeOneRegister:_data04_1 registerNum:94]/10;
    NSString *IPMtTem1=[NSString stringWithFormat:@"%.1f℃",IPMtTem];             //INV温度
    
    float p_bus=[self changeOneRegister:_data04_1 registerNum:98]/10;
    NSString *p_bus1=[NSString stringWithFormat:@"%.1fV",p_bus];                    //P Bus电压
    float n_bus=[self changeOneRegister:_data04_1 registerNum:99]/10;
    NSString *n_bus1=[NSString stringWithFormat:@"%.1fV",n_bus];                  //N Bus电压
    
    float pidFault=[self changeOneRegister:_data04_2 registerNum:177-OneCMDregisterNum];
    NSString *pidFault1=[NSString stringWithFormat:@"%.f",pidFault];                            //PID故障码
    
    int pidStatus=(int)[self changeOneRegister:_data04_2 registerNum:141-OneCMDregisterNum]; //PID状态
    NSString *pidStatus1;
    if (pidStatus==1) {
        pidStatus1=@"Waiting";
    }else if (pidStatus==2) {
        pidStatus1=@"Normal";
    }else if (pidStatus==2) {
        pidStatus1=@"Fault";
    }else{
        pidStatus1=[NSString stringWithFormat:@"%d",pidStatus];
    }
    
//     float pvPower=[self changeTwoRegister:_data04_1 registerNum:1]/10;
//    NSString *pvPower1=[NSString stringWithFormat:@"%.1fW",pvPower];           //PV输入功率
//     float Epv=[self changeTwoRegister:_data03 registerNum:6]/10;
//        NSString *Epv1=[NSString stringWithFormat:@"%.1fW",Epv];                 //额定功率

//    float acHZ=[self changeTwoRegister:_data04_1 registerNum:37]/100;
//    NSString *acHZ1=[NSString stringWithFormat:@"%.fHz",acHZ];                    //电网频率
    

     NSArray *ViewArray5=@[
                           companyString,PvTypy,
                           SnString,totalTime1,
                           versionOutString,versionInString,
                           maxOutPower1,reallyPercent1,
                           IPF1,pvTem1,
                           boostTem1, IPMtTem1,
                           p_bus1,n_bus1,
                           pidFault1,pidStatus1,
                           ];
    
      [_receiveDic setObject:ViewArray5 forKey:@"twoView3"];
    
           [[NSNotificationCenter defaultCenter] postNotificationName:@"recieveReceiveData"object:_receiveDic];
    
}


//获取一个寄存器高8位的值
-(int)changeHighRegister:(NSData*)data registerNum:(int)registerNum{
    int registerValue=0;
    if ((data.length>(2*registerNum+1)) || (data.length==(2*registerNum+1))) {
        Byte *dataArray=(Byte*)[data bytes];
        registerValue=dataArray[2*registerNum];
    }
    return registerValue;
}

//获取一个寄存器低8位的值
-(int)changeLowRegister:(NSData*)data registerNum:(int)registerNum{
    int registerValue=0;
    if ((data.length>(2*registerNum+1)) || (data.length==(2*registerNum+1))) {
        Byte *dataArray=(Byte*)[data bytes];
        registerValue=dataArray[2*registerNum+1];
    }
    return registerValue;
}

//获取一个寄存器值
-(int)changeOneRegister:(NSData*)data registerNum:(int)registerNum{
    int registerValue=0;
   if ((data.length>(2*registerNum+1)) || (data.length==(2*registerNum+1))) {
        Byte *dataArray=(Byte*)[data bytes];
         registerValue=(dataArray[2*registerNum]<<8)+dataArray[2*registerNum+1];
    }
   
    
    return registerValue;
}

//获取高低寄存器值
-(int)changeTwoRegister:(NSData*)data registerNum:(int)registerNum{
      int registerValue=0;
    if ((data.length>(2*registerNum+3)) || (data.length==(2*registerNum+3))) {
        Byte *dataArray=(Byte*)[data bytes];
        registerValue=(dataArray[2*registerNum]<<24)+(dataArray[2*registerNum+1]<<16)+(dataArray[2*registerNum+2]<<8)+dataArray[2*registerNum+3];
    }
  

    return registerValue;
}


//获取字符串寄存器值
-(NSString*)changeToASCII:(NSData*)data beginRegister:(int)beginRegister length:(int)length{
    NSString*getString=@"";
    NSString *string11 =@"";
    
    if ((data.length>(beginRegister*2+length*2)) || (data.length==(beginRegister*2+length*2))) {
        NSData *data1=[data subdataWithRange:NSMakeRange(beginRegister*2, length*2)];
        getString=[[NSString alloc]initWithData:data1 encoding:NSASCIIStringEncoding];
        
       string11 = [getString stringByReplacingOccurrencesOfString:@"\0" withString:@""];
    }
 
    return string11;
}


-(NSString*)getModelString:(NSData*)data{
        NSString*ModelString;
    Byte *dataArray=(Byte*)[data bytes];
    int registerNum=28;
         int registerValue=(dataArray[2*registerNum]<<24)+(dataArray[2*registerNum+1]<<16)+(dataArray[2*registerNum+2]<<8)+dataArray[2*registerNum+3];
    
    NSString* T1=[NSString stringWithFormat:@"%x",(registerValue & 0xf0000000)>>28];
    NSString* T2=[NSString stringWithFormat:@"%x",(registerValue & 0xf000000)>>24];
    NSString* T3=[NSString stringWithFormat:@"%x",(registerValue & 0xf00000)>>20];
        NSString* T4=[NSString stringWithFormat:@"%x",(registerValue & 0xf0000)>>16];
    NSString* T5=[NSString stringWithFormat:@"%x",(registerValue & 0x00f000)>>12];
    NSString* T6=[NSString stringWithFormat:@"%x",(registerValue & 0x000f00)>>8];
        NSString* T7=[NSString stringWithFormat:@"%x",(registerValue & 0x0000f0)>>4];
     NSString* T8=[NSString stringWithFormat:@"%x",(registerValue & 0x00000f)];
    
    
    ModelString=[NSString stringWithFormat:@"A%@B%@D%@T%@P%@U%@M%@S%@",T1,T2,T3,T4,T5,T6,T7,T8];
    
    return ModelString;
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
