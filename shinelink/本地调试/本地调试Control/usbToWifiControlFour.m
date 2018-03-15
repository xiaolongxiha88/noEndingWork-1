//
//  usbToWifiControlFour.m
//  ShinePhone
//
//  Created by sky on 2017/11/4.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiControlFour.h"

@interface usbToWifiControlFour ()
@property (nonatomic, strong)UIButton *goButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *dataView;
@property (nonatomic, strong) NSMutableData *recieveAllData;
@property (nonatomic, strong) NSData *modbusData;
@property (nonatomic, strong) NSData *recieveData;

@property (nonatomic, strong) NSString *text1String;
@property (nonatomic, strong) NSString *text2String;
@property (nonatomic, strong) NSString *text3String;
@property (nonatomic, strong) NSMutableArray *showDataArray;
@end

@implementation usbToWifiControlFour

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFirstData2:) name: @"TcpReceiveDataTwo" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFailed:) name: @"TcpReceiveDataFourFailed" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
    }
    if (!_changeDataValue) {
        _changeDataValue=[[usbToWifiDataControl alloc]init];
    }
    
    [self initUI];
}


-(void)initUI{
 
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.view.backgroundColor=[UIColor whiteColor];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.userInteractionEnabled=YES;
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
        PVData.textColor=COLOR(102, 102, 102, 1);
        PVData.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        PVData.adjustsFontSizeToFitWidth=YES;
        [_scrollView addSubview:PVData];
        
        UITextField  * _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(130*NOW_SIZE,  30*HEIGHT_SIZE+H*i, W2,30*HEIGHT_SIZE )];
        _textField1.textColor =COLOR(102, 102, 102, 1);
        _textField1.tintColor = COLOR(102, 102, 102, 1);
        _textField1.layer.borderWidth=1;
        _textField1.layer.cornerRadius=5;
        _textField1.tag=2000+i;
        _textField1.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        _textField1.textAlignment=NSTextAlignmentCenter;
        _textField1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:_textField1];
        
    }
    
    _goButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    
    _goButton.frame=CGRectMake(60*NOW_SIZE,50*HEIGHT_SIZE+H*nameArray.count, 200*NOW_SIZE, 40*NOW_SIZE);
    [_goButton setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goButton setTitle:@"Start" forState:UIControlStateNormal];
    _goButton.titleLabel.font=[UIFont systemFontOfSize: 14*NOW_SIZE];
    _goButton.titleLabel.adjustsFontSizeToFitWidth=YES;
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


-(void)goToGetData{
    NSLog(@"开始发送");
    
    
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
  
    for (int i=0; i<3; i++) {
        UITextField *text1=[_scrollView viewWithTag:2000+i];
        [text1 resignFirstResponder];
    }
    
    UITextField *text1=[_scrollView viewWithTag:2000];
    _text1String=text1.text;
    UITextField *text2=[_scrollView viewWithTag:2001];
    _text2String=text2.text;
    UITextField *text3=[_scrollView viewWithTag:2002];
    _text3String=text3.text;
    
    [self showProgressView];
     [_ControlOne goToOneTcp:4 cmdNum:1 cmdType:_text1String regAdd:_text2String Length:_text3String];
    
}

-(void)removeTheWaitingView{
    [self hideProgressView];
}

-(void)receiveFirstData2:(NSNotification*) notification{
      [self performSelector:@selector(removeTheWaitingView) withObject:nil afterDelay:TCP_hide_time];
    
    NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
    _recieveAllData=[firstDic objectForKey:@"one"];
    _modbusData=[firstDic objectForKey:@"modbusData"];
        [_goButton setTitle:@"Start" forState:UIControlStateNormal];
    
    [self checkTheResult];
}

-(void)setFailed:(NSNotification*) notification{
    [self hideProgressView];
      [_goButton setTitle:@"Start" forState:UIControlStateNormal];
    [self removeTheTcp];
    
      NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
    _modbusData=[firstDic objectForKey:@"modbusData"];
    [self getDataUI:_modbusData];
        [self showAlertViewWithTitle:@"操作失败" message:@"请查看设置范围或检查网络连接" cancelButtonTitle:root_OK];
 
}


