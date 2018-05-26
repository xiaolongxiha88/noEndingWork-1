//
//  serverPlantList.m
//  ShinePhone
//
//  Created by sky on 2018/5/24.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "serverPlantList.h"
#import "ossNewDeviceCell.h"
#import "ossNewDeviceTwoCell.h"
#import "ShinePhone-Swift.h"
#import "LRLChannelEditController.h"
#import "ossIntegratorSearch.h"
#import "ossNewDeviceControl.h"
#import "addOssIntegratorDevice.h"
#import "addStationViewController.h"
#import "stationTableView.h"
#import "serverPlantSearch.h"
#import "serverPlantCEll2.h"

@interface serverPlantList ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *oneScrollView;
@property (nonatomic, strong) UIScrollView *twoScrollView;
@property (nonatomic, strong) UIScrollView *threeScrollView;
@property (nonatomic, strong) NSArray *oneParaArray;
@property (nonatomic, strong) NSArray *oneParaArrayNum;
@property (nonatomic, strong) NSMutableArray *cellNameArray;
@property (nonatomic, strong) NSArray *cellNameArray2;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign)float tableW;
@property (nonatomic, assign)float oldTableW;
@property (nonatomic, assign)BOOL isChangTableView;
@property (nonatomic, strong) NSMutableArray *selectRowNumArray;
@property (nonatomic, strong) DTKDropdownMenuView *rightMenuView;

@property (nonatomic, strong) NSMutableArray<LRLChannelUnitModel *> *topChannelArr;
@property (nonatomic, strong) NSMutableArray<LRLChannelUnitModel *> *bottomChannelArr;
@property (nonatomic, assign) NSInteger chooseIndex;
@property (nonatomic, assign) NSInteger pageNumForNet;
@property (nonatomic, assign) NSInteger pageTotalNum;

@property (nonatomic, strong) NSDictionary *forChoiceParameterDic;
@property (nonatomic, strong) NSArray *NetForParameterArray;
@property (nonatomic, strong) NSArray *NetForParameterNewArray;
@property (nonatomic, strong) NSArray *NetForParameterNew22Array;
@property (nonatomic, strong) NSArray *oldForParameterArray;
@property (nonatomic, strong) NSMutableArray *topArray;
@property (nonatomic, strong) NSMutableArray *battomArray;
@property (nonatomic, strong) NSArray *parameterNumArray;
@property (nonatomic, strong) NSDictionary *numForNetKeyDic;

@property (nonatomic, strong) NSArray *upOrDownNetValueArray;
@property (nonatomic, strong) NSArray *searchNameArray;
@property (nonatomic, strong) NSArray *netResultArray;
@property (nonatomic, strong) UILabel *numLable;
@property (nonatomic, strong) UILabel *numNameLable;
@property (nonatomic, strong) NSMutableDictionary*deviceNetDic;
@property (nonatomic, strong) UIView *View2;

@property (nonatomic, strong) NSMutableArray *allTableViewDataArray;
@property (nonatomic, strong) NSMutableArray *allTableViewData22Array;

@property (nonatomic, strong)NSString* numNameLableString;
@property (nonatomic, strong) NSMutableDictionary *deviceStatueNumDic;

@property (nonatomic, strong) NSMutableArray *allNumArray;

@property (nonatomic, strong)NSString*plantID;
@property (nonatomic, assign)NSInteger tableRowNum;
@property (nonatomic, strong)NSString*selectPlantID;
@property (nonatomic, strong)NSArray*selectPlantArray;

@end

@implementation serverPlantList


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=root_oss_511_dianZhanGuanLi;
    
    _isChangTableView=NO;
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    
    // [self getNetForListParameter];
    
    [self firstNetData];
    [self initData];
    [self addRightItem];
    
    
}


-(void)firstNetData{
    _deviceNetDic=[NSMutableDictionary new];
    
    [self initTheNetPageAndValue];
    
    [_deviceNetDic setObject:@"15" forKey:@"pageSize"];
    [_deviceNetDic setObject:[NSString stringWithFormat:@"%ld",_pageNumForNet] forKey:@"toPageNum"];
    [_deviceNetDic setObject:@"" forKey:@"plantName"];
    [_deviceNetDic setObject:@"" forKey:@"nominalPower"];
    [_deviceNetDic setObject:@"1" forKey:@"order"];

}


-(void)initData{
    
    [self initTheNetPageAndValue];
    
        //    [[NSUserDefaults standardUserDefaults] setObject:_NetForParameterArray forKey:@"serverPlantListNum"];
    
        _NetForParameterArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"serverPlantListNum"];
    
    //_NetForParameterArray=[NSArray array];
    
        _oneParaArray=@[root_oss_513_jianZhanShiJian,root_oss_514_sheBeiShuLiang,root_Device_head_181,root_oss_524_dangqianGongLv,root_Today_Energy,root_jinri_shouyi,root_Total_Energy,root_zong_shouyi];
        _upOrDownNetValueArray=@[@[@"1",@"2"],@[@"3",@"4"],@[@"5",@"6"],@[@"7",@"8"],@[@"9",@"10"],@[@"11",@"12"],@[@"13",@"14"],@[@"15",@"16"]];
        
        _oldForParameterArray=@[@"5",@"4",@"6",@"7",@"8",@"9",@"10",@"11"];
        
        _parameterNumArray=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
    
  //  [NSString stringWithFormat:@"%@   ",root_oss_513_jianZhanShiJian]
        _forChoiceParameterDic=@{@"0":[NSString stringWithFormat:@"%@     ",root_plant_name],@"1":[NSString stringWithFormat:@"%@     ",root_bieming],@"2":root_oss_507_chengShi,@"3":root_WO_shiqu,@"4":[NSString stringWithFormat:@"%@   ",root_oss_513_jianZhanShiJian],@"5":root_oss_514_sheBeiShuLiang,@"6":root_oss_524_dangqianGongLv,@"7":root_Device_head_181,@"8":root_NBQ_ri_fadianliang,@"9":root_Total_Energy,@"10":root_jinri_shouyi,@"11":root_zong_shouyi};
        _numForNetKeyDic=@{@"0":@"plantName",@"1":@"alias",@"2":@"city",@"3":@"timezoneText",@"4":@"createDateText",@"5":@"deviceCount",@"6":@"currentPac",@"7":@"nominalPower",@"8":@"eToday",@"9":@"eTotal",@"10":@"etodayMoneyText",@"11":@"etotalMoneyText"};
        
        _cellNameArray2=@[root_plant_name,root_Device_head_180,root_Device_head_181,root_NBQ_ri_fadianliang,root_Total_Energy,root_jinri_shouyi,root_zong_shouyi];     //列表的另一种展示
        _NetForParameterNew22Array=@[@"0",@"6",@"7",@"8",@"9",@"10",@"11"];
        

    
    
    [self changeTheParameter];
    
    
}

