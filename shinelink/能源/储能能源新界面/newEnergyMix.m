//
//  newEnergyMix.m
//  ShinePhone
//
//  Created by sky on 2017/11/14.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "newEnergyMix.h"
#import "JHChart.h"
#import "JHLineChart.h"
#import "CircleView1.h"
#import "JHColumnChart.h"
#import "EditGraphView.h"
#import "newEnergyDetailData.h"
#import "newEnergyDetaiTwo.h"
#import "MCBarChartView.h"


#define viewB  ScreenProH*50
#define viewAA  ScreenProH*100
#define SPF5000H  ScreenProH*80
#define ScreenProW  HEIGHT_SIZE/2.38
#define ScreenProH  NOW_SIZE/2.34

#define mixPVcolor COLOR(85, 162, 78, 1)
#define mixYongDianXiaoHaocolor COLOR(82, 164, 179, 1)
#define mixDianWangQuDiancolor COLOR(175, 105, 105, 1)
#define mixLaiZiDianChicolor COLOR(89, 135, 212, 1)

@interface newEnergyMix ()<EditGraphViewDelegate,UIScrollViewDelegate,UIPickerViewDelegate,MCBarChartViewDataSource, MCBarChartViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *pcsNetPlantID;
@property (nonatomic, strong) NSString *pcsNetStorageSN;
@property (nonatomic, strong) NSDictionary *dataOneDic;
@property (nonatomic, strong) NSDictionary *dataTwoDic;
@property (nonatomic, strong) NSDictionary *dataThreeDic;
@property (nonatomic, strong) NSMutableDictionary *dataFourDic;
@property (nonatomic, strong) NSDictionary *dataFiveDic;
@property (nonatomic, strong) NSDictionary *dataTwoNetAllDic;

@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *datePickerButton;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) UIDatePicker *dayPicker;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong)JHLineChart *lineChart;
@property (nonatomic, strong)JHLineChart *lineChart2;

@property(nonatomic,strong)UIButton *selectButton;
@property (nonatomic, strong) UIView *uiview1;
@property (nonatomic, strong) UIView *uiview2;
@property(nonatomic,strong)EditGraphView *editGraph;
@property (nonatomic, strong) NSDictionary *typeDic;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) UIRefreshControl *control;
@property (nonatomic,assign) NSInteger refreshTag;

@property (nonatomic, strong) UIView *uiviewThree;
@property (nonatomic, strong) NSMutableArray *toDetaiDataArray;
@property (nonatomic, strong) NSMutableArray *toDetaiDataArray2;
@property (nonatomic, strong) NSMutableArray *toDetaiDataArray3;
@property (nonatomic, strong) NSMutableArray *boolArray;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *UncolorArray;

@property (strong, nonatomic) NSArray *Xtitles2;
@property (strong, nonatomic) NSMutableArray *dataSource2;
@property (strong, nonatomic) MCBarChartView *barChartView2;
@property (strong, nonatomic)UILabel* unitLable;


@property (nonatomic, strong) NSDateFormatter *monthFormatter;
@property (nonatomic, strong) NSDateFormatter *yearFormatter;
@property (nonatomic, strong) NSDateFormatter *onlyMonthFormatter;

@property (nonatomic, strong) NSMutableArray *yearsArr;
@property (nonatomic, strong) NSMutableArray *monthArr;
@property (nonatomic, strong) NSMutableArray *barColorArray;

@property (nonatomic, strong) UIPickerView *monthPicker;
@property (nonatomic, strong) UIPickerView *yearPicker;
@property (nonatomic, strong) NSString *currentMonth;
@property (nonatomic, strong) NSString *currentYear;
@property (nonatomic, strong)UIView *buttonBackView;
@property (nonatomic, strong)UIView *threeView;

@end

static const NSTimeInterval secondsPerDay = 24 * 60 * 60;

@implementation newEnergyMix



-(void)viewWillAppear:(BOOL)animated{
    //  [self prefersStatusBarHidden];
    //    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    self.tabBarController.tabBar.hidden = NO;
    
        [self initData];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *isNew=[ud objectForKey:@"isNewEnergy"];
    if ([isNew isEqualToString:@"N"]) {
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController popViewControllerAnimated:NO];
        
    }else{
        UILabel *btnChapter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];//左边打开侧滑的按钮
        [btnChapter setText:@""];
        UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:btnChapter];
        self.navigationItem.leftBarButtonItem = item;
        
        // self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton=YES;
        self.navigationItem.backBarButtonItem.title=@"";
        [self.navigationController.navigationBar setBarTintColor:MainColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                          NSForegroundColorAttributeName :[UIColor whiteColor]
                                                                          }];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        
        [self setTitle:root_energy_title];
    }
    
    _boolArray=[NSMutableArray arrayWithObjects:[NSNumber numberWithBool:NO],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO], nil];
    

    
    _colorArray=@[mixPVcolor,mixYongDianXiaoHaocolor,mixDianWangQuDiancolor,mixLaiZiDianChicolor];
    float A=0.3;
    _UncolorArray=@[COLOR(85, 162, 78, A),COLOR(82, 164, 179, A),COLOR(175, 105, 105, A),COLOR(89, 135, 212, A)];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pcsNetPlantID=[[NSUserDefaults standardUserDefaults] objectForKey:@"pcsNetPlantID"];
    _pcsNetStorageSN=[[NSUserDefaults standardUserDefaults] objectForKey:@"pcsNetStorageSN"];
    
    [self initUI];
    
    
}



-(void)initUI{
    
    if (_scrollView) {
        [_scrollView removeFromSuperview];
        _scrollView=nil;
    }
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,3400*ScreenProH);
    _scrollView.backgroundColor=[UIColor whiteColor];
    
    
    _control=[[UIRefreshControl alloc]init];
    [_control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [_scrollView addSubview:_control];
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
     [_control beginRefreshing];
    
    
    
    
    
    [self getNetOne];
    
  [self initUITwo];
    
  [self getNetThree];
    
}




-(void)refreshStateChange:(UIRefreshControl *)control{
    
    
    [self initUI];
    
}

-(void)initUIOne{
    
    UIView *V0=[[UIView alloc]initWithFrame:CGRectMake(0, 0*ScreenProH, SCREEN_Width, 470*ScreenProH-viewAA+SPF5000H)];
    [_scrollView addSubview:V0];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)COLOR(0, 156, 255, 1).CGColor, (__bridge id)COLOR(11, 182, 255, 1).CGColor];
    gradientLayer.locations = nil;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.frame = CGRectMake(0, 0, V0.frame.size.width, V0.frame.size.height);
    [V0.layer addSublayer:gradientLayer];
    
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(0, 143*ScreenProH-viewAA, SCREEN_Width, ScreenProH*60)];
    [_scrollView addSubview:V1];
    
    UIView *V11=[[UIView alloc]initWithFrame:CGRectMake(30*ScreenProW, 143*ScreenProH-viewAA+ScreenProH*60, SCREEN_Width-60*ScreenProW, ScreenProH*1)];
    V11.backgroundColor=COLOR(255, 255, 255, 0.8);
    [_scrollView addSubview:V11];
    
    UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(40*ScreenProW, 13*ScreenProH, 35*ScreenProH, ScreenProH*35)];
    [VM1 setImage:[UIImage imageNamed:@"energyinfo_icon.png"]];
    [V1 addSubview:VM1];
    
    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(90*ScreenProW, 0*ScreenProH, 300*ScreenProH, ScreenProH*60)];
    VL1.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL1.textAlignment = NSTextAlignmentLeft;
    
    VL1.text=root_nengyuan_gailan;
    VL1.textColor =[UIColor whiteColor];
    [V1 addSubview:VL1];
    
    UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(400*ScreenProW, 0*ScreenProH, 320*ScreenProH, ScreenProH*60)];
    VL2.font=[UIFont systemFontOfSize:20*ScreenProH];
    VL2.textAlignment = NSTextAlignmentRight;
    NSString *N1=root_PCS_danwei; NSString *N2=root_dangri; NSString *N3=root_leiji;
    NSString *N=[NSString stringWithFormat:@"%@:kWh  %@/%@",N1,N2,N3];
    VL2.text=N;
    VL2.textColor =COLOR(255, 255, 255, 0.95);
    [V1 addSubview:VL2];
    
    _uiview1=[[UIView alloc]initWithFrame:CGRectMake(0, 205*ScreenProH-viewAA, SCREEN_Width, ScreenProH*250)];
    [_scrollView addSubview:_uiview1];
    
    NSArray *lableName=[NSArray arrayWithObjects:root_guangfu_chanchu,root_5000Chart_177,root_MIX_213,root_yongdian_xiaohao,nil];
    NSString *A=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"epvToday"],[_dataOneDic objectForKey:@"epvTotal"]];
    NSString *B=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"edischarge1Today"],[_dataOneDic objectForKey:@"edischarge1Total"]];
    NSString *C=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"etoGridToday"],[_dataOneDic objectForKey:@"etogridTotal"]];
    NSString *D=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"elocalLoadToday"],[_dataOneDic objectForKey:@"elocalLoadTotal"]];
    
    
    NSArray *lableValue=[NSArray arrayWithObjects:A,B,C,D,nil];
    
    
    float H=ScreenProH*65;
    for (int i=0; i<lableName.count; i++) {
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(0, 20*ScreenProH+(H+10*ScreenProH)*i, SCREEN_Width/2, H)];
        VL1.font=[UIFont systemFontOfSize:30*ScreenProH];
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=lableName[i];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.textColor =COLOR(255, 255, 255, 1);
        [_uiview1 addSubview:VL1];
    }
    for (int i=0; i<lableValue.count; i++) {
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/2, 20*ScreenProH+(H+10*ScreenProH)*i, SCREEN_Width/2, H)];
        VL1.font=[UIFont systemFontOfSize:30*ScreenProH];
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=lableValue[i];
        VL1.textColor =COLOR(255, 255, 255, 1);
        [_uiview1 addSubview:VL1];
    }
    _uiview1.frame=CGRectMake(0, 205*ScreenProH-viewAA, SCREEN_Width, ScreenProH*20+(H+10*ScreenProH)*4);
    
}


-(void)getCharNum:(UITapGestureRecognizer*)tap{
    int Num=(int)tap.view.tag-3000;
    UIButton *button=[tap.view viewWithTag:Num+4000];
    
    BOOL isbool=[_boolArray[Num] boolValue];
    isbool=!isbool;
    [_boolArray replaceObjectAtIndex:Num withObject:[NSNumber numberWithBool:isbool]];
    if (isbool) {
        button.backgroundColor=_colorArray[Num];
    }else{
        button.backgroundColor=_UncolorArray[Num];
    }
    
    if ([_type isEqualToString:@"0"]) {
            [self initUILineChart];
    }else{
        [self initBarChart];
    }

    
    
}

