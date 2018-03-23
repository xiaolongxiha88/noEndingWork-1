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
//#import "threeViewController.h"
#import"VWWWaterView.h"
#import "ControlCNJ.h"
#import "parameterCNJ.h"
#import "PvLogTableViewController.h"
#import "EquipGraphViewController.h"
#import "controlCNJTable.h"
#import "PopoverView00.h"


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
@property (nonatomic, strong)VWWWaterView *waterView;
@property (nonatomic, assign) float pointCenterNum;
@property (nonatomic, strong) NSDictionary *allDict;

@end

@implementation secondCNJ

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_deviceSN;
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=NO;
    
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
            _allDict=[NSDictionary dictionaryWithDictionary:content];
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
    float buttonSize=45*HEIGHT_SIZE;
    float W=(SCREEN_Width-4*buttonSize)/5;
    UIColor *fontColor=COLOR(51, 51, 51, 1);
    float buttonAndW=W+buttonSize;
    
    NSArray *imageNameArray=@[@"控制.png",@"参数.png",@"数据.png",@"日志.png"];
    NSArray *lableNameArray=@[root_kongzhi,root_canshu,root_shuju,root_rizhi];
    NSArray *selNameArray=@[@"controlCNJ",@"parameterCNJ",@"goThree",@"gofour"];
    
    for (int i=0; i<imageNameArray.count; i++) {
        UIButton *firstB=[[UIButton alloc]initWithFrame:CGRectMake(W+buttonAndW*i, 490*HEIGHT_SIZE-SizeH-SizeH2+3*HEIGHT_SIZE, buttonSize,buttonSize )];
        [firstB setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateNormal];
        SEL aSelector = NSSelectorFromString(selNameArray[i]);
        if (iPhoneX) {
            firstB.frame=CGRectMake(W+buttonAndW*i, 490*HEIGHT_SIZE-SizeH-SizeH2+3*HEIGHT_SIZE+iphonexH, buttonSize,buttonSize );
        }
        [firstB addTarget:self action:aSelector forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:firstB];
        UILabel *firstL=[[UILabel alloc]initWithFrame:CGRectMake(W/2+buttonAndW*i, 540*HEIGHT_SIZE-SizeH-SizeH2, buttonSize+W,20*HEIGHT_SIZE )];
        firstL.text=lableNameArray[i];
        if (iPhoneX) {
            firstL.frame=CGRectMake(W/2+buttonAndW*i, 540*HEIGHT_SIZE-SizeH-SizeH2+iphonexH, buttonSize+W,20*HEIGHT_SIZE );
        }
        firstL.textAlignment=NSTextAlignmentCenter;
        firstL.textColor=fontColor;
        firstL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        firstL.adjustsFontSizeToFitWidth=YES;
        [self.scrollView addSubview:firstL];
    }
      
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,SCREEN_Height+20*HEIGHT_SIZE);
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
    CNJ.typeNum=_typeNum;
    [self.navigationController pushViewController:CNJ animated:YES];
}

-(void)parameterCNJ{
    parameterCNJ *PC=[[parameterCNJ alloc]init];
    PC.params2Dict=_paramsDict;
    PC.deviceSN=_deviceSN;
    PC.normalPower=_normalPower2;
    PC.storageType=_storageType;
    PC.typeNum=_typeNum;
    if ([_typeNum isEqualToString:@"1"]) {
        PC.actAndapparentString=[NSString stringWithFormat:@"%@/%@",_allDict[@"activePower"],_allDict[@"apparentPower"]];
    }
    [self.navigationController pushViewController:PC animated:NO];
}

-(void)goThree{
    if (![_typeNum isEqualToString:@"1"]) {
        [self goThreeSP];
    }else{
        [self goThreeSPF5000];
    }
    
}