-(void)checkTheResult{
    _showDataArray=[NSMutableArray new];
    if (([_text1String intValue]==3) || ([_text1String intValue]==4)) {
        NSData *data00=[_recieveAllData subdataWithRange:NSMakeRange(3, _recieveAllData.length-5)];
        int Lenth=[_text3String intValue];
        for (int i=0; i<Lenth; i++) {
            Byte *dataArray=(Byte*)[data00 bytes];
            int registerValue=(dataArray[2*i]<<8)+dataArray[2*i+1];
            [_showDataArray addObject:[NSString stringWithFormat:@"%d",registerValue]];
        }
        
    }
    
    if ([_text1String intValue]==6){
         Byte *Bytedata00=(Byte*)[_modbusData bytes];
            Byte *Bytedata1=(Byte*)[_recieveAllData bytes];
        for (int i=0; i<_recieveAllData.length; i++) {
            [_showDataArray addObject:[NSString stringWithFormat:@"%x",(Bytedata1[i]) & 0xff]];
        }
        if ((Bytedata1[1]==6) && (Bytedata1[0]==Bytedata00[0])) {
            [self showAlertViewWithTitle:root_MAX_303 message:nil cancelButtonTitle:root_OK];
        }else{
            [self showAlertViewWithTitle:@"设置失败" message:nil cancelButtonTitle:root_OK];
        }
    }
    
    [self getDataUI:_modbusData];
    
}




-(void)getDataUI:(NSData*)data{


    
    if (_dataView) {
        [_dataView removeFromSuperview];
        _dataView=nil;
    }
    
    
    float W=20*HEIGHT_SIZE;
    unsigned long k=[_recieveAllData length];
    _dataView=[[UIView alloc]initWithFrame:CGRectMake(0, 220*HEIGHT_SIZE, SCREEN_Width, 230*HEIGHT_SIZE+W*(k))];
    _dataView.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_dataView];
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,300*HEIGHT_SIZE+W*(k));
    
    NSArray *nameArray=@[@"发送数据",@"收到数据"];
    for (int i=0; i<nameArray.count; i++) {
        UILabel *cmdLable=[[UILabel alloc]initWithFrame:CGRectMake(0+SCREEN_Width/2*i,  5*HEIGHT_SIZE, SCREEN_Width/2,W )];
        cmdLable.text=nameArray[i];
        cmdLable.textAlignment=NSTextAlignmentCenter;
        cmdLable.textColor=COLOR(102, 102, 102, 1);
        cmdLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        cmdLable.adjustsFontSizeToFitWidth=YES;
        [_dataView addSubview:cmdLable];
    }
    
    
    
    
   // Byte *tcp1Byte=(Byte*)[_recieveAllData bytes];
    float W11=70*NOW_SIZE,W22=88*NOW_SIZE;
    for (int i=0; i<_showDataArray.count; i++) {
        if ([_text1String intValue]!=6){
            UILabel *PVData0=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width/2,  25*HEIGHT_SIZE+W*(i), W11,W )];
            PVData0.text=[NSString stringWithFormat:@"%d:",[_text2String intValue]+i];
            PVData0.textAlignment=NSTextAlignmentRight;
            PVData0.textColor=COLOR(102, 102, 102, 1);
            PVData0.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
            PVData0.adjustsFontSizeToFitWidth=YES;
            [_dataView addSubview:PVData0];
        }
    
        
        UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width/2+W11+2*NOW_SIZE,  25*HEIGHT_SIZE+W*(i), W22,W )];
        if ([_text1String intValue]!=6){
            PVData.frame=CGRectMake(SCREEN_Width/2+W11+2*NOW_SIZE,  25*HEIGHT_SIZE+W*(i), W22,W );
              PVData.textAlignment=NSTextAlignmentLeft;
        }else{
              PVData.frame=CGRectMake(SCREEN_Width/2,  25*HEIGHT_SIZE+W*(i), SCREEN_Width/2,W );
               PVData.textAlignment=NSTextAlignmentCenter;
        }
        PVData.text=_showDataArray[i];
        PVData.textColor=COLOR(102, 102, 102, 1);
        PVData.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        PVData.adjustsFontSizeToFitWidth=YES;
        [_dataView addSubview:PVData];
        
        
    }
    
    
    Byte *modbusByte=(Byte*)[_modbusData bytes];
    for (int i=0; i<_modbusData.length; i++) {
        UILabel *cmdLable=[[UILabel alloc]initWithFrame:CGRectMake(0,  25*HEIGHT_SIZE+W*(i), SCREEN_Width/2,W )];
        cmdLable.text=[NSString stringWithFormat:@"%x", (modbusByte[i]) & 0xff];
        cmdLable.textAlignment=NSTextAlignmentCenter;
        cmdLable.textColor=COLOR(102, 102, 102, 1);
        cmdLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        cmdLable.adjustsFontSizeToFitWidth=YES;
        [_dataView addSubview:cmdLable];
    }
    

    
}

-(void)removeTheTcp{
    if (_ControlOne) {
        [_ControlOne disConnect];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_ControlOne) {
        [_ControlOne disConnect];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveDataTwo" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveDataTwoFailed" object:nil];
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
