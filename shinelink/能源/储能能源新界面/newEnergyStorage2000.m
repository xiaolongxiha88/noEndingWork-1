//
//  newEnergyStorage.m
//  ShinePhone
//
//  Created by sky on 17/3/31.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "newEnergyStorage2000.h"
#import "newEnergyStorage.h"
#import "JHChart.h"
#import "JHLineChart.h"
#import "CircleView1.h"
#import "JHColumnChart.h"
#import "EditGraphView.h"

#define ScreenProW  HEIGHT_SIZE/2.38
#define ScreenProH  NOW_SIZE/2.34

#define view1H  ScreenProH*120
#define view2H  ScreenProH*(120+425)

@interface newEnergyStorage2000 ()<EditGraphViewDelegate,UIScrollViewDelegate,UIPickerViewDelegate>
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

@end


static const NSTimeInterval secondsPerDay = 24 * 60 * 60;



@implementation newEnergyStorage2000

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
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,3050*ScreenProH-view1H-view2H+90*ScreenProH);
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)COLOR(7, 149, 239, 1).CGColor, (__bridge id)COLOR(2, 201, 222, 1).CGColor];
    gradientLayer.locations = nil;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_Width, 3050*ScreenProH-view1H-view2H+90*ScreenProH);
    [_scrollView.layer addSublayer:gradientLayer];
    
    
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
    
    //    _UiOne=[[UIView alloc]initWithFrame:CGRectMake(0, 0*ScreenProH, SCREEN_Width, ScreenProH*1160)];
    //    [_scrollView addSubview:_UiOne];
    
    UILabel *VL0= [[UILabel alloc] initWithFrame:CGRectMake(0*ScreenProW, 50*ScreenProH, 750*ScreenProH, ScreenProH*60)];
    VL0.font=[UIFont systemFontOfSize:45*ScreenProH];
    VL0.textAlignment = NSTextAlignmentCenter;
    VL0.text=root_energy_title;
    VL0.textColor =[UIColor whiteColor];
    [_scrollView addSubview:VL0];
    
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(0, 143*ScreenProH, SCREEN_Width, ScreenProH*60)];
    V1.backgroundColor=COLOR(4, 55, 85, 0.1);
    [_scrollView addSubview:V1];
    
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
    VL2.textColor =COLOR(186, 216, 244, 1);
    [V1 addSubview:VL2];
    
    _uiview1=[[UIView alloc]initWithFrame:CGRectMake(0, 205*ScreenProH, SCREEN_Width, ScreenProH*310-view1H)];
    [_scrollView addSubview:_uiview1];
    
    NSArray *lableName=[NSArray arrayWithObjects:root_guangfu_chanchu,root_nengyuan_chanchu, nil];
    NSString *A=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"epvToday"],[_dataOneDic objectForKey:@"epvTotal"]];
    NSString *B=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"eDischargeToday"],[_dataOneDic objectForKey:@"eDischargeTotal"]];
    NSArray *lableName1=[NSArray arrayWithObjects:A,B, nil];
    
    for (int i=0; i<2; i++) {
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/2*i, 10*ScreenProH, 375*ScreenProH, ScreenProH*55)];
        VL1.font=[UIFont systemFontOfSize:26*ScreenProH];
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=lableName[i];
        VL1.textColor =COLOR(255, 255, 255, 0.7);
        [_uiview1 addSubview:VL1];
    }
    for (int i=0; i<2; i++) {
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/2*i, 45*ScreenProH, 375*ScreenProH, ScreenProH*85)];
        VL1.font=[UIFont systemFontOfSize:40*ScreenProH];
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=lableName1[i];
        VL1.textColor =COLOR(255, 255, 255, 1);
        [_uiview1 addSubview:VL1];
    }
    