-(void)changeTheParameter{
    
    _cellNameArray=[NSMutableArray new];
    _topArray=[NSMutableArray new];
    _battomArray=[NSMutableArray new];
    
    NSArray *nowNameArray;     //现在显示的参数
    if (_NetForParameterArray.count==0) {
        nowNameArray=[NSArray arrayWithArray:_oldForParameterArray];
    }else{
        NSMutableArray *numArray=[NSMutableArray array];
        for (int i=0; i<_NetForParameterArray.count; i++) {
            [numArray addObject:[NSString stringWithFormat:@"%@",_NetForParameterArray[i]]];
        }
        //     _NetForParameterArray=[NSArray arrayWithArray:numArray];
        nowNameArray=[NSArray arrayWithArray:numArray];
    }
    _NetForParameterNewArray=[NSArray arrayWithArray:nowNameArray];
    [_cellNameArray addObject:[_forChoiceParameterDic objectForKey:@"0"]];
    for (int i=0; i<_NetForParameterNewArray.count; i++) {
        NSString *keyNum=_NetForParameterNewArray[i];
        NSArray *keyAndValueArray=@[keyNum,[_forChoiceParameterDic objectForKey:keyNum]];
        if ([nowNameArray containsObject:keyNum]) {
            [_topArray addObject:keyAndValueArray];
            [_cellNameArray addObject:[_forChoiceParameterDic objectForKey:keyNum]];
        }else{
            [_battomArray addObject:keyAndValueArray];
        }
    }
    
    for (int i=0; i<_parameterNumArray.count; i++) {
        NSString *keyNum=_parameterNumArray[i];
        NSArray *keyAndValueArray=@[keyNum,[_forChoiceParameterDic objectForKey:keyNum]];
        if (![nowNameArray containsObject:keyNum]) {
            [_battomArray addObject:keyAndValueArray];
        }
        
    }
    
    if (!_View2) {
        [self initUI];
    }else{
        [self initTheTheChangeUI];
    }
    
}

#pragma mark -UI区域
-(void)initUI{
    
    
    float H1=0*HEIGHT_SIZE;
    
    if (_oneScrollView) {
        [_oneScrollView removeFromSuperview];
        _oneScrollView=nil;
    }
    

        H1=40*HEIGHT_SIZE;
        _oneScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, H1)];
        _oneScrollView.backgroundColor = [UIColor whiteColor];
        _oneScrollView.showsHorizontalScrollIndicator = NO;
        _oneScrollView.bounces = NO;
        [self.view addSubview:_oneScrollView];
        
        
        //   float W11=90*NOW_SIZE;
        float W_all=0;
        _selectRowNumArray=[NSMutableArray new];
        for (int i=0; i<_oneParaArray.count; i++) {
            
            NSString *nameString=_oneParaArray[i];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
            CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            
            float image0H=12*HEIGHT_SIZE;
            float image0W=5*HEIGHT_SIZE;
            float W_K=3*NOW_SIZE;
            float W_K_0=12*NOW_SIZE;             //平均空隙
            float W_all_0=W_K_0*2+size.width+image0W+W_K;
            
            UIView *View1 = [[UIView alloc]initWithFrame:CGRectMake(0+W_all, 0*HEIGHT_SIZE, W_all_0,H1)];
            View1.backgroundColor = [UIColor clearColor];
            [_oneScrollView addSubview:View1];
            
            W_all=W_all+W_all_0;
            
            UILabel *lableR = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,W_all_0, H1)];
            lableR.textColor = COLOR(102, 102, 102, 1);
            lableR.textAlignment=NSTextAlignmentCenter;
            lableR.userInteractionEnabled=YES;
            lableR.tag=2000+i;
            UITapGestureRecognizer *labelTapR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeTheRowNum:)];
            [lableR addGestureRecognizer:labelTapR];
            lableR.text=_oneParaArray[i];
            lableR.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [View1 addSubview:lableR];
            
            [_selectRowNumArray addObject:[NSNumber numberWithBool:NO]];
            
            UIImageView *image0=[[UIImageView alloc]initWithFrame:CGRectMake((W_all_0+size.width)/2.0+W_K, (H1-image0H)/2.0, image0W,image0H )];
            image0.userInteractionEnabled=YES;
            image0.tag=3000+i;
            image0.image=IMAGE(@"oss_up_down.png");
            [View1 addSubview:image0];
            
        }
        
        _oneScrollView.contentSize=CGSizeMake(W_all+20*NOW_SIZE, H1);
        
 
    
    
    float H2=50*HEIGHT_SIZE;
    float W1=80*NOW_SIZE;
    float WK1=10*NOW_SIZE;
    
    if (_View2) {
        [_View2 removeFromSuperview];
        _View2=nil;
    }
    _View2= [[UIView alloc]initWithFrame:CGRectMake(0, H1, ScreenWidth,H2)];
    _View2.backgroundColor = COLOR(242, 242, 242, 1);
    [self.view addSubview:_View2];
    
    float imageW=22*HEIGHT_SIZE;
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(WK1, (H2-imageW)/2, imageW,imageW )];
    image2.userInteractionEnabled=YES;
    image2.image=IMAGE(@"OSS_list.png");
    UITapGestureRecognizer *labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changTableView)];
    [image2 addGestureRecognizer:labelTap1];
    [_View2 addSubview:image2];
    
//    float H2_1=30*HEIGHT_SIZE;
//    float W2_1=40*NOW_SIZE;
//    float image00W=8*HEIGHT_SIZE;  float image00H=6*HEIGHT_SIZE;float image00K=3*NOW_SIZE;
    
    float W_View201=0;
    
