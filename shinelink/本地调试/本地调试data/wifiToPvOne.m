//
//  wifiToPvOne.m
//  GCDAsyncSocketManagerDemo
//
//  Created by sky on 2017/9/20.
//  Copyright © 2017年 宫城. All rights reserved.
//

#import "wifiToPvOne.h"
#import "GCDAsyncSocket.h"
#import "wifiToPvDataModel.h"
#import "MBProgressHUD.h"

static float TCP_TIME=1;

@interface wifiToPvOne ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) wifiToPvDataModel *getData;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *dataView;
@property (nonatomic, strong) NSData *modbusData;
@property (nonatomic, strong) NSData *recieveData;
@property (nonatomic, assign) long cmdTag;
@property (nonatomic, strong) NSMutableData *recieveAllData;
@property (nonatomic, strong)UIButton *goButton;
@property (nonatomic, assign) BOOL isReceive;
@property (nonatomic, strong) NSData *CmdData;

@property (nonatomic, assign) BOOL isOne;
@property (nonatomic, assign) BOOL isTwo;
@property (nonatomic, assign) BOOL isThree;
@property (nonatomic, assign) int cmdType;
@property (nonatomic, assign) int cmdCount;
@property (nonatomic, strong)NSDictionary*cmdDic;
@property (nonatomic, strong)NSArray *cmdArray;

@property (nonatomic, strong)NSMutableDictionary*AllDataDic;
@property (nonatomic, assign) BOOL isReceiveAll;
@property (nonatomic, strong) NSData *receiveCmdTwoData;

@end

@implementation wifiToPvOne


//type 6 controTwo   7 读取设置值
-(void)goToOneTcp:(int)type cmdNum:(int)cmdNum cmdType:(NSString*)cmdType regAdd:(NSString*)regAdd Length:(NSString*)Length{
 

      _AllDataDic=[NSMutableDictionary new];
       _cmdCount=0;
      _cmdType=type;
    _cmdArray=@[cmdType,regAdd,Length];
      _isReceiveAll=NO;
    int CMDTIME;
    if (_cmdType==3 || _cmdType==6) {
        CMDTIME=2;
    }else{
        CMDTIME=TCP_TIME;
    }
       [self performSelector:@selector(checkTcpTimeout) withObject:nil afterDelay:CMDTIME*cmdNum];
         [self goToGetData:_cmdArray[0] RegAdd:_cmdArray[1] Length:_cmdArray[2]];
}


-(void)goToTcpNoDelay:(int)type cmdNum:(int)cmdNum cmdType:(NSString*)cmdType regAdd:(NSString*)regAdd Length:(NSString*)Length{
    
    
    _AllDataDic=[NSMutableDictionary new];
    _cmdCount=0;
    _cmdType=type;
    _cmdArray=@[cmdType,regAdd,Length];
    _isReceiveAll=NO;

    [self goToGetData:_cmdArray[0] RegAdd:_cmdArray[1] Length:_cmdArray[2]];
}


-(void)goToTcpType:(int)type{

    _cmdType=type;
    _AllDataDic=[NSMutableDictionary new];
    _cmdCount=0;
    if (_cmdType==1) {
            _cmdDic=@{@"one":@[@"3",@"0",@"125"],@"two":@[@"4",@"0",@"125"],@"three":@[@"4",@"125",@"125"]};
        _isOne=NO;   _isTwo=NO;   _isThree=NO;
        _cmdArray=[NSArray arrayWithArray:[_cmdDic objectForKey:@"one"]];
        _isReceiveAll=NO;
        [self performSelector:@selector(checkTcpTimeout) withObject:nil afterDelay:TCP_TIME*3];
        
        [self goToGetData:_cmdArray[0] RegAdd:_cmdArray[1] Length:_cmdArray[2]];
    }
    
}

-(void)checkTcpTimeout{
 
    if (!_isReceiveAll) {
        _cmdCount=4;
        [self disConnect];
    }
  
}

-(void)goToGetData:(NSString*)cmdType RegAdd:(NSString*)regAdd Length:(NSString*)length{
      NSLog(@"开始发送");
    if (!_getData) {
         _getData=[[wifiToPvDataModel alloc]init];
    }
   
    _isReceive=NO;

    NSData *data=[_getData CmdData:cmdType RegAdd:regAdd Length:length modbusBlock:^(NSData* modbusData){
        
        _modbusData=[NSData dataWithData:modbusData];
        if (_cmdType==4) {
              [_AllDataDic setValue:modbusData forKey:@"modbusData"];
        }
    }];

    _CmdData=[NSData dataWithData:data];
    
 
    if (![self isConnected]) {
        [self getConnection];
    }else{
        [self sendCMD:_CmdData];
    }
    
}


