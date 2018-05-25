//
//  ossNewPlantList.m
//  ShinePhone
//
//  Created by sky on 2018/5/21.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossNewPlantList.h"
#import "ossNewDeviceCell.h"
#import "ossNewDeviceTwoCell.h"
#import "ShinePhone-Swift.h"
#import "LRLChannelEditController.h"
#import "ossIntegratorSearch.h"
#import "ossNewDeviceControl.h"
#import "ossNewPlantSearch.h"
#import "ossNewPlantControl2.h"
#import "addOssIntegratorDevice.h"

@interface ossNewPlantList ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
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

@end

@implementation ossNewPlantList



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
    
    [_deviceNetDic setObject:@"-1" forKey:@"groupId"];
    [_deviceNetDic setObject:[NSString stringWithFormat:@"%ld",_pageNumForNet] forKey:@"page"];
    [_deviceNetDic setObject:@"1" forKey:@"order"];
    [_deviceNetDic setObject:@"" forKey:@"iCode"];
    [_deviceNetDic setObject:@"" forKey:@"accountName"];
    [_deviceNetDic setObject:@"" forKey:@"plantName"];
    [_deviceNetDic setObject:@"" forKey:@"city"];
    [_deviceNetDic setObject:@"" forKey:@"designPower"];
}

