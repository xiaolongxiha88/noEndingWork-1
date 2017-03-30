//
//  deviceViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "deviceViewController.h"
#import "TableViewCell.h"
#import "EditStationMenuView.h"
#import "DTKDropdownMenuView.h"
#import "addDevice.h"
#import "secondViewController.h"
#import "StationCellectViewController.h"
#import "secondCNJ.h"
#import "aliasViewController.h"
#import "DemoDevice.h"
#import "GetDevice.h"
#import "DemoDeviceViewController.h"
#import "UIImageView+WebCache.h"
#import "addStationViewController.h"
#import "PopoverView00.h"
 #import <objc/runtime.h>


#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]
#define  AnimationTime 5
#define  AnimationOne  @"one"

@interface deviceViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,EditStationMenuViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate,UIAlertViewDelegate,UIScrollViewDelegate,CAAnimationDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic,strong)EditStationMenuView  *editCellect;
@property (nonatomic, strong) UIAlertController *uploadImageActionSheet;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong) NSMutableArray *DemoPicName;
@property (nonatomic, strong) NSMutableArray *DemoPicName11;
@property (nonatomic, strong) NSMutableArray *DemoPicName2;
@property (nonatomic, strong) NSMutableArray *DemoPicName22;
@property (nonatomic, strong) NSMutableArray *stationID;
@property (nonatomic, strong) NSMutableArray *stationName;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *typeArr;
@property (nonatomic, strong) NSMutableDictionary *plantId;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) CoreDataManager *manager;
@property (nonatomic, strong) NSMutableArray *managerArray;
@property (nonatomic, strong) NSMutableArray *managerNowArray;
@property (nonatomic, strong) DemoDevice *demoDevice;
@property (nonatomic, strong) GetDevice *getDevice;
@property (nonatomic, strong) UIRefreshControl *control;
@property (nonatomic, strong) NSString *netType;
@property (nonatomic, strong) NSString *stationIdOne;
@property (nonatomic, strong) NSString *headPicName;
@property (nonatomic, strong) NSString *head11;
@property (nonatomic, strong) NSString *head12;
@property (nonatomic, strong) NSString *head13;
@property (nonatomic, strong) NSString *head21;
@property (nonatomic, strong) NSString *head22;
@property (nonatomic, strong) NSString *head23;
@property (nonatomic, strong) NSString *head31;
@property (nonatomic, strong) NSString *head32;
@property (nonatomic, strong) NSString *head33;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong) UIAlertView *Alert1;
@property (nonatomic, strong) UIImageView *guideImageView;
@property (nonatomic, strong) NSString *netEnable;
@property (nonatomic, strong) UIImageView *headImage1;
@property (nonatomic, strong) UIImageView *headImage2;
@property (nonatomic, strong) UIImageView *headImage3;
@property (nonatomic, strong) UIView *AdBackView;
@property (nonatomic, strong) UIView *AdFrontView;
@property (nonatomic, strong)UIImageView *dirPic;
 @property (nonatomic, strong) NSString*languageTypeValue;
 @property (nonatomic, strong) NSString*deviceHeadType;
//@property (nonatomic, strong) UIImageView *animationView;

@property (nonatomic, strong) NSString *pcsNetPlantID;
@property (nonatomic, strong) NSString *pcsNetStorageSN;
@property (nonatomic, strong) NSMutableDictionary *pcsDataDic;
@end

@implementation deviceViewController
{   //服务器设备属性
     NSMutableArray* imageArray;
     NSMutableArray *nameArray;
     NSMutableArray *statueArray;
    NSMutableArray *powerArray;
    NSMutableArray *dayArray;
     NSMutableArray *SNArray;
    NSMutableArray *totalPowerArray;
    //DEMO设备属性
     NSMutableArray* imageArray2;
     NSMutableArray *nameArray2;
     NSMutableArray *statueArray2;
     NSMutableArray *powerArray2;
     NSMutableArray *dayArray2;
    NSMutableArray *typeArray2;
    UIPageControl *_pageControl;
    UIScrollView *_scrollerView;
    NSString *_indenty;
    BOOL showProgressEnable;
    BOOL showAnimationEnable;
    
       NSMutableArray* imageStatueArray;
    //全局变量 用来控制偏移量
    NSInteger pageName;
    //coredata
    NSInteger animationNumber;
    
     NSInteger tapPicTime;
}

- (instancetype)initWithDataDict:(NSMutableArray *)stationID stationName:(NSMutableArray *)stationName{
    if (self = [super init]) {
        if (stationID.count>0) {
        self.stationID = [NSMutableArray arrayWithArray:stationID];
        self.stationName = [NSMutableArray arrayWithArray:stationName];
        }else{
            self.stationID =[NSMutableArray arrayWithObjects:@"1", nil];
             self. stationName =[NSMutableArray arrayWithObjects:root_shiFan_dianZhan, nil];
        }
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netRequest) name:@"changeName" object:nil];
    
    if ([_netEnable isEqualToString:@"1"]) {
          [self netRequest];
    }else{
     _netEnable=@"1";
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   _netEnable=@"0";
    showProgressEnable=YES;
    showAnimationEnable=NO;
    
  [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBarTintColor:MainColor];
 
     //self.view=nil;
    if (!_tableView) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(selectRightAction)];
        self.navigationItem.rightBarButtonItem = rightButton;
        _manager=[CoreDataManager sharedCoreDataManager];
        _managerArray=[NSMutableArray array];
        _managerNowArray=[NSMutableArray array];
        // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"reroadDemo" object:nil];
        
        //    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]){
        //self.automaticallyAdjustsScrollViewInsets = YES;
        NSString *coreEnable=[UserInfo defaultUserInfo].coreDataEnable;
        if ([coreEnable isEqualToString:@"1"]){
            [self initCoredata];
        }
        
        
        [self initData];
        [self addTitleMenu];
        [self addRightItem];
        //创建tableView的方法
        [self _createTableView];
        //创建tableView的头视图
        
       

    }
    
    
}

-(void)getDirctorPic{
     // [[UIApplication sharedApplication].keyWindow addSubview:_HUD];
    
    _dirPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width,SCREEN_Height)];
    _dirPic.userInteractionEnabled = YES;
     if ([_languageTypeValue isEqualToString:@"0"]) {
    _dirPic.image = IMAGE(@"设备页引导1.jpg");
     }else{
     _dirPic.image = IMAGE(@"设备页引导1_en.jpg");
     }
   [[UIApplication sharedApplication].keyWindow addSubview:_dirPic];
    tapPicTime=0;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getNextPic:)];
    [_dirPic addGestureRecognizer:tapGestureRecognizer];
}

-(void)getNextPic:(UITapGestureRecognizer*)tap{
    tapPicTime++;
    if ([_languageTypeValue isEqualToString:@"0"]) {
        if (tapPicTime==1) {
            _dirPic.image = IMAGE(@"设备页引导2.jpg");
        }else if (tapPicTime==2){
            _dirPic.image = IMAGE(@"设备页引导3.jpg");
        }else if (tapPicTime==5){
            _dirPic.image = IMAGE(@"设备页引导4.jpg");
        }else if (tapPicTime==3){
           _dirPic.image = IMAGE(@"pvDir_cn.jpg");
        }else if (tapPicTime==4){
           _dirPic.image = IMAGE(@"spDir_cn.jpg");
        }else if (tapPicTime==6){
            [_dirPic removeFromSuperview];
        }
    }else{
        if (tapPicTime==1) {
            _dirPic.image = IMAGE(@"设备页引导2_en.jpg");
        }else if (tapPicTime==2){
            _dirPic.image = IMAGE(@"设备页引导3_en.jpg");
        }else if (tapPicTime==5){
            _dirPic.image = IMAGE(@"设备页引导4_en.jpg");
        }else if (tapPicTime==3){
           _dirPic.image = IMAGE(@"pvDir_en.jpg");
        }else if (tapPicTime==4){
             _dirPic.image = IMAGE(@"spDir_en.jpg");
        }else if (tapPicTime==6){
            [_dirPic removeFromSuperview];
        }
    }
    
}

-(void)getNewAd{
    

    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *adNum=[ud objectForKey:@"advertisingNumber"];
    
    //测试
//adNum=nil;
    
    
    if ([_adNumber integerValue]>[adNum integerValue]||(adNum==nil)) {
        
        [self showProgressView];
        [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"admin":@"admin"}  paramarsSite:@"/newLoginAPI.do?op=getAPPMessage" sucessBlock:^(id content) {
            NSLog(@"getAPPMessage: %@", content);
            [self hideProgressView];
            if (content) {
                
                if([content[@"result"] integerValue]==1){
                
                  [[NSUserDefaults standardUserDefaults] setObject:_adNumber forKey:@"advertisingNumber"];
                    
//                    NSString *demo=@"1470031970617.jpg";
//                        NSString *picUrl=[NSString stringWithFormat:@"%@/%@",Head_Url_more,demo];
                    
                    
                    NSArray *languages = [NSLocale preferredLanguages];
                    NSString *currentLanguage = [languages objectAtIndex:0];
                 
                    NSString *picUrl;
                    
                    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
                        _languageTypeValue=@"0";
                    }else if ([currentLanguage hasPrefix:@"en"]) {
                        _languageTypeValue=@"1";
                    }else{
                        _languageTypeValue=@"2";
                    }
                    
                    if ([_languageTypeValue isEqualToString:@"0"]) {
                        picUrl=[NSString stringWithFormat:@"%@/%@",Head_Url_more,content[@"obj"][@"picurl"]];
                    }else{
                      picUrl=[NSString stringWithFormat:@"%@/%@",Head_Url_more,content[@"obj"][@"enpicurl"]];
                    }
                    
                    
                    
                    
                     float adHeight= 260*NOW_SIZE*33/22;
                    if (!_AdFrontView) {
                         _AdFrontView=[[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE, 25*HEIGHT_SIZE, 285*NOW_SIZE, adHeight)];
                    }
                    
                    _AdFrontView.userInteractionEnabled=YES;
                      [self.view addSubview:_AdFrontView];
                    
                    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
                    goBut.frame=CGRectMake(260*NOW_SIZE,0*HEIGHT_SIZE, 25*NOW_SIZE, 25*HEIGHT_SIZE);
                    [goBut setBackgroundImage:IMAGE(@"adCancel.png") forState:UIControlStateNormal];
                    [goBut addTarget:self action:@selector(adRemove) forControlEvents:UIControlEventTouchUpInside];
                    [_AdFrontView addSubview:goBut];
                    
                    

                    UIImageView *AdFrontImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 25*HEIGHT_SIZE, 260*NOW_SIZE, adHeight)];
                  //  AdFrontImageView.image=[UIImage imageNamed:@"pic_service.png"];
                                        NSURL* imagePath = [NSURL URLWithString:picUrl];
                                        [AdFrontImageView sd_setImageWithURL:imagePath placeholderImage:[UIImage imageNamed:@"pic_service.png"]];
                    [_AdFrontView addSubview:AdFrontImageView];
                    
              
                
                    if (!_AdBackView) {
                           _AdBackView=[[UIView alloc]initWithFrame: [UIScreen mainScreen].bounds];
                    }
             
                _AdBackView.backgroundColor = [UIColor blackColor];
                _AdBackView.alpha = 0.3;
                [self.view addSubview:_AdBackView];
                
                    [self.view bringSubviewToFront:_AdFrontView];
                    [_AdFrontView becomeFirstResponder];
                
                
                }
                
            }
            
        } failure:^(NSError *error) {
            [self hideProgressView];
        }];
        
        
    }
    
    
}