-(void)goThreeSP{
    EquipGraphViewController *equipGraph=[[EquipGraphViewController alloc]init];
    equipGraph.deviceType=@"S";
    equipGraph.SnID=_deviceSN;
    equipGraph.StorageTypeNum=_typeNum;
    equipGraph.dictInfo=@{@"equipId":_deviceSN,
                          @"daySite":@"/newStorageAPI.do?op=getDayLineStorage",
                          @"monthSite":@"/newStorageAPI.do?op=getMonthLineStorage",
                          @"yearSite":@"/newStorageAPI.do?op=getYearLineStorage",
                          @"allSite":@"/newStorageAPI.do?op=getTotalLineStorage"};
    equipGraph.dict=@{@"1":root_CHARGING_POWER, @"2":root_DISCHARGING_POWER, @"3":root_INPUT_VOLTAGE, @"4":root_INPUT_CURRENT, @"5":root_USER_SIDE_POWER, @"6":root_GRID_SIDE_POWER,@"7":root_dianchi};
    equipGraph.dictMonth=@{@"1":root_MONTH_BATTERY_CHARGE, @"2":root_MONTHLY_CHARGED, @"3":root_MONTHLY_DISCHARGED};
    equipGraph.dictYear=@{@"1":root_YEAR_BATTERY_CHARGE, @"2":root_YEAR_CHARGED, @"3":root_YEAR_DISCHARGED};
    equipGraph.dictAll=@{@"1":root_TOTAL_BATTERY_CHARGE, @"2":root_TOTAL_CHARGED, @"3":root_TOTAL_DISCHARGED};
    [self.navigationController pushViewController:equipGraph animated:YES];

}


-(void)goThreeSPF5000{
    EquipGraphViewController *equipGraph=[[EquipGraphViewController alloc]init];
    equipGraph.deviceType=@"S";
    equipGraph.SnID=_deviceSN;
    equipGraph.StorageTypeNum=_typeNum;
    equipGraph.dictInfo=@{@"equipId":_deviceSN,
                          @"daySite":@"/newStorageAPI.do?op=getDayLineStorage",
                          @"monthSite":@"/newStorageAPI.do?op=getMonthLineStorage",
                          @"yearSite":@"/newStorageAPI.do?op=getYearLineStorage",
                          @"allSite":@"/newStorageAPI.do?op=getTotalLineStorage"};
    equipGraph.dict=@{@"1": root_5000Chart_157, @"2":root_5000Chart_158, @"3":root_5000Chart_159, @"4":root_5000Chart_160, @"5":root_5000Chart_161, @"6":root_5000Chart_162,@"7":root_5000Chart_163,@"8":root_5000Chart_164,@"9":root_5000Chart_165,@"10": root_5000Chart_166,@"11": root_5000Chart_167,@"12": root_5000Chart_168,@"13": root_5000Chart_169};
    equipGraph.dictMonth=@{@"1":root_5000Chart_481, @"2":root_5000Chart_483, @"3":root_5000Chart_484, @"4":root_5000Chart_482};
    equipGraph.dictYear=@{@"1":root_5000Chart_485, @"2":root_5000Chart_487, @"3":root_5000Chart_488, @"4":root_5000Chart_486};
    equipGraph.dictAll=@{@"1":root_5000Chart_170,@"2":root_5000Chart_172, @"3":root_5000Chart_173, @"4":root_5000Chart_171,};
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
            if (dayDict0.count>0) {
                for (NSString *key in dayDict0) {
                    NSRange rang = NSMakeRange(11, 5);
                    NSString *key0=[key substringWithRange:rang];
                    NSString *value0=dayDict0[key];
                    [_dayDict setValue:value0 forKey:key0];
                }
            }
           
            self.line2View.isStorage=YES;
            [self.line2View refreshLineChartViewWithDataDict:_dayDict];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
 

    
}

-(void)addProcess{
     //  _typeNum=@"2";
    UIColor *valueColor;
    if (![_typeNum isEqualToString:@"1"]) {
    valueColor=[UIColor whiteColor];
    }else{
            valueColor=[UIColor whiteColor];
  //  valueColor=COLOR(163, 255, 188, 1);
    }
   
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSString *_languageValue;
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        _languageValue=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }
    
    UIView *processView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240*HEIGHT_SIZE-SizeH)];