-(void)initData{
    
    [self initTheNetPageAndValue];
    
  
        if (_parameterDic.allKeys.count>0) {
            _NetForParameterArray=_parameterDic[@"dm_plantapp"];
        }
        
        _oneParaArray=@[@"建站日期",@"时区",@"设备数量",@"设计功率",@"今日发电量",@"累计发电量"];
        _upOrDownNetValueArray=@[@[@"1",@"2"],@[@"3",@"4"],@[@"5",@"6"],@[@"7",@"8"],@[@"9",@"10"],@[@"11",@"12"]];
        
        _oldForParameterArray=@[@"13",@"6",@"7",@"8",@"9",@"12",@"5",@"11"];
        
        _parameterNumArray=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
        _forChoiceParameterDic=@{@"0":@"电站名称",@"1":@"分组名称",@"2":@"别名      ",@"3":root_oss_507_chengShi,@"4":@"时区",@"5":@"建站日期      ",@"6":@"设备数量",@"7":@"设计功率  ",@"8":@"今日发电量",@"9":@"累计发电量",@"10":@"日发电量下限值",@"11":@"安装商",@"12":@"资金收益",@"13":@"所属用户"};
        _numForNetKeyDic=@{@"0":@"plantName",@"1":@"groupId",@"2":@"alias",@"3":@"cityId",@"4":@"timezone",@"5":@"creatDate",@"6":@"deviceCount",@"7":@"nominal_power",@"8":@"etoday",@"9":@"etotal",@"10":@"lowEnergy",@"11":@"iCode",@"12":@"formula_money",@"13":@"accountName"};
        
        _cellNameArray2=@[@"电站名称",@"设计功率",@"今日发电量",@"累计发电量"];     //列表的另一种展示
        _NetForParameterNew22Array=@[@"0",@"7",@"8",@"9"];
        
    
    
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
    
    if (!_oneScrollView) {
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
    
    if (_deviceType==1) {
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
        
    }
    
    
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
    
    float H2_1=30*HEIGHT_SIZE;
    float W2_1=40*NOW_SIZE;
    float image00W=8*HEIGHT_SIZE;  float image00H=6*HEIGHT_SIZE;float image00K=3*NOW_SIZE;
    float W_View201=0;
    UIView *View201= [[UIView alloc]initWithFrame:CGRectMake(WK1+imageW+WK1, 0, W_View201,H2)];
    View201.backgroundColor =[UIColor clearColor];
    View201.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chioceTheStatue)];
    [View201 addGestureRecognizer:labelTap2];
   // [_View2 addSubview:View201];
    
    NSArray *numArray=[self getTheDeviceStatueNum];
    _deviceStatueNumDic=[NSMutableDictionary new];
    for (int i=0; i<numArray.count; i++) {
        NSArray *statueArray=[self changeTheDeviceStatue:numArray[i]];
        [_deviceStatueNumDic setObject:@"" forKey:statueArray[2]];
    }
    
    NSArray *statueArray1=[self changeTheDeviceStatue:@""];
    _numNameLableString=statueArray1[2];
    
    if (_numNameLable) {
        [_numNameLable removeFromSuperview];
        _numNameLable=nil;
    }
    _numNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, (H2-H2_1)/2.0,W2_1, H2_1/2.0)];
    _numNameLable.textColor = COLOR(51, 51, 51, 1);
    _numNameLable.text=statueArray1[1];
    _numNameLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    _numNameLable.textAlignment=NSTextAlignmentCenter;
    _numNameLable.adjustsFontSizeToFitWidth=YES;
    _numNameLable.userInteractionEnabled=YES;
    [View201 addSubview:_numNameLable];
    
    if (_numLable) {
        [_numLable removeFromSuperview];
        _numLable=nil;
    }
    
    _numLable = [[UILabel alloc] initWithFrame:CGRectMake(0, (H2-H2_1)/2.0+H2_1/2.0,W2_1, H2_1/2.0)];
    _numLable.textColor =mainColor;
    _numLable.text=@"";
    _numLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    _numLable.textAlignment=NSTextAlignmentCenter;
    _numLable.adjustsFontSizeToFitWidth=YES;
    _numLable.userInteractionEnabled=YES;
    [View201 addSubview:_numLable];
    
    
    
    UIImageView *image00=[[UIImageView alloc]initWithFrame:CGRectMake(W2_1+image00K, (H2-image00H)/2, image00W,image00H )];
    image00.userInteractionEnabled=YES;
    image00.image=IMAGE(@"upOSS.png");
    [View201 addSubview:image00];
    
    
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
    
    
    
    _twoScrollView.contentSize=CGSizeMake(_cellNameArray.count*W1, _twoScrollViewH);
    
    
    float W_K_0=12*NOW_SIZE;             //平均空隙
    float W1_all=10*NOW_SIZE;
    
    for (int i=0; i<_cellNameArray.count; i++) {
        NSString *nameString=_cellNameArray[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, _twoScrollViewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        float W_all_0=W_K_0*2+size.width;
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0+W1_all, 0,W_all_0, _twoScrollViewH)];
        lable1.textColor = COLOR(51, 51, 51, 1);
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.text=_cellNameArray[i];
        lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_twoScrollView addSubview:lable1];
        
        W1_all=W1_all+W_all_0;
    }
    
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
                [_deviceNetDic setObject:[NSString stringWithFormat:@"%ld",_pageNumForNet] forKey:@"page"];
                [self NetForDevice];
            }else{
                [self showToastViewWithTitle:@"已经到最后一页"];
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
    [_tableView registerClass:[ossNewDeviceTwoCell class] forCellReuseIdentifier:@"CELL2"];
}

-(void)initTheTheChangeUI{
    
    float H1=40*HEIGHT_SIZE;  float H2=50*HEIGHT_SIZE;    float W1=80*NOW_SIZE;
    
    if (_twoScrollView) {
        [_twoScrollView removeFromSuperview];
        _twoScrollView=nil;
    }
    _twoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, H1+H2, SCREEN_Width, H1)];
    _twoScrollView.backgroundColor = [UIColor whiteColor];
    _twoScrollView.showsHorizontalScrollIndicator = NO;
    _twoScrollView.delegate=self;
    _twoScrollView.bounces = NO;
    [self.view addSubview:_twoScrollView];
    
    
    _twoScrollView.contentSize=CGSizeMake(_cellNameArray.count*W1, H1);
    
    
    float W_K_0=12*NOW_SIZE;             //平均空隙
    float W1_all=10*NOW_SIZE;
    
    for (int i=0; i<_cellNameArray.count; i++) {
        NSString *nameString=_cellNameArray[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        float W_all_0=W_K_0*2+size.width;
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0+W1_all, 0,W_all_0-5*NOW_SIZE, H1)];
        lable1.textColor = COLOR(51, 51, 51, 1);
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.text=_cellNameArray[i];
        lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_twoScrollView addSubview:lable1];
        
        W1_all=W1_all+W_all_0;
    }
    
    
    _tableW=W1_all;
    float H3=ScreenHeight-H1-H2-H1-(NaviHeight);
    _threeScrollView.contentSize=CGSizeMake(_tableW, H1);
    
    [self initTableViewUI:H3];
    
    [self NetForDevice];
}