-(void)adRemove{

    [_AdFrontView removeFromSuperview];
      [_AdBackView removeFromSuperview];
    _AdFrontView=nil;
    _AdBackView=nil;

        [self getDirctorPic];
}



#pragma mark - CoreData
-(void)initDatacore{
   
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    

    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *_languageValue=[ud objectForKey:@"demoValue"];
    NSString* nowLanguage;
    
   
    
   

    
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        nowLanguage=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        nowLanguage=@"1";
    }else{
        nowLanguage=@"2";
    }
    
    
    NSString *coreEnable=[UserInfo defaultUserInfo].coreDataEnable;
     // BOOL firstRun = !_manager.hasStore;
    
    if (![_languageValue isEqualToString:nowLanguage]) {
        coreEnable=@"1";
         [[NSUserDefaults standardUserDefaults] setObject:nowLanguage forKey:@"demoValue"];
    }
    
    
    if ([coreEnable isEqualToString:@"1"]){
        [self initDemoData];
        [[UserInfo defaultUserInfo] setCoreDataEnable:@"0"];
    }
    else{
        [self request];
    }
    
     [self  getNewAd];
    
}

-(void)initDemoData{
  
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //    设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DemoDevice" inManagedObjectContext:_manager.managedObjContext];
    //    设置请求实体
    [request setEntity:entity];
    
    //    指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSError *error = nil;
    //    执行获取数据请求，返回数组
    NSArray *fetchResult = [_manager.managedObjContext executeFetchRequest:request error:&error];
    for (NSManagedObject *obj in fetchResult)
    {
        [_manager.managedObjContext deleteObject:obj];
    }       
    
    for(int i=0;i<imageArray2.count;i++)
    {
       _demoDevice=[NSEntityDescription insertNewObjectForEntityForName:@"DemoDevice" inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
        
        _demoDevice.type=typeArray2[i];
        _demoDevice.name=nameArray2[i];
        _demoDevice.power=powerArray2[i];
        _demoDevice.dayPower=dayArray2[i];
        _demoDevice.statueData=statueArray2[i];
        
        UIImage *image=IMAGE(imageArray2[i]);
        NSData *imagedata=UIImageJPEGRepresentation(image, 0.5);
        _demoDevice.image=imagedata;
    }
    
    BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else
    {
        NSLog(@"Save successFull");
    }
    [self request];
}

-(void)request{
    //    创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //    设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DemoDevice" inManagedObjectContext:_manager.managedObjContext];
    //    设置请求实体
    [request setEntity:entity];
    
    //    指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSError *error = nil;
    //    执行获取数据请求，返回数组
    NSArray *fetchResult = [_manager.managedObjContext executeFetchRequest:request error:&error];
    if (!fetchResult)
    {
        NSLog(@"error:%@,%@",error,[error userInfo]);
    }
    [self.managerArray removeAllObjects];
    [self.managerArray addObjectsFromArray:fetchResult];
    
  [self.tableView reloadData];

}

-(void)initData{
    _DemoPicName2=[[NSMutableArray alloc]initWithObjects:@"storagecn.png", @"powercn.png", @"pvcn.png",@"charge-cn.png",nil];
     _DemoPicName22=[[NSMutableArray alloc]initWithObjects:@"storageen.png", @"poweren.png", @"pven.png",@"charge-en.png",nil];
    
    _DemoPicName=[[NSMutableArray alloc]initWithObjects:@"storagebgcn.png", @"pvbgcn.png", @"pvbgcn.png",@"demobgcn.png",nil];
     _DemoPicName11=[[NSMutableArray alloc]initWithObjects:@"storagebgen.png", @"pvbgen.png", @"pvbgen.png",@"demobgen.png",nil];
    
    _typeArr=[NSMutableArray array];
    nameArray=[NSMutableArray array];
    statueArray=[NSMutableArray array];
    dayArray=[NSMutableArray array];
    imageArray=[NSMutableArray array];
    powerArray=[NSMutableArray array];
    totalPowerArray=[NSMutableArray array];
    SNArray=[NSMutableArray array];
    imageStatueArray=[NSMutableArray array];
    imageArray2=[[NSMutableArray alloc]initWithObjects:@"inverter2.png", @"储能机.png", @"充电桩.png",@"PowerRegulator.png",nil];
    nameArray2=[[NSMutableArray alloc]initWithObjects:root_niBianQi, root_chuNengJi, root_chongDianZhuang, root_gongLvTiaoJieQi,  nil];
    statueArray2=[[NSMutableArray alloc]initWithObjects:root_wei_LianJie, root_wei_LianJie, root_wei_LianJie,root_wei_LianJie,nil];
    powerArray2=[[NSMutableArray alloc]initWithObjects:@"50KW", @"50KW", @"5000W", @"5000W",  nil];
    dayArray2=[[NSMutableArray alloc]initWithObjects:@"500kWh", @"500kWh", @"50kWh",@"50kWh",nil];
    typeArray2=[[NSMutableArray alloc]initWithObjects:@"inverter", @"storage", @"charge",@"powerRegulator",nil];
}

#pragma mark - navigationItem
-(void)selectRightAction{
    addDevice *add=[[addDevice alloc]init];
    add.stationId=_stationIdOne;
    [self.navigationController pushViewController:add animated:YES];
}

- (void)addRightItem
{
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:root_tianJia_sheBei iconName:@"DTK_jiangbei" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
            [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
            return;
        }else{
        [self selectRightAction];
        }
        
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:root_caiJiQi_leiBiao iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        StationCellectViewController *goLog=[[StationCellectViewController alloc]init];
        goLog.stationId=_stationIdOne;
        goLog.getDirNum=_adNumber;
        [self.navigationController pushViewController:goLog animated:NO];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:root_Add_Plant iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        addStationViewController *addView=[[addStationViewController alloc]init];
        [self.navigationController pushViewController:addView animated:YES];
        
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2] icon:@"add@2x.png"];
    
    menuView.dropWidth = 150.f;
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = ColorWithRGB(102.f, 102.f, 102.f);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = ColorWithRGB(229.f, 229.f, 229.f);
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}
    
- (void)addTitleMenu
{
    NSMutableArray *DTK=[NSMutableArray array];
    for(int i=0;i<_stationID.count;i++)
    {
        
        NSString *DTKtitle=[[NSString alloc]initWithFormat:_stationName[i]];
    DTKDropdownItem *DTKname= [DTKDropdownItem itemWithTitle:DTKtitle callBack:^(NSUInteger index, id info) {
        NSLog(@"电站%lu",(unsigned long)index);
        [ [UserInfo defaultUserInfo]setPlantID:_stationID[index]];
        [ [UserInfo defaultUserInfo]setPlantNum:[NSString stringWithFormat:@"%lu",(unsigned long)index]];
        [_plantId setObject:_stationID[index] forKey:@"plantId"];
        _stationIdOne=_stationID[index];
        [self refreshData];
        
    }];
         [DTK addObject:DTKname];
    }
  
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewForNavbarTitleViewWithFrame:CGRectMake(0, 0, 200*HEIGHT_SIZE, 44*NOW_SIZE) dropdownItems:DTK];
    menuView.currentNav = self.navigationController;
    menuView.dropWidth = 150.f;
    menuView.titleColor=[UIColor whiteColor];
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor =COLOR(17, 183, 243, 1);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor =COLOR(231, 231, 231, 1);
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    NSString *sel=[[NSUserDefaults standardUserDefaults]objectForKey:@"plantNum"];
      NSInteger selected= [sel integerValue];
    if (sel==nil || sel==NULL||[sel isEqual:@""])
    {
       selected = 0;
    }
  
    if (selected>=_stationID.count) {
        selected= 0;
    }
    menuView.selectedIndex = selected;
    self.navigationItem.titleView = menuView;
    NSString *plantid1=[[NSString alloc]initWithString:_stationID[selected]];
    [ [UserInfo defaultUserInfo]setPlantID:plantid1];
    _stationIdOne=[NSString stringWithString:plantid1];
   // int plantid= [plantid1 intValue];
    //_plantId=[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInteger:plantid] forKey:@"plantId"];
    _plantId=[NSMutableDictionary dictionaryWithObject:plantid1 forKey:@"plantId"];
    NSString *a=@"1";
    NSString *b=@"15";

    [_plantId setObject:a forKey:@"pageNum"];
    [_plantId setObject:b forKey:@"pageSize"];
    
    //没有网络的功能测试开关
    BOOL netOk=1;
    if(netOk==1){
        [self netRequest];
    }
    else{
         [self initDemoData];
        }
}