//    UIView *View201= [[UIView alloc]initWithFrame:CGRectMake(WK1+imageW+WK1, 0, W_View201,H2)];
//    View201.backgroundColor =[UIColor clearColor];
//    View201.userInteractionEnabled=YES;
//    UITapGestureRecognizer *labelTap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chioceTheStatue)];
//    [View201 addGestureRecognizer:labelTap2];
//    [_View2 addSubview:View201];
//
//    NSArray *numArray=[self getTheDeviceStatueNum];
//    _deviceStatueNumDic=[NSMutableDictionary new];
//    for (int i=0; i<numArray.count; i++) {
//        NSArray *statueArray=[self changeTheDeviceStatue:numArray[i]];
//        [_deviceStatueNumDic setObject:@"" forKey:statueArray[2]];
//    }
//
//    NSArray *statueArray1=[self changeTheDeviceStatue:@""];
//    _numNameLableString=statueArray1[2];
//
//    if (_numNameLable) {
//        [_numNameLable removeFromSuperview];
//        _numNameLable=nil;
//    }
//    _numNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, (H2-H2_1)/2.0,W2_1, H2_1/2.0)];
//    _numNameLable.textColor = COLOR(51, 51, 51, 1);
//    _numNameLable.text=statueArray1[1];
//    _numNameLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
//    _numNameLable.textAlignment=NSTextAlignmentCenter;
//    _numNameLable.adjustsFontSizeToFitWidth=YES;
//    _numNameLable.userInteractionEnabled=YES;
//    [View201 addSubview:_numNameLable];
//
//    if (_numLable) {
//        [_numLable removeFromSuperview];
//        _numLable=nil;
//    }
//
//    _numLable = [[UILabel alloc] initWithFrame:CGRectMake(0, (H2-H2_1)/2.0+H2_1/2.0,W2_1, H2_1/2.0)];
//    _numLable.textColor =mainColor;
//    _numLable.text=@"";
//    _numLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
//    _numLable.textAlignment=NSTextAlignmentCenter;
//    _numLable.adjustsFontSizeToFitWidth=YES;
//    _numLable.userInteractionEnabled=YES;
//    [View201 addSubview:_numLable];
//
//
//
//    UIImageView *image00=[[UIImageView alloc]initWithFrame:CGRectMake(W2_1+image00K, (H2-image00H)/2, image00W,image00H )];
//    image00.userInteractionEnabled=YES;
//    image00.image=IMAGE(@"upOSS.png");
//    [View201 addSubview:image00];
    
    
    float View01_W=ScreenWidth-2*WK1-imageW-WK1-WK1-W_View201;
    float imageH1=30*HEIGHT_SIZE;
    UIView *View01= [[UIView alloc]initWithFrame:CGRectMake(2*WK1+imageW+W_View201+WK1, (H2-imageH1)/2.0, View01_W,imageH1)];
    View01.backgroundColor = [UIColor whiteColor];
    [View01.layer setMasksToBounds:YES];
    View01.userInteractionEnabled=YES;
    [View01.layer setCornerRadius:(imageH1/2.0)];
    UITapGestureRecognizer *labelTap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToSearch)];
    [View01 addGestureRecognizer:labelTap3];
    [_View2 addSubview:View01];
    
    float imageH2=20*HEIGHT_SIZE;
    float imageW2=imageH2*(34/36.0);
    float W22=(View01.frame.size.width-imageW2)/2.0;
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(W22, (imageH1-imageH2)/2, imageW2,imageH2 )];
    image3.userInteractionEnabled=YES;
    image3.image=IMAGE(@"oss_search.png");
    [View01 addSubview:image3];
    
    
    float _twoScrollViewH=40*HEIGHT_SIZE;
    /////////////列表显示内容
    if (_twoScrollView) {
        [_twoScrollView removeFromSuperview];
        _twoScrollView=nil;
    }
    _twoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, H1+H2, SCREEN_Width, _twoScrollViewH)];
    _twoScrollView.backgroundColor = [UIColor whiteColor];
    _twoScrollView.showsHorizontalScrollIndicator = NO;
    _twoScrollView.delegate=self;
    _twoScrollView.bounces = NO;
    [self.view addSubview:_twoScrollView];
    
    
    
  
    
    
    float W_K_0=12*NOW_SIZE;             //平均空隙
    float W1_all=10*NOW_SIZE;
    
    float W_MIX_K=0;
    float W1_all_0=10*NOW_SIZE;
    for (int i=0; i<_cellNameArray.count; i++) {
        NSString *nameString=_cellNameArray[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, _twoScrollViewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        float W_all_0=W_K_0*2+size.width;
        
        W1_all_0=W1_all_0+W_all_0;
    }
    if (ScreenWidth>W1_all_0) {
        float num=_cellNameArray.count/1.0;
        W_MIX_K=(ScreenWidth-W1_all_0)/num;
    }
    
    for (int i=0; i<_cellNameArray.count; i++) {
        NSString *nameString=_cellNameArray[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, _twoScrollViewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        float W_all_0=W_K_0*2+size.width+W_MIX_K;
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0+W1_all, 0,W_all_0, _twoScrollViewH)];
        lable1.textColor = COLOR(51, 51, 51, 1);
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.text=_cellNameArray[i];
        lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_twoScrollView addSubview:lable1];
        
        W1_all=W1_all+W_all_0;
    }
    
      _twoScrollView.contentSize=CGSizeMake(W1_all, _twoScrollViewH);
    
    _tableW=W1_all;
    float H3=ScreenHeight-H1-H2-_twoScrollViewH-(NaviHeight);
    if (_threeScrollView) {
        [_threeScrollView removeFromSuperview];
        _threeScrollView=nil;
    }
    _threeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, H1+H2+_twoScrollViewH, SCREEN_Width, H3)];
    _threeScrollView.backgroundColor = [UIColor whiteColor];
    _threeScrollView.showsHorizontalScrollIndicator = NO;
    _threeScrollView.bounces = NO;
    _threeScrollView.delegate=self;
    [self.view addSubview:_threeScrollView];
    _threeScrollView.contentSize=CGSizeMake(_tableW, H1);
    
    
    [self initTableViewUI:H3];
    
    [self NetForDevice];
    
}

-(void)initTableViewUI:(float)H3{
    
    if (_tableView) {
        [_tableView removeFromSuperview];
        _tableView=nil;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _tableW, H3) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=COLOR(242, 242, 242, 1);
    
    
    
    MJRefreshAutoNormalFooter *foot=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (_allTableViewDataArray.count>1) {
            if (_pageNumForNet<_pageTotalNum) {
                _pageNumForNet++;
                [_deviceNetDic setObject:[NSString stringWithFormat:@"%ld",_pageNumForNet] forKey:@"toPageNum"];
                [self NetForDevice];
            }else{
                [self showToastViewWithTitle:root_oss_515_yiJingDaoZuiHouYiYe];
            }
            
            
        }
        
        
        [_tableView.mj_footer endRefreshing];
        
    }];
    [foot setTitle:@"" forState:MJRefreshStateIdle];
    _tableView.mj_footer=foot;
    
    _tableView.mj_footer.automaticallyHidden=NO;
    
    [_threeScrollView addSubview:_tableView];
    
    //注册单元格类型
    [_tableView registerClass:[ossNewDeviceCell class] forCellReuseIdentifier:@"CELL1"];
    [_tableView registerClass:[serverPlantCEll2 class] forCellReuseIdentifier:@"CELL2"];
    
}