//    UIImage *bgImage = IMAGE(@"bg3.png");
//    processView.layer.contents = (id)bgImage.CGImage;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)COLOR(0, 156, 255, 1).CGColor, (__bridge id)COLOR(11, 182, 255, 1).CGColor];
    gradientLayer.locations = nil;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.frame = CGRectMake(0, 0, processView.frame.size.width, processView.frame.size.height);
    [processView.layer addSublayer:gradientLayer];
    [self.scrollView addSubview:processView];
    
    if (![_typeNum isEqualToString:@"1"]) {
        UILabel *leftName=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE, 195*HEIGHT_SIZE-SizeH, 90*NOW_SIZE,20*HEIGHT_SIZE )];
        leftName.text=_dayDischarge;
        leftName.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
        tapGestureRecognizer2.cancelsTouchesInView = NO;
        [leftName addGestureRecognizer:tapGestureRecognizer2];
        leftName.textAlignment=NSTextAlignmentLeft;
        leftName.textColor=valueColor;
        leftName.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [self.scrollView addSubview:leftName];
        UILabel *leftState=[[UILabel alloc]initWithFrame:CGRectMake(2*NOW_SIZE, 215*HEIGHT_SIZE-SizeH, 114*NOW_SIZE,20*HEIGHT_SIZE )];
        if ([_languageValue isEqualToString:@"0"]) {
            leftState.frame=CGRectMake(14*NOW_SIZE, 215*HEIGHT_SIZE-SizeH, 114*NOW_SIZE,20*HEIGHT_SIZE );
        }
        leftState.text=root_ri_fangdianliang;
        leftState.textAlignment=NSTextAlignmentLeft;
        leftState.textColor=[UIColor whiteColor];
        leftState.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        leftState.adjustsFontSizeToFitWidth=YES;
        [self.scrollView addSubview:leftState];
        
        
        UILabel *rightName=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-104*NOW_SIZE, 195*HEIGHT_SIZE-SizeH, 90*NOW_SIZE,20*HEIGHT_SIZE )];
        rightName.text=_totalDischarge;
        rightName.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGestureRecognizer0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
        tapGestureRecognizer0.cancelsTouchesInView = NO;
        [rightName addGestureRecognizer:tapGestureRecognizer0];
        rightName.textAlignment=NSTextAlignmentRight;
        rightName.textColor=valueColor;
        rightName.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [self.scrollView addSubview:rightName];
        
        UILabel *rightState=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-116*NOW_SIZE, 215*HEIGHT_SIZE-SizeH, 114*NOW_SIZE,20*HEIGHT_SIZE )];
        if ([_languageValue isEqualToString:@"0"]) {
            rightState.frame=CGRectMake(kScreenWidth-128*NOW_SIZE, 215*HEIGHT_SIZE-SizeH, 114*NOW_SIZE,20*HEIGHT_SIZE );
        }
        rightState.text=root_zong_fangdianliang;
        rightState.textAlignment=NSTextAlignmentRight;
        rightState.textColor=[UIColor whiteColor];
        rightState.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        rightState.adjustsFontSizeToFitWidth=YES;
        [self.scrollView addSubview:rightState];
        
    

    }else{
        NSArray *lableNameArray=@[root_ri_fangdianliang,root_zong_fangdianliang,root_jinri_shouyi,root_zong_shouyi];
        NSArray *lableValueArray=[NSArray new];
        if ([_allDict.allKeys containsObject:@"storageDetailBean"]) {
             lableValueArray=@[_allDict[@"storageDetailBean"][@"eDischargeTodayText"],_allDict[@"storageDetailBean"][@"eDischargeTotalText"],_allDict[@"todayRevenue"],_allDict[@"totalRevenue"]];
        }else{
            lableValueArray=@[@"",@"",@"",@""];
        }
        
        
        float lableW=SCREEN_Width/4;
        for (int i=0; i<lableValueArray.count; i++) {
            UILabel *valueLable=[[UILabel alloc]initWithFrame:CGRectMake(0+lableW*i, 190*HEIGHT_SIZE-SizeH, lableW,20*HEIGHT_SIZE )];
            valueLable.text=lableValueArray[i];
            valueLable.userInteractionEnabled=YES;
            UITapGestureRecognizer *tapGestureRecognizer0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
            tapGestureRecognizer0.cancelsTouchesInView = NO;
            [valueLable addGestureRecognizer:tapGestureRecognizer0];
            valueLable.textAlignment=NSTextAlignmentCenter;
            valueLable.textColor=valueColor;
            valueLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
            [self.scrollView addSubview:valueLable];
            
            UILabel *nameLable=[[UILabel alloc]initWithFrame:CGRectMake(0+lableW*i, 210*HEIGHT_SIZE-SizeH, lableW,20*HEIGHT_SIZE )];
            nameLable.text=lableNameArray[i];
            nameLable.textAlignment=NSTextAlignmentCenter;
                nameLable.adjustsFontSizeToFitWidth=YES;
            nameLable.textColor=[UIColor whiteColor];
          //  nameLable.adjustsFontSizeToFitWidth=YES;
            if ([_languageValue isEqualToString:@"0"]) {
                   nameLable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            }else{
              nameLable.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
            }
     
            [self.scrollView addSubview:nameLable];
        }
        
    }
    

    UILabel *dataName=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 245*HEIGHT_SIZE-SizeH, 180*NOW_SIZE,20*HEIGHT_SIZE )];
    dataName.text=root_dianchi;
    dataName.textAlignment=NSTextAlignmentLeft;
    dataName.textColor=COLOR(51, 51, 51, 1);
    dataName.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    dataName.adjustsFontSizeToFitWidth=YES;
    [self.scrollView addSubview:dataName];
    
    
    if ([_typeNum isEqualToString:@"1"]) {
        _pointCenterNum=20*HEIGHT_SIZE;
       _waterView = [[VWWWaterView alloc]initWithFrame:CGRectMake(0, 0*NOW_SIZE, 120*HEIGHT_SIZE, 120*HEIGHT_SIZE)];
        _waterView.center = CGPointMake(CGRectGetMidX( [UIScreen mainScreen].bounds), 100*HEIGHT_SIZE-_pointCenterNum);
    }else{
       _waterView = [[VWWWaterView alloc]initWithFrame:CGRectMake(0, 0*NOW_SIZE, 160*HEIGHT_SIZE, 160*HEIGHT_SIZE)];
        _waterView.center = CGPointMake(CGRectGetMidX( [UIScreen mainScreen].bounds), 100*HEIGHT_SIZE);
    }
 
    UIColor *backColor=COLOR(14, 138, 243, 1);
    _waterView.backgroundColor = backColor;//页面背景颜色改背景
    if ([_status isEqualToString:@"0"]) {
        _waterView.backgroundColor = backColor;//页面背景颜色改背景
        _waterView.currentWaterColor = [UIColor colorWithRed:45/ 255.0f green:226/ 255.0f blue:233/ 255.0f alpha:1];//水波颜色
        _statusText=root_xianZhi;
    }else if ([_status isEqualToString:@"1"]) {
        _waterView.backgroundColor = backColor;//页面背景颜色改背景
        _waterView.currentWaterColor = [UIColor colorWithRed:121/ 255.0f green:230/ 255.0f blue:129/ 255.0f alpha:1];//水波颜色
         _statusText=root_chongDian;
    }else if ([_status isEqualToString:@"2"]) {
        _waterView.backgroundColor = backColor;//页面背景颜色改背景
        _waterView.currentWaterColor = [UIColor colorWithRed:222/ 255.0f green:211/ 255.0f blue:91/ 255.0f alpha:1];//水波颜色
         _statusText=root_fangDian;
    }else if ([_status isEqualToString:@"3"]) {
        _waterView.backgroundColor = backColor;//页面背景颜色改背景
        _waterView.currentWaterColor = [UIColor colorWithRed:105/ 255.0f green:214/ 255.0f blue:249/ 255.0f alpha:1];//水波颜色
         _statusText=root_cuoWu;
    }else if ([_status isEqualToString:@"4"]) {
        _waterView.backgroundColor = backColor;//页面背景颜色改背景
        _waterView.currentWaterColor = [UIColor colorWithRed:45/ 255.0f green:226/ 255.0f blue:233/ 255.0f alpha:1];//水波颜色
        _statusText=root_dengDai;
    }else if ([_status isEqualToString:@"-1"]) {
        _waterView.backgroundColor = backColor;//页面背景颜色改背景
        _waterView.currentWaterColor = [UIColor colorWithRed:28/ 255.0f green:111/ 255.0f blue:235/ 255.0f alpha:1];//水波颜色
        _statusText=root_duanKai;
    }else{
        _waterView.currentWaterColor = [UIColor colorWithRed:121/ 255.0f green:230/ 255.0f blue:129/ 255.0f alpha:1];//水波颜色
        _statusText=root_Device_head_186;
    }
    float k1=[_capacity floatValue]*0.01;
    _waterView.percentum = k1;//百分比
    [self.scrollView addSubview:_waterView];
    
    float SizeH3=10*HEIGHT_SIZE;
    UILabel *Ca=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100*NOW_SIZE)/2, (240*HEIGHT_SIZE)/2-SizeH-SizeH3-_pointCenterNum, 100*NOW_SIZE,60*HEIGHT_SIZE )];
    Ca.text=_capacity;
    Ca.textAlignment=NSTextAlignmentCenter;
    if ([_status isEqualToString:@"3"]) {
        Ca.textColor=[UIColor redColor];
    }else{
    Ca.textColor=[UIColor whiteColor];
    }
    Ca.font = [UIFont systemFontOfSize:30*HEIGHT_SIZE];
    [self.scrollView addSubview:Ca];
    
    UILabel *Status=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100*NOW_SIZE)/2, (240*HEIGHT_SIZE)/2-SizeH-SizeH3+45*HEIGHT_SIZE-_pointCenterNum, 100*NOW_SIZE,40*HEIGHT_SIZE )];
    Status.text=_statusText;
    Status.textAlignment=NSTextAlignmentCenter;
    if ([_status isEqualToString:@"3"]) {
        Status.textColor=[UIColor redColor];
    }else{
        Status.textColor=[UIColor whiteColor];
    }
    Status.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
     Status.adjustsFontSizeToFitWidth=YES;
    [self.scrollView addSubview:Status];
    
