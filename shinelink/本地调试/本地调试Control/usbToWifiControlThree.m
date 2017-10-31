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
@end

@implementation usbToWifiControlThree

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
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFirstData2:) name: @"TcpReceiveDataTwo" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFailed) name: @"TcpReceiveDataTwoFailed" object:nil];
        
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
    
    if (_CellTypy==1) {
        [self initTwoUI];
    }else  if (_CellTypy==2) {
        [self initThreeUI];
    }
    
    
    
}


-(void)initTwoUI{
    _nameArray0=@[_titleString];
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 20*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    PV2Lable.text=_titleString;
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=COLOR(102, 102, 102, 1);;
    PV2Lable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    PV2Lable.adjustsFontSizeToFitWidth=YES;
    [_view1 addSubview:PV2Lable];
    
    if (_CellNumber==0 || _CellNumber==1 || _CellNumber==6 || _CellNumber==10 || _CellNumber==11 || _CellNumber==12) {
        _textLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 60*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textLable.text=@"点击选择";
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
    }else{
        _textField2 = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 60*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textField2.layer.borderWidth=1;
        _textField2.layer.cornerRadius=5;
        _textField2.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        _textField2.textColor = COLOR(102, 102, 102, 1);;
        _textField2.tintColor = COLOR(102, 102, 102, 1);;
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
    NSArray *regiserArray=@[@52,@53,@54,@55,@56,@57,@58,@59,@60,@61,@62,@63,@64,@65,@66,@67,@68,@69,@70,@71,@72,@73,@74,@75,@76,@77,@78];
    
    _lableNameArray=@[@[@"经度(122)",@"纬度(123)"],@[@"低(52)",@"高(53)"],@[@"高(54)",@"低(55)"],@[@"低(56)",@"高(57)"],@[@"高(58)",@"低(59)"],@[@"低(60)",@"高(61)"],@[@"高(62)",@"低(63)"],];
    
    if (_CellNumber==15) {
        _nameArray0=@[@"经度(122)",@"纬度(123)"];
    }
    _nameArray0=[NSArray arrayWithArray:_lableNameArray[_CellNumber-21]];
    
    
    
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
    
    NSArray* nameArray=@[@[@"PF调整值1(101)",@"PF调整值2(102)",@"PF调整值3(103)",@"PF调整值4(104)",@"PF调整值5(105)",@"PF调整值6(106)",],@[@"PF限制负载百分比点1(110)",@"PF限制负载百分比点2(112)",@"PF限制负载百分比点3(114)",@"PF限制负载百分比点4(116)"],@[@"PF限制功率因数点1(111)",@"PF限制功率因数点2(113)",@"PF限制功率因数点3(115)",@"PF限制功率因数点4(117)"]];
    
    if (_CellNumber==27) {
        _nameArray0=nameArray[0];
        _goBut.frame=CGRectMake(60*NOW_SIZE,665*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
        _view1.contentSize=CGSizeMake(SCREEN_Width,  SCREEN_Height*2);
    }else if (_CellNumber==28) {
        _nameArray0=nameArray[1];
        _goBut.frame=CGRectMake(60*NOW_SIZE,435*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    }else if (_CellNumber==29) {
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


-(void)finishSet{
    _setValueArray=[NSMutableArray new];
    _setRegisterArray=[NSMutableArray new];
    NSArray *cmdValue=@[
                        @"0",@"1",@"2",@"3",@"4",@"5",@"8",@"22",@"89",@"91",@"92",@"107",@"108",@"109",@"230",@"231",@"232",@"235",@"236",@"237",@"238",@"20",@"93",@"95",@"97",@"99",@"233",@"101",@"110",@"110"];
    
    if (_CellNumber<21) {
        if (_CellNumber==0 || _CellNumber==2 || _CellNumber==8 || _CellNumber==14 || _CellNumber==15 || _CellNumber==16 || _CellNumber==17 || _CellNumber==18 || _CellNumber==19 || _CellNumber==20) {
        }else{
            _setValue=_textField2.text;
        }
        if (_setValue==nil || [_setValue isEqualToString:@""]) {
            [self showToastViewWithTitle:@"请添加设置值"];
            return;
        }
        [_setRegisterArray addObject:cmdValue[_CellNumber]];
        [_setValueArray addObject:_setValue];
    }else{
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
        }
        
        if (_CellNumber>20 && _CellNumber<27) {
            NSArray *cmdValue1=@[@[@"20",@"21"],@[@"93",@"94"],@[@"95",@"96"],@[@"97",@"98"],@[@"99",@"100"],@[@"233",@"234"]];
            _setRegisterArray=[NSMutableArray arrayWithArray:cmdValue1[_CellNumber-21]];
        }else if (_CellNumber==28 || _CellNumber==29){
            NSArray *cmdValue1=@[@[@"110",@"112",@"114",@"116"],@[@"111",@"113",@"115",@"117"]];
            _setRegisterArray=[NSMutableArray arrayWithArray:cmdValue1[_CellNumber-28]];
        }else if (_CellNumber==27){
            _setRegisterArray=[NSMutableArray arrayWithArray:@[@"101",@"102",@"103",@"104",@"105",@"106"]];
        }
    }
    
    [self setTwo];
    [self showProgressView];
}

-(void)setTwo{
    _cmdTcpTimes=0;
    _cmdTcpType=2;
    
    for (int i=0; i<_setValueArray.count; i++) {
        NSString*setValueString=_setValueArray[i];
        if (setValueString==nil || [setValueString isEqualToString:@""]) {
            [_setRegisterArray removeObjectAtIndex:i];
            [_setValueArray removeObjectAtIndex:i];
        }
    }
    
    [_ControlOne goToOneTcp:3 cmdNum:(int)_setValueArray.count cmdType:@"6" regAdd:_setRegisterArray[_cmdTcpTimes] Length:_setValueArray[_cmdTcpTimes]];
    
    
}



-(void)showTheChoice{
    if (_CellNumber==0 || _CellNumber==2 ||  _CellNumber==14 || _CellNumber==15 || _CellNumber==16 || _CellNumber==17 || _CellNumber==18 || _CellNumber==19){
        _choiceArray=@[@"Off(0)",@"On(1)"];
    }
    if (_CellNumber==8 ){
        _choiceArray=@[@"PF=1(0)",@"PF by set(1)",@"Default PF line(2)",@"User PF line(3)",@"UnderExcited(Inda)Reactive Power(4)",@"OverExcited(Capa)Reactive Power(5)",@"Q(v)model(6)"];
    }
    if (_CellNumber==20 ){
        _choiceArray=@[@"0",@"1",@"2"];
    }
    
    [ZJBLStoreShopTypeAlert showWithTitle:@"选择设置值" titles:_choiceArray selectIndex:^(NSInteger SelectIndexNum){
        
        _setValue=[NSString stringWithFormat:@"%ld",SelectIndexNum];
    } selectValue:^(NSString* valueString){
        _textLable.text=valueString;
        
    } showCloseButton:YES];
    
}



-(void)readValueToTcp{
    [self showProgressView];
    _cmdTcpType=1;
    
    NSArray *cmdValue=@[
                        @"0",@"1",@"2",@"3",@"4",@"5",@"8",@"22",@"89",@"91",@"92",@"107",@"108",@"109",@"230",@"231",@"232",@"235",@"236",@"237",@"238",@"20",@"93",@"95",@"97",@"99",@"233",@"101",@"110",@"110"];
    
    _setRegister=cmdValue[_CellNumber];
    
    [_ControlOne goToOneTcp:2 cmdNum:1 cmdType:@"3" regAdd:_setRegister Length:[NSString stringWithFormat:@"%d",_cmdRegisterNum]];
    
    
}

-(void)receiveFirstData2:(NSNotification*) notification{
    [self hideProgressView];
    
    if (_cmdTcpType==1) {
        NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
        _receiveCmdTwoData=[firstDic objectForKey:@"one"];
        
        NSMutableArray *valueArray=[NSMutableArray new];
        for (int i=0; i<_cmdRegisterNum; i++) {
            NSString *value0=[NSString stringWithFormat:@"%d",[_changeDataValue changeOneRegister:_receiveCmdTwoData registerNum:i]];
            if (_CellNumber==28) {
                if (i%2==0) {
                    [valueArray addObject:value0];
                }
            }else  if (_CellNumber==29) {
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
            [self showAlertViewWithTitle:@"设置成功" message:nil cancelButtonTitle:root_OK];
        }else{
            [_ControlOne goToOneTcp:3 cmdNum:(int)_setValueArray.count cmdType:@"6" regAdd:_setRegisterArray[_cmdTcpTimes] Length:_setValueArray[_cmdTcpTimes]];
            
        }
        
    }
    
}


-(void)setFailed{
    [self hideProgressView];
    if (_cmdTcpType==1) {
        [self showAlertViewWithTitle:@"读取数据失败" message:@"请重试或检查网络连接" cancelButtonTitle:root_OK];
    }
    if (_cmdTcpType==2) {
        
        [self showAlertViewWithTitle:@"设置失败" message:@"请查看设置范围或检查网络连接" cancelButtonTitle:root_OK];
    }
}

-(void)showLableValue{
    
    for (int i=0; i<_readValueArray.count; i++) {
        UILabel *lable=[_view1 viewWithTag:3000+i];
        lable.text=[NSString stringWithFormat:@"(读取值:%@)",_readValueArray[i]];
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
