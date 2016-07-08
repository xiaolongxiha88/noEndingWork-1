//
//  secondCNJ.m
//  shinelink
//
//  Created by sky on 16/3/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "secondCNJ.h"
#import"DTKDropdownMenuView.h"
#import "Line2View.h"
#import "threeViewController.h"
#import"VWWWaterView.h"
#import "ControlCNJ.h"
#import "parameterCNJ.h"
#import "PvLogTableViewController.h"
#import "EquipGraphViewController.h"
#import "controlCNJTable.h"

#define SizeH 45*HEIGHT_SIZE
#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]
@interface secondCNJ ()
@property (nonatomic, strong) NSMutableDictionary *dayDict;
@property (nonatomic, strong) NSMutableDictionary *paramsDict;
@property (nonatomic, strong) Line2View *line2View;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *statusText;
@property (nonatomic, strong) NSString *dayDischarge;
@property (nonatomic, strong) NSString *totalDischarge;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) NSString *power;
@property (nonatomic, strong) NSString *normalPower2;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *capacity;
@property (nonatomic, strong) NSString *storageType;
@end

@implementation secondCNJ

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_deviceSN;
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,700*NOW_SIZE);
    [self.view addSubview:_scrollView];
    
   
    
    [self netGetCNJ];
   // [self addRightItem];
    [self addGraph];
    [self addbutton];
    
}

-(void)netGetCNJ{
     [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"storageId":_deviceSN} paramarsSite:@"/newStorageAPI.do?op=getStorageParams" sucessBlock:^(id content) {
        [self hideProgressView];
           NSLog(@"getStorageParams: %@", content);
        if (content) {
        
            _storageType=[NSString stringWithFormat:@"%@",content[@"storageType"]];
            _paramsDict=[NSMutableDictionary dictionaryWithDictionary:content[@"storageBean"]];
            _dayDischarge=[NSString stringWithFormat:@"%@",content[@"storageDetailBean"][@"eDischargeTodayText"]];
            _totalDischarge=[NSString stringWithFormat:@"%@",content[@"storageDetailBean"][@"eDischargeTotalText"]];
            _status=[NSString stringWithFormat:@"%@",content[@"storageBean"][@"status"]];
            _capacity=[NSString stringWithFormat:@"%@",content[@"storageDetailBean"][@"capacityText"]];
               _normalPower2 =[NSString stringWithFormat:@"%@",content[@"storageDetailBean"][@"normalPower"]];
            
            if ([_status isEqualToString:@"1"]) {
                
                _power=[NSString stringWithFormat:@"%@",content[@"storageDetailBean"][@"pChargeText"]];
            }else if([_status isEqualToString:@"2"]){
            _power=[NSString stringWithFormat:@"%@",content[@"storageDetailBean"][@"pDischargeText"]];
            }else{
                _power=@"";
            }
            
           [self addProcess];
            }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self addProcess];
    }];

}
//_scrollView.
-(void)addbutton{
    float SizeH2=15*HEIGHT_SIZE;
    UIButton *firstB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*HEIGHT_SIZE,50*HEIGHT_SIZE )];
    [firstB setImage:[UIImage imageNamed:@"控制.jpg"] forState:UIControlStateNormal];
    [firstB addTarget:self action:@selector(controlCNJ) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:firstB];
    UILabel *firstL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    firstL.text=root_kongzhi;
    firstL.textAlignment=NSTextAlignmentCenter;
    firstL.textColor=[UIColor blackColor];
    firstL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:firstL];
    
    UIButton *secondB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*HEIGHT_SIZE,50*HEIGHT_SIZE )];
    [secondB setImage:[UIImage imageNamed:@"参数.png"] forState:UIControlStateNormal];
     [secondB addTarget:self action:@selector(parameterCNJ) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:secondB];
    UILabel *secondL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE+74*NOW_SIZE, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    secondL.text=root_canshu;
    secondL.textAlignment=NSTextAlignmentCenter;
    secondL.textColor=[UIColor blackColor];
    secondL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:secondL];
    
    UIButton *threeB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*2, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*HEIGHT_SIZE,50*HEIGHT_SIZE )];
    [threeB setImage:[UIImage imageNamed:@"数据.png"] forState:UIControlStateNormal];
      [threeB addTarget:self action:@selector(goThree) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:threeB];
    UILabel *threeL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE+74*NOW_SIZE*2, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    threeL.text=root_shuju;
    threeL.textAlignment=NSTextAlignmentCenter;
    threeL.textColor=[UIColor blackColor];
    threeL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:threeL];
    
    UIButton *fourB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*3, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*HEIGHT_SIZE,50*HEIGHT_SIZE )];
    [fourB setImage:[UIImage imageNamed:@"日志.png"] forState:UIControlStateNormal];
  [fourB addTarget:self action:@selector(gofour) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:fourB];
    UILabel *fourL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE+74*NOW_SIZE*3, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    fourL.text=root_rizhi;
    fourL.textAlignment=NSTextAlignmentCenter;
    fourL.textColor=[UIColor blackColor];
    fourL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:fourL];
}

