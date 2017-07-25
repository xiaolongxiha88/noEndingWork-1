//
//  secondViewController.m
//  shinelink
//
//  Created by sky on 16/3/9.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "secondViewController.h"
#import "CircleView.h"
#import"DTKDropdownMenuView.h"
#import "Line2View.h"
//#import "threeViewController.h"
#import "kongZhiNi0.h"
#import "parameterPV.h"
#import "PvLogTableViewController.h"
#import "EquipGraphViewController.h"
#import "PopoverView00.h"

#define SizeH 45*HEIGHT_SIZE
#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]

@interface secondViewController ()
// 进度增长步长
@property (nonatomic, assign) CGFloat step;
@property (nonatomic, strong) CircleView *progressView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *invsDataArr;
@property (nonatomic, strong) NSMutableDictionary *dayDict;
@property (nonatomic, strong) Line2View *line2View;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) NSString *nominalPower;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSString *dayPower;
@property (nonatomic, strong) NSString *totalPower;

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_SnData;
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=NO;
 
    [self.view addSubview:_scrollView];
    
[self.navigationController.navigationBar setBarTintColor:MainColor];
  
     //[self addRightItem];
    [self addGraph];
    
    [self addbutton];
    
}

-(void)addbutton{
    
  
     float SizeH2=15*HEIGHT_SIZE;
    UIButton *firstB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*NOW_SIZE,50*HEIGHT_SIZE )];
    [firstB setImage:[UIImage imageNamed:@"控制.jpg"] forState:UIControlStateNormal];
     [firstB addTarget:self action:@selector(controlThree) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:firstB];
    UILabel *firstL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*NOW_SIZE,20*HEIGHT_SIZE )];
    firstL.text=root_kongzhi;
    firstL.textAlignment=NSTextAlignmentCenter;
    firstL.textColor=[UIColor blackColor];
    firstL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    firstL.adjustsFontSizeToFitWidth=YES;
    [self.scrollView addSubview:firstL];
    
    UIButton *secondB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*NOW_SIZE,50*HEIGHT_SIZE )];
    [secondB setImage:[UIImage imageNamed:@"参数.png"] forState:UIControlStateNormal];
     [secondB addTarget:self action:@selector(parameterPV) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:secondB];
    UILabel *secondL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE+74*NOW_SIZE, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*NOW_SIZE,20*HEIGHT_SIZE )];
    secondL.text=root_canshu;
    secondL.textAlignment=NSTextAlignmentCenter;
    secondL.textColor=[UIColor blackColor];
    secondL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
      secondL.adjustsFontSizeToFitWidth=YES;
    [self.scrollView addSubview:secondL];
    
    UIButton *threeB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*2, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*NOW_SIZE,50*HEIGHT_SIZE )];
    [threeB setImage:[UIImage imageNamed:@"数据.png"] forState:UIControlStateNormal];
     [threeB addTarget:self action:@selector(goPVThree) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:threeB];
    UILabel *threeL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE+74*NOW_SIZE*2, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*NOW_SIZE,20*HEIGHT_SIZE )];
    threeL.text=root_shuju;
    threeL.textAlignment=NSTextAlignmentCenter;
    threeL.textColor=[UIColor blackColor];
    threeL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
      threeL.adjustsFontSizeToFitWidth=YES;
    [self.scrollView addSubview:threeL];
    
    UIButton *fourB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*3, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*NOW_SIZE,50*HEIGHT_SIZE )];
        [fourB addTarget:self action:@selector(goFour) forControlEvents:UIControlEventTouchUpInside];
    [fourB setImage:[UIImage imageNamed:@"日志.png"] forState:UIControlStateNormal];
   
    [self.scrollView addSubview:fourB];
    UILabel *fourL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE+74*NOW_SIZE*3, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*NOW_SIZE,20*HEIGHT_SIZE )];
    fourL.text=root_rizhi;
    fourL.textAlignment=NSTextAlignmentCenter;
    fourL.textColor=[UIColor blackColor];
    fourL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
       fourL.adjustsFontSizeToFitWidth=YES;
    [self.scrollView addSubview:fourL];
    
 
       _scrollView.contentSize = CGSizeMake(SCREEN_Width,SCREEN_Height+20*HEIGHT_SIZE);
    
}

-(void)goFour{
    PvLogTableViewController *four=[[PvLogTableViewController alloc]init];
    four.PvSn=_SnData;
    four.address=@"/newInverterAPI.do?op=getInverterAlarm";
    four.type=@"inverterId";
    [self.navigationController pushViewController:four animated:NO];

}
-(void)controlThree{
    kongZhiNi0 *go=[[kongZhiNi0 alloc]init];
    go.PvSn=_SnData;
    [self.navigationController pushViewController:go animated:YES];
}