//    NSArray *lableName2=[NSArray arrayWithObjects:root_dianwang_xiaohao,root_yongdian_xiaohao, nil];
//    NSString *C=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"eToUserToday"],[_dataOneDic objectForKey:@"eToUserTotal"]];
//    NSString *D=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"useEnergyToday"],[_dataOneDic objectForKey:@"useEnergyTotal"]];
//    NSArray *lableName3=[NSArray arrayWithObjects:C,D, nil];
//    
//    for (int i=0; i<2; i++) {
//        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/2*i, 140*ScreenProH, 375*ScreenProH, ScreenProH*55)];
//        VL1.font=[UIFont systemFontOfSize:26*ScreenProH];
//        VL1.textAlignment = NSTextAlignmentCenter;
//        VL1.text=lableName2[i];
//        VL1.textColor =COLOR(255, 255, 255, 0.7);
//        [_uiview1 addSubview:VL1];
//    }
//    for (int i=0; i<2; i++) {
//        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/2*i, 175*ScreenProH, 375*ScreenProH, ScreenProH*85)];
//        VL1.font=[UIFont systemFontOfSize:40*ScreenProH];
//        VL1.textAlignment = NSTextAlignmentCenter;
//        VL1.text=lableName3[i];
//        VL1.textColor =COLOR(255, 255, 255, 1);
//        [_uiview1 addSubview:VL1];
//    }
    
}


-(void)initUITwo{
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(0, 480*ScreenProH-view1H, SCREEN_Width, ScreenProH*60)];
    V1.backgroundColor=COLOR(4, 55, 85, 0.1);
    [_scrollView addSubview:V1];
    
    UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(40*ScreenProW, 13*ScreenProH, 35*ScreenProH, ScreenProH*35)];
    [VM1 setImage:[UIImage imageNamed:@"energyinfo_icon.png"]];
    [V1 addSubview:VM1];
    
    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(90*ScreenProW, 0*ScreenProH, 500*ScreenProH, ScreenProH*60)];
    VL1.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL1.textAlignment = NSTextAlignmentLeft;
    VL1.text=root_nengyuan_chanhao;
    VL1.textColor =[UIColor whiteColor];
    [V1 addSubview:VL1];
    
    UIView *V2=[[UIView alloc]initWithFrame:CGRectMake(225*ScreenProW, 550*ScreenProH-view1H, 300*ScreenProW, ScreenProH*60)];
    V2.layer.borderWidth=1;
    V2.layer.cornerRadius=ScreenProH*60/2.5;
    V2.layer.borderColor=COLOR(255, 255, 255, 0.7).CGColor;
    V2.userInteractionEnabled = YES;
    [_scrollView addSubview:V2];
    
    self.lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastButton.frame = CGRectMake(15*ScreenProW, 12.5*ScreenProH, 30*ScreenProH, 35*ScreenProH);
    [self.lastButton setImage:IMAGE(@"date_left_icon.png") forState:UIControlStateNormal];
    //self.lastButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
    self.lastButton.tag = 1004;
    [self.lastButton addTarget:self action:@selector(lastDate:) forControlEvents:UIControlEventTouchUpInside];
    [V2 addSubview:self.lastButton];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(CGRectGetWidth(V2.frame) - 15*ScreenProW-30*ScreenProH, 12.5*ScreenProH, 30*ScreenProH, 35*ScreenProH);
    [self.nextButton setImage:IMAGE(@"date_right_icon.png") forState:UIControlStateNormal];
    //self.nextButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
    self.nextButton.tag = 1005;
    [self.nextButton addTarget:self action:@selector(nextDate:) forControlEvents:UIControlEventTouchUpInside];
    [V2 addSubview:self.nextButton];
    
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd"];
    
    self.datePickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.datePickerButton.frame = CGRectMake(30*ScreenProW+30*ScreenProH, 0, CGRectGetWidth(V2.frame) -( 30*ScreenProW+30*ScreenProH)*2, 60*ScreenProH);
    self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [self.datePickerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.datePickerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.datePickerButton.titleLabel.font = [UIFont boldSystemFontOfSize:28*ScreenProH];
    [self.datePickerButton addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventTouchUpInside];
    [V2 addSubview:self.datePickerButton];
    
    _typeDic=@{@"1":root_dangri,@"2":root_leiji};
    _selectButton=[[UIButton alloc]initWithFrame:CGRectMake(580*ScreenProW, 560*ScreenProH-view1H, 150*ScreenProW, 40*ScreenProH)];
    [_selectButton setTitle:_typeDic[@"1"] forState:0];
    _selectButton.titleLabel.font=[UIFont boldSystemFontOfSize:28*ScreenProH];
    [_selectButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    _selectButton.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_selectButton];
    
    
    UIImageView *selectView = [[UIImageView alloc] initWithFrame:CGRectMake(150*ScreenProW-25*ScreenProH, 11*ScreenProH, 20*ScreenProH, 18*ScreenProH)];
    selectView.image = IMAGE(@"triangular2.png");
    [self.selectButton addSubview:selectView];
    
    
    UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(30*ScreenProW, 600*ScreenProH-view1H, 100*ScreenProW, 40*ScreenProH)];
    VL2.font=[UIFont systemFontOfSize:25*ScreenProH];
    VL2.textAlignment = NSTextAlignmentLeft;
    NSString *N=@"W";
    VL2.text=N;
    VL2.textColor =COLOR(255, 255, 255, 0.8);
    [_scrollView addSubview:VL2];
    
    _type=@"0";
    [self getNetTwo:_currentDay];
    
    
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
        _type=[NSString stringWithFormat:@"%d",0];;
        [self getNetTwo:_currentDay];
    }
    
    if (row==2) {
        [_editGraph removeFromSuperview];
        NSString *string=[NSString stringWithFormat:@"%d",2];
        [_selectButton setTitle:_typeDic[string] forState:0];
        _type=[NSString stringWithFormat:@"%d",1];
        [self getNetTwo:_currentDay];
    }
    
}