- (void)addRightItem
{
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"添加电站" iconName:@"DTK_jiangbei" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        
        addOssIntegratorDevice *searchView=[[addOssIntegratorDevice alloc]init];
        searchView.deviceType=2;
        searchView.cmdType=4;
        searchView.addSuccessBlock = ^{
             [self initTheNetPageAndValue];
            [self NetForDevice];
        };
        [self.navigationController pushViewController:searchView animated:YES];
        
        
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"展示参数" iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
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
    __weak ossNewPlantList *weakSelf = self;
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
    ossNewPlantSearch *searchView=[[ossNewPlantSearch alloc]init];
    searchView.searchType=1;
    searchView.oldSearchValueArray=self.searchNameArray;
    searchView.searchDicBlock = ^(NSDictionary *netDic){
        _deviceNetDic=[NSMutableDictionary dictionaryWithDictionary:netDic];
  
        
    };
    searchView.searchResultBlock = ^(NSArray *resultArray){
        [self initTheNetPageAndValue];
        _netResultArray=resultArray[0];
        _searchNameArray=resultArray[1];
        [self changeNetData];
    };
    [self.navigationController pushViewController:searchView animated:YES];
}


#pragma mark -转换网络数据
-(void)changeNetData{                     //给tableviewcell用的数据
    

 
    

    
    for (int i=0; i<_netResultArray.count; i++) {
        
        NSDictionary *unitOneDic=_netResultArray[i];
        
        if (i==0) {
            _pageNumForNet=[[NSString stringWithFormat:@"%@",unitOneDic[@"offset"]] integerValue];
            _pageTotalNum=[[NSString stringWithFormat:@"%@",unitOneDic[@"pages"]] integerValue];
        }
        
        NSArray *dataArray=unitOneDic[@"datas"];
        

        
        for (int i=0; i<dataArray.count; i++) {
            NSDictionary *twoDic=dataArray[i];
            NSMutableArray *valueArray=[NSMutableArray array];
            NSMutableArray *valueArray22=[NSMutableArray array];
            [valueArray addObject:twoDic[@"plantName"]];
            
            for (int i=0; i<_NetForParameterNewArray.count; i++) {                  //列表1的数据
                if ([unitOneDic.allKeys containsObject:@"serverId"]) {
                    NSString*keyString=[_numForNetKeyDic objectForKey:_NetForParameterNewArray[i]];
                    NSString *valueString=[NSString stringWithFormat:@"%@",twoDic[keyString]];
                    
                    [valueArray addObject:valueString];
                }else{
                    [valueArray addObject:@""];         //没有接入的设备
                }
                
            }
            
            for (int i=0; i<_NetForParameterNew22Array.count; i++) {
                if ([unitOneDic.allKeys containsObject:@"serverId"]) {
                    NSString*keyString=[_numForNetKeyDic objectForKey:_NetForParameterNew22Array[i]];
                    NSString *valueString=[NSString stringWithFormat:@"%@",twoDic[keyString]];
                    
                    [valueArray22 addObject:valueString];
                }else{
                    [valueArray22 addObject:@""];         //没有接入的设备
                }
                
            }
            
            if ([unitOneDic.allKeys containsObject:@"serverId"]) {
                [valueArray addObject:unitOneDic[@"serverId"]];
                [valueArray22 addObject:unitOneDic[@"serverId"]];
            }else{
                [valueArray addObject:@"2"];
                [valueArray22 addObject:unitOneDic[@"2"]];
            }
            
            if ([twoDic.allKeys containsObject:@"pId"]) {
                [valueArray addObject:twoDic[@"pId"]];
                [valueArray22 addObject:twoDic[@"pId"]];
            }else{
                [valueArray addObject:@""];
                [valueArray22 addObject:unitOneDic[@""]];
            }

            
            [_allTableViewDataArray addObject:valueArray];
            [_allTableViewData22Array addObject:valueArray22];
            
        }
        
    }
    

    if (_allTableViewDataArray.count==0) {
        [self showToastViewWithTitle:@"没有电站"];
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
    
       [_deviceNetDic setObject:[NSString stringWithFormat:@"%ld",_pageNumForNet] forKey:@"page"];
    
}

-(void)changTableView{
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
        NSInteger Num=_cellNameArray2.count/2+_cellNameArray2.count%2;
        H=Num*20*HEIGHT_SIZE*2+10*HEIGHT_SIZE+5*HEIGHT_SIZE;
    }
    return H;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _allTableViewDataArray.count;
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
    NSString *keyValueString=@"dm_plantapp";
 
    NSString *textString=[NSString stringWithFormat:@"%@",[self jsonStringWithPrettyPrint:YES dataArray:_NetForParameterArray]];
    NSDictionary *netDic=@{@"text":textString,@"key":keyValueString};
    //  [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:netDic paramarsSite:@"/api/v3/device/saveShowCol" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v3/device/saveShowCol: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
                // self.parameterDic=firstDic[@"obj"];
                
            }else{
                
            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
    
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
    
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:_deviceNetDic paramarsSite:@"/api/v3/customer/plantManage/list" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v3/customer/plantManage/list: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
       
                NSArray *allArray=firstDic[@"obj"][@"pagers"];
            
                if (allArray.count>0) {
                    _netResultArray=allArray;
                    [self changeNetData];
                }else{
                    [self showToastViewWithTitle:@"没有设备"];
                }
                
            }else{
                int ResultValue=[firstDic[@"result"] intValue];
                
                if ((ResultValue>1) && (ResultValue<5)) {
                    NSArray *resultArray=@[@"不是集成商",@"服务器地址为空"];
                    if (ResultValue<(resultArray.count+2)) {
                        [self showToastViewWithTitle:resultArray[ResultValue-2]];
                    }
                }else if (ResultValue==22) {
                    [self showToastViewWithTitle:@"登录超时"];
                }else{
                    [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",firstDic[@"msg"]]];
                }
              
                
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
        return cell;
    }else{
        
        ossNewDeviceTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL2" forIndexPath:indexPath];
        
        if (!cell) {
            cell=[[ossNewDeviceTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL2"];
        }
        cell.deviceType=_deviceType;
        cell.nameValueArray=_allTableViewData22Array[indexPath.row];
        cell.nameArray=_cellNameArray2;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ossNewPlantControl2 *deviceView=[[ossNewPlantControl2 alloc]init];
    deviceView.deviceType=_deviceType;
    NSArray *infoArray;
    if (!_isChangTableView) {
        infoArray=_allTableViewDataArray[indexPath.row];
 
    }else{
        infoArray=_allTableViewData22Array[indexPath.row];
     
    }

       deviceView.deviceSn=infoArray[0];
    deviceView.serverId=infoArray[(infoArray.count-2)];
    deviceView.userId=infoArray[(infoArray.count-1)];
    
    [self.navigationController pushViewController:deviceView animated:YES];
    
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
        [_deviceNetDic setObject:[NSString stringWithFormat:@"%ld",_pageNumForNet] forKey:@"page"];
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
