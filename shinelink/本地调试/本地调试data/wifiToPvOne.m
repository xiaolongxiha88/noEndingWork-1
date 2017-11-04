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



-(void)goToOneTcp:(int)type cmdNum:(int)cmdNum cmdType:(NSString*)cmdType regAdd:(NSString*)regAdd Length:(NSString*)Length{
 

      _AllDataDic=[NSMutableDictionary new];
       _cmdCount=0;
      _cmdType=type;
    _cmdArray=@[cmdType,regAdd,Length];
      _isReceiveAll=NO;
    int CMDTIME;
    if (_cmdType==3) {
        CMDTIME=2;
    }else{
        CMDTIME=TCP_TIME;
    }
       [self performSelector:@selector(checkTcpTimeout) withObject:nil afterDelay:CMDTIME*cmdNum];
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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataTwoFailed"object:_AllDataDic];
        }
        
    }
 
    
}

//读到数据后的回调代理
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
 
    _cmdCount=0;
    NSString *string =[self convertDataToHexStr:data];
    NSLog(@"receive datas=%ld::%@",tag,string);
    _isReceive=YES;
    
    if (_cmdType==1) {
         [self checkWhichNumData:data];
    }else if ((_cmdType==2)||(_cmdType==3)||(_cmdType==4)){
        _isReceiveAll=YES;
    
        if ([self checkData:data]) {
              [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataTwo"object:_AllDataDic];
        }else{
            if (_cmdType==4) {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveDataTwoFailed"object:_AllDataDic];
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
        
        if (_cmdType==3) {
            return [data1 isEqualToData:_modbusData];
        }else{
            if ((length0-5)==length1) {
                isRightData=YES;
                NSData *data00=[data1 subdataWithRange:NSMakeRange(3, data1.length-5)];
                if (_cmdType==1) {
                    [self upDataToDic:data00];
                }else  if (_cmdType==2) {
                    [_AllDataDic setValue:data00 forKey:@"one"];
                }
                if (_cmdType==4) {
                    [_AllDataDic setValue:data1 forKey:@"one"];
                }
                
            }else{
                isRightData=NO;
            }
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