-(void)initCoredata{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GetDevice" inManagedObjectContext:_manager.managedObjContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"deviceSN" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    NSError *error = nil;
    NSArray *fetchResult = [_manager.managedObjContext executeFetchRequest:request error:&error];
    for (NSManagedObject *obj in fetchResult)
    {
        [_manager.managedObjContext deleteObject:obj];
    }
    BOOL isSaveSuccess = [_manager.managedObjContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else
    {
        NSLog(@"Save successFull");
    }

}


-(void)refreshData{
   
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GetDevice" inManagedObjectContext:_manager.managedObjContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"deviceSN" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    NSError *error = nil;
    NSArray *fetchResult = [_manager.managedObjContext executeFetchRequest:request error:&error];
    for (NSManagedObject *obj in fetchResult)
    {
        [_manager.managedObjContext deleteObject:obj];
    }
    BOOL isSaveSuccess = [_manager.managedObjContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else
    {
        NSLog(@"Save successFull");
    }
    
    [self netRequest];

}


-(void)netRequest{
    
    if (showProgressEnable) {
        if (showAnimationEnable) {
            [self getAnimation:_headImage1];
            [self getAnimation:_headImage2];
            [self getAnimation:_headImage3];
        }else{
           //  [_control endRefreshing];
         [self showProgressView];
              }
    }else{
        [self getAnimation:_headImage1];
        [self getAnimation:_headImage2];
        [self getAnimation:_headImage3];
    
    }
  
    _deviceHeadType=@"0";
    _pcsNetPlantID=[_plantId objectForKey:@"plantId"];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:_plantId paramarsSite:@"/newPlantAPI.do?op=getAllDeviceList" sucessBlock:^(id content) {
      
       [self hideProgressView];
        
           [_control endRefreshing];
        
        showProgressEnable=YES;
        showAnimationEnable=YES;
        
         NSLog(@"getAllDeviceList:%@",content);
        _typeArr=[NSMutableArray array];
        nameArray=[NSMutableArray array];
        statueArray=[NSMutableArray array];
        dayArray=[NSMutableArray array];
        imageArray=[NSMutableArray array];
        powerArray=[NSMutableArray array];
        SNArray=[NSMutableArray array];
        imageStatueArray=[NSMutableArray array];
        
    
    
        
       // id jsonObj=[NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
         self.dataArr = [NSMutableArray arrayWithArray:content[@"deviceList"]];
        for (int i=0; i<_dataArr.count; i++) {

            
             [imageStatueArray addObject:@"disconnect@2x.png"];
           
            if ([content[@"deviceList"][i][@"deviceType"]isEqualToString:@"inverter"]) {
               
                
                
                NSString *picTypeSN=content[@"deviceList"][i][@"deviceSn"];
                  [imageArray addObject:[self getPvPic:picTypeSN]];
                
                NSString *PO=[NSString stringWithFormat:@"%@W",content[@"deviceList"][i][@"power"]];
                [powerArray addObject:PO];
                NSString *DY=[NSString stringWithFormat:@"%@kWh",content[@"deviceList"][i][@"eToday"]];
                [dayArray addObject:DY];
                
                [_typeArr addObject:content[@"deviceList"][i][@"deviceType"]];
                [SNArray addObject:content[@"deviceList"][i][@"deviceSn"]];
                if ([content[@"deviceList"][i][@"deviceAilas"]isEqualToString:@""]) {
                    [nameArray addObject:content[@"deviceList"][i][@"deviceType"]];
                }else{
                    [nameArray addObject:content[@"deviceList"][i][@"deviceAilas"]];}
                
                NSString *TO=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"energy"]];
                [totalPowerArray addObject:TO];
                
                NSString *ST0=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"lost"]];
                if ([ST0 isEqualToString:@"1"]) {
                    [statueArray addObject:@"6"];
                }else{
                    
                    NSString *ST=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"deviceStatus"]];
                    [statueArray addObject:ST];
                }

            }else if ([content[@"deviceList"][i][@"deviceType"]isEqualToString:@"storage"]){
                
                _pcsNetStorageSN=content[@"deviceList"][i][@"deviceSn"];
                _deviceHeadType=@"1";
                [imageArray addObject:@"storage.png"];
                NSString *PO=[NSString stringWithFormat:@"%@W",content[@"deviceList"][i][@"pCharge"]];
                [powerArray addObject:PO];
                NSString *DY=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"capacity"]];
                [dayArray addObject:DY];
                
                [_typeArr addObject:content[@"deviceList"][i][@"deviceType"]];
                [SNArray addObject:content[@"deviceList"][i][@"deviceSn"]];
                if ([content[@"deviceList"][i][@"deviceAilas"]isEqualToString:@""]) {
                    [nameArray addObject:content[@"deviceList"][i][@"deviceType"]];
                }else{
                    [nameArray addObject:content[@"deviceList"][i][@"deviceAilas"]];}
                
                NSString *TO2=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"energy"]];
                [totalPowerArray addObject:TO2];
                
                NSString *ST02=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"lost"]];
                if ([ST02 isEqualToString:@"1"]) {
                    [statueArray addObject:@"6"];
                }else{
                    
                    NSString *ST=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"deviceStatus"]];
                    [statueArray addObject:ST];
                }

                
            }
            
           
        }
        
        // _head11=@"88888";_head21=@"88888";_head31=@"88888";
        
        if ([_typeArr containsObject:@"storage"]) {
            _head13=root_Ppv;
            _head23=root_Puser;
             _head33=root_Pgrid;
            NSString *head111=[NSString stringWithFormat:@"%@",content[@"storageTodayPpv"]];
            _head11=head111;
            
           // _head11=@"8888888";
            _head12=@"W";
            
            NSString *head222=[NSString stringWithFormat:@"%@",content[@"storagePuser"]];
           // NSArray *headB=[head222 componentsSeparatedByString:@"_"];
            _head21=head222;
            _head22=@"W";
            
            NSString *head333=[NSString stringWithFormat:@"%@",content[@"storagePgrid"]];
          //  NSArray *headC=[head333 componentsSeparatedByString:@"_"];
            _head31=head333;
            _head32=@"W";
            
            if ( [_head11 intValue]>1000 &&[_head11 intValue]<1000000) {
                float KW=(float)[_head11 intValue]/1000;
                _head12=@"kW";
                _head11=[NSString stringWithFormat:@"%.1f",KW];
            }else if([_head11 intValue]>1000000){
                float MW=(float)[_head11 intValue]/1000000;
                _head12=@"MW";
                _head11=[NSString stringWithFormat:@"%.1f",MW];
            }
            
            if ( [_head21 intValue]>1000 &&[_head21 intValue]<1000000) {
                float KW=(float)[_head21 intValue]/1000;
                _head22=@"kW";
                _head21=[NSString stringWithFormat:@"%.1f",KW];
            }else if([_head21 intValue]>1000000){
                float MW=(float)[_head21 intValue]/1000000;
                _head22=@"MW";
                _head21=[NSString stringWithFormat:@"%.1f",MW];
            }
            
            if ( [_head31 intValue]>1000 &&[_head31 intValue]<1000000) {
                float KW=(float)[_head31 intValue]/1000;
                _head32=@"kW";
                _head31=[NSString stringWithFormat:@"%.1f",KW];
            }else if([_head31 intValue]>1000000){
                float MW=(float)[_head31 intValue]/1000000;
                _head32=@"MW";
                _head31=[NSString stringWithFormat:@"%.1f",MW];
            }
            
        }else if ([_typeArr containsObject:@"inverter"]){
            _head13=root_Revenue;
            //_head23=@"E-today PV";
            _head33=root_todayPV;
              _head23=root_PpvN;
            
            NSString *head111=[NSString stringWithFormat:@"%@",content[@"plantMoneyText"]];
            NSArray *headA=[head111 componentsSeparatedByString:@"/"];
            _head11=[headA objectAtIndex:0];
            _head12=[headA objectAtIndex:1];
            
            NSString *head222=[NSString stringWithFormat:@"%@",content[@"invTodayPpv"]];
            //NSArray *headB=[head222 componentsSeparatedByString:@"_"];
            _head21=head222;
             _head22=@"W";
            
            NSString *head333=[NSString stringWithFormat:@"%@",content[@"todayEnergy"]];
           // NSArray *headC=[head333 componentsSeparatedByString:@"_"];
            _head31=head333;
            //_head31=@"8888";
                _head32=@"kWh";
            
            if ( [_head21 intValue]>1000 &&[_head21 intValue]<1000000) {
                float KW=(float)[_head21 intValue]/1000;
                _head22=@"kW";
                _head21=[NSString stringWithFormat:@"%.1f",KW];
            }else if([_head21 intValue]>1000000){
                float MW=(float)[_head21 intValue]/1000000;
                _head22=@"MW";
                _head21=[NSString stringWithFormat:@"%.1f",MW];
            }
            
            if ( [_head31 intValue]>1000) {
                float KW=(float)[_head31 intValue]/1000;
                _head32=@"MWh";
                _head31=[NSString stringWithFormat:@"%.1f",KW];
            }
           
        }
        
        
        //创建Head
        if (_headerView) {
          //  [_headerView removeFromSuperview];
            _headerView=nil;
            
        }
         [self _createHeaderView];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"GetDevice" inManagedObjectContext:_manager.managedObjContext];
        [request setEntity:entity];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"deviceSN" ascending:NO];
        NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptions];
        NSError *error = nil;
        NSArray *fetchResult = [_manager.managedObjContext executeFetchRequest:request error:&error];
        
      
        
        
        NSMutableArray *SN=[NSMutableArray array];
        for (NSManagedObject *obj in fetchResult)
        {
            GetDevice *get=obj;
            [SN addObject:get.deviceSN];
        }
       
        for(int i=0;i<SNArray.count;i++)
        {
            if (fetchResult.count==0) {
                _getDevice=[NSEntityDescription insertNewObjectForEntityForName:@"GetDevice" inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
                _getDevice.name=nameArray[i];
                _getDevice.power=powerArray[i];
                _getDevice.dayPower=dayArray[i];
                _getDevice.statueData=statueArray[i];
                _getDevice.deviceSN=SNArray[i];
                _getDevice.type=_typeArr[i];
                _getDevice.totalPower=totalPowerArray[i];
                UIImage *image=IMAGE(imageArray[i]);
                NSData *imagedata=UIImageJPEGRepresentation(image, 0.5);
                _getDevice.demoImage=imagedata;
                _getDevice.statueImage=UIImageJPEGRepresentation(IMAGE(imageStatueArray[i]), 0.5);
                
                NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
                [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
                NSString *dateKK = [formatter stringFromDate:[NSDate date]];
                _getDevice.topNum = [[NSString alloc] initWithFormat:@"%@", dateKK];
                
            }else{
                
                if (![SN containsObject:SNArray[i]]) {
                    _getDevice=[NSEntityDescription insertNewObjectForEntityForName:@"GetDevice" inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
                    _getDevice.name=nameArray[i];
                     _getDevice.type=_typeArr[i];
                    _getDevice.power=powerArray[i];
                    _getDevice.dayPower=dayArray[i];
                    _getDevice.statueData=statueArray[i];
                    _getDevice.deviceSN=SNArray[i];
                      _getDevice.totalPower=totalPowerArray[i];
                    UIImage *image=IMAGE(imageArray[i]);
                    NSData *imagedata=UIImageJPEGRepresentation(image, 0.5);
                    _getDevice.demoImage=imagedata;
                    _getDevice.statueImage=UIImageJPEGRepresentation(IMAGE(imageStatueArray[i]), 0.5);
                    
                    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
                    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
                    NSString *dateKK = [formatter stringFromDate:[NSDate date]];
                    _getDevice.topNum = [[NSString alloc] initWithFormat:@"%@", dateKK];
                }else{
                
                    NSPredicate *predicate = [NSPredicate
                                              predicateWithFormat:@"deviceSN like[cd] %@",SNArray[i]];
                    NSFetchRequest * request = [[NSFetchRequest alloc] init];
                    [request setEntity:[NSEntityDescription entityForName:@"GetDevice" inManagedObjectContext:_manager.managedObjContext]];
                    [request setPredicate:predicate];//这里相当于sqlite中的查询条件，具体格式参考苹果文档
                    NSError *error = nil;
                    NSArray *result = [_manager.managedObjContext executeFetchRequest:request error:&error];
                    GetDevice *getDevice2=result[0];
                    getDevice2.name=nameArray[i];
                    getDevice2.type=_typeArr[i];
                    getDevice2.power=powerArray[i];
                    getDevice2.dayPower=dayArray[i];
                    getDevice2.statueData=statueArray[i];
                    getDevice2.deviceSN=SNArray[i];
                    getDevice2.totalPower=totalPowerArray[i];
                    UIImage *image=IMAGE(imageArray[i]);
                    NSData *imagedata=UIImageJPEGRepresentation(image, 0.5);
                    getDevice2.demoImage=imagedata;
                    getDevice2.statueImage=UIImageJPEGRepresentation(IMAGE(imageStatueArray[i]), 0.5);
                    
                }
                
        }
    }
        BOOL isSaveSuccess = [_manager.managedObjContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"Error: %@,%@",error,[error userInfo]);
        }else
        {
            NSLog(@"Save successFull");
        }

        NSFetchRequest *request2 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"GetDevice" inManagedObjectContext:_manager.managedObjContext];
        [request2 setEntity:entity2];
        NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"topNum" ascending:NO];
        NSArray *sortDescriptions2 = [[NSArray alloc] initWithObjects:sortDescriptor2, nil];
        [request2 setSortDescriptors:sortDescriptions2];
        

        
           NSArray *fetchResult1 = [_manager.managedObjContext executeFetchRequest:request2 error:&error];
        [self.managerNowArray removeAllObjects];
        [self.managerNowArray addObjectsFromArray:fetchResult1];
        
        for (int i=0; i<_typeArr.count; i++) {
            for (int j=0; j<typeArray2.count; j++)
            if([_typeArr[i] isEqualToString:typeArray2[j]])
            {
                [imageArray2 removeObjectAtIndex:j];
                [nameArray2 removeObjectAtIndex:j];
                [statueArray2 removeObjectAtIndex:j];
                [powerArray2 removeObjectAtIndex:j];
                 [dayArray2 removeObjectAtIndex:j];
                 [typeArray2 removeObjectAtIndex:j];
                
            }
        }
        
         [self initDatacore];
        self.edgesForExtendedLayout=UIRectEdgeNone;
         self.navigationController.navigationBar.translucent = NO;
        //_tableView.frame =CGRectMake(0, NavigationbarHeight, SCREEN_Width, SCREEN_Height);
       //  [self.tableView reloadData];
            
          //  [self showToastViewWithTitle:@"添加设备成功"];
        
    } failure:^(NSError *error) {
        [self hideProgressView];
         [_control endRefreshing];
        [self showToastViewWithTitle:root_Networking];
    }];

}


