//
//  usbToWifiWarnList.m
//  ShinePhone
//
//  Created by sky on 2017/12/4.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiWarnList.h"
#import "wifiToPvOne.h"
#import "usbToWifiWarnListCell.h"

@interface usbToWifiWarnList ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)wifiToPvOne*ControlOne;
@property(nonatomic,assign)BOOL isfirstData;
@property(nonatomic,assign)int cmdTime;
@property(nonatomic,strong)NSMutableArray *codeArray;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *valueArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIBarButtonItem *rightItem;

@end

@implementation usbToWifiWarnList

- (void)viewDidLoad {
    [super viewDidLoad];
  
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
    }
    
    _rightItem=[[UIBarButtonItem alloc]initWithTitle:root_MAX_322 style:UIBarButtonItemStylePlain target:self action:@selector(getDataFirst)];
    self.navigationItem.rightBarButtonItem=_rightItem;
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    
    [self getDataFirst];
}

-(void)getDataFirst{
    [self showProgressView];
    _rightItem.enabled=NO;
        [self performSelector:@selector(removeTheWaitingView) withObject:nil afterDelay:5];
    
    _cmdTime=0;
    _isfirstData=YES;
    [self removeTheTcp];
         [_ControlOne goToOneTcp:2 cmdNum:1 cmdType:@"4" regAdd:@"500" Length:@"125"];
}

-(void)removeTheWaitingView{
    [self hideProgressView];
    _rightItem.enabled=YES;
}

-(void)viewWillAppear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFirstData2:) name: @"TcpReceiveDataTwo" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFailed) name: @"TcpReceiveDataTwoFailed" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_ControlOne) {
        [_ControlOne disConnect];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveDataTwo" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveDataTwoFailed" object:nil];
    
}

-(void)receiveFirstData2:(NSNotification*) notification{
    NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
    NSData *receiveData=[firstDic objectForKey:@"one"];
    
    if (_isfirstData) {
        _codeArray=[NSMutableArray new];
          _dataArray=[NSMutableArray new];
             _valueArray=[NSMutableArray new];
        _isfirstData=NO;
        [self changeData:receiveData];
          [self performSelector:@selector(goToGetTwoData) withObject:nil afterDelay:2];
      [self getTableView];
    }else{
        [self hideProgressView];
        _rightItem.enabled=YES;
           [self changeData:receiveData];
        
         [self getTableView];
    }

   
}

-(void)goToGetTwoData{
    
          [_ControlOne goToOneTcp:2 cmdNum:1 cmdType:@"4" regAdd:@"625" Length:@"125"];
}

-(void)getTableView{
    
  //  _codeArray=[NSMutableArray new];
    if (_codeArray.count>0) {
        if (!_tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, ScreenHeight-NavigationbarHeight-StatusHeight) style:UITableViewStylePlain];
            _tableView.delegate = self;
            _tableView.dataSource = self;
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.view addSubview:_tableView];
            
            //注册单元格类型
            [_tableView registerClass:[usbToWifiWarnListCell class] forCellReuseIdentifier:@"CELL"];
        }else{
            [_tableView reloadData];
        }
    }else{
        UILabel *alertLable = [[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 100*HEIGHT_SIZE,ScreenWidth,30*HEIGHT_SIZE)];
        alertLable.textColor =COLOR(102, 102, 102, 1);
        alertLable.textAlignment=NSTextAlignmentCenter;
        alertLable.text=root_MAX_323;
        alertLable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [self.view addSubview:alertLable];
    }


}

-(void)changeData:(NSData*)receiveData{
    Byte *dataArray=(Byte*)[receiveData bytes];
    for (int i=0; i<25; i++) {
        int T=5*i*2;
        
          int codeInt=(dataArray[0+T]<<8)+dataArray[1+T];
        if (codeInt!=0) {
            NSString *value=[self getData:codeInt];
            [_valueArray addObject:value];
            [_codeArray addObject:[NSString stringWithFormat:@"%@:%d",root_MAX_324,codeInt]];
            
            int monthInt=dataArray[3+T];
            int dayInt=dataArray[4+T];
            int hourInt=dataArray[5+T];
            int minInt=dataArray[6+T];
            
            NSString*timeString=[NSString stringWithFormat:@"%d-%d %d:%d",monthInt,dayInt,hourInt,minInt];
              [_dataArray addObject:timeString];
        }
     
    }
    
}



-(void)setFailed{
    
    [self removeTheTcp];
    
    [self hideProgressView];
    _rightItem.enabled=YES;
    

    
}

-(void)removeTheTcp{
    if (_ControlOne) {
        [_ControlOne disConnect];
    }
    
}



-(NSString*)getData:(int)faultInt{
    NSString *faultString;
    if (faultInt==1) {
        faultString=@"M3 Receive Main DSP SCI abnormal";
    }else if (faultInt==2) {
        faultString=@"M3 Receive Slave DSP SCI abnormal";
    }else if (faultInt==3) {
        faultString=@"Main DSP Receive M3 SCI abnormal";
    }else if (faultInt==4) {
        faultString=@"Slave DSP Receive M3 SCI abnormal";
    }else if (faultInt==5) {
        faultString=@"Main DSP Receive SPI abnormal";
    }else if (faultInt==6) {
        faultString=@"Slave DSP Receive SPI abnormal";
    }else if (faultInt==9) {
        faultString=@"SPS power fault";
    }else if (faultInt==13) {
        faultString=@"AFCI Fault";
    }else if (faultInt==14) {
        faultString=@"IGBT drive fault";
    }else if (faultInt==15) {
        faultString=@"AFCI Module check fail";
    }else if (faultInt==18) {
        faultString=@"Relay fault";
    }else if (faultInt==22) {
        faultString=@"CPLD abnormal";
    }else if (faultInt==23) {
        faultString=@"Main DSP Bus abnormal";
    }else if (faultInt==24) {
        faultString=@"Slave DSP Bus abnormal";
    }else if (faultInt==25) {
        faultString=@"No AC Connection";
    }else if (faultInt==26) {
        faultString=@"PV Isolation Low";
    }else if (faultInt==27) {
        faultString=@"Leakage current too high";
    }else if (faultInt==28) {
        faultString=@"Output DC current too high";
    }else if (faultInt==29) {
        faultString=@"PV voltage too high";
    }else if (faultInt==30) {
        faultString=@"Grid voltage fault";
    }else if (faultInt==31) {
        faultString=@"Grid frequency fault";
    }else if (faultInt==33) {
        faultString=@"BUS Sample and PV sample inconsistent";
    }else if (faultInt==34) {
        faultString=@"GFCI Sample inconsistent";
    }else if (faultInt==35) {
        faultString=@"ISO Sample inconsistent";
    }else if (faultInt==36) {
        faultString=@"BUS Sample inconsistent";
    }else if (faultInt==37) {
        faultString=@"Grid Sample inconsistent";
    }else{
        faultString=[NSString stringWithFormat:@"Error:%d",faultInt];
    }
    
    return faultString;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _codeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80*HEIGHT_SIZE;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    usbToWifiWarnListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
    if (!cell) {
        cell=[[usbToWifiWarnListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.codeLable.text=self.codeArray[indexPath.row];
     cell.timeLable.text=self.dataArray[indexPath.row];
    cell.valueLable.text=self.valueArray[indexPath.row];
    
    return cell;
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