-(void)parameterPV{
    parameterPV *pv=[[parameterPV alloc]init];
    pv.PvSn=_SnData;
    [self.navigationController pushViewController:pv animated:NO];
}

-(void)goPVThree{
    EquipGraphViewController *equipGraph=[[EquipGraphViewController alloc]init];
    equipGraph.SnID=_SnData;
    equipGraph.deviceType=@"I";
    equipGraph.dictInfo=@{@"equipId":_SnData,
                          @"daySite":@"/newInverterAPI.do?op=getInverterData",
                          @"monthSite":@"/newInverterAPI.do?op=getMonthPac",
                          @"yearSite":@"/newInverterAPI.do?op=getYearPac",
                          @"allSite":@"/newInverterAPI.do?op=getTotalPac"};
    equipGraph.dict=@{@"1":root_PV_POWER,@"9":root_shuchu_gonglv,  @"2":root_PV1_VOLTAGE, @"3":root_PV1_ELEC_CURRENT, @"4":root_PV2_VOLTAGE, @"5":root_PV2_ELEC_CURRENT, @"6":root_R_PHASE_POWER, @"7":root_S_PHASE_POWER, @"8":root_T_PHASE_POWER};
    [self.navigationController pushViewController:equipGraph animated:YES];
    
}
-(void)addGraph{
    _line2View = [[Line2View alloc] initWithFrame:CGRectMake(0, 265*HEIGHT_SIZE-SizeH-5*HEIGHT_SIZE, SCREEN_Width,270*HEIGHT_SIZE )];
    self.line2View.flag=@"1";
    self.line2View.frameType=@"1";
    [self.scrollView addSubview:self.line2View];
//   self.line2View = [[Line2View alloc] initWithFrame:CGRectMake(0, 275*NOW_SIZE, SCREEN_Width,250*NOW_SIZE )];
//    [self.scrollView addSubview:self.line2View];
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd"];
  self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
      [self showProgressView];
[BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"id":_SnData,@"type":@"1", @"date":self.currentDay} paramarsSite:@"/newInverterAPI.do?op=getInverterData" sucessBlock:^(id content) {
        [self hideProgressView];
     NSLog(@"getInverterData: %@", content);
        if (content) {
            
            NSMutableDictionary *dayDict0=[NSMutableDictionary dictionaryWithDictionary:[content objectForKey:@"invPacData"]];
            self.dayDict=[NSMutableDictionary new];
        for (NSString *key in dayDict0) {
            NSRange rang = NSMakeRange(11, 5);
            NSString *key0=[key substringWithRange:rang];
            NSString *value0=dayDict0[key];
            [_dayDict setValue:value0 forKey:key0];
        }
           // self.dayDict=[NSMutableDictionary dictionaryWithDictionary:[content objectForKey:@"invPacData"]];
            
            
            _nominalPower=[content objectForKey:@"nominalPower"];
          _powerData=[content objectForKey:@"power"];
            
            NSString *dayA=[NSString stringWithFormat:@"%@",content[@"eToday"]];
            NSString *dayB=@"kWh";
            
            if ( [dayA intValue]>1000) {
                float KW=(float)[dayA intValue]/1000;
                dayB=@"MWh";
                dayA=[NSString stringWithFormat:@"%.2f",KW];
            }

            _dayPower=[NSString stringWithFormat:@"%@%@",dayA,dayB];
            
            
            NSString *totalA=[NSString stringWithFormat:@"%@",content[@"eTotal"]];
            NSString *totalB=@"kWh";
            
            if ( [totalA intValue]>1000) {
                float KW=(float)[totalA intValue]/1000;
                totalB=@"MWh";
                totalA=[NSString stringWithFormat:@"%.2f",KW];
            }
            
            _totalPower=[NSString stringWithFormat:@"%@%@",totalA,totalB];
            
            
           // self.line2View.frameType=@"1";
            [self.line2View refreshLineChartViewWithDataDict:_dayDict];
            [self addProcess];
        }
    } failure:^(NSError *error) {
      [self hideProgressView];
         [self addProcess];
    }];
    


}