-(void)initUITwo{
    
    
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(0, 480*ScreenProH-viewAA+SPF5000H, SCREEN_Width, ScreenProH*60)];
    [_scrollView addSubview:V1];
    
    UIView *V11=[[UIView alloc]initWithFrame:CGRectMake(30*ScreenProW, 480*ScreenProH-viewAA+ScreenProH*60+SPF5000H, SCREEN_Width-60*ScreenProW, ScreenProH*1)];
    V11.backgroundColor=COLOR(222, 222, 222, 1);
    [_scrollView addSubview:V11];
    
    UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(40*ScreenProW, 13*ScreenProH, 35*ScreenProH, ScreenProH*35)];
    [VM1 setImage:[UIImage imageNamed:@"energyuse_icon.png"]];
    [V1 addSubview:VM1];
    
    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(90*ScreenProW, 0*ScreenProH, 500*ScreenProH, ScreenProH*60)];
    VL1.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL1.textAlignment = NSTextAlignmentLeft;
    VL1.text=root_nengyuan_chanhao;
    VL1.textColor =COLOR(51, 51, 51, 1);
    [V1 addSubview:VL1];
    
    UIImageView *VM2= [[UIImageView alloc] initWithFrame:CGRectMake(660*ScreenProW, 13*ScreenProH, 35*ScreenProH, ScreenProH*35)];
    [VM2 setImage:[UIImage imageNamed:@"note.png"]];
    VM2.userInteractionEnabled=YES;
    UITapGestureRecognizer * demo1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getDetail)];
    [VM2 addGestureRecognizer:demo1];
    [V1 addSubview:VM2];
    
    
    _buttonBackView=[[UIView alloc]initWithFrame:CGRectMake(225*ScreenProW, 550*ScreenProH-viewAA+SPF5000H, 300*ScreenProW, ScreenProH*60)];
    _buttonBackView.layer.borderWidth=ScreenProH*1;
    _buttonBackView.layer.cornerRadius=ScreenProH*60/2.5;
    _buttonBackView.layer.borderColor=COLOR(154, 154, 154, 1).CGColor;
    _buttonBackView.userInteractionEnabled = YES;
    [_scrollView addSubview:_buttonBackView];
    
    self.lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastButton.frame = CGRectMake(15*ScreenProW, 12.5*ScreenProH, 30*ScreenProH, 35*ScreenProH);
    [self.lastButton setImage:IMAGE(@"date_left_icon.png") forState:UIControlStateNormal];
    //self.lastButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
    self.lastButton.tag = 1004;
    [self.lastButton addTarget:self action:@selector(lastDate:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonBackView addSubview:self.lastButton];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(CGRectGetWidth(_buttonBackView.frame) - 15*ScreenProW-30*ScreenProH, 12.5*ScreenProH, 30*ScreenProH, 35*ScreenProH);
    [self.nextButton setImage:IMAGE(@"date_right_icon.png") forState:UIControlStateNormal];
    //self.nextButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
    self.nextButton.tag = 1005;
    [self.nextButton addTarget:self action:@selector(nextDate:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonBackView addSubview:self.nextButton];
    
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd"];
    self.monthFormatter = [[NSDateFormatter alloc] init];
    [self.monthFormatter setDateFormat:@"yyyy-MM"];
    self.yearFormatter = [[NSDateFormatter alloc] init];
    [self.yearFormatter setDateFormat:@"yyyy"];
    self.onlyMonthFormatter = [[NSDateFormatter alloc] init];
    [self.onlyMonthFormatter setDateFormat:@"MM"];
    self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    self.currentMonth = [_monthFormatter stringFromDate:[NSDate date]];
    self.currentYear = [_yearFormatter stringFromDate:[NSDate date]];
    
    
    self.datePickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.datePickerButton.frame = CGRectMake(30*ScreenProW+30*ScreenProH, 0, CGRectGetWidth(_buttonBackView.frame) -( 30*ScreenProW+30*ScreenProH)*2, 60*ScreenProH);
    self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [self.datePickerButton setTitleColor:COLOR(102, 102, 102, 1) forState:UIControlStateNormal];
    self.datePickerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.datePickerButton.titleLabel.font = [UIFont boldSystemFontOfSize:28*ScreenProH];
    [self.datePickerButton addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventTouchUpInside];
    [_buttonBackView addSubview:self.datePickerButton];
    
    _typeDic=@{@"1":root_DAY,@"2":root_MONTH,@"3":root_YEAR,@"4":root_TOTAL};
    _selectButton=[[UIButton alloc]initWithFrame:CGRectMake(580*ScreenProW, 550*ScreenProH-viewAA+SPF5000H, 125*ScreenProW, 60*ScreenProH)];
    [_selectButton setTitle:_typeDic[@"1"] forState:0];
    //    _selectButton.layer.borderWidth=ScreenProH*1;
    //    _selectButton.layer.cornerRadius=ScreenProH*60/2.5;
    //    _selectButton.layer.borderColor=COLOR(154, 154, 154, 1).CGColor;
    _selectButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [_selectButton setTitleColor:COLOR(102, 102, 102, 1) forState:UIControlStateNormal];
    _selectButton.titleLabel.font=[UIFont boldSystemFontOfSize:26*ScreenProH];
    [_selectButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    _selectButton.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_selectButton];
    
    
    UIImageView *selectView = [[UIImageView alloc] initWithFrame:CGRectMake(580*ScreenProW+127*ScreenProW, 550*ScreenProH-viewAA+SPF5000H+20*ScreenProH, 20*ScreenProH, 20*ScreenProH)];
    selectView.image = IMAGE(@"drop_down.png");
    [_scrollView addSubview:selectView];
    
    
    _unitLable= [[UILabel alloc] initWithFrame:CGRectMake(30*ScreenProW, 600*ScreenProH-viewAA+SPF5000H, 100*ScreenProW, 40*ScreenProH)];
    _unitLable.font=[UIFont systemFontOfSize:25*ScreenProH];
    _unitLable.textAlignment = NSTextAlignmentLeft;
    NSString *N=@"W";
    _unitLable.text=N;
    _unitLable.textColor =COLOR(51, 51, 51, 1);
    [_scrollView addSubview:_unitLable];
    
    _type=@"0";
    [self getNetTwo:_currentDay];
    
    
}


-(void)getDetail{
    if (_toDetaiDataArray.count>0) {
        newEnergyDetailData *registerRoot=[[newEnergyDetailData alloc]init];
        if ([_type isEqualToString:@"0"]) {
                  registerRoot.lableNameArray=@[root_shijian,root_guangfu_chanchu_1,root_yongdian_xiaohao,root_MIX_214,root_MIX_215];
        }else{
             registerRoot.lableNameArray=@[root_riqi,root_guangfu_chanchu_1,root_yongdian_xiaohao,root_MIX_214,root_MIX_215];
        }
  
        registerRoot.getDetaiDataArray=[NSMutableArray arrayWithArray:_toDetaiDataArray];
        [self.navigationController pushViewController:registerRoot animated:YES];
    }else{
        [self showToastViewWithTitle:root_Device_head_188];
    }
    
    
}


-(void)buttonPressed{
    
    _editGraph = [[EditGraphView alloc] initWithFrame:self.view.bounds dictionary:_typeDic];
    
    _editGraph.delegate = self;
    _editGraph.tintColor = [UIColor blackColor];
    _editGraph.dynamic = NO;
    _editGraph.blurRadius = 10.0f;
    [[UIApplication sharedApplication].keyWindow addSubview:_editGraph];
}

#pragma mark - EditCellectViewDelegate
- (void)menuDidSelectAtRow:(NSInteger)row {
    if (row==0) {
        //取消菜单
        [_editGraph removeFromSuperview];
    }
    
    if (row==1) {
        [_editGraph removeFromSuperview];
        NSString *string=[NSString stringWithFormat:@"%d",1];
        [_selectButton setTitle:_typeDic[string] forState:0];
        _type=[NSString stringWithFormat:@"%d",0];
        _unitLable.text=@"W";
        [UIView animateWithDuration:0.3f animations:^{
            self.buttonBackView.alpha =1;
        }];
        if (!self.currentDay) {
            self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
        }
        [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
        
        [self getNetTwo:_currentDay];
    }
    
    if (row==2) {
        [_editGraph removeFromSuperview];
        NSString *string=[NSString stringWithFormat:@"%d",2];
        [_selectButton setTitle:_typeDic[string] forState:0];
        _type=[NSString stringWithFormat:@"%d",1];
         _unitLable.text=@"kWh";
        [UIView animateWithDuration:0.3f animations:^{
            self.buttonBackView.alpha =1;
        }];
        if (!self.currentMonth) {
            self.currentMonth = [_monthFormatter stringFromDate:[NSDate date]];
        }
        [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
        
        [self getNetTwo:_currentMonth];
    }
    
    if (row==3) {
        [_editGraph removeFromSuperview];
        NSString *string=[NSString stringWithFormat:@"%d",3];
        [_selectButton setTitle:_typeDic[string] forState:0];
        _type=[NSString stringWithFormat:@"%d",2];
          _unitLable.text=@"kWh";
        [UIView animateWithDuration:0.3f animations:^{
            self.buttonBackView.alpha =1;
        }];
        if (!self.currentYear) {
            self.currentYear = [_yearFormatter stringFromDate:[NSDate date]];
        }
        [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
        
        [self getNetTwo:_currentYear];
    }
    
    if (row==4) {
        [_editGraph removeFromSuperview];
        NSString *string=[NSString stringWithFormat:@"%d",4];
        [_selectButton setTitle:_typeDic[string] forState:0];
        _type=[NSString stringWithFormat:@"%d",3];
          _unitLable.text=@"kWh";
        [UIView animateWithDuration:0.3f animations:^{
            self.buttonBackView.alpha =0;
        }];
        if (!self.currentYear) {
            self.currentYear = [_yearFormatter stringFromDate:[NSDate date]];
        }
        [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
        
        [self getNetTwo:_currentYear];
    }
    
}



-(void)getUITwoLable{
    
    if (_uiview2) {
        [_uiview2 removeFromSuperview];
        _uiview2=nil;
    }
    
    float HH=1160*ScreenProH;
    _uiview2=[[UIView alloc]initWithFrame:CGRectMake(0*ScreenProW, 1160*ScreenProH-viewAA+SPF5000H, 750*ScreenProW, ScreenProH*540)];
    [_scrollView addSubview:_uiview2];
    
    NSArray *nameArray=@[root_guangfu_chanchu_1,root_yongdian_xiaohao,root_MIX_214,root_MIX_215];
    
    for (int i=0; i<4; i++) {
        UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(5*ScreenProW+185*ScreenProW*i, 1160*ScreenProH-HH, 180*ScreenProW, ScreenProH*55)];
        V1.userInteractionEnabled = YES;
        V1.tag=3000+i;
        UITapGestureRecognizer * Tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getCharNum:)];
        [V1 addGestureRecognizer:Tap];
        [_uiview2 addSubview:V1];
        
        UIView *button1= [[UIView alloc]init];
        button1.frame= CGRectMake(40*ScreenProW, 0*ScreenProH, 100*ScreenProW, ScreenProH*20);
        BOOL isbool=[_boolArray[i] boolValue];
        if (isbool) {
            button1.backgroundColor=_colorArray[i];
        }else{
            button1.backgroundColor=_UncolorArray[i];
            
        }
        
        button1.userInteractionEnabled=YES;
        button1.tag=4000+i;
        [V1 addSubview:button1];
        // [button1 addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(0*ScreenProW, 25*ScreenProH, 180*ScreenProW, ScreenProH*30)];
        VL1.font=[UIFont systemFontOfSize:22*ScreenProH];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.userInteractionEnabled=YES;
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=nameArray[i];
        VL1.textColor =COLOR(102, 102, 102, 1);
        [V1 addSubview:VL1];
    }
    
    
    [self initUiTwo2Two];
}

-(void)initUiTwo2Two{
     float HH=1160*ScreenProH;    float lableH=40*ScreenProH;   float Hk=10*ScreenProH;
    
    UIView *V11=[[UIView alloc]initWithFrame:CGRectMake(30*ScreenProW, 1245*ScreenProH-HH-ScreenProH*10, SCREEN_Width-60*ScreenProW, ScreenProH*1)];
    V11.backgroundColor=COLOR(222, 222, 222, 1);
    [_uiview2 addSubview:V11];
    
    
    float VL3W=100*ScreenProW;
    UILabel *VL3= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-VL3W-30*ScreenProW, 1245*ScreenProH-HH, VL3W, lableH)];
    VL3.font=[UIFont systemFontOfSize:30*ScreenProH];
    VL3.textAlignment = NSTextAlignmentRight;
    VL3.text=@"kWh";
    VL3.textColor =COLOR(51, 51, 51, 1);
    [_uiview2 addSubview:VL3];
    
    NSString *A1=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"eChargeToday1"] floatValue]];
    NSString *A2=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"eAcCharge"] floatValue]];
    
    NSString *A4=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"eChargeToday2"] floatValue]];
    NSString *A5=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"etouser"] floatValue]];
    
    BOOL isEmpty1=NO;  BOOL isEmpty2=NO;
    if(([A1 isEqualToString:@"0.0"])&&([A2 isEqualToString:@"0.0"])){
        isEmpty1=YES;
    }
    if(([A4 isEqualToString:@"0.0"])&&([A5 isEqualToString:@"0.0"])){
         isEmpty2=YES;
    }
    NSArray *isEmptyArray=@[[NSNumber numberWithBool:isEmpty1],[NSNumber numberWithBool:isEmpty2]];
    
    float D1=[A1 floatValue];   float D2=[A2 floatValue];
    float A1L=(D1/(D1+D2));

       float D4=[A4 floatValue];   float D5=[A5 floatValue];
      float A2L=(D4/(D4+D5));
    

    
    NSArray *data1=[self getCircleNum:[NSString stringWithFormat:@"%@",[_dataTwoNetAllDic objectForKey:@"eChargeToday1"]] A2:[NSString stringWithFormat:@"%@",[_dataTwoNetAllDic objectForKey:@"eAcCharge"]] ];
    
    NSArray *data2=[self getCircleNum:[NSString stringWithFormat:@"%@",[_dataTwoNetAllDic objectForKey:@"eChargeToday2"]] A2:[NSString stringWithFormat:@"%@",[_dataTwoNetAllDic objectForKey:@"etouser"]] ];
    
    NSArray *laftValueData=@[data1[0],data2[0]];
        NSArray *rightValueData=@[data1[1],data2[1]];
    
     NSArray *colorArray=@[mixPVcolor,mixDianWangQuDiancolor];
      NSArray *colorArray0=@[mixPVcolor,mixYongDianXiaoHaocolor];
    
    NSString *V2N1=root_guangfu_chanchu_1;
    NSString *V2N2=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"eCharge"] floatValue]];
    NSString *V2LableName=[NSString stringWithFormat:@"%@:%@",V2N1,V2N2];
    
    NSString *V3N1=root_yongdian_xiaohao;
    NSString *V3N2=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"elocalLoad"] floatValue]];
    NSString *V3LableName=[NSString stringWithFormat:@"%@:%@",V3N1,V3N2];
    
    NSArray*titleArray=@[V2LableName,V3LableName];
      NSArray*titleColorArray=@[mixPVcolor,mixYongDianXiaoHaocolor];
       NSArray*rightNameArray=@[root_MIX_217,root_Energy_263];
    
    NSString *C1=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"echarge1"] floatValue]];
    NSString *C0=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"eChargeToday2"] floatValue]];
    float CD1=[C1 floatValue];     float CD0=[C0 floatValue];   float CD2=CD0-CD1;
    float CC1=(CD1/CD0)*100;   float CC2=(CD2/CD0)*100;
    NSString *C2=[NSString stringWithFormat:@"%.1f",CD2];
    NSString *leftValue2Name=[NSString stringWithFormat:@"%@:(%@:%@+%@:%@)",root_Energy_264,root_guangfu_chanchu_1,[NSString stringWithFormat:@"%@/%.f%%",C2,CC2],root_PCS_dianyuan,[NSString stringWithFormat:@"%@/%.f%%",C1,CC1]];
    
    
    float Hk0=240*ScreenProH;
    for (int i=0; i<isEmptyArray.count; i++) {
        BOOL isEmpty0=[isEmptyArray[i] boolValue];
        
        UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(0*ScreenProW, 1245*ScreenProH-HH+Hk0*i, ScreenWidth, lableH)];
        VL2.font=[UIFont systemFontOfSize:30*ScreenProH];
        VL2.textAlignment = NSTextAlignmentCenter;
        VL2.text=titleArray[i];
        VL2.textColor =titleColorArray[i];
        [_uiview2 addSubview:VL2];

        
        float Wk=40*ScreenProW; float K1=10*ScreenProH;  float viewH=70*ScreenProH;
        UIView *viewAll= [[UIView alloc] initWithFrame:CGRectMake(Wk, 1245*ScreenProH-HH+lableH+Hk+Hk0*i, ScreenWidth-2*Wk, viewH)];
        viewAll.layer.borderWidth=2*ScreenProH;
        viewAll.layer.cornerRadius=8*ScreenProH;
        UIColor *color1=colorArray0[i];
        viewAll.layer.borderColor=color1.CGColor;
        viewAll.backgroundColor=[UIColor clearColor];
        [_uiview2 addSubview:viewAll];
        
        float W00=ScreenWidth-2*Wk-2*K1;
        float percentValue=A1L;
        if (i==1) {
            percentValue=A2L;
        }
        float Wkx=6*ScreenProH;
        if (isEmpty0) {
            UIView *viewLeft= [[UIView alloc] initWithFrame:CGRectMake(Wk+K1, 1245*ScreenProH-HH+lableH+Hk+K1+Hk0*i, W00, viewH-2*K1)];
            viewLeft.backgroundColor=COLOR(242, 242, 242, 1);
            [_uiview2 addSubview:viewLeft];
        }else{
          
            UIView *viewLeft= [[UIView alloc] initWithFrame:CGRectMake(Wk+K1, 1245*ScreenProH-HH+lableH+Hk+K1+Hk0*i, W00*percentValue, viewH-2*K1)];
            viewLeft.backgroundColor=mixYongDianXiaoHaocolor;
            [_uiview2 addSubview:viewLeft];
            
            UIView *viewRight= [[UIView alloc] initWithFrame:CGRectMake(Wk+K1+W00*percentValue, 1245*ScreenProH-HH+lableH+Hk+K1+Hk0*i, W00-(W00*percentValue), viewH-2*K1)];
            viewRight.backgroundColor=colorArray[i];
            [_uiview2 addSubview:viewRight];
       
            if (percentValue>0.5) {
                viewLeft.frame=CGRectMake(Wk+K1, 1245*ScreenProH-HH+lableH+Hk+K1+Hk0*i, W00*percentValue-Wkx, viewH-2*K1);
                 viewRight.frame=CGRectMake(Wk+K1+W00*percentValue, 1245*ScreenProH-HH+lableH+Hk+K1+Hk0*i, W00-(W00*percentValue), viewH-2*K1);
            }else{
                viewLeft.frame=CGRectMake(Wk+K1, 1245*ScreenProH-HH+lableH+Hk+K1+Hk0*i, W00*percentValue, viewH-2*K1);
                viewRight.frame=CGRectMake(Wk+K1+W00*percentValue+Wkx, 1245*ScreenProH-HH+lableH+Hk+K1+Hk0*i, W00-(W00*percentValue)-Wkx, viewH-2*K1);
            }
        }
            float lableH2=40*ScreenProH;
            UILabel *leftName= [[UILabel alloc] initWithFrame:CGRectMake(Wk, 1245*ScreenProH-HH+lableH+Hk+Hk0*i+viewH, ScreenWidth/2-Wk, lableH2)];
            leftName.font=[UIFont systemFontOfSize:25*ScreenProH];
            leftName.textAlignment = NSTextAlignmentLeft;
            leftName.text=root_MIX_216;
            leftName.textColor =mixYongDianXiaoHaocolor;
            [_uiview2 addSubview:leftName];
            
            UILabel *leftValue= [[UILabel alloc] initWithFrame:CGRectMake(Wk, 1245*ScreenProH-HH+lableH+Hk+Hk0*i+viewH+lableH2, ScreenWidth/2-Wk, lableH2)];
            leftValue.font=[UIFont systemFontOfSize:25*ScreenProH];
            leftValue.textAlignment = NSTextAlignmentLeft;
            leftValue.text=laftValueData[i];
            leftValue.textColor =mixYongDianXiaoHaocolor;
            [_uiview2 addSubview:leftValue];
            
      
            UILabel *rightName= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, 1245*ScreenProH-HH+lableH+Hk+Hk0*i+viewH, ScreenWidth/2-Wk, lableH2)];
            rightName.font=[UIFont systemFontOfSize:25*ScreenProH];
            rightName.textAlignment = NSTextAlignmentRight;
            rightName.text=rightNameArray[i];
            rightName.textColor =colorArray[i];
            [_uiview2 addSubview:rightName];
            
            UILabel *rightValue= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, 1245*ScreenProH-HH+lableH+Hk+Hk0*i+viewH+lableH2, ScreenWidth/2-Wk, lableH2)];
            rightValue.font=[UIFont systemFontOfSize:25*ScreenProH];
            rightValue.textAlignment = NSTextAlignmentRight;
            rightValue.text=rightValueData[i];
            rightValue.textColor =colorArray[i];
            [_uiview2 addSubview:rightValue];
            
            if (i==1) {
                UILabel *leftValue2= [[UILabel alloc] initWithFrame:CGRectMake(Wk, 1245*ScreenProH-HH+lableH+Hk+Hk0*i+viewH+lableH2+lableH2, ScreenWidth-Wk*2, lableH2)];
                leftValue2.font=[UIFont systemFontOfSize:25*ScreenProH];
                leftValue2.textAlignment = NSTextAlignmentLeft;
                leftValue2.text=leftValue2Name;
                leftValue2.textColor =mixYongDianXiaoHaocolor;
                [_uiview2 addSubview:leftValue2];
                
                UIView *V22=[[UIView alloc]initWithFrame:CGRectMake(30*ScreenProW, 1245*ScreenProH-HH+lableH+Hk+Hk0*i+viewH+lableH2*4-10*ScreenProH, SCREEN_Width-60*ScreenProW, ScreenProH*1)];
                V22.backgroundColor=COLOR(222, 222, 222, 1);
                [_uiview2 addSubview:V22];
            }
        
    }
    
    

    

    
 
    
    
}