-(void)gofour{
    PvLogTableViewController *four=[[PvLogTableViewController alloc]init];
    four.PvSn=_deviceSN;
    four.address=@"/newStorageAPI.do?op=getStorageAlarm";
    four.type=@"storageId";
    [self.navigationController pushViewController:four animated:NO];
}

-(void)controlCNJ{
    controlCNJTable *CNJ=[[controlCNJTable alloc]init];
    CNJ.CnjSn=_deviceSN;
    [self.navigationController pushViewController:CNJ animated:YES];
}

-(void)parameterCNJ{
    parameterCNJ *PC=[[parameterCNJ alloc]init];
    PC.params2Dict=_paramsDict;
    PC.deviceSN=_deviceSN;
    PC.normalPower=_normalPower2;
    PC.storageType=_storageType;
    [self.navigationController pushViewController:PC animated:NO];
}

-(void)goThree{
    EquipGraphViewController *equipGraph=[[EquipGraphViewController alloc]init];
    equipGraph.dictInfo=@{@"equipId":_deviceSN,
                          @"daySite":@"/newStorageAPI.do?op=getDayLineStorage",
                          @"monthSite":@"/newStorageAPI.do?op=getMonthLineStorage",
                          @"yearSite":@"/newStorageAPI.do?op=getYearLineStorage",
                          @"allSite":@"/newStorageAPI.do?op=getTotalLineStorage"};
    equipGraph.dict=@{@"1":root_CHARGING_POWER, @"2":root_DISCHARGING_POWER, @"3":root_INPUT_VOLTAGE, @"4":root_INPUT_CURRENT, @"5":root_USER_SIDE_POWER, @"6":root_GRID_SIDE_POWER};
    equipGraph.dictMonth=@{@"1":root_MONTH_BATTERY_CHARGE, @"2":root_MONTHLY_CHARGED, @"3":root_MONTHLY_DISCHARGED};
    equipGraph.dictYear=@{@"1":root_YEAR_BATTERY_CHARGE, @"2":root_YEAR_CHARGED, @"3":root_YEAR_DISCHARGED};
    equipGraph.dictAll=@{@"1":root_TOTAL_BATTERY_CHARGE, @"2":root_TOTAL_CHARGED, @"3":root_TOTAL_DISCHARGED};
    [self.navigationController pushViewController:equipGraph animated:YES];
    
}
-(void)addGraph{
  
    
    self.line2View = [[Line2View alloc] initWithFrame:CGRectMake(0, 260*HEIGHT_SIZE-SizeH, SCREEN_Width,270*HEIGHT_SIZE )];
    self.line2View.flag=@"1";
     self.line2View.frameType=@"1";
    [self.scrollView addSubview:self.line2View];
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd"];
    self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    [self showProgressView];

    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"id":_deviceSN,@"type":@"7", @"date":self.currentDay} paramarsSite:@"/newStorageAPI.do?op=getDayLineStorage" sucessBlock:^(id content) {
        NSLog(@"day: %@", content);
        [self hideProgressView];
        NSMutableDictionary *dayDict0=[NSMutableDictionary new];
        if (content) {
            if (content[@"invPacData"]) {
                [dayDict0 addEntriesFromDictionary:[content objectForKey:@"invPacData"]];
                // NSMutableDictionary *dayDict0=[NSMutableDictionary dictionaryWithDictionary:[content objectForKey:@"invPacData"]];
            }else{
                [dayDict0 addEntriesFromDictionary:content];
            }
            self.dayDict=[NSMutableDictionary new];
            for (NSString *key in dayDict0) {
                NSRange rang = NSMakeRange(11, 5);
                NSString *key0=[key substringWithRange:rang];
                NSString *value0=dayDict0[key];
                [_dayDict setValue:value0 forKey:key0];
            }
            [self.line2View refreshLineChartViewWithDataDict:_dayDict];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
 

    
}

-(void)addProcess{
    UIView *processView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240*HEIGHT_SIZE-SizeH)];
    UIImage *bgImage = IMAGE(@"bg3.png");
    processView.layer.contents = (id)bgImage.CGImage;
    [self.scrollView addSubview:processView];
    UILabel *leftName=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE, 190*HEIGHT_SIZE-SizeH, 90*NOW_SIZE,20*HEIGHT_SIZE )];
    leftName.text=_dayDischarge;
    leftName.textAlignment=NSTextAlignmentLeft;
    leftName.textColor=[UIColor greenColor];
    leftName.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.scrollView addSubview:leftName];
    UILabel *leftState=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE, 210*HEIGHT_SIZE-SizeH, 100*NOW_SIZE,20*HEIGHT_SIZE )];
    leftState.text=root_ri_fangdianliang;
    leftState.textAlignment=NSTextAlignmentLeft;
    leftState.textColor=[UIColor greenColor];
    leftState.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:leftState];
    
    
    UILabel *rightName=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-104*NOW_SIZE, 190*HEIGHT_SIZE-SizeH, 90*NOW_SIZE,20*HEIGHT_SIZE )];
    rightName.text=_totalDischarge;
    rightName.textAlignment=NSTextAlignmentRight;
    rightName.textColor=[UIColor greenColor];
    rightName.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.scrollView addSubview:rightName];
    UILabel *rightState=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-114*NOW_SIZE, 210*HEIGHT_SIZE-SizeH, 100*NOW_SIZE,20*HEIGHT_SIZE )];
    rightState.text=root_zong_fangdianliang;
    rightState.textAlignment=NSTextAlignmentRight;
    rightState.textColor=[UIColor greenColor];
    rightState.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:rightState];
    
    UILabel *dataName=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 245*HEIGHT_SIZE-SizeH, 180*NOW_SIZE,20*HEIGHT_SIZE )];
    dataName.text=root_dianchi;
    dataName.textAlignment=NSTextAlignmentLeft;
    dataName.textColor=[UIColor blackColor];
    dataName.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.scrollView addSubview:dataName];
    
    //_status=@"1";
    VWWWaterView *waterView = [[VWWWaterView alloc]initWithFrame:CGRectMake(0, 0*NOW_SIZE, 160*HEIGHT_SIZE, 160*HEIGHT_SIZE)];
    CGPoint center = CGPointMake(CGRectGetMidX( [UIScreen mainScreen].bounds), 100*HEIGHT_SIZE);
    waterView.center = center;
    if ([_status isEqualToString:@"0"]) {
        waterView.backgroundColor = [UIColor colorWithRed:28/ 255.0f green:111/ 255.0f blue:235/ 255.0f alpha:1];//页面背景颜色改背景
        waterView.currentWaterColor = [UIColor colorWithRed:45/ 255.0f green:226/ 255.0f blue:233/ 255.0f alpha:1];//水波颜色
        _statusText=root_xianZhi;
    }else if ([_status isEqualToString:@"1"]) {
        waterView.backgroundColor = [UIColor colorWithRed:28/ 255.0f green:111/ 255.0f blue:235/ 255.0f alpha:1];//页面背景颜色改背景
        waterView.currentWaterColor = [UIColor colorWithRed:121/ 255.0f green:230/ 255.0f blue:129/ 255.0f alpha:1];//水波颜色
         _statusText=root_chongDian;
    }else if ([_status isEqualToString:@"2"]) {
        waterView.backgroundColor = [UIColor colorWithRed:28/ 255.0f green:111/ 255.0f blue:235/ 255.0f alpha:1];//页面背景颜色改背景
        waterView.currentWaterColor = [UIColor colorWithRed:222/ 255.0f green:211/ 255.0f blue:91/ 255.0f alpha:1];//水波颜色
         _statusText=root_fangDian;
    }else if ([_status isEqualToString:@"3"]) {
        waterView.backgroundColor = [UIColor colorWithRed:28/ 255.0f green:111/ 255.0f blue:235/ 255.0f alpha:1];//页面背景颜色改背景
        waterView.currentWaterColor = [UIColor colorWithRed:105/ 255.0f green:214/ 255.0f blue:249/ 255.0f alpha:1];//水波颜色
         _statusText=root_cuoWu;
    }else if ([_status isEqualToString:@"4"]) {
        waterView.backgroundColor = [UIColor colorWithRed:28/ 255.0f green:111/ 255.0f blue:235/ 255.0f alpha:1];//页面背景颜色改背景
        waterView.currentWaterColor = [UIColor colorWithRed:45/ 255.0f green:226/ 255.0f blue:233/ 255.0f alpha:1];//水波颜色
        _statusText=root_dengDai;
    }else if ([_status isEqualToString:@"-1"]) {
        waterView.backgroundColor = [UIColor colorWithRed:28/ 255.0f green:111/ 255.0f blue:235/ 255.0f alpha:1];//页面背景颜色改背景
        waterView.currentWaterColor = [UIColor colorWithRed:28/ 255.0f green:111/ 255.0f blue:235/ 255.0f alpha:1];//水波颜色
        _statusText=root_duanKai;
    }
    float k1=[_capacity floatValue]*0.01;
    waterView.percentum = k1;//百分比
    [self.scrollView addSubview:waterView];
    
    float SizeH3=10*HEIGHT_SIZE;
    UILabel *Ca=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100*NOW_SIZE)/2, (240*HEIGHT_SIZE)/2-SizeH-SizeH3, 100*NOW_SIZE,60*HEIGHT_SIZE )];
    Ca.text=_capacity;
    Ca.textAlignment=NSTextAlignmentCenter;
    if ([_status isEqualToString:@"3"]) {
        Ca.textColor=[UIColor redColor];
    }else{
    Ca.textColor=[UIColor whiteColor];
    }
    Ca.font = [UIFont systemFontOfSize:30*HEIGHT_SIZE];
    [self.scrollView addSubview:Ca];
    
    UILabel *Status=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100*NOW_SIZE)/2, (240*HEIGHT_SIZE)/2-SizeH-SizeH3+55*HEIGHT_SIZE, 100*NOW_SIZE,40*HEIGHT_SIZE )];
    Status.text=_statusText;
    Status.textAlignment=NSTextAlignmentCenter;
    if ([_status isEqualToString:@"3"]) {
        Status.textColor=[UIColor redColor];
    }else{
        Status.textColor=[UIColor whiteColor];
    }
    Status.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.scrollView addSubview:Status];
    
    UILabel *power1=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100*NOW_SIZE)/2, (240*HEIGHT_SIZE)/2-SizeH-SizeH3+35*HEIGHT_SIZE, 100*NOW_SIZE,40*HEIGHT_SIZE )];
    power1.text=_power;
    power1.textAlignment=NSTextAlignmentCenter;
        power1.textColor=[UIColor whiteColor];
    power1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:power1];
    
}

//- (void)addRightItem
//{
//    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"高级设置" iconName:@"DTK_jiangbei" callBack:^(NSUInteger index, id info) {
//        NSLog(@"rightItem%lu",(unsigned long)index);}];
//    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"基本信息" iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
//        NSLog(@"rightItem%lu",(unsigned long)index);}];
//    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"日志" iconName:@"DTK_update" callBack:^(NSUInteger index, id info) {
//        NSLog(@"rightItem%lu",(unsigned long)index);}];
//    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2] icon:@"DTK_bi"];
//    
//    menuView.dropWidth = 150.f;
//    menuView.titleFont = [UIFont systemFontOfSize:18.f];
//    menuView.textColor = ColorWithRGB(102.f, 102.f, 102.f);
//    menuView.textFont = [UIFont systemFontOfSize:13.f];
//    menuView.cellSeparatorColor = ColorWithRGB(229.f, 229.f, 229.f);
//    menuView.textFont = [UIFont systemFontOfSize:14.f];
//    menuView.animationDuration = 0.2f;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
//}



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
