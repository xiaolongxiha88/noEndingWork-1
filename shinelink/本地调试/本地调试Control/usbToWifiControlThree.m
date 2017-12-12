//
//  usbToWifiControlThree.m
//  ShinePhone
//
//  Created by sky on 2017/10/31.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiControlThree.h"
#import "ZJBLStoreShopTypeAlert.h"

@interface usbToWifiControlThree ()
@property(nonatomic,strong)UIScrollView*view1;
@property(nonatomic,assign) int cmdTcpType;
@property(nonatomic,assign) int cmdTcpTimes;
@property(nonatomic,strong)NSMutableArray*setValueArray;
@property(nonatomic,strong)NSMutableArray*setRegisterArray;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) NSArray *timeArray;
@property(nonatomic,assign)BOOL isFirstReadOK;
@end

@implementation usbToWifiControlThree

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFirstData2:) name: @"TcpReceiveWifiConrolTwo" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFailed) name: @"TcpReceiveWifiConrolTwoFailed" object:nil];
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"读取" style:UIBarButtonItemStylePlain target:self action:@selector(readValueToTcp)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
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
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    if (!_view1) {

        _view1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0*HEIGHT_SIZE, ScreenWidth,SCREEN_Height)];
        _view1.backgroundColor =[UIColor clearColor];
        _view1.userInteractionEnabled = YES;
        _view1.contentSize=CGSizeMake(SCREEN_Width, SCREEN_Height*1.4);
        [self.view addSubview:_view1];
    }
    
    
    _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:@"设置" forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:_goBut];
    
    if (_CellNumber<14) {
        _cmdRegisterNum=1;
    }else{
        _cmdRegisterNum=2;
    }
    if (_CellNumber==1) {
        _cmdRegisterNum=6;
    }
    
    if (_CellTypy==1) {
        [self initTwoUI];
    }else  if (_CellTypy==2) {
        [self initThreeUI];
    }else  if (_CellTypy==3) {
        [self initFourUI];
    }
    
    
    
}


-(void)initTwoUI{
    _nameArray0=@[_titleString];
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 20*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    PV2Lable.text=_titleString;
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=COLOR(102, 102, 102, 1);
    PV2Lable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    PV2Lable.adjustsFontSizeToFitWidth=YES;
    [_view1 addSubview:PV2Lable];
    
    if (_CellNumber==5 || _CellNumber==6 || _CellNumber==1  || _CellNumber==11 || _CellNumber==12) {
        _textLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 60*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textLable.text=root_MIX_223;
        _textLable.userInteractionEnabled=YES;
        _textLable.layer.borderWidth=1;
        _textLable.layer.cornerRadius=5;
        _textLable.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        if (_CellNumber!=1) {
            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice)];
            [_textLable addGestureRecognizer:tapGestureRecognizer1];
        }else{
            UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice2)];
            [_textLable addGestureRecognizer:tapGestureRecognizer2];
        }
      
        _textLable.textAlignment=NSTextAlignmentCenter;
        _textLable.textColor=COLOR(102, 102, 102, 1);
        _textLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        _textLable.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:_textLable];
    }else{
        _textField2 = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 60*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textField2.layer.borderWidth=1;
        _textField2.layer.cornerRadius=5;
        _textField2.tag=2000;
        _textField2.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        _textField2.textColor = COLOR(102, 102, 102, 1);
        _textField2.tintColor = COLOR(102, 102, 102, 1);
        _textField2.textAlignment=NSTextAlignmentCenter;
        _textField2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_view1 addSubview:_textField2];
        
    }
    
    
    UILabel *PV2Lable1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 95*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    PV2Lable1.text=@"";
    PV2Lable1.textAlignment=NSTextAlignmentCenter;
    PV2Lable1.tag=3000;
    PV2Lable1.textColor=COLOR(102, 102, 102, 1);
    PV2Lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    PV2Lable1.adjustsFontSizeToFitWidth=YES;
    [_view1 addSubview:PV2Lable1];
    
    _goBut.frame=CGRectMake(60*NOW_SIZE,165*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    
}