-(void)initUiTwo2{
        float HH=1160*ScreenProH;
    //////////////////圆饼
    UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(0*ScreenProW, 1245*ScreenProH-HH, 375*ScreenProW, ScreenProH*40)];
    VL2.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL2.textAlignment = NSTextAlignmentCenter;
    NSString *V2N1=root_guangfu_chanchu_1;
    NSString *V2N2=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"eCharge"] floatValue]];
    NSString *V2LableName=[NSString stringWithFormat:@"A-%@:%@",V2N1,V2N2];
    VL2.text=V2LableName;
    VL2.textColor =COLOR(102, 102, 102, 1);
    [_uiview2 addSubview:VL2];
    
    UILabel *VL3= [[UILabel alloc] initWithFrame:CGRectMake(375*ScreenProW, 1245*ScreenProH-HH, 375*ScreenProW, ScreenProH*40)];
    VL3.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL3.textAlignment = NSTextAlignmentCenter;
    NSString *V3N1=root_yongdian_xiaohao;
    NSString *V3N2=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"elocalLoad"] floatValue]];
    NSString *V3LableName=[NSString stringWithFormat:@"B-%@:%@",V3N1,V3N2];
    VL3.text=V3LableName;
    VL3.textColor =COLOR(102, 102, 102, 1);
    [_uiview2 addSubview:VL3];
    
    UILabel *VL4= [[UILabel alloc] initWithFrame:CGRectMake(680*ScreenProW, 1280*ScreenProH-HH, 60*ScreenProW, ScreenProH*40)];
    VL4.font=[UIFont systemFontOfSize:25*ScreenProH];
    VL4.textAlignment = NSTextAlignmentRight;
    VL4.text=@"kWh";
    VL4.textColor =COLOR(51, 51, 51, 1);
    [_uiview2 addSubview:VL4];
    
    NSString *A1=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"eChargeToday1"] floatValue]];
    NSString *A2=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"eAcCharge"] floatValue]];
    
    
    NSString *A4=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"eChargeToday2"] floatValue]];
    NSString *A5=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"etouser"] floatValue]];
    
    
    float circleW=80*ScreenProH;
    float circleH=10*ScreenProH;
    float circleB=375*ScreenProH-circleW;
    float circleH0=1275*ScreenProH-HH+circleH;
    if(([A1 isEqualToString:@"0.0"])&&([A2 isEqualToString:@"0.0"])){
        UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(0*ScreenProW+circleW/2, circleH0, circleB, circleB)];
        [VM1 setImage:[UIImage imageNamed:@"data_null.png"]];
        [_uiview2 addSubview:VM1];
        
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"isSPF5000Circle"];
        CircleView1 *circleView1= [[CircleView1 alloc]initWithFrame:CGRectMake(0*ScreenProW+circleW/2, circleH0, circleB, circleB) andUrlStr:@"1" andAllDic:_dataTwoNetAllDic];
        circleView1.isMIX=YES;
        //  circleView1.allDic=[NSDictionary dictionaryWithDictionary:_dataTwoNetAllDic];
        [_uiview2 addSubview:circleView1];
    }
    
    
    if(([A4 isEqualToString:@"0.0"])&&([A5 isEqualToString:@"0.0"])){
        UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(375*ScreenProW+circleW/2, circleH0, circleB, circleB)];
        [VM1 setImage:[UIImage imageNamed:@"data_null.png"]];
        [_uiview2 addSubview:VM1];
    }else{
        CircleView1 *circleView2= [[CircleView1 alloc]initWithFrame:CGRectMake(375*ScreenProW+circleW/2, circleH0, circleB, circleB) andUrlStr:@"2" andAllDic:_dataTwoNetAllDic];
        circleView2.isMIX=YES;
        //  circleView2.allDic=[NSDictionary dictionaryWithDictionary:_dataTwoNetAllDic];
        [_uiview2 addSubview:circleView2];
    }
    
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSArray *data1=[self getCircleNum:[NSString stringWithFormat:@"%@",[_dataTwoNetAllDic objectForKey:@"eChargeToday1"]] A2:[NSString stringWithFormat:@"%@",[_dataTwoNetAllDic objectForKey:@"eAcCharge"]] ];
    
    NSArray *data2=[self getCircleNum:[NSString stringWithFormat:@"%@",[_dataTwoNetAllDic objectForKey:@"eChargeToday2"]] A2:[NSString stringWithFormat:@"%@",[_dataTwoNetAllDic objectForKey:@"etouser"]] ];
    
    float vH=70*ScreenProH;  float vH0=35*ScreenProH;
    float vH1=20*ScreenProH;
    NSArray *nameArray00=@[ root_MIX_216, root_MIX_217];
    
    NSArray *IMAGEnameArray00=@[@"storageS.png",@"loadS.png"];
    
    float nameW=25*ScreenProW;
    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(5*ScreenProW, 1670*ScreenProH-HH+30*ScreenProH-vH, 210*ScreenProW, ScreenProH*25)];
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        VL1.frame=CGRectMake(5*ScreenProW, 1670*ScreenProH-HH+30*ScreenProH-vH, nameW, ScreenProH*25);
    }else{
        VL1.frame=CGRectMake(5*ScreenProW, 1670*ScreenProH-HH+30*ScreenProH-vH, nameW, ScreenProH*25);
    }
    VL1.font=[UIFont systemFontOfSize:23*ScreenProH];
    VL1.textAlignment = NSTextAlignmentRight;
    NSString *A=@"A:";
    VL1.text=A;
    VL1.textColor =COLOR(102, 102, 102, 1);
    [_uiview2 addSubview:VL1];
    
    
    for (int i=0; i<nameArray00.count; i++) {
        UIView *LV123=[[UIView alloc]initWithFrame:CGRectMake(45*ScreenProW+180*ScreenProW+180*ScreenProW*i, 1680*ScreenProH-HH+30*ScreenProH-vH, 180*ScreenProW, ScreenProH*25)];
        
        UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(45*ScreenProW+180*ScreenProW+180*ScreenProW*i, 1680*ScreenProH-HH+30*ScreenProH-vH, 180*ScreenProW, ScreenProH*25)];
        float W;
        if ([currentLanguage hasPrefix:@"zh-Hans"]) {
            W=(SCREEN_Width-nameW-10*ScreenProW)/2;
            LV123.frame=CGRectMake(nameW+10*ScreenProW+W*i, 1670*ScreenProH-HH+30*ScreenProH-vH, W, ScreenProH*25);
            VL2.frame=CGRectMake(nameW+10*ScreenProW+W*i, 1670*ScreenProH-HH+30*ScreenProH-vH+vH0, W, ScreenProH*25);
        }else{
            W=(SCREEN_Width-nameW-10*ScreenProW)/2;
            LV123.frame=CGRectMake(nameW+10*ScreenProW+W*i, 1670*ScreenProH-HH+30*ScreenProH-vH, W, ScreenProH*25);
            VL2.frame=CGRectMake(nameW+10*ScreenProW+W*i, 1670*ScreenProH-HH+30*ScreenProH-vH+vH0, W, ScreenProH*25);
        }
        [_uiview2 addSubview:LV123];
        
        
        VL2.font=[UIFont systemFontOfSize:22*ScreenProH];
        VL2.adjustsFontSizeToFitWidth=YES;
        VL2.textAlignment = NSTextAlignmentCenter;
        VL2.text=data1[i];
        VL2.textColor =COLOR(102, 102, 102, 1);
        [_uiview2 addSubview:VL2];
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(0*ScreenProH, 0*ScreenProH, W, ScreenProH*25)];
        VL1.font=[UIFont systemFontOfSize:22*ScreenProH];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=nameArray00[i];
        VL1.textColor =COLOR(102, 102, 102, 1);
        [LV123 addSubview:VL1];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:22*ScreenProH] forKey:NSFontAttributeName];
        CGSize size = [nameArray00[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, ScreenProH*25) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(W/2-size.width/2-25*ScreenProH, 0*ScreenProH, 25*ScreenProH, ScreenProH*25)];
        [VM1 setImage:[UIImage imageNamed:IMAGEnameArray00[i]]];
        [LV123 addSubview:VM1];
    }
    
    UIView *V11=[[UIView alloc]initWithFrame:CGRectMake(30*ScreenProW, 1670*ScreenProH-HH+62*ScreenProH-vH1-10*ScreenProH, SCREEN_Width-60*ScreenProW, ScreenProH*1)];
    V11.backgroundColor=COLOR(222, 222, 222, 1);
    [_uiview2 addSubview:V11];
    
    NSArray *nameArray100=@[root_MIX_216,root_MIX_214];
    
    NSArray *IMAGEnameArray100=@[@"storageS.png",@"gridS.png"];
    UILabel *VL100= [[UILabel alloc] initWithFrame:CGRectMake(5*ScreenProW, 1670*ScreenProH-HH+62*ScreenProH-vH1, 210*ScreenProW, ScreenProH*25)];
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        VL100.frame=CGRectMake(5*ScreenProW, 1670*ScreenProH-HH+62*ScreenProH-vH1, nameW, ScreenProH*25);
    }else{
        VL100.frame=CGRectMake(5*ScreenProW, 1670*ScreenProH-HH+62*ScreenProH-vH1, nameW, ScreenProH*25);
    }
    VL100.font=[UIFont systemFontOfSize:23*ScreenProH];
    VL100.adjustsFontSizeToFitWidth=YES;
    VL100.textAlignment = NSTextAlignmentRight;
    NSString *B=@"B:";
    VL100.text=B;
    VL100.textColor =COLOR(102, 102, 102, 1);
    [_uiview2 addSubview:VL100];
    float W;
    for (int i=0; i<nameArray100.count; i++) {
        UIView *LV1=[[UIView alloc]initWithFrame:CGRectMake(45*ScreenProW+180*ScreenProW+180*ScreenProW*i, 1670*ScreenProH-HH+62*ScreenProH-vH1, 180*ScreenProW, ScreenProH*25)];
        
        UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(45*ScreenProW+180*ScreenProW+180*ScreenProW*i, 1670*ScreenProH-HH+30*ScreenProH-vH, 180*ScreenProW, ScreenProH*25)];
        VL2.font=[UIFont systemFontOfSize:22*ScreenProH];
        VL2.adjustsFontSizeToFitWidth=YES;
        VL2.textAlignment = NSTextAlignmentCenter;
        VL2.text=data2[i];
        VL2.textColor =COLOR(102, 102, 102, 1);
        [_uiview2 addSubview:VL2];
        
        if ([currentLanguage hasPrefix:@"zh-Hans"]) {
            W=(SCREEN_Width-nameW-10*ScreenProW)/2;
            LV1.frame=CGRectMake(nameW+10*ScreenProW+W*i, 1670*ScreenProH-HH+62*ScreenProH-vH1, W, ScreenProH*25);
            VL2.frame=CGRectMake(nameW+10*ScreenProW+W*i, 1670*ScreenProH-HH+62*ScreenProH-vH1+vH0, W, ScreenProH*25);
        }else{
            W=(SCREEN_Width-nameW-10*ScreenProW)/2;
            LV1.frame=CGRectMake(nameW+10*ScreenProW+W*i, 1670*ScreenProH-HH+62*ScreenProH-vH1, W, ScreenProH*25);
            VL2.frame=CGRectMake(nameW+10*ScreenProW+W*i, 1670*ScreenProH-HH+62*ScreenProH-vH1+vH0, W, ScreenProH*25);
        }
        [_uiview2 addSubview:LV1];
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(0*ScreenProH, 0*ScreenProH, W, ScreenProH*25)];
        VL1.font=[UIFont systemFontOfSize:22*ScreenProH];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=nameArray100[i];
        VL1.textColor =COLOR(102, 102, 102, 1);
        [LV1 addSubview:VL1];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:22*ScreenProH] forKey:NSFontAttributeName];
        CGSize size = [nameArray100[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, ScreenProH*25) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(W/2-size.width/2-25*ScreenProH, 0*ScreenProH, 25*ScreenProH, ScreenProH*25)];
        [VM1 setImage:[UIImage imageNamed:IMAGEnameArray100[i]]];
        [LV1 addSubview:VM1];
    }
}