-(void)getPCSnet{

    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":_pcsNetPlantID,@"storageSn":_pcsNetStorageSN} paramarsSite:@"/newStorageAPI.do?op=getSystemStatusData" sucessBlock:^(id content) {
        [self hideProgressView];
        
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            //    id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"getSystemStatusData==%@", jsonObj);
           
            if ([jsonObj[@"result"] integerValue]==1) {
                
                if (jsonObj[@"obj"]==nil || jsonObj[@"obj"]==NULL||([jsonObj[@"obj"] isEqual:@""] )) {
                }else{
                    _pcsDataDic=[NSMutableDictionary new];
                    [_pcsDataDic setObject:jsonObj[@"obj"][@"capacity"] forKey:@"capacity"];
                      [_pcsDataDic setObject:jsonObj[@"obj"][@"pCharge"] forKey:@"pCharge"];
                     [_pcsDataDic setObject:jsonObj[@"obj"][@"pDisCharge"] forKey:@"pDisCharge"];
                     [_pcsDataDic setObject:jsonObj[@"obj"][@"pacCharge"] forKey:@"pacCharge"];
                     [_pcsDataDic setObject:jsonObj[@"obj"][@"pacToGrid"] forKey:@"pacToGrid"];
                     [_pcsDataDic setObject:jsonObj[@"obj"][@"pacToUser"] forKey:@"pacToUser"];
                     [_pcsDataDic setObject:jsonObj[@"obj"][@"ppv1"] forKey:@"ppv1"];
                     [_pcsDataDic setObject:jsonObj[@"obj"][@"ppv2"] forKey:@"ppv2"];
                     [_pcsDataDic setObject:jsonObj[@"obj"][@"status"] forKey:@"status"];
                     [_pcsDataDic setObject:jsonObj[@"obj"][@"userLoad"] forKey:@"userLoad"];
                    [_pcsDataDic setObject:jsonObj[@"obj"][@"pCharge1"] forKey:@"pCharge1"];
                    [_pcsDataDic setObject:jsonObj[@"obj"][@"pCharge2"] forKey:@"pCharge2"];
                    
                }
                [self getPCSHeadUI];
                [self getPCSHead];
            }
            
       
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}


-(NSString*)getPvPic:(NSString*)pvSN{
    
    NSString *pvPicName;
    NSString*pvSn2=[pvSN substringToIndex:2];
    
  //  pvSn2=@"3N";
    
    NSArray*pvArray1=[NSArray arrayWithObjects:@"R9",@"Z3",@"Z4",@"Z5",@"6A",@"7A",@"8A",@"9A",@"0B",@"1B",@"2B",@"3B",@"4B",@"5B",@"3C",@"3F",@"4F",@"5F",@"6F",@"7F",@"8F",@"9F",@"0G",@"1G",@"2G",@"3G",@"4G",@"5G",@"6G",@"7G",@"8G",@"9G",@"0H",@"1H",@"2H",@"3H",@"4H",@"5H",@"6H",@"7H",@"8H",@"9H",@"0I",@"1I",@"2I",@"3I",@"4I",@"5I",@"6I",@"7I",@"8I",@"9I",@"0J",@"1J",@"2J",@"3J",@"0K",@"1K",@"7K",@"8K",@"9K",@"0L",@"1L",@"2L",@"3L",@"4L",@"5L",@"6L",@"7L",@"4M",@"5M",@"6M",@"7M",@"8M",@"9M",@"0N",@"1N",@"2N",@"3N",@"4N",@"5N",@"9R",@"3S",@"4S",@"7U",@"8U",@"9U",@"0V",@"1V",@"2V",@"3V",@"4V",@"5V",@"6V",@"7V",@"8V",@"9V",@"0W",@"8W",@"8X",@"9X",@"0Y",@"1Y",@"2Y",@"3Y",@"4Y",@"5Y",@"6Y",@"7Y",@"8Y",@"9Y",@"0Z",@"1Z",@"2Z",@"3Z",@"4Z",@"5Z",@"6Z",@"7Z",@"14",@"15",@"16",@"17",@"18",@"25",@"26",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"89",@"90",@"AM",@"AN",@"AO",@"AQ",@"CW",@"CX",@"CV", nil];
    
    NSArray*pvArray2=[NSArray arrayWithObjects:@"D5",@"D6",@"D7",@"D8",@"D9",@"E0",@"E1",@"9L",@"0M",@"1M",@"2M",@"3M",@"3O",@"4O",@"5O",@"19",@"20",@"21",@"22",@"23",@"74",@"75",@"76",@"77",@"78",@"DP",@"DO",@"DN",@"DA",@"DQ",@"DW",@"DV",@"C8",@"C9",@"D5",@"D6",@"D7",@"D8",@"D9",@"E0",@"E1",nil];
    
    NSArray*pvArray3=[NSArray arrayWithObjects:@"4U",@"5U",@"6U",@"2W",@"3W",@"4W",@"83",@"84",@"85",@"86",@"87",@"88",@"AF",@"AG",@"AH",@"AI",@"AJ",@"AK",@"AL",@"BA",@"BB",@"BC",@"BD",@"BE",@"BF",@"BS",@"BT",@"E7",nil];
    
    if ([pvArray1 containsObject:pvSn2]) {
        pvPicName=@"PV_t1.png";
    }else if ([pvArray2 containsObject:pvSn2]){
      pvPicName=@"PV_t3.png";
    }else if ([pvArray3 containsObject:pvSn2]){
        pvPicName=@"PV_t4.png";
    }else{
    pvPicName=@"PV_t2.png";
    }
      
    return pvPicName;
}



#pragma mark 创建tableView的方法
- (void)_createTableView {
    //float a=self.tabBarController.tabBar.frame.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height-NavigationbarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _control=[[UIRefreshControl alloc]init];
    [_control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    
    [_tableView addSubview:_control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [_control beginRefreshing];
    
    // 3.加载数据
    //[self refreshStateChange:_control];
    
    [self.view addSubview:_tableView];
    _indenty = @"indenty";
    //注册单元格类型
    [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:_indenty];
}


-(void)refreshStateChange:(UIRefreshControl *)control{

    showProgressEnable=NO;
    
//    [self getAnimation:_headImage1];
//    [self getAnimation:_headImage2];
//    [self getAnimation:_headImage3];

    [self netRequest];
    
   
}

-(void)getAnimation:(UIImageView*)headImage{
    
    CABasicAnimation *moveupAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveupAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(headImage.center.x, headImage.center.y+55*HEIGHT_SIZE)];
    moveupAnimation.toValue = [NSValue valueWithCGPoint:headImage.center];
 moveupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    moveupAnimation.fillMode = kCAFillModeForwards;
    moveupAnimation.removedOnCompletion = NO;
    moveupAnimation.duration=1;
    moveupAnimation.speed=1;
    moveupAnimation.delegate=self;
    [headImage.layer addAnimation:moveupAnimation forKey:@"moveupAnimation"];

    [self getLineAnimationImage:headImage];

}

-(void)getLineAnimation:(UIImageView*)headImage intR:(NSString*)intRnum intAngle:(NSString*)intAngle{
    
   CAShapeLayer *LineShaperLayer=[CAShapeLayer layer];
    float LineShaperLayerX=headImage.frame.origin.x-10*NOW_SIZE;
     float LineShaperLayerY=headImage.frame.origin.y-10*NOW_SIZE;
      float LineShaperLayerW=headImage.frame.size.width+20*NOW_SIZE;
      float LineShaperLayerH=headImage.frame.size.height+20*NOW_SIZE;
    LineShaperLayer.frame=CGRectMake(LineShaperLayerX, LineShaperLayerY, LineShaperLayerW, LineShaperLayerH);
    CGPoint arcCenterPoint = CGPointMake(LineShaperLayerW/2, LineShaperLayerH/2);
    CGFloat arcRadius = headImage.frame.size.width*0.5*[intRnum floatValue];
    CGFloat arcStartAngle ;
    CGFloat arcEndAngle  ;
    if ([intAngle isEqualToString:@"1"]) {
      arcStartAngle = 0;
    arcEndAngle = M_PI * 2 ;
    }else if ([intAngle isEqualToString:@"2"]){
     arcStartAngle = -M_PI_2;
         arcEndAngle = M_PI * 2 - M_PI_2 + M_PI / 8.0;
    }else if ([intAngle isEqualToString:@"3"]){
        arcStartAngle = -M_PI;
        arcEndAngle = M_PI * 2 - M_PI_2 + M_PI / 8.0;

    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:arcCenterPoint radius:arcRadius startAngle:arcStartAngle endAngle:arcEndAngle clockwise:YES];
    LineShaperLayer.path = bezierPath.CGPath;
    LineShaperLayer.fillColor =nil ;
    LineShaperLayer.strokeColor = [UIColor whiteColor].CGColor;
    LineShaperLayer.lineWidth = 0.6*NOW_SIZE;
    LineShaperLayer.lineCap = kCALineCapRound;
    LineShaperLayer.strokeStart = 0;
    LineShaperLayer.strokeEnd = 0;
   LineShaperLayer.hidden = NO;
    [_headerView.layer addSublayer:LineShaperLayer];
  [self startAnimation:LineShaperLayer];
}

- (void)startAnimation:(CAShapeLayer*) HshapeLayer {
    
   // self.hidden = NO;
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = @(0);
    rotateAnimation.toValue = @(2 * M_PI);
    rotateAnimation.duration = 0.4;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimation.repeatCount = HUGE;
    [HshapeLayer addAnimation:rotateAnimation forKey:@"rotateAnimation"];
    [self endAnimation:HshapeLayer];
}

- (void)endAnimation:(CAShapeLayer*) HshapeLayer {
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(.95);
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeEndAnimation.duration = 0.4;
    strokeEndAnimation.repeatCount = HUGE;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    // strokeEndAnimation.delegate = self;
    [HshapeLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
}




-(void)getLineAnimationImage:(UIImageView*)imageView{
    [self getLineAnimation:imageView intR:@"1.1" intAngle:@"1"];
    [self getLineAnimation:imageView intR:@"1.3" intAngle:@"2"];
    [self getLineAnimation:imageView intR:@"1.5" intAngle:@"3"];
}


- (void)_createHeaderView {
    float headerViewH=200*HEIGHT_SIZE;
    if (!_headerView) {
          _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,headerViewH)];
    }
  
    _tableView.tableHeaderView = _headerView;
   
    float headHeight=_headerView.bounds.size.height;
    _headPicName=@"device_bg.jpg";
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,Kwidth,headHeight)];
    imageView.image = [UIImage imageNamed:_headPicName];
    [_headerView addSubview:imageView];
    
    //_deviceHeadType=@"1";
    if([_deviceHeadType isEqualToString:@"1"]){
         animationNumber=0;
        [self getPCSnet];
        
    }else{
        [self getPvHead];
    }
    
}

