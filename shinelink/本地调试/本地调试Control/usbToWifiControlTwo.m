//
//  usbToWifiControlTwo.m
//  ShinePhone
//
//  Created by sky on 2017/10/27.
//  Copyright © 2017年 sky. All rights reserved.
//



#import "usbToWifiControlTwo.h"
#import "ZJBLStoreShopTypeAlert.h"

@interface usbToWifiControlTwo ()
@property(nonatomic,strong)UIScrollView*view1;
@property(nonatomic,assign) int cmdTcpType;
@property(nonatomic,assign) int cmdTcpTimes;
@property(nonatomic,strong)NSMutableArray*setValueArray;
@property(nonatomic,strong)NSMutableArray*setRegisterArray;
@property(nonatomic,assign)BOOL isFirstReadOK;

@end

@implementation usbToWifiControlTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_MAX_370 style:UIBarButtonItemStylePlain target:self action:@selector(readValueToTcp)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
    }
    if (!_changeDataValue) {
        _changeDataValue=[[usbToWifiDataControl alloc]init];
    }
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFirstData2:) name: @"TcpReceiveWifiConrolTwo" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFailed) name: @"TcpReceiveWifiConrolTwoFailed" object:nil];
    
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
    [_goBut setTitle:root_MAX_371 forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(finishSetTwo) forControlEvents:UIControlEventTouchUpInside];
      [_view1 addSubview:_goBut];
    
    if (_CellNumber<_OneSetInt) {
        _cmdRegisterNum=1;
    }else  if (_CellNumber>_twoSetBeginInt && _CellNumber<_twoSetOverInt) {
        _cmdRegisterNum=2;
    }else if (_CellNumber==30 || _CellNumber==29){
        _cmdRegisterNum=8;
    }else if (_CellNumber==28){
        _cmdRegisterNum=6;
    }
    
    if (_CellTypy==1) {
        [self initTwoUI];
    }else  if (_CellTypy==2) {
        [self initThreeUI];
    }else{
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
    
    if (_CellNumber==0  || _CellNumber==8 || _CellNumber==9 || _CellNumber==15 || _CellNumber==16 || _CellNumber==17 || _CellNumber==18 || _CellNumber==19 || _CellNumber==20 || _CellNumber==21) {
        _textLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 60*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textLable.text=root_MIX_223;
        _textLable.userInteractionEnabled=YES;
        _textLable.layer.borderWidth=1;
        _textLable.layer.cornerRadius=5;
        _textLable.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice)];
        [_textLable addGestureRecognizer:tapGestureRecognizer1];
        _textLable.textAlignment=NSTextAlignmentCenter;
        _textLable.textColor=COLOR(102, 102, 102, 1);;
        _textLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        _textLable.adjustsFontSizeToFitWidth=YES;
        if (_CellNumber==9) {
            _setValue=@"0";
        }else{
              [_view1 addSubview:_textLable];
        }
      
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
    
    
    if (_CellNumber==2 || _CellNumber==3 || _CellNumber==4 || _CellNumber==5 || _CellNumber==6 ) {
        UILabel *PV2Lable2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 120*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
        PV2Lable2.text=root_MAX_377;
        PV2Lable2.textAlignment=NSTextAlignmentLeft;
        PV2Lable2.textColor=COLOR(102, 102, 102, 1);
        PV2Lable2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        PV2Lable2.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:PV2Lable2];
        
        _textLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 150*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textLable.text=root_MAX_378;
        _setValue=@"1";
        _textLable.userInteractionEnabled=YES;
        _textLable.layer.borderWidth=1;
        _textLable.layer.cornerRadius=5;
        _textLable.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice)];
        [_textLable addGestureRecognizer:tapGestureRecognizer1];
        _textLable.textAlignment=NSTextAlignmentCenter;
        _textLable.textColor=COLOR(102, 102, 102, 1);;
        _textLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        _textLable.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:_textLable];
    }
    
    _goBut.frame=CGRectMake(60*NOW_SIZE,220*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
  
}