-(void)getUITwoLable{
    
    if (_uiview2) {
        [_uiview2 removeFromSuperview];
        _uiview2=nil;
    }
    
    float HH=1160*ScreenProH;
    _uiview2=[[UIView alloc]initWithFrame:CGRectMake(0*ScreenProW, 1160*ScreenProH-view1H, 750*ScreenProW, ScreenProH*540)];
    [_scrollView addSubview:_uiview2];
    
    NSArray *colorArray=@[COLOR(255, 217, 35, 1),COLOR(32, 219, 118, 1),COLOR(104, 247, 252, 1),COLOR(55, 110, 251, 1)];
    NSArray *nameArray=@[root_guangfu_chanchu_1,root_nengyuan_chanch_1,root_yongdian_xiaohao,root_yongdian_xiaohao_1];
    
    for (int i=0; i<4; i++) {
        UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(5*ScreenProW+185*ScreenProW*i, 1160*ScreenProH-HH, 180*ScreenProW, ScreenProH*55)];
        V1.userInteractionEnabled = YES;
        [_uiview2 addSubview:V1];
        
        UIButton *button1= [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame= CGRectMake(40*ScreenProW, 0*ScreenProH, 100*ScreenProW, ScreenProH*20);
        button1.backgroundColor=colorArray[i];
        [V1 addSubview:button1];
        // [button1 addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(0*ScreenProW, 25*ScreenProH, 180*ScreenProW, ScreenProH*30)];
        VL1.font=[UIFont systemFontOfSize:22*ScreenProH];
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=nameArray[i];
        VL1.textColor =COLOR(255, 255, 255, 0.8);
        [V1 addSubview:VL1];
    }
    
//    UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(0*ScreenProW, 1245*ScreenProH-HH, 375*ScreenProW, ScreenProH*40)];
//    VL2.font=[UIFont systemFontOfSize:28*ScreenProH];
//    VL2.textAlignment = NSTextAlignmentCenter;
//    NSString *V2N1=root_guangfu_chanchu;
//    NSString *V2N2=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"epvToday"] floatValue]];
//    NSString *V2LableName=[NSString stringWithFormat:@"%@:%@",V2N1,V2N2];
//    VL2.text=V2LableName;
//    VL2.textColor =[UIColor whiteColor];
//    [_uiview2 addSubview:VL2];
//    
//    UILabel *VL3= [[UILabel alloc] initWithFrame:CGRectMake(375*ScreenProW, 1245*ScreenProH-HH, 375*ScreenProW, ScreenProH*40)];
//    VL3.font=[UIFont systemFontOfSize:28*ScreenProH];
//    VL3.textAlignment = NSTextAlignmentCenter;
//    NSString *V3N1=root_zong_yongdian; NSString *V3N2=[NSString stringWithFormat:@"%.1f",[[_dataTwoNetAllDic objectForKey:@"useEnergyToday"] floatValue]];
//    NSString *V3LableName=[NSString stringWithFormat:@"%@:%@",V3N1,V3N2];
//    VL3.text=V3LableName;
//    VL3.textColor =[UIColor whiteColor];
//    [_uiview2 addSubview:VL3];
    
//    UILabel *VL4= [[UILabel alloc] initWithFrame:CGRectMake(680*ScreenProW, 1280*ScreenProH-HH, 60*ScreenProW, ScreenProH*40)];
//    VL4.font=[UIFont systemFontOfSize:25*ScreenProH];
//    VL4.textAlignment = NSTextAlignmentRight;
//    VL4.text=@"kWh";
//    VL4.textColor =COLOR(255, 255, 255, 0.8);
//    [_uiview2 addSubview:VL4];
    
    
//    CircleView1 *circleView1= [[CircleView1 alloc]initWithFrame:CGRectMake(0*ScreenProW, 1295*ScreenProH-HH, 375*ScreenProW, 375*ScreenProH) andUrlStr:@"1" andAllDic:_dataTwoNetAllDic];
//    //  circleView1.allDic=[NSDictionary dictionaryWithDictionary:_dataTwoNetAllDic];
//    [_uiview2 addSubview:circleView1];
//    
//    CircleView1 *circleView2= [[CircleView1 alloc]initWithFrame:CGRectMake(375*ScreenProW, 1295*ScreenProH-HH, 375*ScreenProW, 375*ScreenProH) andUrlStr:@"2" andAllDic:_dataTwoNetAllDic];
//    //  circleView2.allDic=[NSDictionary dictionaryWithDictionary:_dataTwoNetAllDic];
//    [_uiview2 addSubview:circleView2];
    
//    NSArray *nameArray1=@[root_guangfu_chanchu_1,root_nengyuan_chanch_1,root_yongdian_xiaohao,root_yongdian_xiaohao_1];
//    NSArray *IMAGEnameArray1=@[@"solar_icon.png",@"spSmall.png",@"homeLoadSmall.png",@"gridSmall.png"];
//    for (int i=0; i<4; i++) {
//        UIView *LV1=[[UIView alloc]initWithFrame:CGRectMake(15*ScreenProW+180*ScreenProW*i, 1670*ScreenProH-HH, 180*ScreenProW, ScreenProH*25)];
//        [_uiview2 addSubview:LV1];
//        
//        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(0*ScreenProH, 0*ScreenProH, 180*ScreenProW, ScreenProH*25)];
//        VL1.font=[UIFont systemFontOfSize:22*ScreenProH];
//        VL1.textAlignment = NSTextAlignmentCenter;
//        VL1.text=nameArray1[i];
//        VL1.textColor =COLOR(255, 255, 255, 0.8);
//        [LV1 addSubview:VL1];
//        
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:22*ScreenProH] forKey:NSFontAttributeName];
//        CGSize size = [nameArray1[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, ScreenProH*25) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//        
//        UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(90*ScreenProW-size.width/2-30*ScreenProH, 0*ScreenProH, 25*ScreenProH, ScreenProH*25)];
//        [VM1 setImage:[UIImage imageNamed:IMAGEnameArray1[i]]];
//        [LV1 addSubview:VM1];
//    }
    
    
}