-(void)getDetail2{
    
    if (_toDetaiDataArray2.count>0) {
        newEnergyDetaiTwo *registerRoot=[[newEnergyDetaiTwo alloc]init];
        registerRoot.getDetaiDataArray1=[NSMutableArray arrayWithArray:_toDetaiDataArray2];
        registerRoot.getDetaiDataArray2=[NSMutableArray arrayWithArray:_toDetaiDataArray3];
        registerRoot.lableNameArray2=@[root_riqi,root_chongDian,root_fangDian];
    
        [self.navigationController pushViewController:registerRoot animated:YES];
    }
    
}

-(void)initUiThree{
    if (!_threeView) {
        _threeView=[[UIView alloc]initWithFrame:CGRectMake(0, 1730*ScreenProH-viewAA+viewB+SPF5000H, SCREEN_Width, ScreenProH*60)];
        [_scrollView addSubview:_threeView];
        UIView *V11=[[UIView alloc]initWithFrame:CGRectMake(30*ScreenProW, 1730*ScreenProH-viewAA+viewB+ScreenProH*60+SPF5000H, SCREEN_Width-60*ScreenProW, ScreenProH*1)];
        V11.backgroundColor=COLOR(222, 222, 222, 1);
        [_scrollView addSubview:V11];
        
        UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(40*ScreenProW, 13*ScreenProH, 35*ScreenProH, ScreenProH*35)];
        [VM1 setImage:[UIImage imageNamed:@"sp_icon_e.png"]];
        [_threeView addSubview:VM1];
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(90*ScreenProW, 0*ScreenProH, 300*ScreenProH, ScreenProH*60)];
        VL1.font=[UIFont systemFontOfSize:28*ScreenProH];
        VL1.textAlignment = NSTextAlignmentLeft;
        VL1.text=root_MIX_218;
        VL1.textColor =COLOR(51, 51, 51, 1);;
        [_threeView addSubview:VL1];
        
        UIImageView *VM2= [[UIImageView alloc] initWithFrame:CGRectMake(660*ScreenProW, 13*ScreenProH, 35*ScreenProH, ScreenProH*35)];
        [VM2 setImage:[UIImage imageNamed:@"note.png"]];
        VM2.userInteractionEnabled=YES;
        UITapGestureRecognizer * demo1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getDetail2)];
        [VM2 addGestureRecognizer:demo1];
        [_threeView addSubview:VM2];
        
        UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(43*ScreenProW, 1800*ScreenProH-viewAA+viewB+SPF5000H, SCREEN_Width, ScreenProH*30)];
        VL2.font=[UIFont systemFontOfSize:28*ScreenProH];
        VL2.textAlignment = NSTextAlignmentLeft;
        VL2.text=@"%";
        VL2.textColor =COLOR(51, 51, 51, 1);
        [_scrollView addSubview:VL2];
        
    }
   
    
   
    
    if (_dataFiveDic.count>0) {
        [self initUILineChart2];
    }else{
        // NSDictionary *A=@{@"pacToUser":@"0",@"ppv":@"0",@"sysOut":@"0",@"userLoad":@"0"};
        _dataFiveDic=@{@"0:00":@"0",@"1:00":@"0",@"2:00":@"0",@"3:00":@"0",@"4:00":@"0"};
        [self initUILineChart2];
    }
    
    
    if (_dataFourDic.count>0) {
        [self getUiColumnChart];
    }else{
        NSDictionary *A=@{@"charge":@"0",@"disCharge":@"0"};
        _dataFourDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:A,@"0",A,@"1",A,@"2",A,@"3",A,@"4",A,@"5",A,@"6", _currentDay,@"date",nil];
        // _dataFourDic=@{@"9":A,@"8":A,@"7":A,@"6":A,@"5":A,@"4":A,@"3":A};
        [self getUiColumnChart];
    }
    
    
}