-(void)sendCMD:(NSData*)data {
    

 
    NSString *string =[self convertDataToHexStr:data];
    
    NSDate*datenow = [NSDate date];
    long Tag=[datenow timeIntervalSince1970];
    _cmdTag=Tag;
    _recieveAllData=[NSMutableData new];
    
    NSLog(@"CMD datas=%ld::%@",_cmdTag,string);
    
    [_socket writeData:data withTimeout:TCP_TIME tag:_cmdTag];
    
    [self listenData:_cmdTag];
    
    
}


//建立连接
-(NSError *)setupConnection {
    if (_socket == nil)
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *err = nil;
    NSString *hostAddress=tcp_IP;
    int hostPort=tcp_port;
    NSLog(@"IP: %@, port:%i",hostAddress,hostPort);
    if (![_socket connectToHost:hostAddress  onPort:hostPort error:&err]) {
        NSLog(@"Connection error : %@",err);
        [self disConnect];
       [[NSNotificationCenter defaultCenter] postNotificationName:@"recieveFailedTcpData"object:nil];
    } else {
        
         NSLog(@"Connection tcp ok");
          [self sendCMD:_CmdData];
    }
 
    return err;
}

//判断是否是连接的状态
-(BOOL)isConnected {
    return _socket.isConnected;
}

//断开连接
-(void)disConnect {
  
    [_socket disconnect];
}

//取得连接
-(void)getConnection {
    if (![_socket isConnected]) {
    
        [self setupConnection];
    }
}




//socket连接成功后的回调代理
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"onSocket:%p didConnectToHost:%@ port:%hu", sock, host, port);
    
}


//添加通知点1
//socket连接断开后的回调代理
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
  

    NSLog(@"DisConnetion");
    [_socket disconnect];
    
    if (_cmdType==1) {
        if (!_isReceive) {
            _cmdCount++;
            if (_cmdCount>3) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"recieveFailedTcpData"object:nil];
            }else{
                [self goToGetData:_cmdArray[0] RegAdd:_cmdArray[1] Length:_cmdArray[2]];
            }
            
        }
    }else  if (_cmdType==2) {
        if (!_isReceiveAll) {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataTwoFailed"object:nil];
        }
        
    }else  if (_cmdType==3) {
        if (!_isReceiveAll) {
               [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataTwoFailed"object:nil];
        }
     
    }else  if (_cmdType==4) {
        if (!_isReceiveAll) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataFourFailed"object:_AllDataDic];
        }
        
    }else  if (_cmdType==5) {
        if (!_isReceiveAll) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataFiveFailed"object:nil];
        }
        
    }else  if (_cmdType==6 || _cmdType==7) {
        if (!_isReceiveAll) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveWifiConrolTwoFailed"object:nil];
        }
        
    }else  if (_cmdType==8) {
        if (!_isReceiveAll) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataForViewOneFailed"object:nil];
        }
        
    }
 
    
}

//添加通知点2
//读到数据后的回调代理
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
 
    _cmdCount=0;
    NSString *string =[self convertDataToHexStr:data];
    NSLog(@"receive datas=%ld::%@",tag,string);
    _isReceive=YES;
    
    if (_cmdType==1) {
         [self checkWhichNumData:data];
    }else{
        _isReceiveAll=YES;
    
        if ([self checkData:data]) {
            if (_cmdType==5) {
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataFive"object:_AllDataDic];
            }else if (_cmdType==6 || _cmdType==7) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveWifiConrolTwo"object:_AllDataDic];
            }else if (_cmdType==8) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataForViewOne"object:_AllDataDic];
            }else{
                   [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataTwo"object:_AllDataDic];
            }
           
        }else{
            if (_cmdType==4) {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataFourFailed"object:_AllDataDic];
            }else if (_cmdType==5) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataFiveFailed"object:nil];
            }else if (_cmdType==6 || _cmdType==7) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveWifiConrolTwoFailed"object:nil];
            }else if (_cmdType==8) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataForViewOneFailed"object:nil];
            }else{
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataTwoFailed"object:nil];
            }
            
        }
        
        
    }
   
    
}



