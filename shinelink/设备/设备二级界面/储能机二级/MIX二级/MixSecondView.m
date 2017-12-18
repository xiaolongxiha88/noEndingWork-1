//
//  MixSecondView.m
//  ShinePhone
//
//  Created by sky on 2017/11/16.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "MixSecondView.h"
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


@interface MixSecondView ()
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

@implementation MixSecondView


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_deviceSN;
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=NO;
    
    [self.view addSubview:_scrollView];
    
    _typeNum=@"3";
    
    [self netGetCNJ];

      [self addGraph];
    [self addbutton];
    
}

-(void)netGetCNJ{
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"mixId":_deviceSN} paramarsSite:@"/newMixApi.do?op=getMixParams" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getMixParams: %@", content);
        if (content) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content];
            if ([firstDic[@"result"] intValue]==1) {
                NSDictionary *allDataDic=firstDic[@"obj"];
                _allDict=[NSDictionary dictionaryWithDictionary:allDataDic];
                
                _paramsDict=[NSMutableDictionary dictionaryWithDictionary:allDataDic[@"mixBean"]];
                
                _dayDischarge=[NSString stringWithFormat:@"%@",allDataDic[@"mixDetailBean"][@"edischarge1Today"]];
                _totalDischarge=[NSString stringWithFormat:@"%@",allDataDic[@"mixDetailBean"][@"edischarge1Total"]];
                
                _status=[NSString stringWithFormat:@"%@",allDataDic[@"mixBean"][@"status"]];
                
                _capacity=[NSString stringWithFormat:@"%@",allDataDic[@"mixDetailBean"][@"soc"]];
                
                _normalPower2 =[NSString stringWithFormat:@"%@",allDataDic[@"apparentPower"]];
            }else{
                   [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",firstDic[@"msg"]]];
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
        if (iPhoneX) {
            firstB.frame=CGRectMake(W+buttonAndW*i, 490*HEIGHT_SIZE-SizeH-SizeH2+3*HEIGHT_SIZE+iphonexH, buttonSize,buttonSize );
        }
        SEL aSelector = NSSelectorFromString(selNameArray[i]);
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
    four.address=@"/newMixApi.do?op=getMixAlarm";
    four.type=@"mixId";
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
    PC.typeNum=@"3";
    [self.navigationController pushViewController:PC animated:NO];
}

-(void)goThree{
    
        [self goThreeSP];
}


-(void)goThreeSP{
    EquipGraphViewController *equipGraph=[[EquipGraphViewController alloc]init];
    equipGraph.deviceType=@"S";
    equipGraph.StorageTypeSecondNum=@"mix";
    equipGraph.StorageTypeNum=@"4";
    equipGraph.SnID=_deviceSN;
  //  equipGraph.StorageTypeNum=_typeNum;
    equipGraph.dictInfo=@{@"equipId":_deviceSN,
                          @"daySite":@"/newMixApi.do?op=getDayLineMix",
                          @"monthSite":@"/newMixApi.do?op=getMixMonthPac",
                          @"yearSite":@"/newMixApi.do?op=getMixYearPac",
                          @"allSite":@"/newMixApi.do?op=getMixTotalPac"};
    equipGraph.dict=@{@"1":root_5000Chart_159, @"2":root_5000Chart_160, @"3":root_5000Chart_157, @"4":root_5000Chart_158, @"5":root_CHARGING_POWER, @"6":root_PCS_fangdian_gonglv,@"7":root_MIX_236,@"8":root_MIX_237,@"9":root_MIX_238,@"10":@"SOC"};
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
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"mixId":_deviceSN,@"type":@"10", @"date":self.currentDay} paramarsSite:@"/newMixApi.do?op=getDayLineMix" sucessBlock:^(id content) {
        NSLog(@"getDayLineMix: %@", content);
        [self hideProgressView];
        NSMutableDictionary *dayDict0=[NSMutableDictionary new];
        if (content) {
                [dayDict0 addEntriesFromDictionary:content];
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
 
        valueColor=[UIColor whiteColor];
 
    
    
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
    

        NSArray *lableNameArray=@[root_ri_fangdianliang,root_zong_fangdianliang,root_jinri_shouyi,root_zong_shouyi];
        NSArray *lableValueArray=[NSArray new];
        
        
        if ([_allDict.allKeys containsObject:@"mixDetailBean"]) {
            lableValueArray=@[_allDict[@"edischarge1Todaytext"],_allDict[@"edischarge1Totaltext"],_allDict[@"todayRevenuetext"],_allDict[@"totalRevenuetext"]];
        }else{
            lableValueArray=@[@"",@"",@"",@""];
        }
        
        
        float lableW=SCREEN_Width/4;
        for (int i=0; i<lableValueArray.count; i++) {
            UILabel *valueLable=[[UILabel alloc]initWithFrame:CGRectMake(0+lableW*i, 190*HEIGHT_SIZE-SizeH, lableW,20*HEIGHT_SIZE )];
            valueLable.text=[NSString stringWithFormat:@"%@",lableValueArray[i]];
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
            nameLable.textColor=[UIColor whiteColor];
            //  nameLable.adjustsFontSizeToFitWidth=YES;
            if ([_languageValue isEqualToString:@"0"]) {
                nameLable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            }else{
                nameLable.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
            }
            
            [self.scrollView addSubview:nameLable];
        }
        

    
    
    UILabel *dataName=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 245*HEIGHT_SIZE-SizeH, 180*NOW_SIZE,20*HEIGHT_SIZE )];
    dataName.text=root_dianchi;
    dataName.textAlignment=NSTextAlignmentLeft;
    dataName.textColor=COLOR(51, 51, 51, 1);
    dataName.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    dataName.adjustsFontSizeToFitWidth=YES;
    [self.scrollView addSubview:dataName];
    
    
    if ([_typeNum isEqualToString:@"3"]) {
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
        _waterView.currentWaterColor = [UIColor colorWithRed:45/ 255.0f green:226/ 255.0f blue:233/ 255.0f alpha:1];//水波颜色
        _statusText=root_dengDai;
    }else if ([_status isEqualToString:@"1"]) {
        _waterView.currentWaterColor = [UIColor colorWithRed:121/ 255.0f green:230/ 255.0f blue:129/ 255.0f alpha:1];//水波颜色
        _statusText=root_MIX_202;
    }else if ([_status isEqualToString:@"3"]) {
        _waterView.currentWaterColor = [UIColor colorWithRed:105/ 255.0f green:214/ 255.0f blue:249/ 255.0f alpha:1];//水波颜色
        _statusText=root_cuoWu;
    }else if ([_status isEqualToString:@"4"]) {
        _waterView.currentWaterColor = [UIColor colorWithRed:45/ 255.0f green:226/ 255.0f blue:233/ 255.0f alpha:1];//水波颜色
        _statusText=root_MIX_226;
    }else if ([_status isEqualToString:@"5"] || [_status isEqualToString:@"6"] || [_status isEqualToString:@"7"] || [_status isEqualToString:@"8"]) {
        _waterView.currentWaterColor = [UIColor colorWithRed:28/ 255.0f green:111/ 255.0f blue:235/ 255.0f alpha:1];//水波颜色
        _statusText=root_zhengChang;
    }else{
        _waterView.currentWaterColor = [UIColor colorWithRed:28/ 255.0f green:111/ 255.0f blue:235/ 255.0f alpha:1];//水波颜色
        _statusText=root_duanKai;
    }
    float k1=[_capacity floatValue]*0.01;
    _waterView.percentum = k1;//百分比
    [self.scrollView addSubview:_waterView];
    
    float SizeH3=10*HEIGHT_SIZE;
    UILabel *Ca=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100*NOW_SIZE)/2, (240*HEIGHT_SIZE)/2-SizeH-SizeH3-_pointCenterNum, 100*NOW_SIZE,60*HEIGHT_SIZE )];
    if (![_capacity containsString:@"%"]) {
        _capacity=[NSString stringWithFormat:@"%@%%",_capacity];
    }
    Ca.text=_capacity;
    Ca.adjustsFontSizeToFitWidth=YES;
    Ca.textAlignment=NSTextAlignmentCenter;
    if ([_status isEqualToString:@"3"]) {
        Ca.textColor=[UIColor redColor];
    }else{
        Ca.textColor=[UIColor whiteColor];
    }
    Ca.font = [UIFont systemFontOfSize:30*HEIGHT_SIZE];
    [self.scrollView addSubview:Ca];
    
    UILabel *Status=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100*NOW_SIZE)/2, (240*HEIGHT_SIZE)/2-SizeH-SizeH3+45*HEIGHT_SIZE-_pointCenterNum, 100*NOW_SIZE,30*HEIGHT_SIZE )];
    Status.text=_statusText;
    Status.textAlignment=NSTextAlignmentCenter;
    if ([_status isEqualToString:@"3"]) {
        Status.textColor=[UIColor redColor];
    }else{
        Status.textColor=[UIColor whiteColor];
    }
    Status.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    Status.adjustsFontSizeToFitWidth=YES;
    [self.scrollView addSubview:Status];
    
    UILabel *power1=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100*NOW_SIZE)/2, (240*HEIGHT_SIZE)/2-SizeH-SizeH3+35*HEIGHT_SIZE-_pointCenterNum, 100*NOW_SIZE,40*HEIGHT_SIZE )];
    power1.text=_power;
    power1.textAlignment=NSTextAlignmentCenter;
    power1.textColor=[UIColor whiteColor];
    power1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:power1];
    
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