-(void)initThreeUI{

    _lableNameArray=@[@[[NSString stringWithFormat:@"%@(20)",root_MAX_379],[NSString stringWithFormat:@"%@(21)",root_MAX_380]],@[[NSString stringWithFormat:@"%@(93)",root_MAX_381],[NSString stringWithFormat:@"%@(94)",root_MAX_382]],@[[NSString stringWithFormat:@"%@(95)",root_MAX_383],[NSString stringWithFormat:@"%@(96)",root_MAX_384]],@[[NSString stringWithFormat:@"%@(97)",root_MAX_385],[NSString stringWithFormat:@"%@(98)",root_MAX_386]],@[[NSString stringWithFormat:@"%@(99)",root_MAX_387],[NSString stringWithFormat:@"%@(100)",root_MAX_388]],@[[NSString stringWithFormat:@"%@1(233)",root_MAX_389],[NSString stringWithFormat:@"%@2(234)",root_MAX_389]]];
    _nameArray0=[NSArray arrayWithArray:_lableNameArray[_CellNumber-_OneSetInt]];
    
    
    
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
  //    [NSString stringWithFormat:@"%@4(117)",root_MAX_392];
    NSArray* nameArray=@[@[[NSString stringWithFormat:@"%@1(101)",root_MAX_390],[NSString stringWithFormat:@"%@2(102)",root_MAX_390],[NSString stringWithFormat:@"%@3(103)",root_MAX_390],[NSString stringWithFormat:@"%@4(104)",root_MAX_390],[NSString stringWithFormat:@"%@5(105)",root_MAX_390],[NSString stringWithFormat:@"%@6(106)",root_MAX_390],],@[[NSString stringWithFormat:@"%@1(110)",root_MAX_391],[NSString stringWithFormat:@"%@2(112)",root_MAX_391],[NSString stringWithFormat:@"%@3(114)",root_MAX_391],[NSString stringWithFormat:@"%@4(116)",root_MAX_391]],@[[NSString stringWithFormat:@"%@1(111)",root_MAX_392],[NSString stringWithFormat:@"%@2(113)",root_MAX_392],[NSString stringWithFormat:@"%@3(115)",root_MAX_392],[NSString stringWithFormat:@"%@4(117)",root_MAX_392]]];
    
    if (_CellNumber==28) {
        _nameArray0=nameArray[0];
        _goBut.frame=CGRectMake(60*NOW_SIZE,665*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
        _view1.contentSize=CGSizeMake(SCREEN_Width,  SCREEN_Height*2);
    }else if (_CellNumber==29) {
        _nameArray0=nameArray[1];
        _goBut.frame=CGRectMake(60*NOW_SIZE,435*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    }else if (_CellNumber==30) {
        _nameArray0=nameArray[2];
        _goBut.frame=CGRectMake(60*NOW_SIZE,435*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
        
    }
    
    [_view1 addSubview:_goBut];
    
    float H=100*HEIGHT_SIZE;
    for (int i=0; i<_nameArray0.count; i++) {
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
        PV2Lable1.text=@"";
        PV2Lable1.textAlignment=NSTextAlignmentCenter;
        PV2Lable1.tag=3000+i;
        PV2Lable1.textColor=COLOR(102, 102, 102, 1);
        PV2Lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        PV2Lable1.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:PV2Lable1];
    }
    
    
}


-(void)finishSetTwo{
    _setValueArray=[NSMutableArray new];
    _setRegisterArray=[NSMutableArray new];
    NSArray *cmdValue=@[
                        @"0",@"1",@"3",@"4",@"4",@"5",@"5",@"8",@"22",@"89",@"91",@"92",@"107",@"108",@"109",@"230",@"231",@"232",@"235",@"236",@"237",@"238",@"20",@"93",@"95",@"97",@"99",@"233",@"101",@"110",@"110"];
    
    if (_CellNumber<_OneSetInt) {
        if (_CellNumber==2 || _CellNumber==3 || _CellNumber==4 || _CellNumber==5 || _CellNumber==6 ) {
            if (_textField2.text==nil || [_textField2.text isEqualToString:@""]) {
                [self showToastViewWithTitle:root_MAX_375];
                return;
            }
                 [_setRegisterArray addObject:@"2"];                //记忆使能
              [_setValueArray addObject:_setValue];
            
            [_setRegisterArray addObject:cmdValue[_CellNumber]];   //设置值
            if (_CellNumber==5 || _CellNumber==6 ) {
                float value1=0;
                if (_CellNumber==5) {
                       value1=[_textField2.text floatValue]*10000+10000;
                }
                if (_CellNumber==6) {
                    value1=10000-[_textField2.text floatValue]*10000;
                }
                   [_setValueArray addObject:[NSString stringWithFormat:@"%.f",value1]];
            }else{
                     [_setValueArray addObject:_textField2.text];
            }
         
            
            if ( _CellNumber==3 || _CellNumber==4 || _CellNumber==5 || _CellNumber==6 ) {             //PF模式
                  [_setRegisterArray addObject:@"89"];
                if (_CellNumber==3) {
                    [_setValueArray addObject:@"5"];
                }
                if (_CellNumber==4) {
                    [_setValueArray addObject:@"4"];
                }
                if (_CellNumber==5 || _CellNumber==6) {
                    [_setValueArray addObject:@"1"];
                }
            }
            
            
         
            
        }else{
            if (_CellNumber==0 || _CellNumber==2 || _CellNumber==8 || _CellNumber==9 || _CellNumber==15 || _CellNumber==16 || _CellNumber==17 || _CellNumber==18 || _CellNumber==19 || _CellNumber==20 || _CellNumber==21) {
            }else{
                _setValue=_textField2.text;
            }
            if (_setValue==nil || [_setValue isEqualToString:@""]) {
                [self showToastViewWithTitle:root_MAX_375];
                return;
            }
            [_setRegisterArray addObject:cmdValue[_CellNumber]];
            [_setValueArray addObject:_setValue];
        }
       
    }else{
        BOOL isWrite=NO;
        for (int i=0; i<_nameArray0.count; i++) {
            UITextField *textField1=[_view1 viewWithTag:2000+i];
            if (textField1.text==nil || [textField1.text isEqualToString:@""]) {
                
            }else{
                isWrite=YES;
            }
             [_setValueArray addObject:textField1.text];
        }
        if (!isWrite) {
             [self showToastViewWithTitle:root_MAX_375];
            return;
        }
        
        if (_CellNumber>_twoSetBeginInt && _CellNumber<_twoSetOverInt) {
            NSArray *cmdValue1=@[@[@"20",@"21"],@[@"93",@"94"],@[@"95",@"96"],@[@"97",@"98"],@[@"99",@"100"],@[@"233",@"234"]];
            _setRegisterArray=[NSMutableArray arrayWithArray:cmdValue1[_CellNumber-_OneSetInt]];
        }else if (_CellNumber==29 || _CellNumber==30){
            NSArray *cmdValue1=@[@[@"110",@"112",@"114",@"116"],@[@"111",@"113",@"115",@"117"]];
            _setRegisterArray=[NSMutableArray arrayWithArray:cmdValue1[_CellNumber-29]];
        }else if (_CellNumber==28){
            _setRegisterArray=[NSMutableArray arrayWithArray:@[@"101",@"102",@"103",@"104",@"105",@"106"]];
        }
    }
    
    if (_CellNumber==7 || _CellNumber==27) {
        [self showAlertViewWithTitle:root_MAX_393 message:nil cancelButtonTitle:root_OK];
        return;
    }
    
    [self setTwo];
        self.navigationItem.rightBarButtonItem.enabled=NO;
    [self showProgressView];
}

-(void)setTwo{
    _cmdTcpTimes=0;
    _cmdTcpType=2;
    
  //  NSInteger forNum=_setValueArray.count;
    for (int i=0; i<_setValueArray.count; i++) {
        NSString*setValueString=_setValueArray[i];
        if (setValueString==nil || [setValueString isEqualToString:@""]) {
            [_setRegisterArray removeObjectAtIndex:i];
               [_setValueArray removeObjectAtIndex:i];
            i--;
        }
    }
    if (_setRegisterArray.count==0 || _setValueArray.count==0) {
         [self showAlertViewWithTitle:root_MAX_362 message:nil cancelButtonTitle:root_OK];
    }
    if (_setRegisterArray.count!=_setValueArray.count){
            [self showAlertViewWithTitle:root_MAX_362 message:nil cancelButtonTitle:root_OK];
    }
    
    [_ControlOne goToOneTcp:6 cmdNum:(int)_setValueArray.count cmdType:@"6" regAdd:_setRegisterArray[_cmdTcpTimes] Length:_setValueArray[_cmdTcpTimes]];
    
    
}



-(void)showTheChoice{
    if (_CellNumber==0  || _CellNumber==16 || _CellNumber==17 || _CellNumber==18 || _CellNumber==19 || _CellNumber==20){
        _choiceArray=@[@"Off(0)",@"On(1)"];
    }
    if (_CellNumber==9 ){
        _choiceArray=@[@"PF=1(0)",@"PF by set(1)",@"Default PF line(2)",@"User PF line(3)",@"UnderExcited(Inda)Reactive Power(4)",@"OverExcited(Capa)Reactive Power(5)",@"Q(v)model(6)"];
    }
    if (_CellNumber==21 ){
        _choiceArray=@[@"0",@"1",@"2"];
    }
    if (_CellNumber==8 ){
        _choiceArray=@[@"9600(0)",@"38400(1)",@"115200(2)"];
    }
    if (_CellNumber==15 ){
       _choiceArray=@[@"On(0)",@"Off(1)"];
    }
    if (_CellNumber==2 || _CellNumber==3 || _CellNumber==4 || _CellNumber==5 || _CellNumber==6 ) {
         _choiceArray=@[[NSString stringWithFormat:@"%@(0)",root_MAX_394],[NSString stringWithFormat:@"%@(1)",root_MAX_395]];
        
    }
    [ZJBLStoreShopTypeAlert showWithTitle:root_MIX_224 titles:_choiceArray selectIndex:^(NSInteger SelectIndexNum){
        
        _setValue=[NSString stringWithFormat:@"%ld",SelectIndexNum];
    } selectValue:^(NSString* valueString){
        _textLable.text=valueString;
        
    } showCloseButton:YES];
    
}

-(void)removeTheWaitingView{
    [self hideProgressView];
    self.navigationItem.rightBarButtonItem.enabled=YES;
}

-(void)readValueToTcp{
    [self showProgressView];
      self.navigationItem.rightBarButtonItem.enabled=NO;
    
    
    
    _cmdTcpType=1;
//    NSArray *cmdValue=@[
// @"0",@"1",@"2",@"3",@"4",@"5",@"8",@"22",@"89",@"91",@"92",@"107",@"108",@"109",@"230",@"231",@"232",@"235",@"236",@"237",@"238",@"20",@"93",@"95",@"97",@"99",@"233",@"101",@"110",@"110"];
    
    NSArray *cmdValue=@[
                        @"0",@"1",@"3",@"4",@"4",@"5",@"5",@"8",@"22",@"89",@"91",@"92",@"107",@"108",@"109",@"230",@"231",@"232",@"235",@"236",@"237",@"238",@"20",@"93",@"95",@"97",@"99",@"233",@"101",@"110",@"110"];
    
    _isFirstReadOK=NO;
    _setRegister=cmdValue[_CellNumber];
    
 [_ControlOne goToOneTcp:7 cmdNum:1 cmdType:@"3" regAdd:_setRegister Length:[NSString stringWithFormat:@"%d",_cmdRegisterNum]];
   
    
}

-(void)receiveFirstData2:(NSNotification*) notification{
     [self performSelector:@selector(removeTheWaitingView) withObject:nil afterDelay:TCP_hide_time];
    
    if (_cmdTcpType==1) {
         _isFirstReadOK=YES;
        NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
        _receiveCmdTwoData=[firstDic objectForKey:@"one"];
        NSUInteger Lenth=_receiveCmdTwoData.length;
        if (Lenth<_cmdRegisterNum*2) {
             [self showAlertViewWithTitle:root_MAX_376 message:nil cancelButtonTitle:root_OK];
            return;
        }
        NSMutableArray *valueArray=[NSMutableArray new];
        for (int i=0; i<_cmdRegisterNum; i++) {
            
            NSString *value0=[NSString stringWithFormat:@"%d",[_changeDataValue changeOneRegister:_receiveCmdTwoData registerNum:i]];
            
            if (_CellNumber==5 || _CellNumber==6 ) {
                float valueInt0=[value0 intValue]-10000;
                float valueInt=valueInt0/10000;
                value0=[NSString stringWithFormat:@"%.4f",valueInt];
            }
            
            if (_CellNumber==29) {          //PF限制负载百分比点
                if (i%2==0) {
                    [valueArray addObject:value0];
                }
            }else  if (_CellNumber==30) {                 //PF限制功率因数1~4
                if (i%2==1) {
                    [valueArray addObject:value0];
                }
                
            }else{
                [valueArray addObject:value0];
            }
            
        }
        _readValueArray=[NSArray arrayWithArray:valueArray];
        
        [self showLableValue];
    }else{
        _cmdTcpTimes++;
        if (_cmdTcpTimes==_setRegisterArray.count) {
                   [self showAlertViewWithTitle:root_MAX_303 message:nil cancelButtonTitle:root_OK];
        }else{
            self.navigationItem.rightBarButtonItem.enabled=NO;
            [self showProgressView];
            
                [_ControlOne goToOneTcp:6 cmdNum:(int)_setValueArray.count cmdType:@"6" regAdd:_setRegisterArray[_cmdTcpTimes] Length:_setValueArray[_cmdTcpTimes]];
               
        }
        
    }
   
}


-(void)setFailed{
    [self removeTheWaitingView];
//    [self removeTheTcp];
    
    if (_cmdTcpType==1) {
        if (!_isFirstReadOK) {
            //    [self showAlertViewWithTitle:@"读取数据失败" message:@"请重试或检查网络连接" cancelButtonTitle:root_OK];
        }
    
    }
    if (_cmdTcpType==2) {
        
           [self showAlertViewWithTitle:root_MAX_363 message:root_MAX_364 cancelButtonTitle:root_OK];
    }
}

-(void)showLableValue{
    
    for (int i=0; i<_readValueArray.count; i++) {
        UILabel *lable=[_view1 viewWithTag:3000+i];
        lable.text=[NSString stringWithFormat:@"(%@:%@)",root_MAX_369,_readValueArray[i]];
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