-(void)initThreeUI{
    NSString *High=@"高";
    NSString *Low=@"低";
    //低高
    NSArray *regiserArray=@[@52,@53,@54,@55,@56,@57,@58,@59,@60,@61,@62,@63,@64,@65,@66,@67,@68,@69,@70,@71,@72,@73,@74,@75,@76,@77,@78,@79];
 
    if (_CellNumber==14) {
        _nameArray0=@[[NSString stringWithFormat:@"%@(28)",High],[NSString stringWithFormat:@"%@(29)",Low]];
    }
    if (_CellNumber==15) {
        _nameArray0=@[@"经度(122)",@"纬度(123)"];
    }
   
    if (_CellNumber>15) {
        int K=0+(_CellNumber-16)*2;
        NSString *A1=[NSString stringWithFormat:@"%@(%@)",Low,regiserArray[K]];
        NSString *A2=[NSString stringWithFormat:@"%@(%@)",High,regiserArray[K+1]];
//        NSString *A3=[NSString stringWithFormat:@"%@(%@)",High,regiserArray[K]];
//        NSString *A4=[NSString stringWithFormat:@"%@(%@)",Low,regiserArray[K+1]];
        if (_CellNumber>15) {
            _nameArray0=@[A1,A2];
        }
        if (_CellNumber==17 || _CellNumber==19 || _CellNumber==21) {
            _nameArray0=@[A1,A2];
        }
    }

    
  
    
    float H=100*HEIGHT_SIZE;
    for (int i=0; i<2; i++) {
        UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 20*HEIGHT_SIZE+H*i, 300*NOW_SIZE,20*HEIGHT_SIZE )];
        PV2Lable.text=_nameArray0[i];
        PV2Lable.textAlignment=NSTextAlignmentLeft;
        PV2Lable.textColor=COLOR(102, 102, 102, 1);;
        PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        PV2Lable.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:PV2Lable];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 60*HEIGHT_SIZE+H*i, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        textField.layer.borderWidth=1;
        textField.layer.cornerRadius=5;
        textField.tag=2000+i;
        textField.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        textField.textColor = COLOR(102, 102, 102, 1);;
        textField.tintColor = COLOR(102, 102, 102, 1);;
        textField.textAlignment=NSTextAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_view1 addSubview:textField];
        
        UILabel *PV2Lable1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 95*HEIGHT_SIZE+H*i, 300*NOW_SIZE,20*HEIGHT_SIZE )];
        PV2Lable1.text=nil;
        PV2Lable1.textAlignment=NSTextAlignmentCenter;
        PV2Lable1.textColor=COLOR(102, 102, 102, 1);
        PV2Lable1.tag=3000+i;
        PV2Lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        PV2Lable1.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:PV2Lable1];
    }
    
    
    _goBut.frame=CGRectMake(60*NOW_SIZE,265*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_view1 addSubview:_goBut];
}


-(void)initFourUI{
    self.title=@"设置Model";
    NSArray *nameArray=@[@"A",@"B",@"D",@"T",@"P",@"U",@"M",@"S"];
    float W=ScreenWidth/nameArray.count;
    for (int i=0; i<nameArray.count; i++) {
        UILabel *PV2Lable1=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE+W*i, 30*HEIGHT_SIZE, W,30*HEIGHT_SIZE )];
        PV2Lable1.text=nameArray[i];
        PV2Lable1.textAlignment=NSTextAlignmentCenter;
        PV2Lable1.textColor=COLOR(102, 102, 102, 1);
        PV2Lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        PV2Lable1.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:PV2Lable1];
    }
 
    for (int i=0; i<nameArray.count; i++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0*NOW_SIZE+W*i, 60*HEIGHT_SIZE, W,30*HEIGHT_SIZE )];
        textField.layer.borderWidth=1;
        textField.layer.cornerRadius=5;
        textField.tag=4000+i;
        textField.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        textField.textColor = COLOR(102, 102, 102, 1);
        textField.tintColor = COLOR(102, 102, 102, 1);
        textField.textAlignment=NSTextAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_view1 addSubview:textField];
    }
    
    UILabel *PV2Lable1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 95*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    PV2Lable1.text=@"";
    PV2Lable1.textAlignment=NSTextAlignmentCenter;
    PV2Lable1.tag=3000;
    PV2Lable1.textColor=COLOR(102, 102, 102, 1);
    PV2Lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    PV2Lable1.adjustsFontSizeToFitWidth=YES;
    [_view1 addSubview:PV2Lable1];
    
        _goBut.frame=CGRectMake(60*NOW_SIZE,150*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
      [_view1 addSubview:_goBut];
}