//发起一个读取的请求，当收到数据时后面的didReadData才能被回调
-(void)listenData:(long)Tag {
   
    [_socket readDataWithTimeout:TCP_TIME tag:Tag];
}



//添加通知点3
-(BOOL)checkData:(NSData*)data{
    BOOL  isRightData=YES;
    
    NSData *dataAll=[NSData dataWithData:data];
      Byte *ByteAll=(Byte*)[dataAll bytes];
    
    int lengthAll0=(int)[dataAll length];
    int lengthAll=(ByteAll[4]<<8)+ByteAll[5];
    
    if ((lengthAll0-6)==lengthAll) {
        NSData *data1=[data subdataWithRange:NSMakeRange(20, data.length-20)];
        Byte *Bytedata1=(Byte*)[data1 bytes];
        int length0=(int)[data1 length];
        int length1=Bytedata1[2];
        
        NSData *data2=[data subdataWithRange:NSMakeRange(20, data.length-22)];
        NSData *CRC=[self getCrc16:data2];
        Byte *CRCArray=(Byte*)[CRC bytes];
        int C1=CRCArray[0];
        int C2=CRCArray[1];
        
        if ((C1==Bytedata1[length0-2])&&(C2==Bytedata1[length0-1])) {
            if (_cmdType==3 || _cmdType==6) {          //06设置
                Byte *Bytedata00=(Byte*)[_modbusData bytes];
                
                    if ((Bytedata1[1]==6) && (Bytedata1[0]==Bytedata00[0])) {
                        isRightData=YES;
                    }else{
                        isRightData=NO;
                    }
                
                return isRightData;
            }else{
                if ((length0-5)==length1) {
                    isRightData=YES;
                    NSData *data00=[data1 subdataWithRange:NSMakeRange(3, data1.length-5)];
                    if (_cmdType==1) {
                        [self upDataToDic:data00];
                    }else  if ((_cmdType==2) || (_cmdType==5) || (_cmdType==7) || (_cmdType==8)) {
                        [_AllDataDic setValue:data00 forKey:@"one"];
                    }
                    
                }else{
                    isRightData=NO;
                }
            }
            if (_cmdType==4) {           //高级设置
               //  NSData *data00=[data1 subdataWithRange:NSMakeRange(3, data1.length-5)];
                [_AllDataDic setValue:data1 forKey:@"one"];
                isRightData=YES;
            }
            
        }else{
            isRightData=NO;
        }
        }else{
              isRightData=NO;
        }
        

    return isRightData;
}



-(void)checkWhichNumData:(NSData*)data{
    if (!_isOne) {
        BOOL tureData= [self checkData:data];
        if (tureData) {
            _isOne=tureData;
            _cmdArray=[NSArray arrayWithArray:[_cmdDic objectForKey:@"two"]];
        }
        [self goToGetData:_cmdArray[0] RegAdd:_cmdArray[1] Length:_cmdArray[2]];
    }else{
        if (!_isTwo) {
            BOOL tureData= [self checkData:data];
            if (tureData) {
                _isTwo=tureData;
                _cmdArray=[NSArray arrayWithArray:[_cmdDic objectForKey:@"three"]];
            }
            [self goToGetData:_cmdArray[0] RegAdd:_cmdArray[1] Length:_cmdArray[2]];
        }else{
            if (!_isThree) {
                BOOL tureData= [self checkData:data];
                if (tureData) {
                    _isThree=tureData;
                }else{
                    [self goToGetData:_cmdArray[0] RegAdd:_cmdArray[1] Length:_cmdArray[2]];
                }
                
            }
            
        }
        
    }
    
    
    
}


-(void)upDataToDic:(NSData*)data{
    
    if (!_isOne) {
         [_AllDataDic setValue:data forKey:@"one"];
    }else{
        if (!_isTwo) {
            [_AllDataDic setValue:data forKey:@"two"];
        }else{
               [_AllDataDic setValue:data forKey:@"three"];
            _isReceiveAll=YES;
                   [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveData"object:_AllDataDic];
        }
        
    }
   
    
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
                //  [string appendString:hexStr];
                [string appendFormat:@"%@#", hexStr];
            } else {
                [string appendFormat:@"0%@#", hexStr];
            }
            
        }
        
    }];
    
    return string;
}






-(void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag {
    NSLog(@"Reading data length of %lu",(unsigned long)partialLength);
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
    NSLog(@"CRC go");
    return datacrc;
}



- (void)didReceiveMemoryWarning {
 
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
