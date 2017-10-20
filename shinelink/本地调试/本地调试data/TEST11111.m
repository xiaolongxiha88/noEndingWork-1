//
//  TEST11111.m
//  ShinePhone
//
//  Created by sky on 2017/10/20.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "TEST11111.h"
#import "GCDAsyncSocket.h"
#import "wifiToPvDataModel.h"


@interface TEST11111 ()<GCDAsyncSocketDelegate>
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
@end

@implementation TEST11111



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _getData=[[wifiToPvDataModel alloc]init];
    
    [self setupConnection];
    
    
    [self initUI];
    
    
}

-(void)initUI{
    [self.navigationController setNavigationBarHidden:YES];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.view.backgroundColor=MainColor;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    //_scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
    
    
    NSArray *nameArray=@[@"Command type:",@"Register address:",@"length/Data:"];
    float W1=120*NOW_SIZE;
    float W2=150*NOW_SIZE;
    float H=40*HEIGHT_SIZE;
    
    for (int i=0; i<nameArray.count; i++) {
        UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake(0,  30*HEIGHT_SIZE+H*i, W1,30*HEIGHT_SIZE )];
        PVData.text=nameArray[i];
        PVData.textAlignment=NSTextAlignmentRight;
        PVData.textColor=[UIColor whiteColor];
        PVData.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        PVData.adjustsFontSizeToFitWidth=YES;
        [_scrollView addSubview:PVData];
        
        UITextField  * _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(130*NOW_SIZE,  30*HEIGHT_SIZE+H*i, W2,30*HEIGHT_SIZE )];
        _textField1.textColor = [UIColor whiteColor];
        _textField1.tintColor = [UIColor whiteColor];
        _textField1.layer.borderWidth=1;
        _textField1.layer.cornerRadius=5;
        _textField1.tag=2000+i;
        _textField1.layer.borderColor=[UIColor whiteColor].CGColor;
        _textField1.textAlignment=NSTextAlignmentCenter;
        _textField1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:_textField1];
        
    }
    
    _goButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goButton.frame=CGRectMake(80*NOW_SIZE,50*HEIGHT_SIZE+H*nameArray.count, 160*NOW_SIZE, 40*NOW_SIZE);
    [_goButton.layer setMasksToBounds:YES];
    _goButton.layer.borderWidth=1;
    _goButton.layer.cornerRadius=40*NOW_SIZE/2;
    _goButton.layer.borderColor=[UIColor whiteColor].CGColor;
    _goButton.backgroundColor=[UIColor clearColor];
    _goButton.titleLabel.font=[UIFont systemFontOfSize: 16*NOW_SIZE];
    _goButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    [_goButton setTitle:@"Start" forState:UIControlStateNormal];
    [_goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _goButton.tintColor=MainColor;
    [_goButton addTarget:self action:@selector(goToGetData) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_goButton];
    
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    for (int i=0; i<3; i++) {
        UITextField *text1=[_scrollView viewWithTag:2000+i];
        [text1 resignFirstResponder];
    }
}

-(void)checkIsReceiveData{
    if (!_isReceive) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"无法收到数据，请检查发送的数据。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
        [_goButton setTitle:@"Start" forState:UIControlStateNormal];
        [_goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _goButton.userInteractionEnabled=YES;
        NSLog(@"DisConnetion");
        [_socket disconnect];
        
        [self getDataUI:nil];
    }
    
    
}

-(void)goToGetData{
    NSLog(@"开始发送");
    
    _isReceive=NO;
    _goButton.userInteractionEnabled=NO;
    [self performSelector:@selector(checkIsReceiveData)  withObject:nil afterDelay:3.0];
    
    for (int i=0; i<3; i++) {
        UITextField *text1=[_scrollView viewWithTag:2000+i];
        if ((text1.text==nil)||([text1.text isEqualToString:@""])) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请填写参数" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    
    [_goButton setTitle:@"Sending..." forState:UIControlStateNormal];
    [_goButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    for (int i=0; i<3; i++) {
        UITextField *text1=[_scrollView viewWithTag:2000+i];
        [text1 resignFirstResponder];
    }
    
    UITextField *text1=[_scrollView viewWithTag:2000];
    NSString *text1String=text1.text;
    UITextField *text2=[_scrollView viewWithTag:2001];
    NSString *text2String=text2.text;
    UITextField *text3=[_scrollView viewWithTag:2002];
    NSString *text3String=text3.text;
    
    NSData *data=[_getData CmdData:text1String RegAdd:text2String Length:text3String modbusBlock:^(NSData* modbusData){
        _modbusData=[NSData dataWithData:modbusData];
    }];
    
    [self sendCMD:data];
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
        [self disConnect];
        //        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setupConnection) userInfo:nil repeats:NO];
        //        NSLog(@"scheduled start");
        [self setupConnection];
    }
}

-(void)sendCMD:(NSData*)data {
    
    //  [self socketDidCloseReadStream:_socket];
    [self getConnection];
    
    NSString *string =[self convertDataToHexStr:data];
    
    
    
    NSDate*datenow = [NSDate date];
    long Tag=[datenow timeIntervalSince1970];
    _cmdTag=Tag;
    _recieveAllData=[NSMutableData new];
    
    NSLog(@"CMD datas=%ld::%@",_cmdTag,string);
    
    if (_dataView) {
        [_dataView removeFromSuperview];
        _dataView=nil;
    }
    
    [_socket writeData:data withTimeout:-1 tag:_cmdTag];
    
    [self listenData:_cmdTag];
    
    
}


//socket连接成功后的回调代理
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"onSocket:%p didConnectToHost:%@ port:%hu", sock, host, port);
    //[delegate networkConnected];
    //   [self listenData:1];
    
    
    
    
}

//socket连接断开后的回调代理
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请连接WIFI模块" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
    [_goButton setTitle:@"Start" forState:UIControlStateNormal];
    [_goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _goButton.userInteractionEnabled=YES;
    NSLog(@"DisConnetion");
    [_socket disconnect];
    
    
    //    [delegate networkDisconnect];
    //    if (needConnect)
    //        [self getConnection];
}

//读到数据后的回调代理
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    
    NSString *string =[self convertDataToHexStr:data];
    NSLog(@"receive datas=%ld::%@",tag,string);
    _isReceive=YES;
    _goButton.userInteractionEnabled=YES;
    [self getDataUI:data];
    
    
    
    
    //   [delegate readData:data];
    //    [self splitData:data];
    //    [self listenData];
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