//    UILabel *power1=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100*NOW_SIZE)/2, (240*HEIGHT_SIZE)/2-SizeH-SizeH3+35*HEIGHT_SIZE-_pointCenterNum, 100*NOW_SIZE,40*HEIGHT_SIZE )];
//    power1.text=_power;
//    power1.textAlignment=NSTextAlignmentCenter;
//        power1.textColor=[UIColor whiteColor];
//    power1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
  //  [self.scrollView addSubview:power1];
    
}


#pragma mark - 弹框提示
-(void)showAnotherView:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UILabel *lable = (UILabel*) tap.view;
    NSArray* lableNameArray = [NSArray arrayWithObject:lable.text];
    
    PopoverView00 *popoverView = [PopoverView00 popoverView00];
    [popoverView showToView:lable withActions:[self QQActions:lableNameArray]];
}


- (NSArray<PopoverAction *> *)QQActions:(NSArray*)lableNameArray {
    // 发起多人聊天 action
    NSMutableArray *actionArray=[NSMutableArray new];
    for (int i=0; i<lableNameArray.count; i++) {
        PopoverAction *Action = [PopoverAction actionWithImage:nil title:lableNameArray[i] handler:^(PopoverAction *action) {
#pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
            
        }];
        [actionArray addObject:Action];
    }
    return actionArray;
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
