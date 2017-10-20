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


@interface wifiToPvOne ()<GCDAsyncSocketDelegate>
@property (nonatomic, strong) GCDAsyncSocket *socket;
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

@end

@implementation wifiToPvOne




-(void)checkIsReceiveData{
    if (!_isReceive) {
 
        NSLog(@"DisConnetion");
        [_socket disconnect];
        
          [self getDataUI:nil];
    }
    
    
}

-(void)goToGetData:(NSString*)cmdType RegAdd:(NSString*)regAdd Length:(NSString*)length{
      NSLog(@"开始发送");
    if (!_getData) {
         _getData=[[wifiToPvDataModel alloc]init];
      [self setupConnection];
    }
   
    
    
    
    
    _isReceive=NO;
    
//    [self performSelector:@selector(checkIsReceiveData)  withObject:nil afterDelay:3.0];
    
    NSData *data=[_getData CmdData:cmdType RegAdd:regAdd Length:length modbusBlock:^(NSData* modbusData){
       
    }];

    _CmdData=[NSData dataWithData:data];
    
//    [self sendCMD:data];
    
    
}


-(void)sendCMD:(NSData*)data {
    
    if (![self isConnected]) {
           [self getConnection];
    }
 
    
    NSString *string =[self convertDataToHexStr:data];
    
    
    
    NSDate*datenow = [NSDate date];
    long Tag=[datenow timeIntervalSince1970];
    _cmdTag=Tag;
    _recieveAllData=[NSMutableData new];
    
    NSLog(@"CMD datas=%ld::%@",_cmdTag,string);
    
    [_socket writeData:data withTimeout:-1 tag:_cmdTag];
    
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
    } else {
        err = nil;
    }
    //  needConnect = YES;
    return err;
}

//判断是否是连接的状态
-(BOOL)isConnected {
    return _socket.isConnected;
}

//断开连接
-(void)disConnect {
    //   needConnect = NO;
    [_socket disconnect];
}

//取得连接
-(void)getConnection {
    if (![_socket isConnected]) {
     //   [self disConnect];
        [self setupConnection];
    }
}




//socket连接成功后的回调代理
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"onSocket:%p didConnectToHost:%@ port:%hu", sock, host, port);
    
    [self sendCMD:_CmdData];
    
    //[delegate networkConnected];
 //   [self listenData:1];
    
}

//socket连接断开后的回调代理
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
  

    NSLog(@"DisConnetion");
    [_socket disconnect];
    
    
}

//读到数据后的回调代理
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
 

    NSString *string =[self convertDataToHexStr:data];
    NSLog(@"receive datas=%ld::%@",tag,string);
    _isReceive=YES;

   [[NSNotificationCenter defaultCenter] postNotificationName:@"TcpReceiveData"object:data];
    
  //  receiveDataTwoBlock(data1);
    
   //     [self getDataUI:data];
        

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


-(void)getDataUI:(NSData*)data{
   [_goButton setTitle:@"Start" forState:UIControlStateNormal];
     [_goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (_dataView) {
        [_dataView removeFromSuperview];
        _dataView=nil;
    }

    NSData *data1=[data subdataWithRange:NSMakeRange(20, data.length-20)];
    [_recieveAllData appendData:data1];
    
    float W=20*HEIGHT_SIZE;
    unsigned long k=[_recieveAllData length];
        _dataView=[[UIView alloc]initWithFrame:CGRectMake(0, 220*HEIGHT_SIZE, SCREEN_Width, 230*HEIGHT_SIZE+W*(k))];
    _dataView.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_dataView];
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,260*HEIGHT_SIZE+W*(k));
    
    NSArray *nameArray=@[@"发送数据",@"收到数据"];
    for (int i=0; i<nameArray.count; i++) {
        UILabel *cmdLable=[[UILabel alloc]initWithFrame:CGRectMake(0+SCREEN_Width/2*i,  5*HEIGHT_SIZE, SCREEN_Width/2,W )];
        cmdLable.text=nameArray[i];
        cmdLable.textAlignment=NSTextAlignmentCenter;
        cmdLable.textColor=[UIColor whiteColor];
        cmdLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        cmdLable.adjustsFontSizeToFitWidth=YES;
        [_dataView addSubview:cmdLable];
    }
    
    

    
       Byte *tcp1Byte=(Byte*)[_recieveAllData bytes];
    
    for (int i=0; i<_recieveAllData.length; i++) {
        UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width/2,  25*HEIGHT_SIZE+W*(i), SCREEN_Width/2,W )];
        PVData.text=[NSString stringWithFormat:@"%d--%x", i,(tcp1Byte[i]) & 0xff];
        PVData.textAlignment=NSTextAlignmentCenter;
        PVData.textColor=[UIColor whiteColor];
        PVData.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        PVData.adjustsFontSizeToFitWidth=YES;
        [_dataView addSubview:PVData];
        
   
    }
    
    
    Byte *modbusByte=(Byte*)[_modbusData bytes];
    for (int i=0; i<_modbusData.length; i++) {
        UILabel *cmdLable=[[UILabel alloc]initWithFrame:CGRectMake(0,  25*HEIGHT_SIZE+W*(i), SCREEN_Width/2,W )];
        cmdLable.text=[NSString stringWithFormat:@"%x", (modbusByte[i]) & 0xff];
        cmdLable.textAlignment=NSTextAlignmentCenter;
        cmdLable.textColor=[UIColor whiteColor];
        cmdLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        cmdLable.adjustsFontSizeToFitWidth=YES;
        [_dataView addSubview:cmdLable];
    }
    
       [self listenData:_cmdTag];
    
}


-(void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag {
    NSLog(@"Reading data length of %lu",(unsigned long)partialLength);
}

//发起一个读取的请求，当收到数据时后面的didReadData才能被回调
-(void)listenData:(long)Tag {
    //    NSString* sp = @"\n";
    //    NSData* sp_data = [sp dataUsingEncoding:NSUTF8StringEncoding];
    // [_socket readDataToData:[GCDAsyncSocket ZeroData] withTimeout:-1 tag:1];
    
    [_socket readDataWithTimeout:-1 tag:Tag];
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