-(void)initUiThree{
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(0, 1730*ScreenProH-view2H, SCREEN_Width, ScreenProH*60)];
    V1.backgroundColor=COLOR(4, 55, 85, 0.1);
    [_scrollView addSubview:V1];
    
    UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(40*ScreenProW, 13*ScreenProH, 35*ScreenProH, ScreenProH*35)];
    [VM1 setImage:[UIImage imageNamed:@"sp_icon_e.png"]];
    [V1 addSubview:VM1];
    
    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(90*ScreenProW, 0*ScreenProH, 300*ScreenProH, ScreenProH*60)];
    VL1.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL1.textAlignment = NSTextAlignmentLeft;
    VL1.text=root_chuneng_nengyuan;
    VL1.textColor =[UIColor whiteColor];
    [V1 addSubview:VL1];
    
    UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(43*ScreenProW, 1800*ScreenProH-view2H, SCREEN_Width, ScreenProH*30)];
    VL2.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL2.textAlignment = NSTextAlignmentLeft;
    VL2.text=@"%";
    VL2.textColor =COLOR(255, 255, 255, 0.8);
    [_scrollView addSubview:VL2];
    
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
    
    
    NSMutableArray*Y1=[NSMutableArray array];
    NSMutableArray*Y2=[NSMutableArray array];
    NSMutableArray*Y3=[NSMutableArray array];
    NSMutableArray*Y4=[NSMutableArray array];
    
    if (yArray.count>0) {
        
        for (int i=0; i<yArray.count; i++) {
            if ([[yArray[i] objectForKey:@"pacToUser"] floatValue]>=0) {
                [Y4 addObject:[yArray[i] objectForKey:@"pacToUser"]];
            }else{
                [Y4 addObject:@"0"];
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
                [Y3 addObject:[yArray[i] objectForKey:@"userLoad"]];
            }else{
                [Y3 addObject:@"0"];
            }
            
        }
    }
    
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
    
    if (_lineChart) {
        [_lineChart removeFromSuperview];
        _lineChart=nil;
    }
    
    _lineChart = [[JHLineChart alloc] initWithFrame:CGRectMake(10*ScreenProW, 620*ScreenProH-view1H, 730*ScreenProW, 530*ScreenProH) andLineChartType:JHChartLineValueNotForEveryX];
    _lineChart.xlableNameArray=[NSArray arrayWithArray:tempXArr];
    _lineChart.xLineDataArr =xArray;
    _lineChart.contentInsets = UIEdgeInsetsMake(10*ScreenProH, 65*ScreenProW, 40*ScreenProH, 10*ScreenProW);
    
    _lineChart.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
    
    _lineChart.valueArr = @[Y1,Y2,Y3,Y4];
    _lineChart.showYLevelLine = YES;
    _lineChart.showYLine = NO;
    _lineChart.showValueLeadingLine = YES;
    _lineChart.xDescTextFontSize=20*ScreenProH;
    _lineChart.yDescTextFontSize=20*ScreenProH;
    _lineChart.lineWidth=2*ScreenProH;
    _lineChart.backgroundColor = [UIColor clearColor];
    _lineChart.hasPoint=NO;
    //   lineChart.showValueLeadingLine=YES;
    _lineChart.valueLineColorArr =@[COLOR(255, 217, 35, 1),COLOR(32, 219, 118, 1),COLOR(104, 247, 252, 1),COLOR(55, 110, 251, 1)];
    // _lineChart.pointColorArr = @[[UIColor clearColor],[UIColor clearColor],[UIColor clearColor],[UIColor clearColor]];
    _lineChart.xAndYLineColor = COLOR(255, 255, 255, 0.9);
    _lineChart.xAndYNumberColor = COLOR(255, 255, 255, 0.8);
    _lineChart.positionLineColorArr = @[[UIColor clearColor],[UIColor clearColor],[UIColor clearColor],[UIColor clearColor]];
    _lineChart.contentFill = NO;
    _lineChart.pathCurve = YES;
    //_lineChart.contentFillColorArr = @[COLOR(255, 217, 35, 0.5),COLOR(32, 219, 118, 0.5),COLOR(104, 247, 252, 0.5),COLOR(14, 222, 228, 0.5)];
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
        [yArray addObject:_dataFiveDic[key]];
    }
    
    
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
    
    _lineChart2 = [[JHLineChart alloc] initWithFrame:CGRectMake(10*ScreenProW, 1810*ScreenProH-view2H, 730*ScreenProW, 530*ScreenProH) andLineChartType:JHChartLineValueNotForEveryX];
    _lineChart2.xlableNameArray=[NSArray arrayWithArray:tempXArr];
    _lineChart2.xLineDataArr =xArray;
    _lineChart2.contentInsets = UIEdgeInsetsMake(10*ScreenProH, 65*ScreenProW, 40*ScreenProH, 10*ScreenProW);
    
    _lineChart2.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
    
    _lineChart2.valueArr = @[yArray];
    _lineChart2.showYLevelLine = YES;
    _lineChart2.showYLine = NO;
    _lineChart2.showValueLeadingLine = YES;
    _lineChart2.xDescTextFontSize=20*ScreenProH;
    _lineChart2.yDescTextFontSize=20*ScreenProH;
    _lineChart2.lineWidth=2*ScreenProH;
    _lineChart2.backgroundColor = [UIColor clearColor];
    _lineChart2.hasPoint=NO;
    //   lineChart.showValueLeadingLine=YES;
    _lineChart2.valueLineColorArr =@[COLOR(48, 233, 255, 0.5)];
    // _lineChart2.pointColorArr = @[[UIColor clearColor],[UIColor clearColor],[UIColor clearColor],[UIColor clearColor]];
    _lineChart2.xAndYLineColor = COLOR(255, 255, 255, 0.9);
    _lineChart2.xAndYNumberColor = COLOR(255, 255, 255, 0.8);
    _lineChart2.positionLineColorArr = @[[UIColor clearColor],[UIColor clearColor],[UIColor clearColor],[UIColor clearColor]];
    _lineChart2.contentFill = YES;
    _lineChart2.pathCurve = YES;
    _lineChart2.contentFillColorArr = @[COLOR(48, 233, 255, 0.5)];
    [_scrollView addSubview:_lineChart2];
    [_lineChart2 showAnimation];
    
    UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(10*ScreenProW, 2350*ScreenProH-view2H, 730*ScreenProW, 30*ScreenProH)];
    VL2.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL2.textAlignment = NSTextAlignmentCenter;
    VL2.text=root_shishi_SOC;
    VL2.textColor =COLOR(255, 255, 255, 1);
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
    
    float HH=2400*ScreenProH;
    if (_uiviewThree) {
        [_uiviewThree removeFromSuperview];
        _uiviewThree=nil;
    }
    
    _uiviewThree=[[UIView alloc]initWithFrame:CGRectMake(0, 2400*ScreenProH-view2H, SCREEN_Width, ScreenProH*600)];
    [_scrollView addSubview:_uiviewThree];
    
    JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(10*ScreenProW, 2400*ScreenProH-HH, 730*ScreenProW, 530*ScreenProH)];
    column.valueArr = valueArr00;
    
    // column.valueArr =[NSArray arrayWithObjects:A1, nil];
    
    /*       This point represents the distance from the lower left corner of the origin.         */
    column.originSize = CGPointMake(30*ScreenProW, 30*ScreenProH);
    /*    The first column of the distance from the starting point     */
    column.drawFromOriginX = 10*ScreenProW;
    column.typeSpace = 30*ScreenProW;
    column.isShowYLine = NO;
    column.columnWidth = 30*ScreenProW;
    column.xDescTextFontSize=20*ScreenProH;
    column.yDescTextFontSize=20*ScreenProH;
    /*        Column backgroundColor         */
    column.bgVewBackgoundColor = [UIColor clearColor];
    /*        X, Y axis font color         */
    column.drawTextColorForX_Y =COLOR(255, 255, 255, 0.8);
    /*        X, Y axis line color         */
    column.colorForXYLine =  COLOR(255, 255, 255, 0.5);
    column.xAndYLineColor = COLOR(255, 255, 255, 0.9);
    /*    Each module of the color array, such as the A class of the language performance of the color is red, the color of the math achievement is green     */
    column.columnBGcolorsArr = @[COLOR(18, 237, 7, 1),COLOR(254, 238, 62, 1)];
    /*        Module prompt         */
    column.xShowInfoText = xArray;
    column.isShowLineChart = NO;
    
    [column showAnimation];
    [_uiviewThree addSubview:column];
    
    UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(10*ScreenProW, 2950*ScreenProH-HH, 730*ScreenProW, 40*ScreenProH)];
    VL2.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL2.textAlignment = NSTextAlignmentCenter;
    VL2.text=root_chuneng_congfang_xinxi;
    VL2.textColor =COLOR(255, 255, 255, 1);
    [_uiviewThree addSubview:VL2];
    
    
    UILabel *VL3= [[UILabel alloc] initWithFrame:CGRectMake(25*ScreenProW, 2440*ScreenProH-HH, 100*ScreenProW, 30*ScreenProH)];
    VL3.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL3.textAlignment = NSTextAlignmentLeft;
    VL3.text=@"kWh";
    VL3.textColor =COLOR(255, 255, 255,0.8 );
    [_uiviewThree addSubview:VL3];
    
    NSArray *nameArray1=@[root_mianban_dianliang,root_yongdian_xiaohao];
    NSArray *IMAGEnameArray1=@[COLOR(18, 237, 7, 1),COLOR(254, 238, 62, 1)];
    for (int i=0; i<2; i++) {
        UIView *LV1=[[UIView alloc]initWithFrame:CGRectMake(375*ScreenProW+100*i, 2440*ScreenProH-HH, 100*ScreenProW, 30*ScreenProH)];
        [_uiviewThree addSubview:LV1];
        
        UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(0*ScreenProW, 6*ScreenProH, 18*ScreenProH, ScreenProH*18)];
        VM1.backgroundColor=IMAGEnameArray1[i];
        [LV1 addSubview:VM1];
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(30*ScreenProH, 3*ScreenProH, 200*ScreenProW-30*ScreenProH, ScreenProH*25)];
        VL1.font=[UIFont systemFontOfSize:22*ScreenProH];
        VL1.textAlignment = NSTextAlignmentLeft;
        VL1.text=nameArray1[i];
        VL1.textColor =COLOR(255, 255, 255, 0.8);
        [LV1 addSubview:VL1];
    }
    
    
}