-(void)getPCSHead{
//    [_animationView removeFromSuperview];
//    _animationView=nil;
    
   float H0=7*HEIGHT_SIZE,W1=15*NOW_SIZE,H1=35*HEIGHT_SIZE,imageSize=45*HEIGHT_SIZE,H2=90*HEIGHT_SIZE,W2=82*NOW_SIZE;
    float imageH1=H1+imageSize/2;  float imageH12=7*HEIGHT_SIZE,imageW12=12*HEIGHT_SIZE;float WW2=5*NOW_SIZE;
 
      //上—1-0
    CGPoint pointStart=CGPointMake(W1+imageSize, imageH1-H0);
    CGPoint pointtEnd=CGPointMake(W1+W2, imageH1-H0);
  
    //上—1-1
    CGPoint pointStart0=CGPointMake(W1+imageSize, imageH1+H0);
    CGPoint pointtEnd0=CGPointMake(W1+W2, imageH1+H0);
    
    //上—2-1
    CGPoint pointStart1=CGPointMake(W1+W2+imageSize, imageH1-imageH12);
    CGPoint pointtEnd1=CGPointMake(W1+2*W2, imageH1-imageH12);

    //上—2-2
    CGPoint pointStart2=CGPointMake(W1+W2+imageSize, imageH1+imageH12);
    CGPoint pointtEnd2=CGPointMake(W1+2*W2-imageW12, imageH1+imageH12);
    CGPoint pointtEnd21=CGPointMake(W1+2*W2-imageW12, imageH1+imageH12+33*HEIGHT_SIZE);
    CGPoint pointtEnd22=CGPointMake(W1+3*W2-imageW12-WW2-1.5*NOW_SIZE, imageH1+imageH12+33*HEIGHT_SIZE);
    //上—3
    CGPoint pointStart3=CGPointMake(W1+2*W2+imageSize, imageH1);
    CGPoint pointtEnd3=CGPointMake(W1+3*W2, imageH1);
    
    //下—1
    CGPoint pointtStartW1=CGPointMake(W1+W2+imageSize/2, imageH1+imageSize/2);
    CGPoint pointtEndW1=CGPointMake(W1+W2+imageSize/2, imageH1+H2-imageSize/2);

    //下—2
    CGPoint pointtStartW2=CGPointMake(W1+2*W2+1.5*imageSize-WW2, imageH1);
    CGPoint pointtEndW2=CGPointMake(W1+2*W2+1.5*imageSize-WW2, imageH1+H2-imageSize/2);
    
    
    NSArray *startArray=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart],[NSValue valueWithCGPoint:pointStart0],[NSValue valueWithCGPoint:pointStart1], [NSValue valueWithCGPoint:pointtStartW1], [NSValue valueWithCGPoint:pointStart3], [NSValue valueWithCGPoint:pointStart2], [NSValue valueWithCGPoint:pointtEnd2], [NSValue valueWithCGPoint:pointtEnd21], [NSValue valueWithCGPoint:pointtEnd22], [NSValue valueWithCGPoint:pointtStartW2], nil];
    
        NSArray *endArray=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd],[NSValue valueWithCGPoint:pointtEnd0],[NSValue valueWithCGPoint:pointtEnd1], [NSValue valueWithCGPoint:pointtEndW1], [NSValue valueWithCGPoint:pointtEnd3], [NSValue valueWithCGPoint:pointtEnd2], [NSValue valueWithCGPoint:pointtEnd21], [NSValue valueWithCGPoint:pointtEnd22], [NSValue valueWithCGPoint:pointtEndW2], [NSValue valueWithCGPoint:pointtEndW2], nil];

    if (animationNumber==0) {
        animationNumber=1;
        for (int i=0; i<startArray.count; i++) {
            NSArray *P=[NSArray arrayWithObjects:[startArray objectAtIndex:i],[endArray objectAtIndex:i], nil];
              [self getHeadLayer:P];
        }
    }
    
    float TIME=8;
    //路径一
    NSArray *startArray0=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart],[NSValue valueWithCGPoint:pointStart1], [NSValue valueWithCGPoint:pointStart3], [NSValue valueWithCGPoint:pointtStartW2],nil];
    
        NSArray *endArray0=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd],[NSValue valueWithCGPoint:pointtEnd1], [NSValue valueWithCGPoint:pointtStartW2],[NSValue valueWithCGPoint:pointtEndW2],nil];
    
    [self getHeadAnimation:startArray0 second:endArray0 three:TIME];
    
    ////////////////////////////////
    NSArray *startArray01=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart0],[NSValue valueWithCGPoint:pointStart1], [NSValue valueWithCGPoint:pointStart3], [NSValue valueWithCGPoint:pointtStartW2],nil];
    
    NSArray *endArray01=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd0],[NSValue valueWithCGPoint:pointtEnd1], [NSValue valueWithCGPoint:pointtStartW2],[NSValue valueWithCGPoint:pointtEndW2],nil];
    
    [self getHeadAnimation:startArray01 second:endArray01 three:TIME];

    float pacToUser=[[_pcsDataDic objectForKey:@"pacToUser"] floatValue];
     float pacToGrid=[[_pcsDataDic objectForKey:@"pacToGrid"] floatValue];
    int status=[[_pcsDataDic objectForKey:@"status"] intValue];
    
   // status=2;
    if (pacToGrid>0) {
        //路径二
        NSArray *startArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart3], nil];
        NSArray *endArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd3], nil];
        [self getHeadAnimation:startArray02 second:endArray02 three:TIME*0.27];
    }
    
 if( (pacToUser>0)&&(status==1)) {
        //路径三
        NSArray *startArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd3],[NSValue valueWithCGPoint:pointtStartW2],  [NSValue valueWithCGPoint:pointtEnd22], [NSValue valueWithCGPoint:pointtEnd21], [NSValue valueWithCGPoint:pointtEnd2],nil];
        NSArray *endArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtStartW2], [NSValue valueWithCGPoint:pointtEnd22], [NSValue valueWithCGPoint:pointtEnd21], [NSValue valueWithCGPoint:pointtEnd2], [NSValue valueWithCGPoint:pointStart2],nil];
    
        [self getHeadAnimation:startArray02 second:endArray02 three:TIME*1.4];
 }
    
     if (pacToUser>0) {
     NSArray *startArray022=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd3],[NSValue valueWithCGPoint:pointtStartW2],  [NSValue valueWithCGPoint:pointtEnd22], nil];
     NSArray *endArray022=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtStartW2], [NSValue valueWithCGPoint:pointtEnd22], [NSValue valueWithCGPoint:pointtEndW2], nil];
     
     [self getHeadAnimation:startArray022 second:endArray022 three:TIME*0.46];
    
}


    
    if (status==1) {
        NSArray *startArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtStartW1], nil];
        NSArray *endArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEndW1], nil];
        [self getHeadAnimation:startArray02 second:endArray02 three:TIME*0.33];
    }
    if (status==2) {
        NSArray *startArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEndW1], nil];
        NSArray *endArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtStartW1], nil];
        [self getHeadAnimation:startArray02 second:endArray02 three:TIME*0.33];
    }
    
}

-(void)getHeadLayer:(NSArray*)startPoint0{
    CGPoint startPoint=[[startPoint0 objectAtIndex:0] CGPointValue];
    CGPoint endPoint=[[startPoint0 objectAtIndex:1] CGPointValue];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CAShapeLayer *trackLayer = [CAShapeLayer new];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    trackLayer.path = path.CGPath;
    trackLayer.frame = _headerView.bounds;
    trackLayer.lineWidth=1;
    trackLayer.fillColor = nil;
    trackLayer.strokeColor =COLOR(229, 220, 120, 1).CGColor;
    [_headerView.layer addSublayer:trackLayer];
}