-(void)initTheTheChangeUI{
    
    float H1=0;  float H2=50*HEIGHT_SIZE;
    
    if (_twoScrollView) {
        [_twoScrollView removeFromSuperview];
    }
    
    float W_K_0=12*NOW_SIZE;             //平均空隙
    float W1_all=10*NOW_SIZE;
    
    if (!_isChangTableView) {
        
        if (_twoScrollView) {
            _twoScrollView=nil;
        }
        
        H1=40*HEIGHT_SIZE;
        
        _twoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, H1+H2, SCREEN_Width, H1)];
        _twoScrollView.backgroundColor = [UIColor whiteColor];
        _twoScrollView.showsHorizontalScrollIndicator = NO;
        _twoScrollView.delegate=self;
        _twoScrollView.bounces = NO;
        [self.view addSubview:_twoScrollView];
        
        
        
        
        float W_MIX_K=0;
        float W1_all_0=10*NOW_SIZE;
        for (int i=0; i<_cellNameArray.count; i++) {
            NSString *nameString=_cellNameArray[i];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
            CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            
            float W_all_0=W_K_0*2+size.width;
            
            W1_all_0=W1_all_0+W_all_0;
        }
        if (ScreenWidth>W1_all_0) {
            float num=_cellNameArray.count/1.0;
            W_MIX_K=(ScreenWidth-W1_all_0)/num;
        }
        
        for (int i=0; i<_cellNameArray.count; i++) {
            NSString *nameString=_cellNameArray[i];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
            CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            
            float W_all_0=W_K_0*2+size.width+W_MIX_K;
            
            UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0+W1_all, 0,W_all_0-5*NOW_SIZE, H1)];
            lable1.textColor = COLOR(51, 51, 51, 1);
            lable1.textAlignment=NSTextAlignmentLeft;
            lable1.text=_cellNameArray[i];
            lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [_twoScrollView addSubview:lable1];
            
            W1_all=W1_all+W_all_0;
        }
        
        _twoScrollView.contentSize=CGSizeMake(W1_all, H1);
            _tableW=W1_all;
    }else{
        W1_all=ScreenWidth;
    }
    
    
    

    float H3=ScreenHeight-H1-H2-H1-(NaviHeight);
    _threeScrollView.contentSize=CGSizeMake(W1_all, H1);
    
    [self initTableViewUI:H3];
    
    [self NetForDevice];
}


- (void)addRightItem
{
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:root_Add_Plant iconName:@"DTK_jiangbei" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
            [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
            return;
        }
        
                addStationViewController *addView=[[addStationViewController alloc]init];
              addView.hidesBottomBarWhenPushed=YES;
        addView.cmdType=1;
                addView.addSuccessBlock = ^{
                    [self initTheNetPageAndValue];
                    [self NetForDevice];
                };
                [self.navigationController pushViewController:addView animated:YES];
        

        
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:root_oss_516_zhanShiCanShu iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        
        [self goToChoiceParameter];
        
    }];
    
    //    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"设备分配" iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
    //        NSLog(@"rightItem%lu",(unsigned long)index);
    //
    //    }];
    
    _rightMenuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1] icon:@"add@2x.png"];
    //  menuView.intrinsicContentSize=CGSizeMake(44.f, 44.f);
    // menuView.translatesAutoresizingMaskIntoConstraints=true;
    _rightMenuView.dropWidth =150.f;
    _rightMenuView.titleFont = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    _rightMenuView.textColor =COLOR(102, 102, 102, 1);
    _rightMenuView.cellSeparatorColor =COLOR(229, 229, 229, 1);
    _rightMenuView.textFont = [UIFont systemFontOfSize:14.f];
    _rightMenuView.animationDuration = 0.2f;
    
    // _rightMenuView.userInteractionEnabled=YES;
    
    if (deviceSystemVersion>=11.0) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self.rightMenuView action:@selector(pullTheTableView)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightMenuView];
    }
    
    
}


#pragma mark -选择显示参数
-(void)goToChoiceParameter{
    LRLChannelEditController *channelEdit = [[LRLChannelEditController alloc] initWithTopDataSource:self.topChannelArr andBottomDataSource:self.bottomChannelArr andInitialIndex:self.chooseIndex];
    
    //编辑后的回调
    __weak serverPlantList *weakSelf = self;
    channelEdit.removeInitialIndexBlock = ^(NSMutableArray<LRLChannelUnitModel *> *topArr, NSMutableArray<LRLChannelUnitModel *> *bottomArr){
        weakSelf.topChannelArr = topArr;
        weakSelf.bottomChannelArr = bottomArr;
        //  LRLChannelUnitModel *model =weakSelf.topChannelArr[1];
        NSLog(@"删除了初始选中项的回调:\n保留的频道有: %@", topArr);
    };
    channelEdit.chooseIndexBlock = ^(NSInteger index, NSMutableArray<LRLChannelUnitModel *> *topArr, NSMutableArray<LRLChannelUnitModel *> *bottomArr){
        weakSelf.topChannelArr = topArr;
        weakSelf.bottomChannelArr = bottomArr;
        weakSelf.chooseIndex = index;
        
        NSMutableArray *numArray=[NSMutableArray array];
        for (int i=0; i<weakSelf.topChannelArr.count; i++) {
            LRLChannelUnitModel *model =weakSelf.topChannelArr[i];
            // NSArray *modeArray=@[model.cid,model.name];
            [numArray addObject:[NSString stringWithFormat:@"%@",model.cid]];
        }
        weakSelf.NetForParameterArray=[NSMutableArray arrayWithArray:numArray];
        [self initTheNetPageAndValue];
        [weakSelf changeTheParameter];
        [weakSelf goToNetForListParameter];
        
    };
    
    channelEdit.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:channelEdit animated:YES completion:nil];
    
}








-(NSMutableArray<LRLChannelUnitModel *> *)topChannelArr{
    if (!_topChannelArr) {
        //这里模拟从本地获取的频道数组
        _topChannelArr = [NSMutableArray array];
        
        for (int i = 0; i < _topArray.count; ++i) {
            NSArray *modeArray=_topArray[i];
            LRLChannelUnitModel *channelModel = [[LRLChannelUnitModel alloc] init];
            channelModel.name = modeArray[1];
            channelModel.cid =modeArray[0];
            channelModel.isTop = YES;
            [_topChannelArr addObject:channelModel];
        }
    }
    return _topChannelArr;
}
-(NSMutableArray<LRLChannelUnitModel *> *)bottomChannelArr{
    if (!_bottomChannelArr) {
        _bottomChannelArr = [NSMutableArray array];
        for (int i = 0; i < _battomArray.count; i++) {
            NSArray *modeArray=_battomArray[i];
            LRLChannelUnitModel *channelModel = [[LRLChannelUnitModel alloc] init];
            channelModel.name = modeArray[1];
            channelModel.cid = modeArray[0];
            channelModel.isTop = NO;
            [_bottomChannelArr addObject:channelModel];
        }
        
    }
    return _bottomChannelArr;
}