-(void)finishSet{
    _setValueArray=[NSMutableArray new];
    _setRegisterArray=[NSMutableArray new];
//    NSArray *cmdValue=@[
//                        @"15",@"16",@"17",@"18",@"19",@"30",@"45",@"51",@"80",@"81",@"88",@"201",@"202",@"203",@"28",@"122",@"52",@"54",@"56",@"58",@"60",@"62",@"64",@"66",@"68",@"70",@"72",@"74",@"76",@"78"];
    
    NSArray *cmdValue=@[
                        @"30",@"45",@"17",@"18",@"19",@"15",@"16",@"51",@"80",@"81",@"88",@"201",@"202",@"203",@"28",@"122",@"52",@"54",@"56",@"58",@"60",@"62",@"64",@"66",@"68",@"70",@"72",@"74",@"76",@"78"];
    if (_CellTypy!=3) {
        if (_CellNumber<14) {
            if (_CellNumber==5 || _CellNumber==6 || _CellNumber==1  || _CellNumber==11 || _CellNumber==12) {
            }else{
                _setValue=_textField2.text;
            }
            if (_setValue==nil || [_setValue isEqualToString:@""]) {
                [self showToastViewWithTitle:@"请添加设置值"];
                return;
            }
            [_setRegisterArray addObject:cmdValue[_CellNumber]];
            [_setValueArray addObject:_setValue];
            if (_CellNumber==1) {
                _setRegisterArray=[NSMutableArray arrayWithArray:@[@45,@46,@47,@48,@49,@50]];
                _setValueArray=[NSMutableArray arrayWithArray:_timeArray];
            }
        }else if (_CellNumber>13 && _CellNumber<30){
            BOOL isWrite=NO;
            for (int i=0; i<_nameArray0.count; i++) {
                UITextField *textField1=[_view1 viewWithTag:2000+i];
                if (textField1.text==nil || [textField1.text isEqualToString:@""]) {}else{
                    isWrite=YES;
                }
                [_setValueArray addObject:textField1.text];
            }
            if (!isWrite) {
                [self showToastViewWithTitle:@"请添加设置值"];
                  return;
            }
            
            NSArray *regiserArray=@[@28,@29,@122,@123,@52,@53,@54,@55,@56,@57,@58,@59,@60,@61,@62,@63,@64,@65,@66,@67,@68,@69,@70,@71,@72,@73,@74,@75,@76,@77,@78,@79];
            int K=0+(_CellNumber-14)*2;
            _setRegisterArray=[NSMutableArray arrayWithArray:@[regiserArray[K],regiserArray[K+1]]];
            
        }
    }else{
        _setRegisterArray=[NSMutableArray arrayWithArray:@[@28,@29]];
        [self getModelDate];
    }
  

    [self setTwo];
       self.navigationItem.rightBarButtonItem.enabled=NO;
    [self showProgressView];
}

