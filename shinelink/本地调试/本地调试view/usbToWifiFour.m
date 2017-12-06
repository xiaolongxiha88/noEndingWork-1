//
//  usbToWifiFour.m
//  ShinePhone
//
//  Created by sky on 2017/11/2.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiFour.h"
#import "wifiToPvOne.h"
#import "LineViewForUsb.h"
#import "JHColumnChart.h"

@interface usbToWifiFour ()

@property(nonatomic,strong)UILabel *lable1;
@property(nonatomic,strong)NSArray *buttonName;
@property(nonatomic,strong)NSArray *lableNameArray;
@property(nonatomic,strong)NSArray *xlableNameArray;
@property(nonatomic,strong)wifiToPvOne*ControlOne;
@property(nonatomic,strong) NSString* setRegister;
@property(nonatomic,strong) NSString* setRegisterLength;
@property (nonatomic, strong) LineViewForUsb *LineViewForUsbView;
@property(nonatomic,strong)NSMutableDictionary *barDic;
@property(nonatomic,assign)int cmdType;

@property (nonatomic, strong) UILabel *xUnitLabel;
@property(nonatomic,assign)BOOL isSendCmdNow;

@end

@implementation usbToWifiFour

- (void)viewDidLoad {
    [super viewDidLoad];
 
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
    }
    if (!_changeDataValue) {
        _changeDataValue=[[usbToWifiDataControl alloc]init];
    }
    
 _isSendCmdNow=NO;
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFirstData5:) name: @"TcpReceiveDataFive" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFailed5) name: @"TcpReceiveDataFiveFailed" object:nil];
    
}

-(void)initUI{
     float layerW=1;
    _buttonName=@[@"Hour",@"Day",@"Month",@"Year"];
    _lableNameArray=@[@"最近24小时发电量",@"最近7天发电量",@"最近12个月发电量",@"最近20年发电量"];
        _xlableNameArray=@[@"(小时)",@"(天)",@"(月)",@"(年)"];
    
    for (int i=0; i<_buttonName.count; i++) {
        UIButton *selecteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selecteButton.frame = CGRectMake( SCREEN_Width/4*i, 0, SCREEN_Width/4, 40*HEIGHT_SIZE);
        [selecteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [selecteButton setTitleColor:MainColor forState:UIControlStateSelected];
        [selecteButton setTitle:_buttonName[i] forState:UIControlStateNormal];
        selecteButton.layer.borderWidth=layerW;
        selecteButton.layer.borderColor=COLOR(108, 199, 255, 1).CGColor;
        [self setButtonColor:selecteButton];
        selecteButton.tag = 1000+i;
        selecteButton.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
        if (i==0) {
              selecteButton.selected = YES;
        }else{
                    selecteButton.selected = NO;
        }
      
        [selecteButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selecteButton];
    }
 
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(0,40*HEIGHT_SIZE, SCREEN_Width, 100*HEIGHT_SIZE)];
    V1.backgroundColor=MainColor;
    [self.view addSubview:V1];
    
   _lable1=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 40*HEIGHT_SIZE, SCREEN_Width,20*HEIGHT_SIZE )];
    _lable1.text=_lableNameArray[0];
    _lable1.textAlignment=NSTextAlignmentCenter;
    _lable1.textColor=[UIColor whiteColor];
    _lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    _lable1.adjustsFontSizeToFitWidth=YES;
    [V1 addSubview:_lable1];
    
    _xUnitLabel=[[UILabel alloc]initWithFrame:CGRectMake(200*NOW_SIZE, 445*HEIGHT_SIZE, 100*NOW_SIZE,20*HEIGHT_SIZE )];
    _xUnitLabel.text=_xlableNameArray[0];
    _xUnitLabel.textAlignment=NSTextAlignmentRight;
    _xUnitLabel.textColor=COLOR(102, 102, 102, 1);
    _xUnitLabel.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    _xUnitLabel.adjustsFontSizeToFitWidth=YES;

    
        [self cmdForData:1000];
    
}

- (void)buttonDidClicked:(UIButton *)sender {
      _isSendCmdNow=YES;
    
     for (int i=0; i<_buttonName.count; i++) {
      UIButton *button=[self.view viewWithTag:1000+i];
         if ((i+1000)==(sender.tag)) {
             button.selected=YES;
             _lable1.text=_lableNameArray[i];
             _xUnitLabel.text=_xlableNameArray[i];
         }else{
                button.selected=NO;
         }
    }

    [self cmdForData:(int)sender.tag];
}



-(void)cmdForData:(int)cmdType{
    int K=cmdType-1000;
    _cmdType=K;
    
    NSArray*setRegisterArray=@[@"284",@"332",@"346",@"375"];
    NSArray*setLenthArray=@[@"48",@"14",@"24",@"40"];
    
    [self showProgressView];
    
  
    [_ControlOne goToOneTcp:5 cmdNum:1 cmdType:@"4" regAdd:setRegisterArray[K] Length:setLenthArray[K]];
    
    
}



-(void)removeTheWaitingView{
    [self hideProgressView];
  
}


-(void)receiveFirstData5:(NSNotification*) notification{
   _isSendCmdNow=NO;
    
        [self.view addSubview:_xUnitLabel];
    
         [self performSelector:@selector(removeTheWaitingView) withObject:nil afterDelay:1];
    
    _barDic=[NSMutableDictionary new];

        NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
    NSData *cmdData=[firstDic objectForKey:@"one"];
    

    int lenth=(int)[cmdData length];
    for (int i=0; i<lenth/4; i++) {
        int T=0+2*i;
            NSString *numString=[NSString stringWithFormat:@"%d",i+1];
        float value=[_changeDataValue changeTwoRegister:cmdData registerNum:T]/10;
        [_barDic setObject:[NSString stringWithFormat:@"%.1f",value] forKey:numString];
        
    //    [_barDic setObject:[NSString stringWithFormat:@"%d",T] forKey:numString];
    }

    if (lenth>0) {
          [self getBarUI];
    }
  
    
}


-(void)getBarUI{
    if (!_LineViewForUsbView) {
        self.LineViewForUsbView = [[LineViewForUsb alloc] initWithFrame:CGRectMake(0, 110*HEIGHT_SIZE, SCREEN_Width, 300*HEIGHT_SIZE)];
        self.LineViewForUsbView.barTypeNum=1;
        self.LineViewForUsbView.unitLaleName=root_Energy;
        [self.view addSubview:self.LineViewForUsbView];
    }

         [self.LineViewForUsbView refreshBarChartViewWithDataDict:_barDic chartType:_cmdType];
    
    
    
    
 
    
    
    
    
    
}


-(void)setFailed5{
     [self hideProgressView];

                [self showAlertViewWithTitle:@"读取数据失败" message:@"请重试或检查网络连接" cancelButtonTitle:root_OK];
  

   
}



-(void)setButtonColor:(UIButton*)button{
    
    [button setBackgroundImage:[self createImageWithColor:COLOR(0, 151, 245, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateNormal];
    [button setBackgroundImage:[self createImageWithColor:[UIColor whiteColor] rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[self createImageWithColor:[UIColor whiteColor] rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateSelected];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    if (_ControlOne) {
        [_ControlOne disConnect];
    }
 
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveDataFive" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveDataFiveFailed" object:nil];
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