#pragma mark -搜索回调
-(void)goToSearch{
    serverPlantSearch *searchView=[[serverPlantSearch alloc]init];
    searchView.searchType=1;
    searchView.oldSearchValueArray=self.searchNameArray;
    searchView.searchDicBlock = ^(NSDictionary *netDic){
        _deviceNetDic=[NSMutableDictionary dictionaryWithDictionary:netDic];
     
    };
    searchView.searchResultBlock = ^(NSArray *resultArray){
    //[self initTheNetPageAndValue];
        _allTableViewDataArray=[NSMutableArray array];
        _allTableViewData22Array=[NSMutableArray array];
        _pageNumForNet=1;
        [_deviceNetDic setObject:[NSString stringWithFormat:@"%ld",_pageNumForNet] forKey:@"toPageNum"];
        
        _netResultArray=resultArray[0];
        _searchNameArray=resultArray[1];
        _allNumArray=resultArray[2];
        [self changeNetData];
    };
    [self.navigationController pushViewController:searchView animated:YES];
}


#pragma mark -转换网络数据
-(void)changeNetData{                     //给tableviewcell用的数据
    
   
    if (_pageNumForNet==1) {
        [_allNumArray addObject:root_oss_513_jianZhanShiJian];
        [_allNumArray addObject:@""];
        [_allTableViewData22Array addObject:_allNumArray];
    }
  
    
    
    for (int i=0; i<_netResultArray.count; i++) {
        
     
   
            NSDictionary *twoDic=_netResultArray[i];
        
            NSMutableArray *valueArray=[NSMutableArray array];
            NSMutableArray *valueArray22=[NSMutableArray array];
            [valueArray addObject:twoDic[@"plantName"]];
        

        
            for (int i=0; i<_NetForParameterNewArray.count; i++) {                  //列表1的数据
              
                    NSString*keyString=[_numForNetKeyDic objectForKey:_NetForParameterNewArray[i]];
                NSString *keyNum=_NetForParameterNewArray[i];
                
                    NSString *valueString;
                if ([keyNum isEqualToString:@"6"] || [keyNum isEqualToString:@"8"] || [keyNum isEqualToString:@"9"]) {
                     valueString=[NSString stringWithFormat:@"%.1f",[[NSString stringWithFormat:@"%@",twoDic[keyString]] floatValue]];
                }else{
                         valueString=[NSString stringWithFormat:@"%@",twoDic[keyString]];
                }
                
                    [valueArray addObject:valueString];
                
            }
        
        
            for (int i=0; i<_NetForParameterNew22Array.count; i++) {
        
                    NSString*keyString=[_numForNetKeyDic objectForKey:_NetForParameterNew22Array[i]];
                
                NSString *keyNum=_NetForParameterNew22Array[i];
                
                NSString *valueString;
                if ([keyNum isEqualToString:@"6"] || [keyNum isEqualToString:@"8"] || [keyNum isEqualToString:@"9"]) {
                    valueString=[NSString stringWithFormat:@"%.1f",[[NSString stringWithFormat:@"%@",twoDic[keyString]] floatValue]];
                }else{
                    valueString=[NSString stringWithFormat:@"%@",twoDic[keyString]];
                }
                
               //     NSString *valueString=[NSString stringWithFormat:@"%@",twoDic[keyString]];
                    
                    [valueArray22 addObject:valueString];
             
                
            }
        
      [valueArray22 addObject:[NSString stringWithFormat:@"%@",twoDic[@"createDateText"]]];
        
                [valueArray addObject:[NSString stringWithFormat:@"%@",twoDic[@"id"]]];
                [valueArray22 addObject:[NSString stringWithFormat:@"%@",twoDic[@"id"]]];
                
      
            
            [_allTableViewDataArray addObject:valueArray];
            [_allTableViewData22Array addObject:valueArray22];
            
    
        
    }
    

    [_tableView reloadData];
    
    
}


#pragma mark -排序
-(void)changeTheRowNum:(UITapGestureRecognizer*)tap{
    NSInteger  tagNum=tap.view.tag-2000;
    
    NSArray *netValueArray=_upOrDownNetValueArray[tagNum];
    BOOL isSelect=[_selectRowNumArray[tagNum] boolValue];
    isSelect = !isSelect;
    
    for (int i=0; i<_selectRowNumArray.count; i++) {
        UIImageView *image0=[self.view viewWithTag:3000+i];
        if (i!=tagNum) {
            image0.image=IMAGE(@"oss_up_down.png");
            [_selectRowNumArray replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
        }else{
            if (isSelect) {
                image0.image=IMAGE(@"oss_up.png");
                [_deviceNetDic setObject:netValueArray[1] forKey:@"order"];
            }else{
                image0.image=IMAGE(@"oss_down.png");
                [_deviceNetDic setObject:netValueArray[0] forKey:@"order"];
            }
            
            [_selectRowNumArray replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:isSelect]];
        }
        
    }
    
    [self initTheNetPageAndValue];
    [self NetForDevice];
    
}

-(void)initTheNetPageAndValue{
    
    _allTableViewDataArray=[NSMutableArray array];
    _allTableViewData22Array=[NSMutableArray array];
    _pageNumForNet=1;
    _pageTotalNum=1;
    [_deviceNetDic setObject:[NSString stringWithFormat:@"%ld",_pageNumForNet] forKey:@"toPageNum"];
    
}


#pragma mark -切换tableview

-(void)changTableView{
    
//    [self initTheNetPageAndValue];
    
    _isChangTableView=!_isChangTableView;
    if (_isChangTableView) {
        [_twoScrollView removeFromSuperview];
        _threeScrollView.frame=CGRectMake(_threeScrollView.frame.origin.x, _threeScrollView.frame.origin.y-40*HEIGHT_SIZE, _threeScrollView.frame.size.width, _threeScrollView.frame.size.height+40*HEIGHT_SIZE);
        _threeScrollView.contentSize=CGSizeMake(ScreenWidth, _threeScrollView.frame.size.height);
    }else{
        [self.view addSubview:_twoScrollView];
        _threeScrollView.frame=CGRectMake(_threeScrollView.frame.origin.x, _threeScrollView.frame.origin.y+40*HEIGHT_SIZE, _threeScrollView.frame.size.width, _threeScrollView.frame.size.height-40*HEIGHT_SIZE);
        _threeScrollView.contentSize=CGSizeMake(_tableW, _threeScrollView.frame.size.height);
    }
    
    
    [self initTableViewUI:_threeScrollView.frame.size.height];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float H=30*HEIGHT_SIZE;
    
    if (_isChangTableView) {
       H=190*HEIGHT_SIZE;
    }
    return H;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger Num;
    
    if (_isChangTableView) {
        Num=_allTableViewData22Array.count;
    }else{
            Num=_allTableViewDataArray.count;
    }
    
    return Num;
}