-(void)getHeadAnimation:(NSArray*)startPoint0 second:(NSArray*)endPoint0 three:(float)time{

//    [_animationView removeFromSuperview];
//    _animationView=nil;
    
 CGPoint startPoint=[[startPoint0 objectAtIndex:0] CGPointValue];

UIImageView  *_animationView = [[UIImageView alloc] initWithFrame:CGRectMake(startPoint.x-2*NOW_SIZE,startPoint.y-2*HEIGHT_SIZE,6*HEIGHT_SIZE,4*HEIGHT_SIZE)];
    _animationView.image = [UIImage imageNamed:@"yuan.png"];
    [_headerView addSubview:_animationView];
    
    UIBezierPath *movePath = [UIBezierPath bezierPath];

    for (int i=0; i<startPoint0.count; i++) {
        CGPoint startPoint00=[[startPoint0 objectAtIndex:i] CGPointValue];
         CGPoint endPoint00=[[endPoint0 objectAtIndex:i] CGPointValue];
        [movePath moveToPoint:startPoint00];
        [movePath addLineToPoint:endPoint00];
    }
    
   
    
    CAKeyframeAnimation * posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = movePath.CGPath;
    posAnim.removedOnCompletion = YES;
   // [movePath addQuadCurveToPoint:CGPointMake(100, 300) controlPoint:CGPointMake(300, 100)];
    
    
//    CABasicAnimation *animation1= [CABasicAnimation animationWithKeyPath:@"position"];
//    //animation1.duration = 2.5; // 持续时间
//    // animation1.repeatCount = MAXFLOAT; // 重复次数
//    animation1.fromValue = [NSValue valueWithCGPoint:startPoint]; // 起始帧
//    animation1.toValue = [NSValue valueWithCGPoint:endPoint]; // 终了帧
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    animation2.duration = 0.6; // 动画持续时间
    animation2.repeatCount = MAXFLOAT; // 重复次数
    animation2.autoreverses = YES; // 动画结束时执行逆动画
    animation2.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation2.toValue = [NSNumber numberWithFloat:1.5]; // 结束时的倍率
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate=self;
    // 动画选项设定
//NSString *durationTime=time;
    group.duration = time;
    group.repeatCount = MAXFLOAT;

    group.animations = [NSArray arrayWithObjects:posAnim, animation2, nil];
    // 添加动画
   // NSString *animationKey=[startPoint0 objectAtIndex:3];
    [_animationView.layer addAnimation:group forKey:@"animation"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
      [self.view.layer removeAllAnimations];
    
}

//    [_pcsDataDic setObject:jsonObj[@"obj"][@"capacity"] forKey:@"capacity"];
//    [_pcsDataDic setObject:jsonObj[@"obj"][@"pCharge"] forKey:@"pCharge"];
//    [_pcsDataDic setObject:jsonObj[@"obj"][@"pDisCharge"] forKey:@"pDisCharge"];
//    [_pcsDataDic setObject:jsonObj[@"obj"][@"pacCharge"] forKey:@"pacCharge"];
//    [_pcsDataDic setObject:jsonObj[@"obj"][@"pacToGrid"] forKey:@"pacToGrid"];
//    [_pcsDataDic setObject:jsonObj[@"obj"][@"pacToUser"] forKey:@"pacToUser"];
//    [_pcsDataDic setObject:jsonObj[@"obj"][@"ppv1"] forKey:@"ppv1"];
//    [_pcsDataDic setObject:jsonObj[@"obj"][@"ppv2"] forKey:@"ppv2"];
//    [_pcsDataDic setObject:jsonObj[@"obj"][@"status"] forKey:@"status"];
//    [_pcsDataDic setObject:jsonObj[@"obj"][@"userLoad"] forKey:@"userLoad"];
//[_pcsDataDic setObject:jsonObj[@"obj"][@"pCharge1"] forKey:@"pCharge1"];
//[_pcsDataDic setObject:jsonObj[@"obj"][@"pCharge2"] forKey:@"pCharge2"];

-(void)getPCSHeadUI{
    NSString *ppv1=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"ppv1"] floatValue]];
    NSString *ppv2=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"ppv2"] floatValue]];
    NSString *pCharge=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pCharge"] floatValue]];
     NSString *pDisCharge=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pDisCharge"] floatValue]];
    NSString *capacity=[NSString stringWithFormat:@"%.1f%%",[[_pcsDataDic objectForKey:@"capacity"] floatValue]];
    NSString *pacCharge=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pacCharge"] floatValue]];
      NSString *userLoad=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"userLoad"] floatValue]];
     NSString *pacToGrid=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pacToGrid"] floatValue]];
     NSString *pacToUser=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pacToUser"] floatValue]];
    NSString *pCharge1=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pCharge1"] floatValue]];
    NSString *pCharge2=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pCharge2"] floatValue]];
 
    float lableW=55*NOW_SIZE;float lableH=15*HEIGHT_SIZE;float lableH0=10*HEIGHT_SIZE;
    float H0=8*HEIGHT_SIZE,W1=15*NOW_SIZE,H1=35*HEIGHT_SIZE,imageSize=45*HEIGHT_SIZE,H2=90*HEIGHT_SIZE,W2=82*NOW_SIZE;
    float imageH1=H1+imageSize/2;
    //float imageH12=7*HEIGHT_SIZE,imageW12=12*HEIGHT_SIZE;float WW2=5*NOW_SIZE;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(W1,H1,imageSize,imageSize)];
    imageView1.image = [UIImage imageNamed:@"icon_solor.png"];
    [_headerView addSubview:imageView1];
    UILabel *solorLable=[[UILabel alloc] initWithFrame:CGRectMake(W1+(imageSize-lableW)/2,H1-lableH,lableW,lableH)];
     solorLable.text=root_PCS_guangfu;
    solorLable.textColor=[UIColor whiteColor];
    solorLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable.textAlignment = NSTextAlignmentCenter;
     [_headerView addSubview:solorLable];
    UILabel *solorLableA=[[UILabel alloc] initWithFrame:CGRectMake(W1+imageSize, imageH1-H0-lableH0,37*NOW_SIZE,lableH0)];
    solorLableA.text=ppv1;
    solorLableA.textColor=[UIColor whiteColor];
    solorLableA.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableA.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:solorLableA];
    UILabel *solorLableA1=[[UILabel alloc] initWithFrame:CGRectMake(W1+imageSize, imageH1+H0,37*NOW_SIZE,lableH0)];
    solorLableA1.text=ppv2;
    solorLableA1.textColor=[UIColor whiteColor];
    solorLableA1.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableA1.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:solorLableA1];
    UILabel *solorLableB1=[[UILabel alloc] initWithFrame:CGRectMake(W1+W2+imageSize/2-65*NOW_SIZE, imageH1+imageSize/2+20*HEIGHT_SIZE,60*NOW_SIZE,lableH0)];
    if([[_pcsDataDic objectForKey:@"status"] intValue]==1){
     solorLableB1.text=pCharge;
    }else{
    solorLableB1.text=pDisCharge;
    }
   
    solorLableB1.textColor=[UIColor whiteColor];
    solorLableB1.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableB1.textAlignment = NSTextAlignmentRight;
    [_headerView addSubview:solorLableB1];
    UILabel *solorLableB2=[[UILabel alloc] initWithFrame:CGRectMake(W1+W2+imageSize/2+44*NOW_SIZE, imageH1+imageSize/2+20*HEIGHT_SIZE,60*NOW_SIZE,lableH0)];
    solorLableB2.text=pacCharge;
    solorLableB2.textColor=[UIColor whiteColor];
    solorLableB2.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableB2.textAlignment = NSTextAlignmentLeft;
    [_headerView addSubview:solorLableB2];
    UILabel *solorLableB3=[[UILabel alloc] initWithFrame:CGRectMake(W1+3*W2+(imageSize-lableW)/2,H1+imageSize+2*HEIGHT_SIZE,lableW,lableH0)];
    if ([pacToGrid floatValue]>0) {
          solorLableB3.text=pacToGrid;
    }else if ([pacToUser floatValue]>0){
         solorLableB3.text=pacToUser;
    }
    solorLableB3.textColor=[UIColor whiteColor];
    solorLableB3.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableB3.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:solorLableB3];
    UILabel *solorLableB4=[[UILabel alloc] initWithFrame:CGRectMake(W1+W2+(imageSize-lableW)/2,H1+H2+imageSize+lableH+0*HEIGHT_SIZE,lableW,lableH0)];
        solorLableB4.text=capacity;
    solorLableB4.textColor=[UIColor whiteColor];
    solorLableB4.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableB4.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:solorLableB4];
    UILabel *solorLableB5=[[UILabel alloc] initWithFrame:CGRectMake(W1+2.5*W2+(imageSize-lableW)/2,H1+H2+imageSize+lableH+0*HEIGHT_SIZE,lableW,lableH0)];
    solorLableB5.text=userLoad;
    solorLableB5.textColor=[UIColor whiteColor];
    solorLableB5.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableB5.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:solorLableB5];
    
   
    
    UILabel *solorLableB6=[[UILabel alloc] initWithFrame:CGRectMake(20*NOW_SIZE,H1+H2+imageSize+5*HEIGHT_SIZE,60*NOW_SIZE,lableH)];
    NSString *B1=root_PCS_danwei;
    solorLableB6.text=[NSString stringWithFormat:@"%@:W",B1];
    solorLableB6.textColor=[UIColor whiteColor];
    solorLableB6.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLableB6.textAlignment = NSTextAlignmentCenter;
    solorLableB6.center=CGPointMake(35*NOW_SIZE, H1+H2+imageSize+5*HEIGHT_SIZE+lableH/2);
    [_headerView addSubview:solorLableB6];
    UIImageView *image00 = [[UIImageView alloc] initWithFrame:CGRectMake(25*NOW_SIZE,H1+H2+imageSize-17*HEIGHT_SIZE,16*NOW_SIZE,16*NOW_SIZE)];
    image00.image = [UIImage imageNamed:@"zhushi11.png"];
    NSString *name1=root_PCS_guangfu_1;  NSString *name11=[NSString stringWithFormat:@"%@:%@W",name1,ppv1];
     NSString *name2=root_PCS_guangfu_2;  NSString *name22=[NSString stringWithFormat:@"%@:%@W",name2,ppv2];
    NSString *name3=root_PCS_chongdian_1;  NSString *name33=[NSString stringWithFormat:@"%@:%@W",name3,pCharge1];
        NSString *name4=root_PCS_chongdian_2;  NSString *name44=[NSString stringWithFormat:@"%@:%@W",name4,pCharge2];
    NSString *name0=root_PCS_fangdian_gonglv;  NSString *name00=[NSString stringWithFormat:@"%@:%@W",name0,pDisCharge];
      NSString *name5=root_PCS_dianchi_baifenbi;  NSString *name55=[NSString stringWithFormat:@"%@:%@",name5,capacity];
      NSString *name6=root_PCS_dianwang_chongdian_gonglv;  NSString *name66=[NSString stringWithFormat:@"%@:%@W",name6,pacCharge];
      NSString *name7=root_PCS_fuzai_gonglv;  NSString *name77=[NSString stringWithFormat:@"%@:%@W",name7,userLoad];
    NSString *name8=root_PCS_to_dianwang;  NSString *name88=[NSString stringWithFormat:@"%@:%@W",name8,pacToGrid];
    NSString *name9=root_PCS_from_dianwang;  NSString *name99=[NSString stringWithFormat:@"%@:%@W",name9,pacToUser];
    
    
    NSArray *lableName=[NSArray arrayWithObjects:name11,name22,name33,name44,name00,name55,name66,name77,name88,name99,nil];
    image00.userInteractionEnabled=YES;
    objc_setAssociatedObject(image00, "firstObject", lableName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [image00 addGestureRecognizer:tapGestureRecognizer];
    image00.center=CGPointMake(35*NOW_SIZE, H1+H2+imageSize-9*HEIGHT_SIZE);
    [_headerView addSubview:image00];
    
    UIView *VV1=[[UIView alloc] initWithFrame:CGRectMake(5*NOW_SIZE,H1+H2+imageSize-28*HEIGHT_SIZE,60*NOW_SIZE,50*NOW_SIZE)];
    VV1.userInteractionEnabled=YES;
    objc_setAssociatedObject(VV1, "firstObject", lableName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer1.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [VV1 addGestureRecognizer:tapGestureRecognizer1];
    [_headerView addSubview:VV1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(W1+W2,H1,imageSize,imageSize)];
    imageView2.image = [UIImage imageNamed:@"icon_sp.png"];
    [_headerView addSubview:imageView2];
    UILabel *solorLable1=[[UILabel alloc] initWithFrame:CGRectMake(W1+W2+(imageSize-lableW)/2,H1-lableH,lableW,lableH)];
    solorLable1.text=root_PCS_chunengji;
    solorLable1.textColor=[UIColor whiteColor];
    solorLable1.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable1.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:solorLable1];
    
    UIImageView *imageView3= [[UIImageView alloc] initWithFrame:CGRectMake(W1+2*W2,H1,imageSize,imageSize)];
    imageView3.image = [UIImage imageNamed:@"icon_inv.png"];
    [_headerView addSubview:imageView3];
    UILabel *solorLable2=[[UILabel alloc] initWithFrame:CGRectMake(W1+2*W2+(imageSize-lableW)/2,H1-lableH,lableW,lableH)];
    solorLable2.text=root_PCS_nibianqi;
    solorLable2.textColor=[UIColor whiteColor];
    solorLable2.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable2.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:solorLable2];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(W1+3*W2,H1,imageSize,imageSize)];
    imageView4.image = [UIImage imageNamed:@"icon_grid.png"];
    [_headerView addSubview:imageView4];
    UILabel *solorLable3=[[UILabel alloc] initWithFrame:CGRectMake(W1+3*W2+(imageSize-lableW)/2,H1-lableH,lableW,lableH)];
    solorLable3.text=root_PCS_dianwang;
    solorLable3.textColor=[UIColor whiteColor];
    solorLable3.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable3.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:solorLable3];
    
    UIImageView *imageView12 = [[UIImageView alloc] initWithFrame:CGRectMake(W1+W2,H1+H2,imageSize,imageSize)];
    imageView12.image = [UIImage imageNamed:@"icon_bat.png"];
    [_headerView addSubview:imageView12];
    UILabel *solorLable4=[[UILabel alloc] initWithFrame:CGRectMake(W1+W2+(imageSize-lableW)/2,H1+H2+imageSize,lableW,lableH)];
    solorLable4.text=root_PCS_dianyuan;
    solorLable4.textColor=[UIColor whiteColor];
    solorLable4.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable4.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:solorLable4];
    
    UIImageView *imageView22 = [[UIImageView alloc] initWithFrame:CGRectMake(W1+2.5*W2,H1+H2,imageSize,imageSize)];
    imageView22.image = [UIImage imageNamed:@"icon_load.png"];
    [_headerView addSubview:imageView22];
    UILabel *solorLable5=[[UILabel alloc] initWithFrame:CGRectMake(W1+2.5*W2+(imageSize-lableW)/2,H1+H2+imageSize,lableW,lableH)];
    solorLable5.text=root_PCS_fuzhai;
    solorLable5.textColor=[UIColor whiteColor];
    solorLable5.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable5.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:solorLable5];

}