-(void)initUILineChart{
    
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1, NSString *obj2){
        NSRange range = NSMakeRange(0, obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSMutableArray *xArray = [NSMutableArray arrayWithArray:[_dataTwoDic.allKeys sortedArrayUsingComparator:sort]];
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSString *key in xArray) {
        [yArray addObject:_dataTwoDic[key]];
    }
    
    NSMutableArray *yArray1 = [NSMutableArray array];
    NSMutableArray *xArray1 = [NSMutableArray array];
    
  
    
    NSMutableArray*Y5=[NSMutableArray array];
    NSMutableArray*Y6=[NSMutableArray array];
    NSMutableArray*Y7=[NSMutableArray array];
    NSMutableArray*Y8=[NSMutableArray array];
    
    if (yArray.count>0) {
        
        for (int i=0; i<yArray.count; i++) {
            if ([[yArray[i] objectForKey:@"pacToUser"] floatValue]>=0) {
                [Y7 addObject:[yArray[i] objectForKey:@"pacToUser"]];
            }else{
                [Y7 addObject:@"0"];
            }
            if ([[yArray[i] objectForKey:@"ppv"] floatValue]>=0) {
                [Y5 addObject:[yArray[i] objectForKey:@"ppv"]];
            }else{
                [Y5 addObject:@"0"];
            }
            if ([[yArray[i] objectForKey:@"sysOut"] floatValue]>=0) {
                [Y6 addObject:[yArray[i] objectForKey:@"sysOut"]];
            }else{
                [Y6 addObject:@"0"];
            }
            if ([[yArray[i] objectForKey:@"userLoad"] floatValue]>=0) {
                [Y8 addObject:[yArray[i] objectForKey:@"userLoad"]];
            }else{
                [Y8 addObject:@"0"];
            }
            
        }
    }
    _toDetaiDataArray=[NSMutableArray arrayWithObjects:xArray, Y5,Y6,Y7,Y8,nil];
    
  
    
    if (xArray.count>2) {
        for (int i=0; i<xArray.count-2; i++) {
            if (i%3==0) {
                float y1=([[yArray[i] objectForKey:@"pacToUser"] floatValue]+[[yArray[i+1] objectForKey:@"pacToUser"] floatValue]+[[yArray[i+2] objectForKey:@"pacToUser"] floatValue])/3;
                float y2=([[yArray[i] objectForKey:@"ppv"] floatValue]+[[yArray[i+1] objectForKey:@"ppv"] floatValue]+[[yArray[i+2] objectForKey:@"ppv"] floatValue])/3;
                float y3=([[yArray[i] objectForKey:@"sysOut"] floatValue]+[[yArray[i+1] objectForKey:@"sysOut"] floatValue]+[[yArray[i+2] objectForKey:@"sysOut"] floatValue])/3;
                float y4=([[yArray[i] objectForKey:@"userLoad"] floatValue]+[[yArray[i+1] objectForKey:@"userLoad"] floatValue]+[[yArray[i+2] objectForKey:@"userLoad"] floatValue])/3;
                NSDictionary *y0=@{@"pacToUser":[NSNumber numberWithFloat:y1],@"ppv":[NSNumber numberWithFloat:y2],@"sysOut":[NSNumber numberWithFloat:y3],@"userLoad":[NSNumber numberWithFloat:y4]};
                [xArray1 addObject:xArray[i]];
                [yArray1 addObject:y0];
            }
        }
        xArray=[NSMutableArray arrayWithArray:xArray1];
        yArray=[NSMutableArray arrayWithArray:yArray1];
    }
    
    
    NSMutableArray*Y1=[NSMutableArray array];
    NSMutableArray*Y2=[NSMutableArray array];
    NSMutableArray*Y3=[NSMutableArray array];
    NSMutableArray*Y4=[NSMutableArray array];
    
    if (yArray.count>0) {
        
        for (int i=0; i<yArray.count; i++) {
            if ([[yArray[i] objectForKey:@"pacToUser"] floatValue]>=0) {
                [Y3 addObject:[yArray[i] objectForKey:@"pacToUser"]];
            }else{
                [Y3 addObject:@"0"];
            }
            if ([[yArray[i] objectForKey:@"ppv"] floatValue]>=0) {
                [Y1 addObject:[yArray[i] objectForKey:@"ppv"]];
            }else{
                [Y1 addObject:@"0"];
            }
            if ([[yArray[i] objectForKey:@"sysOut"] floatValue]>=0) {
                [Y2 addObject:[yArray[i] objectForKey:@"sysOut"]];
            }else{
                [Y2 addObject:@"0"];
            }
            if ([[yArray[i] objectForKey:@"userLoad"] floatValue]>=0) {
                [Y4 addObject:[yArray[i] objectForKey:@"userLoad"]];
            }else{
                [Y4 addObject:@"0"];
            }
            
        }
    }
  //  _toDetaiDataArray=[NSMutableArray arrayWithObjects:xArray, Y1,Y2,Y3,Y4,nil];
    
    NSMutableArray *tempXArr = [NSMutableArray array];
    if (xArray.count > 0) {
        NSString *flag = [[NSMutableString stringWithString:xArray[0]] substringWithRange:NSMakeRange(1, 1)];
        if ([flag isEqualToString:@":"]) {
            //从偶数统计
            for (int i = 1; i <= xArray.count; i++) {
                if (i % 2 == 0) {
                    NSString *tempStr = [[NSMutableString stringWithString:xArray[i-1]] substringToIndex:2];
                    //    NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: [NSString stringWithFormat:@"%d", [tempStr intValue]]};
                    [tempXArr addObject:[NSString stringWithFormat:@"%d", [tempStr intValue]]];
                } else {
                    //  NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: @""};
                    [tempXArr addObject:@""];
                }
            }
        } else {
            //从奇数统计
            for (int i = 1; i <= xArray.count; i++) {
                if (i % 2 != 0) {
                    NSString *tempStr = [[NSMutableString stringWithString:xArray[i-1]] substringToIndex:2];
                    //NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: [NSString stringWithFormat:@"%d", [tempStr intValue]]};
                    [tempXArr addObject:[NSString stringWithFormat:@"%d", [tempStr intValue]]];
                } else {
                    //         NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: @""};
                    [tempXArr addObject:@""];
                }
            }
        }
    }
    
    
    NSSet *set = [NSSet setWithArray:tempXArr];
    tempXArr=[NSMutableArray arrayWithArray:[set allObjects]];
    tempXArr= [NSMutableArray arrayWithArray:[tempXArr sortedArrayUsingComparator:sort]];
    NSString *AAA=[tempXArr objectAtIndex:0];
    if (AAA==nil) {
        [tempXArr removeObjectAtIndex:0];
    }
    if ([AAA isEqualToString:@""]) {
        [tempXArr removeObjectAtIndex:0];
    }
    if (AAA==NULL) {
        [tempXArr removeObjectAtIndex:0];
    }
    
   
    
    NSArray *valueArray0=@[Y1,Y2,Y3,Y4];
    NSArray *valueLineColorArray0=@[mixPVcolor,mixYongDianXiaoHaocolor,mixDianWangQuDiancolor,mixLaiZiDianChicolor];
      //ppv   sysOut   pacToUser  userLoad
    float A=0.5;
    NSArray *contentFillColorArray0=@[COLOR(85, 162, 78, A),COLOR(82, 164, 179, A),COLOR(175, 105, 105, A),COLOR(89, 135, 212, A)];
    
    NSMutableArray *valueArray=[NSMutableArray new];
    NSMutableArray *valueLineColorArray=[NSMutableArray new];
    NSMutableArray *contentFillColorArray=[NSMutableArray new];
    NSMutableArray *positionLineColorArray=[NSMutableArray new];
    for (int i=0; i<_boolArray.count; i++) {
        BOOL value=[_boolArray[i] boolValue];
        if (value) {
            [valueArray addObject:valueArray0[i]];
            [valueLineColorArray addObject:valueLineColorArray0[i]];
            [contentFillColorArray addObject:contentFillColorArray0[i]];
            [positionLineColorArray addObject:[UIColor clearColor]];
        }
    }
    
    
    if (_lineChart) {
        [_lineChart removeFromSuperview];
        _lineChart=nil;
    }
    if (_barChartView2) {
        [_barChartView2 removeFromSuperview];
        _barChartView2=nil;
    }
    
    _lineChart = [[JHLineChart alloc] initWithFrame:CGRectMake(10*ScreenProW, 620*ScreenProH-viewAA+SPF5000H, 740*ScreenProW, 530*ScreenProH) andLineChartType:JHChartLineValueNotForEveryX];
    _lineChart.xlableNameArray=[NSArray arrayWithArray:tempXArr];
    _lineChart.xLineDataArr =xArray;
    _lineChart.contentInsets = UIEdgeInsetsMake(10*ScreenProH, 65*ScreenProW, 40*ScreenProH, 0*ScreenProW);
    
    _lineChart.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
    
    _lineChart.valueArr = valueArray;
    _lineChart.showYLevelLine = YES;
    _lineChart.showYLine = YES;
    //   _lineChart.showValueLeadingLine = YES;
    _lineChart.xDescTextFontSize=20*ScreenProH;
    _lineChart.yDescTextFontSize=20*ScreenProH;
    _lineChart.lineWidth=2*ScreenProH;
    _lineChart.backgroundColor = [UIColor clearColor];
    _lineChart.hasPoint=NO;
    
    _lineChart.valueLineColorArr =valueLineColorArray;
    // _lineChart.pointColorArr = @[[UIColor clearColor],[UIColor clearColor],[UIColor clearColor],[UIColor clearColor]];
    _lineChart.xAndYLineColor = COLOR(153, 153, 153, 1);
    _lineChart.xAndYNumberColor =COLOR(102, 102, 102, 1);
    _lineChart.positionLineColorArr = positionLineColorArray;
    _lineChart.contentFill = YES;
    _lineChart.pathCurve = NO;
    _lineChart.contentFillColorArr = contentFillColorArray;
    [_scrollView addSubview:_lineChart];
    [_lineChart showAnimation];
    
}