-(void)delayMethod{
    [_control endRefreshing];
}

-(void)getNetOne{
    
    
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":_pcsNetPlantID,@"storageSn":_pcsNetStorageSN} paramarsSite:@"/newStorageAPI.do?op=getEnergyOverviewData" sucessBlock:^(id content) {
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
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":_pcsNetPlantID,@"storageSn":_pcsNetStorageSN,@"date":time,@"type":_type} paramarsSite:@"/newStorageAPI.do?op=getEnergyProdAndConsData" sucessBlock:^(id content) {
        [self hideProgressView];
        
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2];
        
        _dataTwoDic=[NSDictionary new];
        _dataTwoNetAllDic=[NSDictionary new];
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            //    id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"getEnergyProdAndConsData==%@", jsonObj);
            
            if ([jsonObj[@"result"] integerValue]==1) {
                
                if (jsonObj[@"obj"]==nil || jsonObj[@"obj"]==NULL||([jsonObj[@"obj"] isEqual:@""] )) {
                }else{
                    _dataTwoDic=[NSDictionary dictionaryWithDictionary:jsonObj[@"obj"][@"chartData"]];
                    _dataTwoNetAllDic=[NSDictionary dictionaryWithDictionary:jsonObj[@"obj"]];
                    
                    [self getUITwoLable];
                    
                    
                    
                }
                

                if (_dataTwoDic.count>0) {
                    [self initUILineChart];
                }else{
                    NSDictionary *A=@{@"pacToUser":@"0",@"ppv":@"0",@"sysOut":@"0",@"userLoad":@"0"};
                    _dataTwoDic=[NSDictionary dictionaryWithObject:A forKey:@"0:00"];
                    [self initUILineChart];
                }
                
            }
            
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}