-(void)getPvHead{
    float marchWidth=0*NOW_SIZE;
    float marchHeigh=18*HEIGHT_SIZE;
    float  headLableH=30*HEIGHT_SIZE;
    float  headLableColorH=4*HEIGHT_SIZE;
    float  headLableColorW=30*NOW_SIZE;
    float headLableValueH=50*HEIGHT_SIZE;
    float headImageH=40*HEIGHT_SIZE;
    float unitWidth=(Kwidth)/3;
    float gapH=10*HEIGHT_SIZE;
    NSArray *headNameArray=[NSArray arrayWithObjects: root_PpvN,root_Revenue,root_todayPV,nil];
    NSMutableArray *headValueArray=[NSMutableArray arrayWithObjects: _head21,_head11,_head31,nil];
    NSMutableArray *headValue1Array=[NSMutableArray arrayWithObjects: _head22,_head12,_head32,nil];
    if (headValueArray.count==0) {
        [headValueArray addObject:@"0"]; [headValueArray addObject:@"0"]; [headValueArray addObject:@"0"];
        [headValue1Array addObject:@""]; [headValue1Array addObject:@""]; [headValue1Array addObject:@""];
    }
    NSArray *headColorArray=[NSArray arrayWithObjects: COLOR(17, 183, 243, 1),COLOR(219, 210, 74, 1),COLOR(83, 218, 118, 1),nil];
    NSArray *headImageNameArray11=[NSArray arrayWithObjects: @"deviceHead1.png",@"deviceHead2.png",@"deviceHead33.png",nil];
    
    for (int i=0; i<headValueArray.count; i++) {
        UILabel *Lable12=[[UILabel alloc]initWithFrame:CGRectMake(marchWidth+unitWidth*i, marchHeigh, unitWidth,headLableH )];
        Lable12.text=headNameArray[i];
        Lable12.textAlignment=NSTextAlignmentCenter;
        Lable12.textColor=[UIColor whiteColor];
        Lable12.font = [UIFont systemFontOfSize:15*HEIGHT_SIZE];
        [_headerView addSubview:Lable12];
        
        UIView *headLableView1=[[UIView alloc]initWithFrame:CGRectMake(marchWidth+(unitWidth-headLableColorW)/2+unitWidth*i, marchHeigh+headLableH+gapH, headLableColorW, headLableColorH)];
        headLableView1.backgroundColor=headColorArray[i];
        [_headerView addSubview:headLableView1];
        
    
        UILabel *Lable1=[[UILabel alloc]initWithFrame:CGRectMake(unitWidth*i, marchHeigh+headLableH+gapH*2, unitWidth,headLableValueH)];
        Lable1.text=headValueArray[i];
        NSArray *lableName=[NSArray arrayWithObject:headValueArray[i]];
        Lable1.userInteractionEnabled=YES;
       objc_setAssociatedObject(Lable1, "firstObject", lableName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        tapGestureRecognizer.cancelsTouchesInView = NO;
        //将触摸事件添加到当前view
        [Lable1 addGestureRecognizer:tapGestureRecognizer];
        Lable1.textAlignment=NSTextAlignmentCenter;
        Lable1.textColor=[UIColor whiteColor];
        Lable1.font = [UIFont systemFontOfSize:26*HEIGHT_SIZE];
        [_headerView addSubview:Lable1];
        //        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:30*HEIGHT_SIZE] forKey:NSFontAttributeName];
        //        CGSize size = [headValueArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, headLableValueH) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        // [Lable1 sizeToFit];
        
        
        UILabel *Lable1L=[[UILabel alloc]initWithFrame:CGRectMake(unitWidth*i, marchHeigh+headLableH+gapH*2+headLableValueH-15*HEIGHT_SIZE, unitWidth,headLableValueH*0.5)];
        Lable1L.text=headValue1Array[i];
        Lable1L.textAlignment=NSTextAlignmentCenter;
        Lable1L.textColor=[UIColor whiteColor];
        Lable1L.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_headerView addSubview:Lable1L];
        
        
        float headImageH0=CGRectGetMaxY(Lable1.frame);
        float  headImageHgab=20*HEIGHT_SIZE;
        if (i==0) {
            _headImage1= [[UIImageView alloc] initWithFrame:CGRectMake(marchWidth+(unitWidth-headImageH)/2+unitWidth*i, headImageH0+headImageHgab, headImageH,headImageH)];
            _headImage1.image = [UIImage imageNamed:headImageNameArray11[i]];
            [_headerView addSubview:_headImage1];
        }else if (i==1){
            _headImage2= [[UIImageView alloc] initWithFrame:CGRectMake(marchWidth+(unitWidth-headImageH)/2+unitWidth*i, headImageH0+headImageHgab, headImageH,headImageH)];
            _headImage2.image = [UIImage imageNamed:headImageNameArray11[i]];
            [_headerView addSubview:_headImage2];
        }else if (i==2){
            _headImage3= [[UIImageView alloc] initWithFrame:CGRectMake(marchWidth+(unitWidth-headImageH)/2+unitWidth*i, headImageH0+headImageHgab, headImageH,headImageH)];
            _headImage3.image = [UIImage imageNamed:headImageNameArray11[i]];
            [_headerView addSubview:_headImage3];
        }
        
    }
    
    
    [self performSelector:@selector(showGuideView) withObject:nil afterDelay:0.5];


}


- (void)showGuideView {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        //第一次启动
        
        //引导操作动画
        self.guideImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_Width - 80*NOW_SIZE)/2, 20*NOW_SIZE, 100*NOW_SIZE, 180*NOW_SIZE)];
        NSMutableArray *guideImages = [NSMutableArray array];
        for (int i = 1; i <= 11; i++) {
            NSString *imageStr = [NSString stringWithFormat:@"L%d.png", i];
            [guideImages addObject:IMAGE(imageStr)];
        }
        
        [self.guideImageView setAnimationImages:guideImages];
        [self.guideImageView setAnimationDuration:self.guideImageView.animationImages.count * 0.09];
        [self.guideImageView setAnimationRepeatCount:0];
        [self.guideImageView startAnimating];
        [self.view addSubview:self.guideImageView];
    }
}

- (void)hideGuideView {
    [self.guideImageView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.guideImageView.animationDuration];
}

#pragma mark - 弹框提示
-(void)showAnotherView:(id)sender
{
      UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
     UIView *lable = (UIView*) tap.view;
    NSArray* lableNameArray = objc_getAssociatedObject(lable, "firstObject");
    
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

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self hideGuideView];

}

#pragma mark - EditCellectViewDelegate
- (void)menuDidSelectAtRow:(NSInteger)row {
    
    GetDevice *getDevice=[_managerNowArray objectAtIndex:_indexPath.row];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [_editCellect removeFromSuperview];
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }
    if (row==0) {
        //取消菜单
        [_editCellect removeFromSuperview];
        return;
    }
    if (row==1) {
        [_editCellect removeFromSuperview];
        aliasViewController *alias=[[aliasViewController alloc]init];
        alias.deviceSN=getDevice.deviceSN;
        if ([getDevice.type isEqualToString:@"inverter"]) {
            alias.netType=@"/newInverterAPI.do?op=updateInvInfo";
            alias.deviceSnKey=@"inverterId";
        }else if ([getDevice.type isEqualToString:@"storage"]){
        alias.deviceSnKey=@"storageId";
         alias.netType=@"/newStorageAPI.do?op=updateStorageInfo";
        }
        [self.navigationController pushViewController:alias animated:YES];
    }
    if (row==2) {
        [_editCellect removeFromSuperview];
        _dataDic=[NSMutableDictionary dictionaryWithObject:@"" forKey:@"alias"];
        if ([getDevice.type isEqualToString:@"inverter"]) {
               [_dataDic setObject:getDevice.deviceSN forKey:@"inverterId"];
            _netType=@"/newInverterAPI.do?op=updateInvInfo";
            
        }else if ([getDevice.type isEqualToString:@"storage"]){
             [_dataDic setObject:getDevice.deviceSN forKey:@"storageId"];
     
           _netType=@"/newStorageAPI.do?op=updateStorageInfo";
        }
        [_dataDic setObject:SNArray[_indexPath.row] forKey:@"inverterId"];
        
        [self addPicture];
    }
    if (row==3) {
        [_editCellect removeFromSuperview];
        
        _Alert1 = [[UIAlertView alloc] initWithTitle:root_ALET message:root_shifou_shanchu_shebei delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_OK, nil];
        
        [_Alert1 show];

            }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }else if (buttonIndex==1){
      
        [self deleteDevice];
    }
    
}

-(void)deleteDevice{
    
GetDevice *getDevice=[_managerNowArray objectAtIndex:_indexPath.row];
    [self showProgressView];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    NSString *netType;
    GetDevice *get=[_managerNowArray objectAtIndex:_indexPath.row];
    if ([getDevice.type isEqualToString:@"inverter"]) {
        [dict setObject:getDevice.deviceSN forKey:@"inverterId"];
        netType=@"/newInverterAPI.do?op=deleteInverter";
        
    }else if ([getDevice.type isEqualToString:@"storage"]){
        [dict setObject:getDevice.deviceSN forKey:@"storageId"];
        
        netType=@"/newStorageAPI.do?op=deleteStorage";
    }
    
 //   [dict setObject:get.deviceSN forKey:@"inverterId"];
    
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:dict paramarsSite:netType sucessBlock:^(id content) {
        //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
        NSLog(@"updateInvInfo: %@", content);
        [self hideProgressView];
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if (content1) {
            if ([content1[@"success"] integerValue] == 0) {
                if ([content1[@"msg"] integerValue] ==501) {
                    [self showAlertViewWithTitle:nil message:root_xiTong_CuoWu cancelButtonTitle:root_Yes];
                    //[self.tableView reloadData];
                }else if ([content1[@"msg"] integerValue] ==701) {
                    [self showAlertViewWithTitle:nil message:root_zhanghu_meiyou_quanxian cancelButtonTitle:root_Yes];
                }
            }else{
                [self showAlertViewWithTitle:nil message:root_shanChu_chengGong cancelButtonTitle:root_Yes];
                [[CoreDataManager sharedCoreDataManager].managedObjContext deleteObject:get];
                NSError *error = nil;
                BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
                if (!isSaveSuccess) {
                    NSLog(@"Error: %@,%@",error,[error userInfo]);
                }else
                {
                    NSLog(@"del successFull");
                    [self netRequest];
                }
            }
        }
    } failure:^(NSError *error) {
        [self showToastViewWithTitle:root_Networking];
    }];

    
}