-(void)initUILineChart2{
    
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1, NSString *obj2){
        NSRange range = NSMakeRange(0, obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSMutableArray *xArray = [NSMutableArray arrayWithArray:[_dataFiveDic.allKeys sortedArrayUsingComparator:sort]];
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSString *key in xArray) {
        if ([_dataFiveDic[key] isKindOfClass:[NSDictionary class]]) {
               NSDictionary *valueDic=[NSDictionary dictionaryWithDictionary:_dataFiveDic[key]];
            if ([valueDic.allKeys containsObject:@"soc"]) {
                float socValue=[[NSString stringWithFormat:@"%@",[valueDic objectForKey:@"soc"]] floatValue];
                if (socValue<=100) {
                     [yArray addObject:[valueDic objectForKey:@"soc"]];
                }else{
                    [yArray addObject:@"100"];
                }
                
            }
        }else{
              [yArray addObject:_dataFiveDic[key]];
        }
 
       
    }
    
    _toDetaiDataArray2=[NSMutableArray arrayWithObjects:xArray,yArray, nil];
    
    NSMutableArray *tempXArr = [NSMutableArray array];
    if (xArray.count > 0) {
        NSString *flag = [[NSMutableString stringWithString:xArray[0]] substringWithRange:NSMakeRange(1, 1)];
        if ([flag isEqualToString:@":"]) {
            //从偶数统计
            for (int i = 1; i <= xArray.count; i++) {
                if (i % 2 == 0) {
                    NSString *tempStr = [[NSMutableString stringWithString:xArray[i-1]] substringToIndex:2];
                    //    NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: [NSString stringWithFormat:@"%d", [tempStr intValue]]};
                    [tempXArr addObject:[NSString stringWithFormat:@"%d", [tempStr intValue]]];
                } else {
                    //  NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: @""};
                    [tempXArr addObject:@""];
                }
            }
        } else {
            //从奇数统计
            for (int i = 1; i <= xArray.count; i++) {
                if (i % 2 != 0) {
                    NSString *tempStr = [[NSMutableString stringWithString:xArray[i-1]] substringToIndex:2];
                    //NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: [NSString stringWithFormat:@"%d", [tempStr intValue]]};
                    [tempXArr addObject:[NSString stringWithFormat:@"%d", [tempStr intValue]]];
                } else {
                    //         NSDictionary *tempDict = @{[NSNumber numberWithInt:i]: @""};
                    [tempXArr addObject:@""];
                }
            }
        }
    }
    
    
    NSSet *set = [NSSet setWithArray:tempXArr];
    tempXArr=[NSMutableArray arrayWithArray:[set allObjects]];
    tempXArr= [NSMutableArray arrayWithArray:[tempXArr sortedArrayUsingComparator:sort]];
    NSString *AAA=[tempXArr objectAtIndex:0];
    if (AAA==nil) {
        [tempXArr removeObjectAtIndex:0];
    }
    if ([AAA isEqualToString:@""]) {
        [tempXArr removeObjectAtIndex:0];
    }
    if (AAA==NULL) {
        [tempXArr removeObjectAtIndex:0];
    }
    if (_lineChart2) {
        [_lineChart2 removeFromSuperview];
        _lineChart2=nil;
    }
    
    // _lineChart2 = [[JHLineChart alloc] initWithFrame:CGRectMake(10*ScreenProW, 1810*ScreenProH-viewAA+viewB, 730*ScreenProW, 530*ScreenProH)
    
    _lineChart2 = [[JHLineChart alloc] initWithFrame:CGRectMake(10*ScreenProW, 1810*ScreenProH-viewAA+viewB+SPF5000H, 730*ScreenProW, 530*ScreenProH) andLineChartType:JHChartLineValueNotForEveryX];
    
    _lineChart2.xlableNameArray=[NSArray arrayWithArray:tempXArr];
    _lineChart2.xLineDataArr =xArray;
    _lineChart2.contentInsets = UIEdgeInsetsMake(10*ScreenProH, 65*ScreenProW, 40*ScreenProH, 10*ScreenProW);
    
    _lineChart2.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
    _lineChart2.isOnlyOne=YES;
    _lineChart2.valueArr = @[yArray];
    _lineChart2.showYLevelLine = YES;
    _lineChart2.showYLine = YES;
    _lineChart2.showValueLeadingLine = YES;
    _lineChart2.xDescTextFontSize=20*ScreenProH;
    _lineChart2.yDescTextFontSize=20*ScreenProH;
    _lineChart2.lineWidth=1*ScreenProH;
    _lineChart2.backgroundColor = [UIColor clearColor];
    _lineChart2.hasPoint=NO;
    //   lineChart.showValueLeadingLine=YES;
    _lineChart2.valueLineColorArr =@[COLOR(89, 225, 151, 1)];
    // _lineChart2.pointColorArr = @[[UIColor clearColor],[UIColor clearColor],[UIColor clearColor],[UIColor clearColor]];
    _lineChart2.xAndYLineColor = COLOR(153, 153, 153, 1);
    _lineChart2.xAndYNumberColor =COLOR(102, 102, 102, 1);
    _lineChart2.positionLineColorArr = @[[UIColor clearColor],[UIColor clearColor],[UIColor clearColor],[UIColor clearColor]];
    _lineChart2.contentFill = YES;
    _lineChart2.pathCurve = YES;
    _lineChart2.contentFillColorArr = @[COLOR(89, 225, 151, 0.6)];
    [_scrollView addSubview:_lineChart2];
    [_lineChart2 showAnimation];
    
    UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(10*ScreenProW, 2350*ScreenProH+viewB-viewAA+SPF5000H, 730*ScreenProW, 30*ScreenProH)];
    VL2.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL2.textAlignment = NSTextAlignmentCenter;
    VL2.text=root_shishi_SOC;
    VL2.textColor =COLOR(102, 102, 102, 1);
    [_scrollView addSubview:VL2];
    
}

-(void)getUiColumnChart{
    NSString *dataS=[_dataFourDic objectForKey:@"date"];
    // dataS=@"2017-04-01";
    
    [_dataFourDic removeObjectForKey:@"date"];
    NSMutableDictionary *AllDic=[NSMutableDictionary new];
    
    
    NSDateFormatter *dayFormatter1=[[NSDateFormatter alloc] init];
    [dayFormatter1 setDateFormat:@"MM-dd"];
    
    for (id key in _dataFourDic) {
        NSString *Value=[_dataFourDic objectForKey:key];
        //    int Key=dataString1-[key intValue];
        int Key=[key intValue];
        NSDate *currentDayDate = [self.dayFormatter dateFromString:dataS];
        NSDate *yesterday = [currentDayDate dateByAddingTimeInterval: -secondsPerDay*Key];
        NSString *dataSs = [dayFormatter1 stringFromDate:yesterday];
        
        //        NSArray * arr = [dataSs componentsSeparatedByString:@"-"];
        //        NSString *dataString=[arr lastObject];
        //        NSString *KEY=dataString;
        
        [AllDic setObject:Value forKey:dataSs];
    }
    
    
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1, NSString *obj2){
        NSRange range = NSMakeRange(0, obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSMutableArray *xArray = [NSMutableArray arrayWithArray:[AllDic.allKeys sortedArrayUsingComparator:sort]];
    if ([xArray containsObject:@"date"]) {
        [xArray removeObject:@"date"];
    }
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSString *key in xArray) {
        [yArray addObject:AllDic[key]];
    }
    
    
    
    NSMutableArray*valueArr00=[NSMutableArray array];
    //  NSMutableArray*Y2=[NSMutableArray array];
    
    
    if (yArray.count>0) {
        
        for (int i=0; i<yArray.count; i++) {
            NSString *Y1,*Y2;
            if ([[yArray[i] objectForKey:@"charge"] floatValue]>=0) {
                Y1=[yArray[i] objectForKey:@"charge"] ;
            }else{
                Y1=@"0";
            }
            if ([[yArray[i] objectForKey:@"disCharge"] floatValue]>=0) {
                Y2=[yArray[i] objectForKey:@"disCharge"];
            }else{
                Y2=@"0";
            }
            NSArray *Y0=[NSArray arrayWithObjects:Y1,Y2, nil];
            [valueArr00 addObject:Y0];
        }
    }
    
    _toDetaiDataArray3=[NSMutableArray arrayWithObjects:xArray,valueArr00, nil];
    
    float HH=2400*ScreenProH;
    if (_uiviewThree) {
        [_uiviewThree removeFromSuperview];
        _uiviewThree=nil;
    }
    
    _uiviewThree=[[UIView alloc]initWithFrame:CGRectMake(0, 2400*ScreenProH-viewAA+viewB+SPF5000H, SCREEN_Width, ScreenProH*600)];
    //   _uiviewThree=[[UIView alloc]initWithFrame:CGRectMake(0, 2400*ScreenProH-view2H-viewAA, SCREEN_Width, ScreenProH*600)];
    [_scrollView addSubview:_uiviewThree];
    
    JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(10*ScreenProW, 2500*ScreenProH-HH, 730*ScreenProW, 530*ScreenProH)];
    
    column.valueArr = valueArr00;
    
    // column.valueArr =[NSArray arrayWithObjects:A1, nil];
    
    /*       This point represents the distance from the lower left corner of the origin.         */
    column.originSize = CGPointMake(65*ScreenProW, 30*ScreenProH);
    /*    The first column of the distance from the starting point     */
    column.drawFromOriginX = 10*ScreenProW;
    column.typeSpace = 30*ScreenProW;
    column.isShowYLine = YES;
    column.columnWidth = 30*ScreenProW;
    column.xDescTextFontSize=20*ScreenProH;
    column.yDescTextFontSize=20*ScreenProH;
    /*        Column backgroundColor         */
    column.bgVewBackgoundColor = [UIColor clearColor];
    /*        X, Y axis font color         */
    column.drawTextColorForX_Y =COLOR(102, 102, 102, 1);
    /*        X, Y axis line color         */
    column.colorForXYLine =  COLOR(153, 153, 153, 1);
    column.xAndYLineColor = COLOR(153, 153, 153, 1);
    /*    Each module of the color array, such as the A class of the language performance of the color is red, the color of the math achievement is green     */
    column.columnBGcolorsArr = @[COLOR(122, 230, 129, 1),COLOR(254, 238, 62, 1)];
    /*        Module prompt         */
    column.xShowInfoText = xArray;
    column.isShowLineChart = YES;
    
    [column showAnimation];
    [_uiviewThree addSubview:column];
    
    UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(10*ScreenProW, 3050*ScreenProH-HH, 730*ScreenProW, 40*ScreenProH)];
    // UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(10*ScreenProW, 2950*ScreenProH-HH+40*ScreenProH, 730*ScreenProW, 40*ScreenProH)];
    VL2.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL2.textAlignment = NSTextAlignmentCenter;
    VL2.text=root_MIX_219;
    VL2.textColor =COLOR(102, 102, 102, 1);
    [_uiviewThree addSubview:VL2];
    
    UILabel *VL3= [[UILabel alloc] initWithFrame:CGRectMake(25*ScreenProW, 2440*ScreenProH-HH, 100*ScreenProW, 30*ScreenProH)];
    // UILabel *VL3= [[UILabel alloc] initWithFrame:CGRectMake(25*ScreenProW, 2440*ScreenProH-HH, 100*ScreenProW, 30*ScreenProH)];
    VL3.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL3.textAlignment = NSTextAlignmentLeft;
    VL3.text=@"kWh";
    VL3.textColor =COLOR(102, 102, 102, 1);
    [_uiviewThree addSubview:VL3];
    
    NSArray *nameArray1=@[root_chongDian,root_fangDian];
    NSArray *IMAGEnameArray1=@[COLOR(18, 237, 7, 1),COLOR(254, 238, 62, 1)];
    for (int i=0; i<2; i++) {
        UIView *LV1=[[UIView alloc]initWithFrame:CGRectMake(335*ScreenProW+100*i, 2440*ScreenProH-HH, 100*ScreenProW, 30*ScreenProH)];
        //  UIView *LV1=[[UIView alloc]initWithFrame:CGRectMake(375*ScreenProW+100*i, 2440*ScreenProH-HH, 100*ScreenProW, 30*ScreenProH)];
        [_uiviewThree addSubview:LV1];
        
        UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(0*ScreenProW, 6*ScreenProH, 18*ScreenProH, ScreenProH*18)];
        //   UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(0*ScreenProW, 6*ScreenProH, 18*ScreenProH, ScreenProH*18)];
        VM1.backgroundColor=IMAGEnameArray1[i];
        [LV1 addSubview:VM1];
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(30*ScreenProH, 3*ScreenProH, 200*ScreenProW-30*ScreenProH, ScreenProH*25)];
        //  UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(30*ScreenProH, 3*ScreenProH, 200*ScreenProW-30*ScreenProH, ScreenProH*25)];
        VL1.font=[UIFont systemFontOfSize:22*ScreenProH];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.textAlignment = NSTextAlignmentLeft;
        VL1.text=nameArray1[i];
        VL1.textColor =COLOR(102, 102, 102, 1);
        [LV1 addSubview:VL1];
    }
    
    
}

-(void)delayMethod{
    [_control endRefreshing];
}