-(void)getModelDate{
    NSMutableArray *valueArray=[NSMutableArray new];
    for (int i=0; i<8; i++) {
        UITextField *lable=[_view1 viewWithTag:4000+i];
        if (lable.text==nil || [lable.text isEqualToString:@""]) {
                 [self showToastViewWithTitle:@"请添加设置值"];
            return;
        }
        [valueArray addObject:lable.text];
    }
    
    unsigned long v0 = strtoul([valueArray[0] UTF8String],0,16);
    unsigned long v1 = strtoul([valueArray[1] UTF8String],0,16);
    unsigned long v2 = strtoul([valueArray[2] UTF8String],0,16);
    unsigned long v3 = strtoul([valueArray[3] UTF8String],0,16);
    unsigned long value28=((v0 & 0xff)<<12)+((v1 & 0xff)<<8)+((v2 & 0xff)<<4)+(v3 & 0xff);
    
    unsigned long v4 = strtoul([valueArray[4] UTF8String],0,16);
    unsigned long v5 = strtoul([valueArray[5] UTF8String],0,16);
     unsigned long v6 = strtoul([valueArray[6] UTF8String],0,16);
     unsigned long v7 = strtoul([valueArray[7] UTF8String],0,16);
     unsigned long value29=((v4 & 0xff)<<12)+((v5 & 0xff)<<8)+((v6 & 0xff)<<4)+(v7 & 0xff);

    
    
     _setValueArray=[NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%ld",value28],[NSString stringWithFormat:@"%ld",value29]]];
    
}

-(void)readModelDate{
    NSString*ModelString;
    Byte *dataArray=(Byte*)[_receiveCmdTwoData bytes];
    int registerNum=0;
    int registerValue=(dataArray[2*registerNum]<<24)+(dataArray[2*registerNum+1]<<16)+(dataArray[2*registerNum+2]<<8)+dataArray[2*registerNum+3];
    
    NSString* T1=[[NSString stringWithFormat:@"%x",(registerValue & 0xf0000000)>>28] uppercaseString];
    NSString* T2=[[NSString stringWithFormat:@"%x",(registerValue & 0xf000000)>>24] uppercaseString];
    NSString* T3=[[NSString stringWithFormat:@"%x",(registerValue & 0xf00000)>>20] uppercaseString];
    NSString* T4=[[NSString stringWithFormat:@"%x",(registerValue & 0xf0000)>>16] uppercaseString];
    NSString* T5=[[NSString stringWithFormat:@"%x",(registerValue & 0x00f000)>>12] uppercaseString];
    NSString* T6=[[NSString stringWithFormat:@"%x",(registerValue & 0x000f00)>>8] uppercaseString];
    NSString* T7=[[NSString stringWithFormat:@"%x",(registerValue & 0x0000f0)>>4] uppercaseString];
    NSString* T8=[[NSString stringWithFormat:@"%x",(registerValue & 0x00000f)] uppercaseString];

    ModelString=[NSString stringWithFormat:@"A%@B%@D%@T%@P%@U%@M%@S%@",T1,T2,T3,T4,T5,T6,T7,T8];
      _readValueArray=@[ModelString];
}


-(void)setTwo{
    _cmdTcpTimes=0;
    _cmdTcpType=2;
    
    for (int i=0; i<_setValueArray.count; i++) {
        NSString*setValueString=_setValueArray[i];
        if (setValueString==nil || [setValueString isEqualToString:@""]) {
            [_setRegisterArray removeObjectAtIndex:i];
            [_setValueArray removeObjectAtIndex:i];
            i--;
        }
    }
    if (_setRegisterArray.count==0 || _setValueArray.count==0) {
        [self showAlertViewWithTitle:@"设置失败,请重新进入页面进行设置" message:nil cancelButtonTitle:root_OK];
    }
    if (_setRegisterArray.count!=_setValueArray.count){
        [self showAlertViewWithTitle:@"设置失败,请重新进入页面进行设置" message:nil cancelButtonTitle:root_OK];
    }
    [_ControlOne goToOneTcp:3 cmdNum:(int)_setValueArray.count cmdType:@"6" regAdd:_setRegisterArray[_cmdTcpTimes] Length:_setValueArray[_cmdTcpTimes]];
    
    
}

-(void)showTheChoice2{
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    
    _date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, SCREEN_Height-300*HEIGHT_SIZE, SCREEN_Width, 300*HEIGHT_SIZE)];
    _date.backgroundColor=[UIColor whiteColor];
    _date.datePickerMode=UIDatePickerModeDateAndTime;
    [self.view addSubview:_date];
    
    if (self.toolBar) {
        [UIView animateWithDuration:0.3f animations:^{
            self.toolBar.alpha = 1;
            self.toolBar.frame = CGRectMake(0, SCREEN_Height-300*HEIGHT_SIZE-44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            [self.view addSubview:_toolBar];
        }];
    } else {
        self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_Height-300*HEIGHT_SIZE-44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE)];
        self.toolBar.barStyle = UIBarStyleDefault;
        self.toolBar.barTintColor = MainColor;
        [self.view addSubview:self.toolBar];
        
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(removeToolBar)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(completeSelectDate:)];
        
        UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
        
        spaceButton.tintColor=[UIColor whiteColor];
        doneButton.tintColor=[UIColor whiteColor];
        
        self.toolBar.items = @[spaceButton,flexibleitem,doneButton];
    }
}