-(void)addPicture{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
  
    
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: root_paiZhao style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        self.cameraImagePicker = [[UIImagePickerController alloc] init];
        self.cameraImagePicker.allowsEditing = YES;
        self.cameraImagePicker.delegate = self;
        self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_cameraImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_xiangkuang_xuanQu style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        self.photoLibraryImagePicker.allowsEditing = YES;
        self.photoLibraryImagePicker.delegate = self;
        self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
    [dataImageDict setObject:imageData forKey:@"image"];
   
    
    [BaseRequest uplodImageWithMethod:HEAD_URL paramars:_dataDic paramarsSite:_netType dataImageDict:dataImageDict sucessBlock:^(id content) {
      
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
          NSLog(@"updateInvInfo: %@", content1);
        if (content1) {
            if ([content1[@"success"] integerValue] == 0) {
                if ([content1[@"msg"] integerValue] ==501) {
                    [self showAlertViewWithTitle:nil message:root_xitong_cuoWu cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==701) {
                    [self showAlertViewWithTitle:nil message:root_zhanghu_meiyou_quanxian cancelButtonTitle:root_Yes];
                }
            }else{
                
                [self showAlertViewWithTitle:nil message:root_xiuGai_chengGong cancelButtonTitle:root_Yes];
            
                GetDevice *getDevice=[_managerNowArray objectAtIndex:_indexPath.row];
                [getDevice setValue:imageData forKey:@"nowImage"];
                NSError *error;
                BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
                if (!isSaveSuccess) {
                    NSLog(@"Error: %@,%@",error,[error userInfo]);
                }else
                {
                    NSLog(@"Save successFull");
                }
                [self.tableView reloadData];
                
            }
        }
    } failure:^(NSError *error) {
        [self showToastViewWithTitle:root_Networking];
    }];
}

#pragma mark tableView的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}



-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
        if (section==0) {
        return root_yi_peiZhi;
    }
    else{
        return  root_wei_peiZhi;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    
    return 30*HEIGHT_SIZE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

    
 
    //TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.section==0){
        GetDevice *getDevice=[_managerNowArray objectAtIndex:indexPath.row];
    if([getDevice.type isEqualToString:@"inverter"])
    {
    secondViewController *sd=[[secondViewController alloc ]init];
        sd.dayData=getDevice.dayPower;
        sd.totalData=getDevice.totalPower;
        sd.powerData=getDevice.power;
        sd.SnData=getDevice.deviceSN;
               sd.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:sd animated:NO];
    }
    else if([getDevice.type  isEqualToString:@"storage"]){
        secondCNJ *sd=[[secondCNJ alloc ]init];
        sd.deviceSN=getDevice.deviceSN;
        sd.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:sd animated:NO];}}
    else{
         DemoDevice *demoDevice=[_managerArray objectAtIndex:indexPath.row];
        
           // nameArray2=[[NSMutableArray alloc]initWithObjects:root_niBianQi, root_chuNengJi, root_chongDianZhuang, root_gongLvTiaoJieQi,  nil];
        
       if([demoDevice.type isEqualToString:@"inverter"]){
           
            DemoDeviceViewController *sd=[[DemoDeviceViewController alloc ]init];
            sd.hidesBottomBarWhenPushed=YES;
           
           if ([_languageValue isEqualToString:@"0"]) {
               sd.picName=_DemoPicName[2];
               sd.picName2=_DemoPicName2[2];
           }else{
               sd.picName=_DemoPicName11[2];
               sd.picName2=_DemoPicName22[2];
           }
       
           NSString *title1=[NSString stringWithFormat:@"%@(%@)",root_niBianQi,root_demo];
           sd.title=title1;
            [self.navigationController pushViewController:sd animated:NO];}
        else if([demoDevice.type  isEqualToString:@"storage"]){
            DemoDeviceViewController *sd=[[DemoDeviceViewController alloc ]init];
            sd.hidesBottomBarWhenPushed=YES;
      
            if ([_languageValue isEqualToString:@"0"]) {
                sd.picName=_DemoPicName[0];
                sd.picName2=_DemoPicName2[0];
            }else{
                sd.picName=_DemoPicName11[0];
                sd.picName2=_DemoPicName22[0];
            }
            
            NSString *title1=[NSString stringWithFormat:@"%@(%@)",root_chuNengJi,root_demo];
            sd.title=title1;
            
              // sd.title=@"storage(Demo)";
            [self.navigationController pushViewController:sd animated:NO];}
        else if([demoDevice.type  isEqualToString:@"charge"]){
            DemoDeviceViewController *sd=[[DemoDeviceViewController alloc ]init];
            sd.hidesBottomBarWhenPushed=YES;
 
            
            if ([_languageValue isEqualToString:@"0"]) {
                sd.picName=_DemoPicName[3];
                sd.picName2=_DemoPicName2[3];
            }else{
                sd.picName=_DemoPicName11[3];
                sd.picName2=_DemoPicName22[3];
            }
            NSString *title1=[NSString stringWithFormat:@"%@(%@)",root_chongDianZhuang,root_demo];
            sd.title=title1;
            
              //sd.title=@"charge(Demo)";
            [self.navigationController pushViewController:sd animated:NO];}
        else if([demoDevice.type  isEqualToString:@"powerRegulator"]){
            DemoDeviceViewController *sd=[[DemoDeviceViewController alloc ]init];
            sd.hidesBottomBarWhenPushed=YES;
    
            
            if ([_languageValue isEqualToString:@"0"]) {
                sd.picName=_DemoPicName[1];
                sd.picName2=_DemoPicName2[1];
            }else{
                sd.picName=_DemoPicName11[1];
                sd.picName2=_DemoPicName22[1];
            }
            
            NSString *title1=[NSString stringWithFormat:@"%@(%@)",root_gongLvTiaoJieQi,root_demo];
            sd.title=title1;
            
           // sd.title=@"powerRegulator(Demo)";
            [self.navigationController pushViewController:sd animated:NO];}
    
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return _managerNowArray.count;
    }
    else{
         return _managerArray.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
   TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
 //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
    if (!cell) {
    cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
    }
   
        GetDevice *getDevice=[_managerNowArray objectAtIndex:indexPath.row];
        if (getDevice.nowImage) {
            [cell.coverImageView  setImage:[UIImage imageWithData:getDevice.nowImage]];
        }else{
            [cell.coverImageView  setImage:[UIImage imageWithData:getDevice.demoImage]];}
      
        if ([getDevice.type isEqualToString:@"inverter"]) {
            cell.electric.text = root_ri_dianLiang;
            if ([getDevice.statueData isEqualToString:@"1"]){
                cell.stateValue.text =root_dengDai ;
                cell.stateValue.textColor=COLOR(17, 183, 243, 1);
            }else if ([getDevice.statueData isEqualToString:@"2"]){
                cell.stateValue.text =root_zhengChang ;
                  cell.stateValue.textColor=COLOR(121, 230, 129, 1);
            }else if ([getDevice.statueData isEqualToString:@"4"]){
                cell.stateValue.text =root_cuoWu ;
                  cell.stateValue.textColor=COLOR(255, 86, 82, 1);
            }else if ([getDevice.statueData isEqualToString:@"5"]){
                cell.stateValue.text =root_duanKai ;
                  cell.stateValue.textColor=COLOR(163, 163, 163, 1);
            }else if ([getDevice.statueData isEqualToString:@"-1"]){
                cell.stateValue.text =root_duanKai ;
                cell.stateValue.textColor=COLOR(163, 163, 163, 1);
            }else if ([getDevice.statueData isEqualToString:@"6"]){
                cell.stateValue.text =root_duanKai ;
                cell.stateValue.textColor=COLOR(163, 163, 163, 1);
            }
            
                
        }else if (([getDevice.type isEqualToString:@"storage"])){
            
         cell.electric.text = root_dianChi_baifenBi;
            if ([getDevice.statueData isEqualToString:@"0"]){
                cell.stateValue.text =root_xianZhi;
                  cell.stateValue.textColor=COLOR(45, 226, 233, 1);
            }else if ([getDevice.statueData isEqualToString:@"1"]){
                cell.stateValue.text =root_chongDian;
                  cell.stateValue.textColor=COLOR(121, 230, 129, 1);
            }else if ([getDevice.statueData isEqualToString:@"2"]){
                cell.stateValue.text =root_fangDian ;
                  cell.stateValue.textColor=COLOR(222, 211, 91, 1);
            }else if ([getDevice.statueData isEqualToString:@"3"]){
                cell.stateValue.text =root_cuoWu ;
                  cell.stateValue.textColor=COLOR(255, 86, 82, 1);
            }else if ([getDevice.statueData isEqualToString:@"4"]){
                cell.stateValue.text =root_dengDai ;
                  cell.stateValue.textColor=COLOR(17, 183, 243, 1);
            }else if ([getDevice.statueData isEqualToString:@"-1"]){
                cell.stateValue.text =root_duanKai ;
                cell.stateValue.textColor=COLOR(163, 163, 163, 1);
            }else if ([getDevice.statueData isEqualToString:@"6"]){
                cell.stateValue.text =root_duanKai ;
                cell.stateValue.textColor=COLOR(163, 163, 163, 1);
            }
            
            
            
            
        }
            cell.titleLabel.text = getDevice.name;
        cell.titleLabel.textColor = MainColor;
       
     cell.powerValue.text = getDevice.power;
     cell.electricValue.text =getDevice.dayPower;
       //[cell.stateView setImage:[UIImage imageWithData:getDevice.statueImage] ];
        return cell;
    }
    else{
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
        //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
        if (!cell) {
            cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
        }
        DemoDevice *demoDevice=[_managerArray objectAtIndex:indexPath.row];
        [cell.coverImageView  setImage:[UIImage imageWithData:demoDevice.image]];
         cell.electric.text = root_ri_dianLiang;
        cell.titleLabel.text = demoDevice.name;
        cell.titleLabel.textColor = [UIColor grayColor];
        cell.powerValue.text = demoDevice.power;
        cell.electricValue.text =demoDevice.dayPower;
        //cell.stateView.image =IMAGE(@"disconnect@2x.png");
        cell.stateValue.text=demoDevice.statueData;
          cell.stateValue.textColor=COLOR(163, 163, 163, 1);
        return cell;
        
        }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //更新数据
        if(indexPath.section==0)
        {
        }
        if(indexPath.section==1)
        {
          
            DemoDevice *demoDevice=[_managerArray objectAtIndex:indexPath.row];
              [_managerArray removeObjectAtIndex:indexPath.row];
            
         [[CoreDataManager sharedCoreDataManager].managedObjContext deleteObject:demoDevice];
            NSError *error = nil;
            
            //    托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
            BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
            if (!isSaveSuccess) {
                NSLog(@"Error: %@,%@",error,[error userInfo]);
            }else
            {
                NSLog(@"del successFull");
            }
           [self request];
        }
        //更新UI
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
    //添加一个编辑按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:root_bianJi handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了编辑");
        _indexPath=indexPath;
        _editCellect = [[EditStationMenuView alloc] initWithFrame:self.view.bounds];
        _editCellect.delegate = self;
        _editCellect.tintColor = [UIColor blackColor];
        _editCellect.dynamic = NO;
        _editCellect.blurRadius = 10.0f;
        [[UIApplication sharedApplication].keyWindow addSubview:_editCellect];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    
    //添加一个置顶按钮
    UITableViewRowAction *topRowAction =[UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:root_zhiDing handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了置顶");
        //1.更新数据
        if(indexPath.section==0){
            
         GetDevice *getDevice=[_managerNowArray objectAtIndex:indexPath.row];
    
            NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
            [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
            NSString *dateKK = [formatter stringFromDate:[NSDate date]];
            getDevice.topNum = [[NSString alloc] initWithFormat:@"%@", dateKK];
   NSError *error = nil;
            BOOL isSaveSuccess = [_manager.managedObjContext save:&error];
            if (!isSaveSuccess) {
                NSLog(@"Error: %@,%@",error,[error userInfo]);
            }else
            {
                NSLog(@"Save successFull");
            }
            
            NSFetchRequest *request2 = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"GetDevice" inManagedObjectContext:_manager.managedObjContext];
            [request2 setEntity:entity2];
            NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"topNum" ascending:NO];
            NSArray *sortDescriptions2 = [[NSArray alloc] initWithObjects:sortDescriptor2, nil];
            [request2 setSortDescriptors:sortDescriptions2];
            
            
            
            NSArray *fetchResult1 = [_manager.managedObjContext executeFetchRequest:request2 error:&error];
            [self.managerNowArray removeAllObjects];
            [self.managerNowArray addObjectsFromArray:fetchResult1];
  
            [self.tableView reloadData];
        }
   
        //2.更新UI
        NSIndexPath *firstIndexPath =[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
    }];
    
    //置顶按钮颜色
    topRowAction.backgroundColor =COLOR(99, 209, 249, 1);
    
        return @[deleteAction,topRowAction];}else return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 65*HEIGHT_SIZE;
    }




-(void)viewDidDisappear:(BOOL)animated{
    
    if (_AdFrontView) {
        [_AdFrontView removeFromSuperview];
         _AdFrontView=nil;
    }
    if (_AdBackView) {
        [_AdBackView removeFromSuperview];
        _AdBackView=nil;
    }
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