-(void)getNetOne{
    
    
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":_pcsNetPlantID,@"mixId":_pcsNetStorageSN} paramarsSite:@"/newMixApi.do?op=getEnergyOverview" sucessBlock:^(id content) {
        [self hideProgressView];
        
        
        //  [_control endRefreshing];
        
        _dataOneDic=[NSDictionary new];
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            //    id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"getEnergyOverviewData==%@", jsonObj);
            
            if ([jsonObj[@"result"] integerValue]==1) {
                
                if (jsonObj[@"obj"]==nil || jsonObj[@"obj"]==NULL||([jsonObj[@"obj"] isEqual:@""] )) {
                }else{
                    _dataOneDic=[NSDictionary dictionaryWithDictionary:jsonObj[@"obj"]];
                    [self initUIOne];
                }
                
            }
            
            
        }
    } failure:^(NSError *error) {
        [_control endRefreshing];
        [self hideProgressView];
        
    }];
    
}


-(void)getNetTwo:(NSString*)time{
    
//    time=@"2017-12";
//    _type=@"1";
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":_pcsNetPlantID,@"mixId":_pcsNetStorageSN,@"date":time,@"type":_type} paramarsSite:@"/newMixApi.do?op=getEnergyProdAndCons" sucessBlock:^(id content) {
        [self hideProgressView];
        
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2];
        
        _dataTwoDic=[NSDictionary new];
        _dataTwoNetAllDic=[NSDictionary new];
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            //    id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"/newMixApi.do?op= getEnergyProdAndCons==%@", jsonObj);
            
            if ([jsonObj[@"result"] integerValue]==1) {
                
                if (jsonObj[@"obj"]==nil || jsonObj[@"obj"]==NULL||([jsonObj[@"obj"] isEqual:@""] )) {
                }else{
                     _dataTwoNetAllDic=[NSDictionary dictionaryWithDictionary:jsonObj[@"obj"]];
                        _dataTwoDic=[NSDictionary dictionaryWithDictionary:jsonObj[@"obj"][@"chartData"]];
                
                    [self getUITwoLable];
                    
                }
          
                _toDetaiDataArray=[NSMutableArray array];
                
           
                if (_dataTwoDic.count==0) {
                    if ([_type isEqualToString:@"0"]) {
                        NSDictionary *A=@{@"pacToUser":@"0",@"ppv":@"0",@"sysOut":@"0",@"userLoad":@"0"};
                        _dataTwoDic=[NSDictionary dictionaryWithObject:A forKey:@"0:00"];
                        [self initUILineChart];
                    }else{
                        if (_lineChart) {
                            [_lineChart removeFromSuperview];
                            _lineChart=nil;
                        }
                        if (_barChartView2) {
                            [_barChartView2 removeFromSuperview];
                            _barChartView2=nil;
                        }
                        return ;
                    }
              
                }
           
                
                if ([_type isEqualToString:@"0"]) {
                    
            [self initUILineChart];
                }else{
                    [self initBarChart];
                }
                
            }
            
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}


-(void)initBarChart{
    NSArray *pacToUserArray=[NSArray arrayWithArray:[_dataTwoDic objectForKey:@"pacToUser"]];
    NSArray *ppvArray=[NSArray arrayWithArray:[_dataTwoDic objectForKey:@"ppv"]];
    NSArray *sysOutArray=[NSArray arrayWithArray:[_dataTwoDic objectForKey:@"sysOut"]];
     NSArray *userLoadArray=[NSArray arrayWithArray:[_dataTwoDic objectForKey:@"userLoad"]];
    
    NSNumber *maxyAxisValue1 = [pacToUserArray valueForKeyPath:@"@max.floatValue"];
       NSNumber *maxyAxisValue2 = [ppvArray valueForKeyPath:@"@max.floatValue"];
       NSNumber *maxyAxisValue3 = [sysOutArray valueForKeyPath:@"@max.floatValue"];
       NSNumber *maxyAxisValue4 = [userLoadArray valueForKeyPath:@"@max.floatValue"];
    NSArray *maxArray=@[maxyAxisValue1,maxyAxisValue2,maxyAxisValue3,maxyAxisValue4];
      NSNumber *maxyAxisValue = [maxArray valueForKeyPath:@"@max.floatValue"];
    
    if ([maxyAxisValue integerValue]==0) {
            maxyAxisValue=[NSNumber numberWithInt:100];
    }else{
        float getY0=[maxyAxisValue floatValue]/6;
        int getY1=ceil(getY0);
        if ((0<getY1)&&(getY1<10)) {
            maxyAxisValue=[NSNumber numberWithInt:getY1*6];
        }else if ((10<getY1)&&(getY1<100)) {
            getY1=ceil(getY0/5)*5;
            maxyAxisValue=[NSNumber numberWithInt:getY1*6];
        }else if ((100<getY1)&&(getY1<1000)) {
            getY1=ceil(getY0/50)*50;
            maxyAxisValue=[NSNumber numberWithInt:getY1*6];
        }else if ((1000<getY1)&&(getY1<10000)) {
            getY1=ceil(getY0/500)*500;
            maxyAxisValue=[NSNumber numberWithInt:getY1*6];
        }else if ((10000<getY1)&&(getY1<100000)) {
            getY1=ceil(getY0/5000)*5000;
            maxyAxisValue=[NSNumber numberWithInt:getY1*6];
        }
    }

    //ppv   sysOut   pacToUser  userLoad
    NSMutableArray *allArrayY=[NSMutableArray array];
       NSMutableArray *allArrayX=[NSMutableArray array];
  BOOL boolValue0=[_boolArray[0] boolValue];  BOOL boolValue1=[_boolArray[1] boolValue];
    BOOL boolValue2=[_boolArray[2] boolValue];  BOOL boolValue3=[_boolArray[3] boolValue];
        for (int i=0; i<ppvArray.count; i++) {
            NSMutableArray *newArray=[NSMutableArray array];
            if (boolValue0) {
                if (ppvArray.count>i) {
                    [newArray addObject:ppvArray[i]];
                }else{
                    [newArray addObject:@"0"];
                }
            }
            if (boolValue1) {
                if (sysOutArray.count>i) {
                    [newArray addObject:sysOutArray[i]];
                }else{
                    [newArray addObject:@"0"];
                }
            }
            if (boolValue2) {
                if (pacToUserArray.count>i) {
                    [newArray addObject:pacToUserArray[i]];
                }else{
                    [newArray addObject:@"0"];
                }
            }
            if (boolValue3) {
                if (userLoadArray.count>i) {
                    [newArray addObject:userLoadArray[i]];
                }else{
                    [newArray addObject:@"0"];
                }
            }
            
            
        
                   [allArrayY addObject:newArray];
                if ([_type isEqualToString:@"1"] || [_type isEqualToString:@"2"]) {
                    [allArrayX addObject:[NSString stringWithFormat:@"%d",i+1]];
                }
                if ([_type isEqualToString:@"3"] ) {
                    NSString *yearS= [_yearFormatter stringFromDate:[NSDate date]];
                    NSInteger Num=ppvArray.count;
                    [allArrayX addObject:[NSString stringWithFormat:@"%ld",[yearS integerValue]-Num+1+i]];
                }
          
        }
    


    
 _toDetaiDataArray=[NSMutableArray arrayWithObjects:allArrayX, ppvArray,sysOutArray,pacToUserArray,userLoadArray,nil];
    
    
NSArray *valueLineColorArray000=@[mixPVcolor,mixYongDianXiaoHaocolor,mixDianWangQuDiancolor,mixLaiZiDianChicolor];
    //ppv   sysOut   pacToUser  userLoad

    _barColorArray=[NSMutableArray array];
    for (int i=0; i<_boolArray.count; i++) {
        BOOL value=[_boolArray[i] boolValue];
        if (value) {
            [_barColorArray addObject:valueLineColorArray000[i]];
        }
    }
    
    if (!boolValue0 && !boolValue1 && !boolValue2  && !boolValue3) {
        if (_barChartView2) {
            [_barChartView2 removeFromSuperview];
            _barChartView2=nil;
        }
        return;
    }
    
    
    if (_lineChart) {
        [_lineChart removeFromSuperview];
        _lineChart=nil;
    }
    _Xtitles2=[NSArray arrayWithArray:allArrayX];
    _dataSource2=[NSMutableArray arrayWithArray:allArrayY];

    
    if (!_barChartView2) {
        _barChartView2 = [[MCBarChartView alloc] initWithFrame:CGRectMake(0, 620*ScreenProH-viewAA+SPF5000H, [UIScreen mainScreen].bounds.size.width,  530*ScreenProH)];
        _barChartView2.tag = 222;
        _barChartView2.dataSource = self;
        _barChartView2.delegate = self;
          [_scrollView addSubview:_barChartView2];
    }

    _barChartView2.maxValue = maxyAxisValue;
    _barChartView2.unitOfYAxis = @"";
    _barChartView2.colorOfXAxis =COLOR(153, 153, 153, 1);
    _barChartView2.colorOfXText = COLOR(102, 102, 102, 1);
    _barChartView2.colorOfYAxis = COLOR(153, 153, 153, 1);
    _barChartView2.colorOfYText = COLOR(102, 102, 102, 1);
  
    
    [_barChartView2 reloadDataWithAnimate:YES];
    
    
    
}


- (NSInteger)numberOfSectionsInBarChartView:(MCBarChartView *)barChartView {

        return [_dataSource2 count];
 
    
}


- (NSInteger)barChartView:(MCBarChartView *)barChartView numberOfBarsInSection:(NSInteger)section {
    if (barChartView.tag == 111) {
        return 1;
    } else {
        return [_dataSource2[section] count];
    }
}

- (id)barChartView:(MCBarChartView *)barChartView valueOfBarInSection:(NSInteger)section index:(NSInteger)index {

        return _dataSource2[section][index];
  
}

//NSArray *valueLineColorArray0=@[COLOR(255, 217, 35, 1),COLOR(54, 193, 118, 1),COLOR(139, 128, 255, 1),COLOR(14, 239, 246, 1)];
//ppv   sysOut   pacToUser  userLoad

- (UIColor *)barChartView:(MCBarChartView *)barChartView colorOfBarInSection:(NSInteger)section index:(NSInteger)index {
  
    if (_barColorArray.count>index) {
        return _barColorArray[index];
    }else{
        return COLOR(255, 217, 35, 1);
    }
    
    
   
}

- (NSString *)barChartView:(MCBarChartView *)barChartView titleOfBarInSection:(NSInteger)section {
    return _Xtitles2[section];
}



- (CGFloat)barWidthInBarChartView:(MCBarChartView *)barChartView {
    NSInteger Num= _barColorArray.count;
    float W0=10*NOW_SIZE;
    if ([_type isEqualToString:@"3"]) {
        W0=30*NOW_SIZE;
    }
    float W=W0/Num;

           return W;

}

- (CGFloat)paddingForSectionInBarChartView:(MCBarChartView *)barChartView {

        return 12;
 
}



-(void)getNetThree{
    // NSString *time=@"2017-03-28";
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":_pcsNetPlantID,@"mixId":_pcsNetStorageSN,@"date":_currentDay} paramarsSite:@"/newMixApi.do?op=getMixEnergy" sucessBlock:^(id content) {
        [self hideProgressView];
        _dataFourDic=[NSMutableDictionary new];
        _dataFiveDic=[NSDictionary new];
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            //    id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"getMixEnergy==%@", jsonObj);
            
            if ([jsonObj[@"result"] integerValue]==1) {
                
                if (jsonObj[@"obj"]==nil || jsonObj[@"obj"]==NULL||([jsonObj[@"obj"] isEqual:@""] )) {
                }else{
                    _dataFourDic=[NSMutableDictionary dictionaryWithDictionary:jsonObj[@"obj"][@"cdsData"]];
                    _dataFiveDic=[NSDictionary dictionaryWithDictionary:jsonObj[@"obj"][@"socData"]];
                    [self initUiThree];
                }
                
            }
            
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}






-(NSArray*)getCircleNum:(NSString*)A1 A2:(NSString*)A2{
    NSArray *CircleNumArray;
    
    
    float D1=[A1 floatValue];   float D2=[A2 floatValue];
    float B1=(D1/(D1+D2))*100;
    float B2=(D2/(D1+D2))*100;
    
    CircleNumArray =@[[NSString stringWithFormat:@"%.1f/%.1f%%",D1,B1],
                      [NSString stringWithFormat:@"%.1f/%.1f%%",D2,B2],
                      ];
    
    
    return CircleNumArray;
}