-(void)getNetThree{
    // NSString *time=@"2017-03-28";
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":_pcsNetPlantID,@"storageSn":_pcsNetStorageSN,@"date":_currentDay} paramarsSite:@"/newStorageAPI.do?op=getStorageEnergyData" sucessBlock:^(id content) {
        [self hideProgressView];
        _dataFourDic=[NSMutableDictionary new];
        _dataFiveDic=[NSDictionary new];
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            //    id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"getStorageEnergyData==%@", jsonObj);
            
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


-(void)viewWillAppear:(BOOL)animated{
    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *isNew=[ud objectForKey:@"isNewEnergy"];
    if ([isNew isEqualToString:@"N"]) {
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController popViewControllerAnimated:NO];
        
    }else{
        [self.navigationController setNavigationBarHidden:YES];
    }
    
}

- (BOOL)prefersStatusBarHidden
{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *isNew=[ud objectForKey:@"isNewEnergy"];
    if ([isNew isEqualToString:@"N"]) {
        return NO;//隐藏为YES，显示为NO
    }else{
        return  YES;
    }
    
}

- (void)pickDate {
    self.lastButton.enabled = NO;
    self.nextButton.enabled = NO;
    
    
    //选择日
    NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
    
    if (!self.dayPicker) {
        self.dayPicker = [[UIDatePicker alloc] init];
        self.dayPicker.backgroundColor = [UIColor whiteColor];
        self.dayPicker.datePickerMode = UIDatePickerModeDate;
        self.dayPicker.date = currentDayDate;
        self.dayPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE+190*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
        [self.view addSubview:self.dayPicker];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            self.dayPicker.date = currentDayDate;
            self.dayPicker.alpha = 1;
            self.dayPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE+190*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            [self.view addSubview:self.dayPicker];
        }];
    }
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE + 216*HEIGHT_SIZE+190*HEIGHT_SIZE, SCREEN_Width, 30*HEIGHT_SIZE)];
    self.toolBar.barStyle = UIBarStyleDefault;
    self.toolBar.barTintColor = MainColor;
    [self.view addSubview:self.toolBar];
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:root_finish style:UIBarButtonItemStyleDone target:self action:@selector(completeSelectDate:)];
    [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14*HEIGHT_SIZE],NSFontAttributeName, nil] forState:UIControlStateNormal];
    doneButton.tintColor = [UIColor whiteColor];
    self.toolBar.items = @[spaceButton, doneButton];
    
}