//转数组转JSON
-(NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint dataArray:(NSArray*)dataArray{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataArray
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}


#pragma mark -网络获取区域
-(void)goToNetForListParameter{
    
              [[NSUserDefaults standardUserDefaults] setObject:_NetForParameterArray forKey:@"serverPlantListNum"];    //保存参数列表
    
//    NSString *keyValueString=@"";
//    if (_deviceType==1) {
//        keyValueString=@"dm_invapp";
//    }else if (_deviceType==2) {
//        keyValueString=@"dm_storageapp";
//    }else if (_deviceType==3) {
//        keyValueString=@"dm_mixapp";
//    }
//    NSString *textString=[NSString stringWithFormat:@"%@",[self jsonStringWithPrettyPrint:YES dataArray:_NetForParameterArray]];
//    NSDictionary *netDic=@{@"text":textString,@"key":keyValueString};
//    //  [self showProgressView];
//    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:netDic paramarsSite:@"/api/v3/device/saveShowCol" sucessBlock:^(id content) {
//        [self hideProgressView];
//
//        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"/api/v3/device/saveShowCol: %@", content1);
//
//        if (content1) {
//            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
//
//            if ([firstDic[@"result"] intValue]==1) {
//                // self.parameterDic=firstDic[@"obj"];
//
//            }else{
//
//            }
//        }
//    } failure:^(NSError *error) {
//        [self hideProgressView];
//        [self showToastViewWithTitle:root_Networking];
//    }];
    
}

-(void)goToGetListParameter{
    
    
    //  [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:@{@"":@""} paramarsSite:@"/api/v3/device/getShowCol" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v3/device/getShowCol: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
                self.parameterDic=firstDic[@"obj"];
                [self initData];
            }else{
                [self initData];
            }
        }
    } failure:^(NSError *error) {
        [self initData];
        
    }];
    
}