- (void)initData {
    self.yearsArr = [NSMutableArray array];
    for (int i = 1900; i<2100; i++) {
        [self.yearsArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    self.monthArr = [NSMutableArray array];
    for (int i = 1; i<13; i++) {
        [self.monthArr addObject:[NSString stringWithFormat:@"%02d", i]];
    }
}

#pragma mark - 上一个时间  下一个时间  按钮事件
//上一个时间
- (void)lastDate:(UIButton *)sender {
    //日
    if ([_type isEqualToString:@"0"]) {
        NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
        NSDate *yesterday = [currentDayDate dateByAddingTimeInterval: -secondsPerDay];
        
        self.currentDay = [self.dayFormatter stringFromDate:yesterday];
        [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    
        [self getNetTwo:_currentDay];
          [self getNetThree];
    }
    
    //月
    if ([_type isEqualToString:@"1"]) {
        NSDate *currentYearDate = [self.monthFormatter dateFromString:self.currentMonth];
        NSString *currentYearStr = [self.yearFormatter stringFromDate:currentYearDate];
        NSString *currentMonthStr = [self.onlyMonthFormatter stringFromDate:currentYearDate];
        
        
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                
                for (int j = 0; j<self.monthArr.count; j++) {
                    if ([_monthArr[j] integerValue] == [currentMonthStr integerValue]) {
                        if (i > 0 && j > 0) {
                            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i], _monthArr[j-1]];
                            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                        
                             [self getNetTwo:self.currentMonth ];
                        }
                        
                        if (i > 0 && j == 0) {
                            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i-1], _monthArr[_monthArr.count - 1]];
                            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                            [self getNetTwo:self.currentMonth ];
                        }
                        
                        break;
                    }
                }
                
                break;
            }
        }
        
        
        
    }
    
    //年
    if ([_type isEqualToString:@"2"]) {
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                if (i > 0) {
                    self.currentYear = _yearsArr[i-1];
                    [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
                    [self getNetTwo:self.currentYear ];
                }
                break;
            }
        }
    }
}

//下一个时间
- (void)nextDate:(UIButton *)sender {
    //日
    if ([_type isEqualToString:@"0"]) {
        NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
        NSDate *tomorrow = [currentDayDate dateByAddingTimeInterval: secondsPerDay];
        
        NSDate *nowDate= [NSDate date];
        NSComparisonResult result = [tomorrow compare:nowDate];
        
        if (result == NSOrderedDescending) {
            
            [self showToastViewWithTitle:root_wufa_chakan_weilai_shuju];
            return;
        }else{
            self.currentDay = [self.dayFormatter stringFromDate:tomorrow];
            [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
            [self getNetTwo:_currentDay];
            [self getNetThree];
        }
        
    }
    
    
    //月
    if ([_type isEqualToString:@"1"]) {
        NSDate *currentYearDate = [self.monthFormatter dateFromString:self.currentMonth];
        NSString *currentYearStr = [self.yearFormatter stringFromDate:currentYearDate];
        NSString *currentMonthStr = [self.onlyMonthFormatter stringFromDate:currentYearDate];
        
        NSDate *nowDate= [NSDate date];
        
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                
                for (int j = 0; j<self.monthArr.count; j++) {
                    if ([_monthArr[j] integerValue] == [currentMonthStr integerValue]) {
                        if (i < _yearsArr.count && j < _monthArr.count-1) {
                            NSString *monthDate=[NSString stringWithFormat:@"%@-%@", _yearsArr[i], _monthArr[j+1]];
                            NSDate *monthDate1 = [self.monthFormatter dateFromString:monthDate];
                            NSComparisonResult result = [monthDate1 compare:nowDate];
                            
                            if (result == NSOrderedDescending) {
                                
                                [self showToastViewWithTitle:root_wufa_chakan_weilai_shuju];
                                return;
                            }else{
                                self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i], _monthArr[j+1]];
                                [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                                     [self getNetTwo:self.currentMonth ];
                            }
                            
                            
                        }
                        
                        if (i < _yearsArr.count && j == _monthArr.count-1) {
                            NSString *monthDate= [NSString stringWithFormat:@"%@-%@", _yearsArr[i+1], _monthArr[0]];
                            NSDate *monthDate1 = [self.monthFormatter dateFromString:monthDate];
                            NSComparisonResult result = [monthDate1 compare:nowDate];
                            
                            if (result == NSOrderedDescending) {
                                
                                [self showToastViewWithTitle:root_wufa_chakan_weilai_shuju];
                                return;
                            }else{
                                self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i+1], _monthArr[0]];
                                [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                                     [self getNetTwo:self.currentMonth ];
                            }
                            
                            //                            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i+1], _monthArr[0]];
                            //                            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                            //                            [self.monthDict removeAllObjects];
                            //                            [self requestMonthDatasWithMonthString:self.currentMonth];
                        }
                        
                        break;
                    }
                }
                
                break;
            }
        }
        
        
    }
    
    //年
    if ([_type isEqualToString:@"2"]) {
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                if (i < _yearsArr.count) {
                    NSDate *nowDate= [NSDate date];
                    NSString *yearDate=_yearsArr[i+1];
                    NSDate *monthDate1 = [self.yearFormatter dateFromString:yearDate];
                    NSComparisonResult result = [monthDate1 compare:nowDate];
                    
                    if (result == NSOrderedDescending) {
                        
                        [self showToastViewWithTitle:root_wufa_chakan_weilai_shuju];
                        return;
                    }else{
                        self.currentYear = _yearsArr[i+1];
                        [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
                        [self getNetTwo:self.currentYear ];
                    }
                }
                break;
            }
        }
    }
}



#pragma mark - datePickerButton点击事件 选择时间
- (void)pickDate {
    self.lastButton.enabled = NO;
    self.nextButton.enabled = NO;
    
    if ([_type isEqualToString:@"0"]) {
        //选择日
        NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
        
        if (!self.dayPicker) {
            self.dayPicker = [[UIDatePicker alloc] init];
            self.dayPicker.backgroundColor = [UIColor whiteColor];
            self.dayPicker.datePickerMode = UIDatePickerModeDate;
            self.dayPicker.date = currentDayDate;
            self.dayPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            [self.view addSubview:self.dayPicker];
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.date = currentDayDate;
                self.dayPicker.alpha = 1;
                self.dayPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                [self.view addSubview:self.dayPicker];
            }];
        }
    }
    
    if ([_type isEqualToString:@"1"]) {
        //选择月
        NSDate *currentMonthDate = [self.monthFormatter dateFromString:self.currentMonth];
        NSString *currentYearStr = [self.yearFormatter stringFromDate:currentMonthDate];
        NSString *currentMonthStr = [self.onlyMonthFormatter stringFromDate:currentMonthDate];
        
        if (!self.monthPicker) {
            self.monthPicker = [[UIPickerView alloc] init];
            self.monthPicker.backgroundColor = [UIColor whiteColor];
            self.monthPicker.delegate = self;
            self.monthPicker.dataSource = self;
            self.monthPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            [self.view addSubview:self.monthPicker];
            
            for (int i = 0; i<self.yearsArr.count; i++) {
                if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                    [self.monthPicker selectRow:i inComponent:0 animated:NO];
                    break;
                }
            }
            for (int i = 0; i<self.monthArr.count; i++) {
                if ([_monthArr[i] integerValue] == [currentMonthStr integerValue]) {
                    [self.monthPicker selectRow:i inComponent:1 animated:NO];
                    break;
                }
            }
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                for (int i = 0; i<self.yearsArr.count; i++) {
                    if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                        [self.monthPicker selectRow:i inComponent:0 animated:NO];
                        break;
                    }
                }
                for (int i = 0; i<self.monthArr.count; i++) {
                    if ([_monthArr[i] integerValue] == [currentMonthStr integerValue]) {
                        [self.monthPicker selectRow:i inComponent:1 animated:NO];
                        break;
                    }
                }
                self.monthPicker.alpha = 1;
                self.monthPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                [self.view addSubview:self.monthPicker];
            }];
        }
    }
    
    if ([_type isEqualToString:@"2"]) {
        //选择年
        if (!self.yearPicker) {
            self.yearPicker = [[UIPickerView alloc] init];
            self.yearPicker.backgroundColor = [UIColor whiteColor];
            self.yearPicker.delegate = self;
            self.yearPicker.dataSource = self;
            self.yearPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            [self.view addSubview:self.yearPicker];
            
            for (int i = 0; i<self.yearsArr.count; i++) {
                if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                    [self.yearPicker selectRow:i inComponent:0 animated:NO];
                    break;
                }
            }
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                for (int i = 0; i<self.yearsArr.count; i++) {
                    if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                        [self.yearPicker selectRow:i inComponent:0 animated:NO];
                        break;
                    }
                }
                self.yearPicker.alpha = 1;
                self.yearPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                [self.view addSubview:self.yearPicker];
            }];
        }
    }
    
    if (![_type isEqualToString:@"3"]) {
        if (self.toolBar) {
            [UIView animateWithDuration:0.3f animations:^{
                self.toolBar.alpha = 1;
                self.toolBar.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE + 216*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
                [self.view addSubview:_toolBar];
            }];
        } else {
            self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE + 216*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE)];
            self.toolBar.barStyle = UIBarStyleDefault;
            self.toolBar.barTintColor = MainColor;
            [self.view addSubview:self.toolBar];
            
            UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            
            UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:root_finish style:UIBarButtonItemStyleDone target:self action:@selector(completeSelectDate:)];
            [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14*HEIGHT_SIZE],NSFontAttributeName, nil] forState:UIControlStateNormal];
            doneButton.tintColor = [UIColor whiteColor];
            self.toolBar.items = @[spaceButton, doneButton];
        }
    }
}

#pragma mark 完成选择时间
- (void)completeSelectDate:(UIToolbar *)toolBar {
    self.lastButton.enabled = YES;
    self.nextButton.enabled = YES;
    
    if ([_type isEqualToString:@"0"]) {
        if (self.dayPicker) {
            self.currentDay = [self.dayFormatter stringFromDate:self.dayPicker.date];
            [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
            
            [self getNetTwo:_currentDay];
            [self getNetThree];
            
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.alpha = 0;
                self.toolBar.alpha = 0;
                self.dayPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                self.toolBar.frame = CGRectMake(0,( -216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.dayPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
            
        }
    }
    
    if ([_type isEqualToString:@"1"]) {
        if (self.monthPicker) {
            NSInteger rowYear = [_monthPicker selectedRowInComponent:0];
            NSInteger rowMonth = [_monthPicker selectedRowInComponent:1];
            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[rowYear], _monthArr[rowMonth]];
            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
            
              [self getNetTwo:self.currentMonth];
          
            
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.alpha = 0;
                self.toolBar.alpha = 0;
                self.monthPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE- 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.monthPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
    }
    
    if ([_type isEqualToString:@"2"]) {
        if (self.yearPicker) {
            NSInteger rowYear = [_yearPicker selectedRowInComponent:0];
            self.currentYear = [NSString stringWithFormat:@"%@", _yearsArr[rowYear]];
            [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
            
                [self getNetTwo:self.currentYear];
          
            
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.alpha = 0;
                self.toolBar.alpha = 0;
                self.yearPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.yearPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
    }
}

#pragma mark - 取消选择时间
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.dayPicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.dayPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.dayPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.dayPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
            self.lastButton.enabled = YES;
            self.nextButton.enabled = YES;
        }];
    }
    
    if (self.monthPicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.monthPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.monthPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.monthPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
            self.lastButton.enabled = YES;
            self.nextButton.enabled = YES;
        }];
    }
    
    if (self.yearPicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.yearPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.yearPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.yearPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
            self.lastButton.enabled = YES;
            self.nextButton.enabled = YES;
        }];
    }
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == _monthPicker) {
        return 2;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == _monthPicker) {
        if (component == 0) {
            return _yearsArr.count;
        }
        return _monthArr.count;
    }
    return _yearsArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == _monthPicker) {
        if (component == 0) {
            return [NSString stringWithFormat:@"%@", _yearsArr[row]];
        }
        return [NSString stringWithFormat:@"%@", _monthArr[row]];
    }
    return [NSString stringWithFormat:@"%@", _yearsArr[row]];
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