-(void)removeToolBar{
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}


- (void)completeSelectDate:(UIToolbar *)toolBar {
    self.currentDay = [self.dayFormatter stringFromDate:self.date.date];
    _textLable.text=_currentDay;
    
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
 
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self.date.date];
    
    NSInteger year=[components year]-2000;
    NSInteger month=[components month];
    NSInteger day=[components day];
 
      // [self.dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSString *hour = [dateFormatter stringFromDate:self.date.date];
    [dateFormatter setDateFormat:@"mm"];
    NSString *min = [dateFormatter stringFromDate:self.date.date];
    [dateFormatter setDateFormat:@"ss"];
    NSString *sec = [dateFormatter stringFromDate:self.date.date];
    
    _timeArray=@[[NSString stringWithFormat:@"%ld",year],[NSString stringWithFormat:@"%ld",month],[NSString stringWithFormat:@"%ld",day],hour,min,sec];
       _setValue=[NSString stringWithFormat:@"%ld",year];
}

-(void)showTheChoice{
    if (_CellNumber==12){
        _choiceArray=@[@"On(0)",@"Off(1)"];
    }
    if (_CellNumber==11 ){
        _choiceArray=@[@"Automatic(0)",@"Continual(1)",@"Overnight(2)"];
    }
    if (_CellNumber==5 ){
        _choiceArray=@[@"0",@"1",@"2",@"3",@"4",@"5"];
    }
    if (_CellNumber==6){
        _choiceArray=@[@"Need to select(0)",@"Have selected(1)"];
    }
    [ZJBLStoreShopTypeAlert showWithTitle:@"选择设置值" titles:_choiceArray selectIndex:^(NSInteger SelectIndexNum){
        
        _setValue=[NSString stringWithFormat:@"%ld",SelectIndexNum];
    } selectValue:^(NSString* valueString){
        _textLable.text=valueString;
        
    } showCloseButton:YES];
    
}



-(void)readValueToTcp{
       self.navigationItem.rightBarButtonItem.enabled=NO;
    [self showProgressView];
    _cmdTcpType=1;
    
//    NSArray *cmdValue=@[
//                        @"15",@"16",@"17",@"18",@"19",@"30",@"45",@"51",@"80",@"81",@"88",@"201",@"202",@"203",@"28",@"122",@"52",@"54",@"56",@"58",@"60",@"62",@"64",@"66",@"68",@"70",@"72",@"74",@"76",@"78"];
    
    NSArray *cmdValue=@[
                        @"30",@"45",@"17",@"18",@"19",@"15",@"16",@"51",@"80",@"81",@"88",@"201",@"202",@"203",@"28",@"122",@"52",@"54",@"56",@"58",@"60",@"62",@"64",@"66",@"68",@"70",@"72",@"74",@"76",@"78"];
    
    if (_CellTypy!=3) {
          _setRegister=cmdValue[_CellNumber];
    }else{
        _setRegister=@"28";
        _cmdRegisterNum=2;
    }
  
    _isFirstReadOK=NO;
    [_ControlOne goToOneTcp:2 cmdNum:1 cmdType:@"3" regAdd:_setRegister Length:[NSString stringWithFormat:@"%d",_cmdRegisterNum]];
    
    
}