-(void)NetForDevice{
    _allNumArray=[NSMutableArray new];
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:_deviceNetDic paramarsSite:@"/newPlantAPI.do?op=getAllPlantList" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/newPlantAPI.do?op=getAllPlantList: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
               NSArray *PlantListArray=[NSArray array];
            if ([firstDic.allKeys containsObject:@"PlantList"]) {
                PlantListArray=[NSArray arrayWithArray:firstDic[@"PlantList"]];
            }
            
            if (PlantListArray.count>0) {
                
                [_allNumArray addObject:root_oss_520_QuanBuDianZhanLeiJiShuJu];
                 [_allNumArray addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",firstDic[@"usercurrentPac"]] floatValue]]];
           [_allNumArray addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",firstDic[@"usernominalPower"]] floatValue]]];
                   [_allNumArray addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",firstDic[@"usereToday"]] floatValue]]];
                   [_allNumArray addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",firstDic[@"usereTotal"]] floatValue]]];
                   [_allNumArray addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",firstDic[@"usereTodayMoney"]] floatValue]]];
                   [_allNumArray addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",firstDic[@"usereTotalMoney"]] floatValue]]];
                
                _pageNumForNet=[[NSString stringWithFormat:@"%@",firstDic[@"currentPageNum"]] integerValue];
                _pageTotalNum=[[NSString stringWithFormat:@"%@",firstDic[@"totalPageNum"]] integerValue];
                
                    _netResultArray=[NSArray arrayWithArray:PlantListArray];
                    [self changeNetData];
 
 
            }else{
                     [self showToastViewWithTitle:@"No Plant"];
                
            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
        
    }];
    
}


- (void)cellDidLongPressed:(UIGestureRecognizer *)recognizer{
    if(recognizer.state == UIGestureRecognizerStateBegan) {
        NSInteger NUM=recognizer.view.tag;
        _tableRowNum=NUM-7000;
        if (!_isChangTableView) {
            NSArray *dataArray=_allTableViewDataArray[_tableRowNum];
            _plantID=dataArray[dataArray.count-1];
        }else{
            NSArray *dataArray=_allTableViewData22Array[_tableRowNum];
            _plantID=dataArray[dataArray.count-1];
        }
        
        [self goToEdit];
    }

    
}

- (void)cellDidLongPressed2:(UIGestureRecognizer *)recognizer{
    if(recognizer.state == UIGestureRecognizerStateBegan) {
        NSInteger NUM=recognizer.view.tag;
        _tableRowNum=NUM-7000;
        
        if (_tableRowNum!=0) {
            if (!_isChangTableView) {
                NSArray *dataArray=_allTableViewDataArray[_tableRowNum];
                _plantID=dataArray[dataArray.count-1];
            }else{
                NSArray *dataArray=_allTableViewData22Array[_tableRowNum];
                _plantID=dataArray[dataArray.count-1];
            }
            
            [self goToEdit];
        }else{
            [self showToastViewWithTitle:root_oss_521_QuanBuDianZhan_BuNengBianJi];
        }

        
     
        
    }

    
}


-(void)goToEdit{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }
    
    [ZJBLStoreShopTypeAlert showWithTitle:root_oss_511_dianZhanGuanLi titles:@[root_oss_522_bianJiDianZhan,root_oss_523_ShanChuDianZhan] selectIndex:^(NSInteger selectIndex) {
        
        if (selectIndex==0) {
            stationTableView *addView=[[stationTableView alloc]init];
            addView.stationId=_plantID;
            addView.goToPlantBlock=^{
                [self initTheNetPageAndValue];
                [self NetForDevice];
            };
            addView.setType=1;
            [self.navigationController pushViewController:addView animated:YES];
        }
        if (selectIndex==1) {
            [self deleteStation];
        }
        
    }selectValue:^(NSString *selectValue){
        
        
    } showCloseButton:YES ];
}


-(void)deleteStation{
    
    [self showProgressView];
    
    
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":_plantID} paramarsSite:@"/newPlantAPI.do?op=delplant" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/newPlantAPI.do?op=delplant: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
                [self showToastViewWithTitle:root_shanChu_chengGong];
                
                if (!_isChangTableView) {
                    [_allTableViewDataArray removeObjectAtIndex:_tableRowNum];
                }else{
                        [_allTableViewData22Array removeObjectAtIndex:_tableRowNum];
                }
                [_tableView reloadData];
                
            }else{
                  [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",firstDic[@"msg"]]];
            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
    
    
}




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.twoScrollView) {
        if (self.twoScrollView.contentOffset.x != self.threeScrollView.contentOffset.x) {
            self.threeScrollView.contentOffset = CGPointMake(self.twoScrollView.contentOffset.x, 0);
        }
    } else if (scrollView == self.threeScrollView) {
        if (self.threeScrollView.contentOffset.x != self.twoScrollView.contentOffset.x) {
            self.twoScrollView.contentOffset = CGPointMake(self.threeScrollView.contentOffset.x, 0);
        }
    } else if ([scrollView isKindOfClass:[UITableView class]]) {
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_isChangTableView) {
        ossNewDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL1" forIndexPath:indexPath];
        
        if (!cell) {
            cell=[[ossNewDeviceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL1"];
        }
        cell.deviceType=_deviceType;
        cell.nameValueArray=_allTableViewDataArray[indexPath.row];
        cell.nameArray=_cellNameArray;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tag=7000+indexPath.row;
        UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellDidLongPressed:)];
        longPressGesture.minimumPressDuration = 0.5f;
        [cell addGestureRecognizer:longPressGesture];
        
        return cell;
    }else{
        
        serverPlantCEll2 *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL2" forIndexPath:indexPath];
        
        if (!cell) {
            cell=[[serverPlantCEll2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL2"];
        }
        
        cell.nameValueArray=_allTableViewData22Array[indexPath.row];
        cell.nameArray=_cellNameArray2;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
          cell.tag=7000+indexPath.row;
        UILongPressGestureRecognizer * longPressGesture1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellDidLongPressed2:)];
        longPressGesture1.minimumPressDuration = 0.5f;
        [cell addGestureRecognizer:longPressGesture1];
        return cell;
    }
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *plantIDArray=[NSMutableArray new];
      NSMutableArray *plantNameArray=[NSMutableArray new];
    NSString*plantID; NSString*plantName;
    if (!_isChangTableView) {
        for (int i=0; i<_allTableViewDataArray.count; i++) {
            NSArray*array1=[NSArray arrayWithArray:_allTableViewDataArray[i]];
            [plantIDArray addObject:array1[array1.count-1]];
                 [plantNameArray addObject:array1[0]];
        }
             NSArray*array2=[NSArray arrayWithArray:_allTableViewDataArray[indexPath.row]];
        plantID=[NSString stringWithFormat:@"%@",array2[array2.count-1]];
            plantName=[NSString stringWithFormat:@"%@",array2[0]];
    }else{
        for (int i=0; i<_allTableViewData22Array.count; i++) {
            NSArray*array1=[NSArray arrayWithArray:_allTableViewData22Array[i]];
            [plantIDArray addObject:array1[array1.count-1]];
               [plantNameArray addObject:array1[0]];
        }
        NSArray*array2=[NSArray arrayWithArray:_allTableViewData22Array[indexPath.row]];
        plantID=[NSString stringWithFormat:@"%@",array2[array2.count-1]];
        plantName=[NSString stringWithFormat:@"%@",array2[0]];
        
    }
    
    _selectPlantID=plantID;
    _selectPlantArray=@[plantIDArray,plantNameArray];
    
    if (_isChangTableView) {
        if (indexPath.row==0) {
       //     [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",]];
            return;
        }
    }
    
    if (_LogTypeForOSS==1) {
        [self goToGetPlantNameDemo];
    }else{
        [self goToGetPlantName];
    }


    
}



-(void)goToGetPlantName{
    

    NSString *reUsername=[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *rePassword=[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    
    [self showProgressView];
    [BaseRequest requestWithMethod:HEAD_URL paramars:@{@"userName":reUsername, @"password":[self MD5:rePassword]} paramarsSite:@"/newLoginAPI.do" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"loginIn:%@",content);
        if (content) {
            if ([content[@"success"] integerValue] == 0) {
                
                  [self sendThePlantArray:_selectPlantArray];

            } else {
                
             NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:content];
           
                NSMutableArray *stationID1=dataDic[@"data"];
                NSMutableArray *stationID=[NSMutableArray array];
                if (stationID1.count>0) {
                    for(int i=0;i<stationID1.count;i++){
                        NSString *a=stationID1[i][@"plantId"];
                        [stationID addObject:a];
                    }
                }
                NSMutableArray *stationName1=dataDic[@"data"];
                NSMutableArray *stationName=[NSMutableArray array];
                if (stationID1.count>0) {
                    for(int i=0;i<stationID1.count;i++){
                        NSString *a=stationName1[i][@"plantName"];
                        [stationName addObject:a];
                    }
                }
                
                if (stationID.count>0) {
                    //       stationID= [NSMutableArray arrayWithArray:stationID];
                    //       stationName= [NSMutableArray arrayWithArray:stationName];
                }else{
                    stationID=[NSMutableArray arrayWithObjects:@"1", nil];
                    stationName =[NSMutableArray arrayWithObjects:root_shiFan_dianZhan, nil];
                }
                
                
                NSArray *plantArray=@[stationID,stationName];
                
                [self sendThePlantArray:plantArray];
                
            }
        }else{
                [self sendThePlantArray:_selectPlantArray];
        }
        
    } failure:^(NSError *error) {

        [self hideProgressView];
  
       [self sendThePlantArray:_selectPlantArray];
        
    }];

    
}



-(void)goToGetPlantNameDemo{
    
    
    
    [self showProgressView];
    [BaseRequest requestWithMethod:HEAD_URL paramars:@{@"userName":_demoLoginName, @"password":_demoLoginPassword,@"serverUrl":HEAD_URL} paramarsSite:@"/newLoginAPI.do?op=apiserverlogin" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"/newLoginAPI.do?op=apiserverlogin:%@",content);
        if (content) {
            if ([content[@"success"] integerValue] == 0) {
                
                [self sendThePlantArray:_selectPlantArray];
                
            } else {
                
                NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:content];
                
                NSMutableArray *stationID1=dataDic[@"data"];
                NSMutableArray *stationID=[NSMutableArray array];
                if (stationID1.count>0) {
                    for(int i=0;i<stationID1.count;i++){
                        NSString *a=stationID1[i][@"plantId"];
                        [stationID addObject:a];
                    }
                }
                NSMutableArray *stationName1=dataDic[@"data"];
                NSMutableArray *stationName=[NSMutableArray array];
                if (stationID1.count>0) {
                    for(int i=0;i<stationID1.count;i++){
                        NSString *a=stationName1[i][@"plantName"];
                        [stationName addObject:a];
                    }
                }
                
                if (stationID.count>0) {
                    //       stationID= [NSMutableArray arrayWithArray:stationID];
                    //       stationName= [NSMutableArray arrayWithArray:stationName];
                }else{
                    stationID=[NSMutableArray arrayWithObjects:@"1", nil];
                    stationName =[NSMutableArray arrayWithObjects:root_shiFan_dianZhan, nil];
                }
                
                
                NSArray *plantArray=@[stationID,stationName];
                
                [self sendThePlantArray:plantArray];
                
            }
        }else{
            [self sendThePlantArray:_selectPlantArray];
        }
        
    } failure:^(NSError *error) {
        
        [self hideProgressView];
        
        [self sendThePlantArray:_selectPlantArray];
        
    }];
    
    
}