-(void)addProcess{
    UIView *processView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200*HEIGHT_SIZE)];
    UIImage *bgImage = IMAGE(@"bg3.png");
    processView.layer.contents = (id)bgImage.CGImage;
    [self.scrollView addSubview:processView];
    
    UILabel *dayData=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 180*HEIGHT_SIZE-SizeH, 90*NOW_SIZE,20*HEIGHT_SIZE )];
    dayData.text=_dayPower;
    dayData.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [dayData addGestureRecognizer:tapGestureRecognizer];
    dayData.textAlignment=NSTextAlignmentCenter;
    dayData.textColor=[UIColor whiteColor];
    dayData.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
    [self.scrollView addSubview:dayData];
    UILabel *leftState=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 200*HEIGHT_SIZE-SizeH, 90*NOW_SIZE,20*HEIGHT_SIZE )];
    leftState.text=root_NBQ_ri_dianliang;
    leftState.textAlignment=NSTextAlignmentCenter;
    leftState.textColor=[UIColor whiteColor];
    leftState.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
     leftState.adjustsFontSizeToFitWidth=YES;
    [self.scrollView addSubview:leftState];
    
   // _powerData=@"200000";
     UILabel *powerData=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-130*NOW_SIZE)/2, 120*HEIGHT_SIZE-SizeH, 130*NOW_SIZE,40*HEIGHT_SIZE )];
    NSString *powerH=[NSString stringWithFormat:@"%@W",_powerData];
    powerData.text=powerH;
       powerData.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
    tapGestureRecognizer2.cancelsTouchesInView = NO;
    [powerData addGestureRecognizer:tapGestureRecognizer2];
    powerData.textAlignment=NSTextAlignmentCenter;
    powerData.textColor=[UIColor whiteColor];
    powerData.font = [UIFont systemFontOfSize:24*HEIGHT_SIZE];
    [self.scrollView addSubview:powerData];
    UILabel *centState=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-120*NOW_SIZE)/2,160*HEIGHT_SIZE-SizeH, 120*NOW_SIZE,20*HEIGHT_SIZE )];
    centState.text=root_dangqian_gonglv;
    centState.textAlignment=NSTextAlignmentCenter;
    centState.textColor=[UIColor whiteColor];
    centState.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
     centState.adjustsFontSizeToFitWidth=YES;
    [self.scrollView addSubview:centState];
    
    UILabel *totalData=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-95*NOW_SIZE, 180*HEIGHT_SIZE-SizeH, 90*NOW_SIZE,20*HEIGHT_SIZE )];
    totalData.text=_totalPower;
      totalData.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
    tapGestureRecognizer1.cancelsTouchesInView = NO;
    [totalData addGestureRecognizer:tapGestureRecognizer1];
    totalData.textAlignment=NSTextAlignmentCenter;
    totalData.textColor=[UIColor whiteColor];
    totalData.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
    [self.scrollView addSubview:totalData];
    UILabel *rightState=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-95*NOW_SIZE, 200*HEIGHT_SIZE-SizeH, 90*NOW_SIZE,20*HEIGHT_SIZE )];
    rightState.text=root_NBQ_zong_dianliang;
    rightState.textAlignment=NSTextAlignmentCenter;
    rightState.textColor=[UIColor whiteColor];
    rightState.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
      rightState.adjustsFontSizeToFitWidth=YES;
    rightState.adjustsFontSizeToFitWidth=YES;

    [self.scrollView addSubview:rightState];
    
    UILabel *dayDate=[[UILabel alloc]initWithFrame:CGRectMake(0, 255*HEIGHT_SIZE-SizeH-5*HEIGHT_SIZE, 250*NOW_SIZE,20*HEIGHT_SIZE )];
    dayDate.text=root_ri_gonglv_zoushitu;
    dayDate.textAlignment=NSTextAlignmentLeft;
    dayDate.textColor=[UIColor blackColor];
    dayDate.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    dayData.adjustsFontSizeToFitWidth=YES;
    [self.scrollView addSubview:dayDate];
    
    _progressView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 180*NOW_SIZE, 200*HEIGHT_SIZE)];
    CGPoint center = CGPointMake(CGRectGetMidX( [UIScreen mainScreen].bounds), CGRectGetMidY(processView.bounds));
    _progressView.center = center;
    float K=[_powerData floatValue]/[_nominalPower floatValue];
    //K=0.3;
    _progressView.startAngle = - M_PI*1/2 ;
    _progressView.endAngle   =- M_PI*1/2 +M_PI*2*K;
    [processView addSubview:_progressView];
    self.step = 1.0 / 30;
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.step target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];

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




- (void)updateProgress {
    CGFloat progress = self.progressView.progress;
    if (progress > 100) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    progress += 0.3;
    self.progressView.progress = progress;
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