-(void)removeTheWaitingView{
    [self hideProgressView];
    self.navigationItem.rightBarButtonItem.enabled=YES;
}

-(void)receiveFirstData2:(NSNotification*) notification{
    if (_cmdTcpType==1) {
         [self performSelector:@selector(removeTheWaitingView) withObject:nil afterDelay:0.1];
    }else{
        if (_cmdTcpTimes==0) {
            float times=1.2;
            if (_setRegisterArray.count>0) {
                times=1.2*_setRegisterArray.count;
            }
            [self performSelector:@selector(removeTheWaitingView) withObject:nil afterDelay:times];
        }
    }

    if (_cmdTcpType==1) {
        _isFirstReadOK=YES;
        NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
        _receiveCmdTwoData=[firstDic objectForKey:@"one"];
        NSUInteger Lenth=_receiveCmdTwoData.length;
        if (Lenth<_cmdRegisterNum*2) {
            [self showAlertViewWithTitle:@"读取失败" message:nil cancelButtonTitle:root_OK];
            return;
        }
        NSMutableArray *valueArray=[NSMutableArray new];
        for (int i=0; i<_cmdRegisterNum; i++) {
            NSString *value0=[NSString stringWithFormat:@"%d",[_changeDataValue changeOneRegister:_receiveCmdTwoData registerNum:i]];
          
                [valueArray addObject:value0];

        }
        _readValueArray=[NSArray arrayWithArray:valueArray];
        if (_CellTypy==3) {
            [self readModelDate];
        }
        
        [self showLableValue];
    }else{
        _cmdTcpTimes++;
        if (_cmdTcpTimes==_setRegisterArray.count) {
            [self showAlertViewWithTitle:@"设置成功" message:nil cancelButtonTitle:root_OK];
        }else{
               self.navigationItem.rightBarButtonItem.enabled=NO;
            [self showProgressView];
          
            
            [_ControlOne goToOneTcp:3 cmdNum:(int)_setValueArray.count cmdType:@"6" regAdd:_setRegisterArray[_cmdTcpTimes] Length:_setValueArray[_cmdTcpTimes]];
            
        }
        
    }
    
}


-(void)setFailed{
    [self removeTheWaitingView];
        [self removeTheTcp];
    
    if (_cmdTcpType==1) {
        if (!_isFirstReadOK) {
            [self showAlertViewWithTitle:@"读取数据失败" message:@"请重试或检查网络连接" cancelButtonTitle:root_OK];
        }
        
    }
    if (_cmdTcpType==2) {
        
        [self showAlertViewWithTitle:@"设置失败" message:@"请查看设置范围或检查网络连接" cancelButtonTitle:root_OK];
    }
}

-(void)showLableValue{
    
    for (int i=0; i<_readValueArray.count; i++) {
        UILabel *lable=[_view1 viewWithTag:3000+i];
        lable.text=[NSString stringWithFormat:@"(读取值:%@)",_readValueArray[i]];
        if (_CellNumber==1) {
            lable.text=[NSString stringWithFormat:@"(读取值:%@-%@-%@ %@:%@:%@)",_readValueArray[0],_readValueArray[1],_readValueArray[2],_readValueArray[3],_readValueArray[4],_readValueArray[5]];
        }
    }

    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    if (_CellTypy==1) {
        UITextField *lable=[_view1 viewWithTag:2000];
        [lable resignFirstResponder];
    }else  if (_CellTypy==2) {
        for (int i=0; i<2; i++) {
            UITextField *lable=[_view1 viewWithTag:2000+i];
            [lable resignFirstResponder];
        }
    }else{
        for (int i=0; i<_nameArray0.count; i++) {
            UITextField *lable=[_view1 viewWithTag:2000+i];
            [lable resignFirstResponder];
        }
        
    }
    if (_CellTypy==3) {
        for (int i=0; i<8; i++) {
            UITextField *lable=[_view1 viewWithTag:4000+i];
            [lable resignFirstResponder];
        }
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

    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveWifiConrolTwo" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveWifiConrolTwoFailed" object:nil];
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