-(void)sendThePlantArray:(NSArray*)plantArray{
    NSArray *plantAllArray=[NSArray arrayWithArray:plantArray];
    
    NSInteger selectNum=0;
    
    NSArray *plantIdArray=plantAllArray[0];
    
    if (plantIdArray.count==0) {
        NSArray *array1 =[NSArray arrayWithObjects:@"1", nil];
          NSArray *array2=[NSArray arrayWithObjects:root_shiFan_dianZhan, nil];
             plantAllArray=@[array1,array2];
    }

    
    for (int i=0;i<plantIdArray.count ; i++) {
        NSString *ID=plantIdArray[i];
        if ([ID isEqualToString:_selectPlantID]) {
            selectNum=i;
        }
    }
    
        [ [UserInfo defaultUserInfo]setPlantNum:[NSString stringWithFormat:@"%ld",selectNum]];
    
        self.goBackBlock(plantAllArray);
    [self.navigationController popViewControllerAnimated:YES];
    
}

























-(void)chioceTheStatue{
    NSString *titleString=@"选择设备状态";
    NSArray*numArray;
    numArray=[self getTheDeviceStatueNum];
    
    NSMutableArray *nameArray=[NSMutableArray array];
    NSMutableDictionary *nameAndValueDic=[NSMutableDictionary new];
    NSMutableDictionary *numAndValueStringDic=[NSMutableDictionary new];
    NSMutableDictionary *netAndValueStringDic=[NSMutableDictionary new];
    NSMutableDictionary *netKeyAndValueStringDic=[NSMutableDictionary new];
    for (int i=0; i<numArray.count; i++) {
        NSArray* statueArray=[self changeTheDeviceStatue:numArray[i]];
        NSString *name=[NSString stringWithFormat:@"%@(%@)",statueArray[1], [_deviceStatueNumDic objectForKey:statueArray[2]]];
        [nameArray addObject:name];
        [nameAndValueDic setObject:statueArray[1] forKey:name];
        [numAndValueStringDic setObject:numArray[i] forKey:name];
        [netKeyAndValueStringDic setObject:statueArray[2] forKey:name];
        [netAndValueStringDic setObject:numArray[i] forKey:name];
    }
    [ZJBLStoreShopTypeAlert showWithTitle:titleString titles:nameArray selectIndex:^(NSInteger selectIndex) {
        
    }selectValue:^(NSString *selectValue){
        _numNameLableString=[netAndValueStringDic objectForKey:selectValue];
        NSArray* statue1Array=[self changeTheDeviceStatue:_numNameLableString];
        _numLable.textColor=statue1Array[0];
        _numNameLable.text=[nameAndValueDic objectForKey:selectValue];
        _numLable.text=[NSString stringWithFormat:@"%@",[_deviceStatueNumDic objectForKey:[netKeyAndValueStringDic objectForKey:selectValue]]];
        NSString*netNum=[numAndValueStringDic objectForKey:selectValue];
        
        
        [self initTheNetPageAndValue];
        
        [_deviceNetDic setObject:netNum forKey:@"deviceStatus"];
        [_deviceNetDic setObject:[NSString stringWithFormat:@"%ld",_pageNumForNet] forKey:@"toPageNum"];
        [self NetForDevice];
        
    } showCloseButton:YES ];
    
    
}

-(NSArray*)getTheDeviceStatueNum{
    NSArray *numArray;
    if (_deviceType==2) {
        numArray=@[@"",@"-2",@"1",@"2",@"3",@"-1"];
    }else if (_deviceType==3) {
        numArray=@[@"",@"5",@"1",@"0",@"3",@"-1"];
    }else{
        numArray=@[@"",@"1",@"3",@"-1",@"0"];
    }
    return numArray;
}
-(NSArray*)changeTheDeviceStatue:(NSString*)numString{
    NSArray *statueArray;
    
    NSDictionary *colorDic; NSDictionary *nameDic;NSDictionary *netKeyDic;
    if (_deviceType==1) {
        colorDic=@{@"3":COLOR(210, 53, 53, 1),@"-1":COLOR(154, 154, 154, 1),@"0":COLOR(213, 180, 0, 1),@"1":COLOR(44, 189, 10, 1),@"":MainColor};
        nameDic=@{@"3":@"故障",@"-1":@"离线",@"0":@"等待",@"1":@"在线",@"":@"全部"};
        netKeyDic=@{@"3":@"faultNum",@"-1":@"lostNum",@"0":@"waitNum",@"1":@"onlineNum",@"":@"totalNum"};
    }else if (_deviceType==2) {
        colorDic=@{@"3":COLOR(210, 53, 53, 1),@"-1":COLOR(154, 154, 154, 1),@"1":COLOR(44, 189, 10, 1),@"2":COLOR(213, 180, 0, 1),@"-2":COLOR(61, 190, 4, 1),@"":MainColor};
        nameDic=@{@"3":@"故障",@"-1":@"离线",@"1":@"充电",@"2":@"放电",@"-2":@"在线",@"":@"全部"};
        netKeyDic=@{@"3":@"faultNum",@"-1":@"lostNum",@"1":@"chargeNum",@"2":@"dischargeNum",@"-2":@"onlineNum",@"":@"totalNum"};
    }else if (_deviceType==3) {
        colorDic=@{@"3":COLOR(210, 53, 53, 1),@"-1":COLOR(154, 154, 154, 1),@"0":COLOR(213, 180, 0, 1),@"1":COLOR(209, 148, 0, 1),@"5":COLOR(44, 189, 10, 1),@"":MainColor};
        nameDic=@{@"3":@"故障",@"-1":@"离线",@"0":@"等待",@"1":@"自检",@"5":@"在线",@"":@"全部"};
        netKeyDic=@{@"3":@"faultNum",@"-1":@"lostNum",@"0":@"waitNum",@"1":@"selfCheck",@"5":@"onlineNum",@"":@"totalNum"};
    }
    
    
    if ([colorDic.allKeys containsObject:numString]) {           //颜色、名字、网络KEY
        statueArray=@[[colorDic objectForKey:numString],[nameDic objectForKey:numString],[netKeyDic objectForKey:numString]];
    }else{
        statueArray=@[[colorDic objectForKey:@""],[nameDic objectForKey:@""],[netKeyDic objectForKey:@""]];
    }
    
    return statueArray;
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