- (void)completeSelectDate:(UIToolbar *)toolBar {
    self.lastButton.enabled = YES;
    self.nextButton.enabled = YES;
    
    if (self.dayPicker) {
        self.currentDay = [self.dayFormatter stringFromDate:self.dayPicker.date];
        [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
        [self getNetTwo:_currentDay];
        [UIView animateWithDuration:0.3f animations:^{
            self.dayPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.dayPicker.frame = CGRectMake(0, (-216 - 64 - 70-190)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            self.toolBar.frame = CGRectMake(0,( -216 - 64 - 70-190)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.dayPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
        }];
        
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.dayPicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.dayPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.dayPicker.frame = CGRectMake(0, (-216 - 64 - 70-190)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70-190)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.dayPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
            self.lastButton.enabled = YES;
            self.nextButton.enabled = YES;
        }];
    }
}


- (void)lastDate:(UIButton *)sender {
    
    NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
    NSDate *yesterday = [currentDayDate dateByAddingTimeInterval: -secondsPerDay];
    self.currentDay = [self.dayFormatter stringFromDate:yesterday];
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [self getNetTwo:_currentDay];
    [self getNetThree];
}

- (void)nextDate:(UIButton *)sender {
    
    NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
    NSDate *tomorrow = [currentDayDate dateByAddingTimeInterval: secondsPerDay];
    self.currentDay = [self.dayFormatter stringFromDate:tomorrow];
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    
    [self getNetTwo:_currentDay];
    [self getNetThree];
}




-(void)viewDidDisappear:(BOOL)animated{
    
    // [ _scrollView removeFromSuperview];
    //  self.view=nil;
    
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

