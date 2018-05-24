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
#import "findViewController.h"
#import "newEnergyStorage.h"
#import "meViewController.h"
#import "storageHead.h"
#import "SPF5000Head.h"
#import "KTDropdownMenuView.h"
#import "Masonry.h"
#import "MixHead.h"
#import "MixSecondView.h"
#import "MaxSecondViewController.h"
#import "ossNewPlantControl.h"
#import "ossNewPlantControl2.h"
#import "ossNewDeviceControl.h"

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
@property (nonatomic, strong) UITabBarController *tabbar;

@property (nonatomic, strong) NSString *pcsNetPlantID;
@property (nonatomic, strong) NSString *pcsNetStorageSN;
@property (nonatomic, strong) NSMutableDictionary *pcsDataDic;
@property (nonatomic, assign) int storageType;      //0:SP2000,1:SP3000,2:SPF5000
@property (nonatomic) BOOL isStorageAllLost;
@property (nonatomic, assign) int deviceType;      //3:MIX
@property (nonatomic, strong) NSString *MixSN;    //头部MIX的SN

@property (nonatomic, strong) UIView *noneDeviceView;

@property (nonatomic) BOOL isPvType;

@property (nonatomic, strong) NSMutableDictionary *storageTypeDic;

@property (nonatomic, strong) DTKDropdownMenuView *rightMenuView;
@property (nonatomic, strong) DTKDropdownMenuView *titleMenuView;
@property (nonatomic, strong) KTDropdownMenuView *menuView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic,strong)UIBarButtonItem *leftItem;

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
          [self addTitleMenu];
    }else{
     _netEnable=@"1";
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   _netEnable=@"0";
_pcsNetStorageSN=@"";
    
    _isPvType=NO;
    
 
    if (_LogTypeForOSS==1) {
        _leftItem=[[UIBarButtonItem alloc]initWithTitle:@"返回OSS" style:UIBarButtonItemStylePlain target:self action:@selector(goToOSS)];
        self.navigationItem.leftBarButtonItem=_leftItem;
    }
    
  
  [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBarTintColor:MainColor];
   // [self.navigationController.navigationBar changBarFor11];

    CGRect navigationBarRect=self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.frame=CGRectMake(navigationBarRect.origin.x, navigationBarRect.origin.y, navigationBarRect.size.width, UI_NAVIGATION_BAR_HEIGHT);

    
    if (!_tableView) {
        
 
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
                    
                    
                    float adW=230*HEIGHT_SIZE;
                     float adAllW=adW+25*HEIGHT_SIZE;
                    
                     float adHeight= adW*33/22;
                    if (!_AdFrontView) {
                         _AdFrontView=[[UIView alloc]initWithFrame:CGRectMake((SCREEN_Width-adW)/2, 25*HEIGHT_SIZE, adAllW, adHeight)];
                    }
                    
                    _AdFrontView.userInteractionEnabled=YES;
                      [self.view addSubview:_AdFrontView];
                    
                    UIImageView *AdFrontImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 25*HEIGHT_SIZE, adW, adHeight)];
                  //  AdFrontImageView.image=[UIImage imageNamed:@"pic_service.png"];
                                        NSURL* imagePath = [NSURL URLWithString:picUrl];
                                        [AdFrontImageView sd_setImageWithURL:imagePath placeholderImage:[UIImage imageNamed:@"pic_service.png"]];
                    [_AdFrontView addSubview:AdFrontImageView];
                    
              
                    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
                    goBut.frame=CGRectMake(adW,0*HEIGHT_SIZE, 25*HEIGHT_SIZE, 25*HEIGHT_SIZE);
                    [goBut setBackgroundImage:IMAGE(@"adCancel.png") forState:UIControlStateNormal];
                    [goBut addTarget:self action:@selector(adRemove) forControlEvents:UIControlEventTouchUpInside];
                    [_AdFrontView addSubview:goBut];
                    
                
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
    
    _DemoPicName=[[NSMutableArray alloc]initWithObjects:@"storagecn.png", @"powercn.png", @"pvcn.png",@"charge-cn.png",nil];
     _DemoPicName11=[[NSMutableArray alloc]initWithObjects:@"storageen.png", @"poweren.png", @"pven.png",@"charge-en.png",nil];
    
    _typeArr=[NSMutableArray array];
    nameArray=[NSMutableArray array];
    statueArray=[NSMutableArray array];
    dayArray=[NSMutableArray array];
    imageArray=[NSMutableArray array];
    powerArray=[NSMutableArray array];
    totalPowerArray=[NSMutableArray array];
    SNArray=[NSMutableArray array];
    imageStatueArray=[NSMutableArray array];
    imageArray2=[[NSMutableArray alloc]initWithObjects:@"PV_head0.png", @"storage.png", @"充电桩.png",@"MeBoost.png",nil];
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
       add.hidesBottomBarWhenPushed=YES;
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
          goLog.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:goLog animated:NO];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:root_Add_Plant iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        addStationViewController *addView=[[addStationViewController alloc]init];
        [self.navigationController pushViewController:addView animated:YES];
        
    }];
    
   _rightMenuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2] icon:@"add@2x.png"];
//  menuView.intrinsicContentSize=CGSizeMake(44.f, 44.f);
   // menuView.translatesAutoresizingMaskIntoConstraints=true;
    _rightMenuView.dropWidth = 200.f;
    _rightMenuView.titleFont = [UIFont systemFontOfSize:18.f];
    _rightMenuView.textColor = ColorWithRGB(102.f, 102.f, 102.f);
    _rightMenuView.cellSeparatorColor = ColorWithRGB(229.f, 229.f, 229.f);
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




-(void)goToOSS{
    if (_LogOssNum==1) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ossNewDeviceControl class]])
            {
                ossNewDeviceControl *A =(ossNewDeviceControl *)controller;
                [self.navigationController popToViewController:A animated:YES];
            }
            
        }
    }else  if (_LogOssNum==2) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ossNewPlantControl class]])
            {
                ossNewPlantControl *A =(ossNewPlantControl *)controller;
                [self.navigationController popToViewController:A animated:YES];
            }
            
        }
    }else  if (_LogOssNum==3) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ossNewPlantControl2 class]])
            {
                ossNewPlantControl2 *A =(ossNewPlantControl2 *)controller;
                [self.navigationController popToViewController:A animated:YES];
            }
            
        }
    }
    
}


- (void)addTitleMenu
{
  
    NSString *sel=[[NSUserDefaults standardUserDefaults]objectForKey:@"plantNum"];
      NSInteger selected= [sel integerValue];
    if (sel==nil || sel==NULL||[sel isEqual:@""])
    {
       selected = 0;
    }
  
    if (selected>=_stationID.count) {
        selected= 0;
    }
  
    
    if (deviceSystemVersion>=11.0) {
        if (_menuView) {
            [_menuView removeFromSuperview];
            _menuView=nil;
        }
        _menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,200, 44) titles:_stationName];
        
        _menuView.selectedAtIndex = ^(int index)
        {
            NSLog(@"selected title:%@", _stationName[index]);
            [ [UserInfo defaultUserInfo]setPlantID:_stationID[index]];
            [ [UserInfo defaultUserInfo]setPlantNum:[NSString stringWithFormat:@"%lu",(unsigned long)index]];
            [_plantId setObject:_stationID[index] forKey:@"plantId"];
            _stationIdOne=_stationID[index];
            
            _isPvType=NO;
            [self refreshData];
        };
        _menuView.width = 150.f;
         _menuView.cellSeparatorColor =COLOR(231, 231, 231, 1);
        _menuView.cellColor=MainColor;
        //  menuView.textColor =MainColor;
          _menuView.textFont = [UIFont systemFontOfSize:17.f];
        _menuView.cellHeight=40*HEIGHT_SIZE;
            _menuView.animationDuration = 0.2f;
         _menuView.selectedIndex = selected;
        
        self.navigationItem.titleView = _menuView;
        
    }else{
        if (_titleMenuView) {
            [_titleMenuView removeFromSuperview];
            _titleMenuView=nil;
        }
        NSMutableArray *DTK=[NSMutableArray array];
        for(int i=0;i<_stationID.count;i++)
        {
            NSString *DTKtitle=[NSString stringWithFormat:@"%@",_stationName[i]];
            // NSString *DTKtitle=[[NSString alloc]initWithFormat:_stationName[i]];
            DTKDropdownItem *DTKname= [DTKDropdownItem itemWithTitle:DTKtitle callBack:^(NSUInteger index, id info) {
                NSLog(@"电站%lu",(unsigned long)index);
                [ [UserInfo defaultUserInfo]setPlantID:_stationID[index]];
                [ [UserInfo defaultUserInfo]setPlantNum:[NSString stringWithFormat:@"%lu",(unsigned long)index]];
                [_plantId setObject:_stationID[index] forKey:@"plantId"];
                _stationIdOne=_stationID[index];
                
                _isPvType=NO;
                [self refreshData];
                
            }];
            [DTK addObject:DTKname];
        }
        
        _titleMenuView = [DTKDropdownMenuView dropdownMenuViewForNavbarTitleViewWithFrame:CGRectMake(0, 0, 200*NOW_SIZE, UI_NAVIGATION_BAR_HEIGHT) dropdownItems:DTK];
        //  menuView.intrinsicContentSize=CGSizeMake(200*HEIGHT_SIZE, 44*HEIGHT_SIZE);
        //menuView.translatesAutoresizingMaskIntoConstraints=true;
      _titleMenuView.currentNav = self.navigationController;
        _titleMenuView.dropWidth = 150.f;
        _titleMenuView.titleColor=[UIColor whiteColor];
        _titleMenuView.titleFont = [UIFont systemFontOfSize:17.f];
        _titleMenuView.textColor =MainColor;
        _titleMenuView.textFont = [UIFont systemFontOfSize:13.f];
        _titleMenuView.cellSeparatorColor =COLOR(231, 231, 231, 1);
        _titleMenuView.textFont = [UIFont systemFontOfSize:14.f];
        _titleMenuView.animationDuration = 0.2f;
          _titleMenuView.selectedIndex = selected;

         self.navigationItem.titleView = _titleMenuView;
    }
    
    
    
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
    
    _storageTypeDic=[NSMutableDictionary new];
   _storageType=-1;
    
    if (_isPvType) {
         [self getAnimation:_headImage1];
         [self getAnimation:_headImage2];
         [self getAnimation:_headImage3];
    }else{
      [self showProgressView];
    }
    
    
    _deviceHeadType=@"0";           //0逆变器  1储能机   2MIX
    _pcsNetPlantID=[_plantId objectForKey:@"plantId"];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:_plantId paramarsSite:@"/newPlantAPI.do?op=getAllDeviceList" sucessBlock:^(id content) {
      
       [self hideProgressView];
        
           [_control endRefreshing];
        
    
        _isPvType=YES;
        
         NSLog(@"getAllDeviceList:%@",content);
        _typeArr=[NSMutableArray array];
        nameArray=[NSMutableArray array];
        statueArray=[NSMutableArray array];
        dayArray=[NSMutableArray array];
        imageArray=[NSMutableArray array];
        powerArray=[NSMutableArray array];
        SNArray=[NSMutableArray array];
        imageStatueArray=[NSMutableArray array];
        _isStorageAllLost=YES;
    

        
       // id jsonObj=[NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
         self.dataArr = [NSMutableArray arrayWithArray:content[@"deviceList"]];
        for (int i=0; i<_dataArr.count; i++) {

            
             [imageStatueArray addObject:@"disconnect@2x.png"];
           
            if ([content[@"deviceList"][i][@"deviceType"]isEqualToString:@"inverter"]) {                                //inverter 设备解析
               
                
                
                NSDictionary *deviceDic=content[@"deviceList"][i];
                if ([deviceDic.allKeys containsObject:@"invType"]) {                   //invType=0逆变器  1 max
                     NSString *invType=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"invType"]];
                    if ([invType integerValue]==1) {
                          [_typeArr addObject:@"MAX"];
                    }else{
                          [_typeArr addObject:content[@"deviceList"][i][@"deviceType"]];
                    }
                }else{
                      [_typeArr addObject:content[@"deviceList"][i][@"deviceType"]];
                }
                
                NSString *picTypeSN=content[@"deviceList"][i][@"deviceSn"];
                  [imageArray addObject:[self getPvPic:picTypeSN]];
                
                NSString *PO=[NSString stringWithFormat:@"%@W",content[@"deviceList"][i][@"power"]];
                [powerArray addObject:PO];
                NSString *DY=[NSString stringWithFormat:@"%@kWh",content[@"deviceList"][i][@"eToday"]];
                [dayArray addObject:DY];
                
              
                [SNArray addObject:content[@"deviceList"][i][@"deviceSn"]];
                if ([content[@"deviceList"][i][@"deviceAilas"]isEqualToString:@""]) {
                    [nameArray addObject:content[@"deviceList"][i][@"deviceSn"]];
                }else{
                    [nameArray addObject:content[@"deviceList"][i][@"deviceAilas"]];}
                
                NSString *TO=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"energy"]];
                [totalPowerArray addObject:TO];
                
                NSString *ST0=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"lost"]];
                if ([ST0 isEqualToString:@"1"]) {
                    [statueArray addObject:@"20"];
                }else{
                    
                    NSString *ST=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"deviceStatus"]];
                    [statueArray addObject:ST];
                       _isStorageAllLost=NO;
                }

            }else if ([content[@"deviceList"][i][@"deviceType"]isEqualToString:@"storage"]){                    //storage 设备解析
                
                 _isPvType=NO;
                if ([_deviceHeadType intValue]<1) {
                      _deviceHeadType=@"1";
                }
              
                [imageArray addObject:@"storage.png"];
                [powerArray addObject:[NSString stringWithFormat:@"%@W",content[@"deviceList"][i][@"pCharge"]]];
                [dayArray addObject:[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"capacity"]]];
                
                [_typeArr addObject:content[@"deviceList"][i][@"deviceType"]];
                [SNArray addObject:content[@"deviceList"][i][@"deviceSn"]];
                if ([content[@"deviceList"][i][@"deviceAilas"]isEqualToString:@""]) {
                    [nameArray addObject:content[@"deviceList"][i][@"deviceSn"]];
                }else{
                    [nameArray addObject:content[@"deviceList"][i][@"deviceAilas"]];
                }
                
                
                [totalPowerArray addObject:[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"energy"]]];
                
                NSString *ST02=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"lost"]];
                if ([ST02 isEqualToString:@"1"]) {
                    [statueArray addObject:@"20"];
                }else{
                    NSString *ST=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"deviceStatus"]];
                    [statueArray addObject:ST];
                      _isStorageAllLost=NO;
                }

                NSDictionary *deviceDic=content[@"deviceList"][i];
                if ([deviceDic.allKeys containsObject:@"storageType"]) {
                    NSString *type=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"storageType"]];
                    if ([type intValue]>_storageType) {
                        _storageType=[type intValue];
                        _pcsNetStorageSN=content[@"deviceList"][i][@"deviceSn"];
                    }
                    
                    [_storageTypeDic setValue:content[@"deviceList"][i][@"storageType"] forKey:content[@"deviceList"][i][@"deviceSn"]];
                }else{
                    _pcsNetStorageSN=content[@"deviceList"][i][@"deviceSn"];
                }
                
                
            }else if ([content[@"deviceList"][i][@"deviceType"]isEqualToString:@"mix"]){                  //MIX 设备解析
                if ([_deviceHeadType intValue]<2) {
                    _deviceHeadType=@"2";
                }
                [imageArray addObject:@"mixPic.png"];
                [powerArray addObject:[NSString stringWithFormat:@"%@W",content[@"deviceList"][i][@"pCharge"]]];
                [dayArray addObject:[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"capacity"]]];
                
                [_typeArr addObject:content[@"deviceList"][i][@"deviceType"]];
                [SNArray addObject:content[@"deviceList"][i][@"deviceSn"]];
                _MixSN=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"deviceSn"]];
                if ([content[@"deviceList"][i][@"deviceAilas"]isEqualToString:@""]) {
                    [nameArray addObject:content[@"deviceList"][i][@"deviceSn"]];
                }else{
                    [nameArray addObject:content[@"deviceList"][i][@"deviceAilas"]];
                }
                
                NSString *ST02=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"lost"]];
                if ([ST02 isEqualToString:@"1"]) {
                    [statueArray addObject:@"20"];
                }else{
                    NSString *ST=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"deviceStatus"]];
                    [statueArray addObject:ST];
                      _isStorageAllLost=NO;
                }
                
                         [totalPowerArray addObject:[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"energy"]]];
                
            }   //end
            
           
        }
        
        if (_dataArr.count==0) {
             [self getPVheadData:content];
        }
        
        if ([_typeArr containsObject:@"storage"]) {
            
        }else if ([_typeArr containsObject:@"inverter"] || [_typeArr containsObject:@"MAX"]){
            [self getPVheadData:content];
        }
        
        
        

        
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
            GetDevice *get=(GetDevice*)obj;
            
            if ([SNArray containsObject:get.deviceSN]) {
                   [SN addObject:get.deviceSN];
            }else{
                [_manager.managedObjContext deleteObject:obj];
            }
         
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
                    if (result.count>0) {
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
        
        //创建Head
        if (_headerView) {
            [_headerView removeFromSuperview];
            _headerView=nil;
            
        }
        [self _createHeaderView];
        

        
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
        
         [[NSUserDefaults standardUserDefaults] setObject:_pcsNetPlantID forKey:@"pcsNetPlantID"];
         [[NSUserDefaults standardUserDefaults] setObject:_pcsNetStorageSN forKey:@"pcsNetStorageSN"];
        
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            //    id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"getSystemStatusData==%@", jsonObj);
           
            if ([jsonObj[@"result"] integerValue]==1) {
                
                if (jsonObj[@"obj"]==nil || jsonObj[@"obj"]==NULL||([jsonObj[@"obj"] isEqual:@""] )) {
                }else{
                  //  NSString *deviceType=[NSString stringWithFormat:@"%@",jsonObj[@"obj"][@"deviceType"]];

                    _pcsDataDic=[NSMutableDictionary dictionaryWithDictionary:jsonObj[@"obj"]];
   
                }
                
                 [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_storageType] forKey:@"PcsDeviceType"];
                
                if (_storageType!=2) {
                    storageHead *StorageV=[[storageHead alloc]initWithFrame:CGRectMake(0, 0, _headerView.frame.size.width, _headerView.frame.size.height)];
                    StorageV.pcsDataDic=_pcsDataDic;
                    StorageV.isStorageLost=_isStorageAllLost;
                    StorageV.animationNumber=animationNumber;
                    [_headerView addSubview:StorageV];
                    [StorageV initUI];
                }else{
                    
                    SPF5000Head *StorageV=[[SPF5000Head alloc]initWithFrame:CGRectMake(0, 0, _headerView.frame.size.width, _headerView.frame.size.height)];
                    StorageV.pcsDataDic=_pcsDataDic;
                      StorageV.isStorageLost=_isStorageAllLost;
                    StorageV.animationNumber=animationNumber;
                    [_headerView addSubview:StorageV];
                    [StorageV initUI];
                    
 
                }
               
                

            }
            
       
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}


-(void)getMIXnet{
    
     NSString *plantID=[_plantId objectForKey:@"plantId"];
    
  //  _MixSN=@"SPH6000CS1";
    
    [[NSUserDefaults standardUserDefaults] setObject:plantID forKey:@"pcsNetPlantID"];
    [[NSUserDefaults standardUserDefaults] setObject:_MixSN forKey:@"pcsNetStorageSN"];
    
           [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":plantID,@"mixId":_MixSN} paramarsSite:@"/newMixApi.do?op=getSystemStatus" sucessBlock:^(id content) {
        [self hideProgressView];
        
        if (content) {

            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];

            NSLog(@"/newMixApi.do?op=getSystemStatus==%@", jsonObj);
            
            if ([jsonObj[@"result"] integerValue]==1) {
                
                if (jsonObj[@"obj"]==nil || jsonObj[@"obj"]==NULL||([jsonObj[@"obj"] isEqual:@""] )) {
                }else{
                  
                    _pcsDataDic=[NSMutableDictionary dictionaryWithDictionary:jsonObj[@"obj"]];
                    
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:3] forKey:@"PcsDeviceType"];
                
 
                    MixHead *StorageV=[[MixHead alloc]initWithFrame:CGRectMake(0, 0, _headerView.frame.size.width, _headerView.frame.size.height)];
                StorageV.allDic=[NSDictionary dictionaryWithDictionary:_pcsDataDic];
                    [_headerView addSubview:StorageV];
                    [StorageV initUI];
                
            }else{
                
                    [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",jsonObj[@"msg"]]];
            }
            
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}


-(NSString*)getPvPic:(NSString*)pvSN{
    
    NSString *pvPicName;
         pvPicName=@"PV_head0.png";
    return pvPicName;
}


#pragma mark 创建没有设备的界面
-(void)initNoneDeviceUI{
    if (_noneDeviceView) {
        [_noneDeviceView removeFromSuperview];
        _noneDeviceView=nil;
    }
    if (!_noneDeviceView) {
        _noneDeviceView=[[UIView alloc]initWithFrame:CGRectMake(0,200*HEIGHT_SIZE, ScreenWidth, 300*HEIGHT_SIZE)];
        _noneDeviceView.backgroundColor=[UIColor whiteColor];
        [_headerView addSubview:_noneDeviceView];
        
        float H=100*HEIGHT_SIZE;
        UIButton *addDeviceButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        addDeviceButton.frame=CGRectMake((ScreenWidth-H)/2,20*HEIGHT_SIZE, H, H);
        //    [addDeviceButton.layer setMasksToBounds:YES];
        //    [addDeviceButton.layer setCornerRadius:20.0];
        [addDeviceButton setBackgroundImage:IMAGE(@"add_nor.png") forState:UIControlStateNormal];
        [addDeviceButton setBackgroundImage:IMAGE(@"add_click.png") forState:UIControlStateSelected];
        [addDeviceButton setBackgroundImage:IMAGE(@"add_click.png") forState:UIControlStateHighlighted];
        // addDeviceButton.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
        // [addDeviceButton setTitle:root_yijian_jianzhan forState:UIControlStateNormal];
        [addDeviceButton addTarget:self action:@selector(selectRightAction) forControlEvents:UIControlEventTouchUpInside];
        [_noneDeviceView addSubview:addDeviceButton];
        
        float H2=20*HEIGHT_SIZE;
        UILabel *buttonName = [[UILabel alloc] initWithFrame:CGRectMake(0,20*HEIGHT_SIZE+H+3*HEIGHT_SIZE, ScreenWidth,H2)];
        buttonName.font=[UIFont systemFontOfSize:12*HEIGHT_SIZE];
        buttonName.textAlignment = NSTextAlignmentCenter;
        buttonName.text=root_tianJia_sheBei;
        buttonName.textColor = COLOR(102, 102,102, 1);
        [_noneDeviceView addSubview:buttonName];
        
           float W=160*HEIGHT_SIZE;
        UIButton *gotoDataloggerButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        gotoDataloggerButton.frame=CGRectMake((ScreenWidth-W)/2,20*HEIGHT_SIZE+H+20*HEIGHT_SIZE+20*HEIGHT_SIZE+H2, W, (83.0/452.0)*160*HEIGHT_SIZE);
        //    [addDeviceButton.layer setMasksToBounds:YES];
        //    [addDeviceButton.layer setCornerRadius:20.0];
        [gotoDataloggerButton setBackgroundImage:IMAGE(@"help_nor.png") forState:UIControlStateNormal];
        [gotoDataloggerButton setBackgroundImage:IMAGE(@"help_click.png") forState:UIControlStateSelected];
        [gotoDataloggerButton setBackgroundImage:IMAGE(@"help_click.png") forState:UIControlStateHighlighted];
         gotoDataloggerButton.titleLabel.font=[UIFont systemFontOfSize: 12*HEIGHT_SIZE];
         [gotoDataloggerButton setTitle:root_caiJiQi_leiBiao forState:UIControlStateNormal];
        [gotoDataloggerButton addTarget:self action:@selector(goToDataloggerList) forControlEvents:UIControlEventTouchUpInside];
        [_noneDeviceView addSubview:gotoDataloggerButton];
        
    }
  
    
    
}

-(void)goToDataloggerList{
    StationCellectViewController *goLog=[[StationCellectViewController alloc]init];
    goLog.stationId=_stationIdOne;
    goLog.getDirNum=_adNumber;
      goLog.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:goLog animated:YES];
}


#pragma mark 创建tableView的方法
- (void)_createTableView {
    //float a=self.tabBarController.tabBar.frame.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height-UI_NAVIGATION_BAR_HEIGHT-UI_STATUS_BAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _control=[[UIRefreshControl alloc]init];
    [_control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    
     [_tableView addSubview:_control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
   // [_control beginRefreshing];
    
    // 3.加载数据
    //[self refreshStateChange:_control];
    
    [self.view addSubview:_tableView];
    _indenty = @"indenty";
    //注册单元格类型
    [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:_indenty];
}


-(void)refreshStateChange:(UIRefreshControl *)control{
 

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
    }else {
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


#pragma mark - 增加Head的Banner

- (void)_createHeaderView {
    
   
    
    float headerViewH=200*HEIGHT_SIZE;
    
    if ([_deviceHeadType intValue]==2) {
        headerViewH=260*NOW_SIZE;
    }
    
    if (self.managerNowArray.count==0) {
        headerViewH=500*HEIGHT_SIZE;
    }
    
    if (!_headerView) {
          _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,headerViewH)];
    }
  
    _tableView.tableHeaderView = _headerView;
   
    float headHeight=_headerView.bounds.size.height;


    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,Kwidth,headHeight)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)COLOR(0, 156, 255, 1).CGColor, (__bridge id)COLOR(11, 182, 255, 1).CGColor];
    gradientLayer.locations = nil;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
    [imageView.layer addSublayer:gradientLayer];
    [_headerView addSubview:imageView];
    
    
    if (self.managerNowArray.count>0) {
        if (_noneDeviceView) {
            [_noneDeviceView removeFromSuperview];
            _noneDeviceView=nil;
        }
    }else{
        [self initNoneDeviceUI];
    }
    
    
    //_deviceHeadType=@"1";
    if([_deviceHeadType isEqualToString:@"1"]){
         animationNumber=0;
          [self getPCSnet];
          [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:@"isNewEnergy"];
        
    }else if([_deviceHeadType isEqualToString:@"0"]){
                [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:@"isNewEnergy"];
        
        [self getPvHead];
        
    }else if([_deviceHeadType isEqualToString:@"2"]){
    
        [self getMIXnet];
        [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:@"isNewEnergy"];
        
    }
    

  
    
    
}




- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
      [self.view.layer removeAllAnimations];
    
}





-(void)getPvHead{
    float marchWidth=0*NOW_SIZE;
    float marchHeigh=10*HEIGHT_SIZE;
    float  headLableH=20*HEIGHT_SIZE;
    float  headLableColorH=4*HEIGHT_SIZE;
    float  headLableColorW=30*NOW_SIZE;
    float headLableValueH=20*HEIGHT_SIZE;
     float headLableNameH=12*HEIGHT_SIZE;
    float headImageH=40*HEIGHT_SIZE;
    float unitWidth=(Kwidth)/3;
    float gapH=5*HEIGHT_SIZE;
    float gapH2=5*HEIGHT_SIZE;
    
   
    NSArray *headColorArray=[NSArray arrayWithObjects: COLOR(89, 220, 255, 1),COLOR(78, 224, 180, 1),COLOR(179, 218, 138, 1),nil];
    NSArray *headImageNameArray11=[NSArray arrayWithObjects: @"deviceHead1.png",@"deviceHead33.png",@"deviceHead2.png",nil];
    NSArray *timeArray=@[root_Device_head_180,root_Device_head_181,root_Device_head_182,root_Device_head_183,root_Device_head_182,root_Device_head_183];
    
    
    for (int i=0; i<_pvHeadNameArray.count; i++) {
        UILabel *Lable12=[[UILabel alloc]initWithFrame:CGRectMake(marchWidth+unitWidth*i, marchHeigh, unitWidth,headLableH )];
        Lable12.text=_pvHeadNameArray[i];
        Lable12.textAlignment=NSTextAlignmentCenter;
        Lable12.textColor=[UIColor whiteColor];
        Lable12.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        Lable12.adjustsFontSizeToFitWidth=YES;
        [_headerView addSubview:Lable12];
        
        UIView *headLableView1=[[UIView alloc]initWithFrame:CGRectMake(marchWidth+(unitWidth-headLableColorW)/2+unitWidth*i, marchHeigh+headLableH+gapH, headLableColorW, headLableColorH)];
        headLableView1.backgroundColor=headColorArray[i];
        [_headerView addSubview:headLableView1];
        
        UILabel *LableName1=[[UILabel alloc]initWithFrame:CGRectMake(unitWidth*i, marchHeigh+headLableH+gapH*2+gapH*2, unitWidth,headLableNameH)];
        LableName1.text=timeArray[0+2*i];
        LableName1.textAlignment=NSTextAlignmentCenter;
        LableName1.textColor=COLOR(255, 255, 255, 0.8);
        LableName1.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        [_headerView addSubview:LableName1];
        
    
        UILabel *Lable1=[[UILabel alloc]initWithFrame:CGRectMake(unitWidth*i, marchHeigh+headLableH+gapH*2+headLableNameH+gapH*2, unitWidth,headLableValueH)];
              NSString *lableText=[NSString stringWithFormat:@"%@%@",_pvHeadDataArray[0+2*i],_pvHeadDataUnitArray[0+2*i]];
        NSMutableAttributedString *attrString0 = [[NSMutableAttributedString alloc] initWithString:lableText];
        NSUInteger length = [lableText length];
        UIFont *baseFont = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
        [attrString0 addAttribute:NSFontAttributeName value:baseFont range:NSMakeRange(0, length)];
        UIFont *baseFont1 = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        [attrString0 addAttribute:NSFontAttributeName value:baseFont1 range:[lableText rangeOfString:_pvHeadDataUnitArray[0+2*i]]];
        Lable1.attributedText=attrString0;
        //Lable1.text=lableText;
        NSArray *lableName=[NSArray arrayWithObject:lableText];
        Lable1.userInteractionEnabled=YES;
       objc_setAssociatedObject(Lable1, "firstObject", lableName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
        tapGestureRecognizer.cancelsTouchesInView = NO;
        [Lable1 addGestureRecognizer:tapGestureRecognizer];
        Lable1.textAlignment=NSTextAlignmentCenter;
        Lable1.textColor=[UIColor whiteColor];
        Lable1.adjustsFontSizeToFitWidth=YES;
       // Lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_headerView addSubview:Lable1];
 
        UILabel *LableName2=[[UILabel alloc]initWithFrame:CGRectMake(unitWidth*i, marchHeigh+headLableH+gapH*2+headLableValueH*2+gapH2*5, unitWidth,headLableNameH)];
        LableName2.text=timeArray[1+2*i];
        LableName2.textAlignment=NSTextAlignmentCenter;
        LableName2.textColor=COLOR(255, 255, 255, 0.8);
        LableName2.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        [_headerView addSubview:LableName2];

        UILabel *Lable1L=[[UILabel alloc]initWithFrame:CGRectMake(unitWidth*i, marchHeigh+headLableH+gapH*2+headLableValueH*2+headLableNameH+gapH2*5, unitWidth,headLableValueH)];
          NSString *lableText2=[NSString stringWithFormat:@"%@%@",_pvHeadDataArray[1+2*i],_pvHeadDataUnitArray[1+2*i]];
          //Lable1L.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
         NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:lableText2];
        NSUInteger length2 = [lableText2 length];
        UIFont *baseFont2 = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
        [attrString addAttribute:NSFontAttributeName value:baseFont2 range:NSMakeRange(0, length2)];
          UIFont *baseFont12 = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
         [attrString addAttribute:NSFontAttributeName value:baseFont12 range:[lableText2 rangeOfString:_pvHeadDataUnitArray[1+2*i]]];
        Lable1L.attributedText=attrString;
         Lable1L.adjustsFontSizeToFitWidth=YES;
    //    Lable1L.text=lableText2;
        NSArray *lableName2=[NSArray arrayWithObject:lableText2];
        Lable1L.userInteractionEnabled=YES;
        objc_setAssociatedObject(Lable1L, "firstObject", lableName2, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        UITapGestureRecognizer *tapGestureRecognizer2= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
        tapGestureRecognizer2.cancelsTouchesInView = NO;
        [Lable1L addGestureRecognizer:tapGestureRecognizer2];
        Lable1L.textAlignment=NSTextAlignmentCenter;
        Lable1L.textColor=[UIColor whiteColor];
      
        [_headerView addSubview:Lable1L];
        
        
        float headImageH0=CGRectGetMaxY(Lable1L.frame);
        float  headImageHgab=10*HEIGHT_SIZE;
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
        }else if ([getDevice.type isEqualToString:@"mix"]){
            alias.deviceSnKey=@"mixId";
            alias.netType=@"/newMixApi.do?op=updateMixInfoAPI";
        }else if ([getDevice.type isEqualToString:@"MAX"]){
            alias.deviceSnKey=@"maxId";
            alias.netType=@"/newInverterAPI.do?op=updateMaxInfo";
        }
        
        [self.navigationController pushViewController:alias animated:YES];
    }
    if (row==2) {
        [_editCellect removeFromSuperview];

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
        
    }else if ([getDevice.type isEqualToString:@"mix"]){
        [dict setObject:getDevice.deviceSN forKey:@"mixId"];
        netType=@"/newMixApi.do?op=deleteMixAPI";
        
    }else if ([getDevice.type isEqualToString:@"MAX"]){
        [dict setObject:getDevice.deviceSN forKey:@"maxId"];
        netType=@"/newInverterAPI.do?op=deletemax";
        
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
                   // [self netRequest];
          
                    [_managerNowArray removeObjectAtIndex:_indexPath.row];
                    
                    [self.tableView reloadData];
                }
            }
        }
    } failure:^(NSError *error) {
           [self hideProgressView];
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
    
//    [BaseRequest uplodImageWithMethod:HEAD_URL paramars:_dataDic paramarsSite:_netType dataImageDict:dataImageDict sucessBlock:^(id content) {
//
//        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
//          NSLog(@"updateInvInfo: %@", content1);
//        if (content1) {
//            if ([content1[@"success"] integerValue] == 0) {
//                if ([content1[@"msg"] integerValue] ==501) {
//                    [self showAlertViewWithTitle:nil message:root_xitong_cuoWu cancelButtonTitle:root_Yes];
//                }else if ([content1[@"msg"] integerValue] ==701) {
//                    [self showAlertViewWithTitle:nil message:root_zhanghu_meiyou_quanxian cancelButtonTitle:root_Yes];
//                }
//            }else{
//
//                [self showAlertViewWithTitle:nil message:root_xiuGai_chengGong cancelButtonTitle:root_Yes];
//
//            }
//        }
//    } failure:^(NSError *error) {
//           [self hideProgressView];
//        [self showToastViewWithTitle:root_Networking];
//    }];
    
    
}

#pragma mark tableView的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.managerNowArray.count==0){
            return 0;
    }else{
         return 1;
    }

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
        if (_storageTypeDic.count>0) {
            NSString *type=[NSString stringWithFormat:@"%@",[_storageTypeDic objectForKey:getDevice.deviceSN]];
       
            //////// typeNum=1:spf5000    2:普通储能机  3.MIX
            if ([type isEqualToString:@"2"]) {
                sd.typeNum=@"1";
            }else{
                sd.typeNum=@"2";
            }
        }
      
        sd.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:sd animated:NO];
        
    }else if([getDevice.type  isEqualToString:@"mix"]){
        MixSecondView *sd=[[MixSecondView alloc ]init];
        sd.deviceSN=getDevice.deviceSN;
        sd.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:sd animated:NO];
    }else if([getDevice.type  isEqualToString:@"MAX"]){
      
        MaxSecondViewController *sd=[[MaxSecondViewController alloc ]init];
        sd.dayData=getDevice.dayPower;
        sd.totalData=getDevice.totalPower;
        sd.powerData=getDevice.power;
        sd.SnData=getDevice.deviceSN;
        sd.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:sd animated:NO];
    }
        
    }
    else{
         DemoDevice *demoDevice=[_managerArray objectAtIndex:indexPath.row];
        
           // nameArray2=[[NSMutableArray alloc]initWithObjects:root_niBianQi, root_chuNengJi, root_chongDianZhuang, root_gongLvTiaoJieQi,  nil];
        
       if([demoDevice.type isEqualToString:@"inverter"]){
           
            DemoDeviceViewController *sd=[[DemoDeviceViewController alloc ]init];
            sd.hidesBottomBarWhenPushed=YES;
           sd.leftName=root_NBQ_ri_dianliang;
           sd.rightName=root_NBQ_zong_dianliang;
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
            sd.leftName=root_ri_fangdianliang;
            sd.rightName=root_zong_fangdianliang;
            
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
            sd.leftName=root_Device_head_184;
            sd.rightName=root_Device_head_185;
            
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
            sd.leftName=root_NBQ_ri_dianliang;
            sd.rightName=root_NBQ_zong_dianliang;
            
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
 
    if (!cell) {
    cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
    }
   
        GetDevice *getDevice=[_managerNowArray objectAtIndex:indexPath.row];
        if (getDevice.nowImage) {
            [cell.coverImageView  setImage:[UIImage imageWithData:getDevice.nowImage]];
        }else{
            [cell.coverImageView  setImage:[UIImage imageWithData:getDevice.demoImage]];}
      
        if ([getDevice.type isEqualToString:@"inverter"] || [getDevice.type isEqualToString:@"MAX"]) {
            cell.electric.text =[NSString stringWithFormat:@"%@%@",root_ri_dianLiang,getDevice.dayPower];
            cell.power.text =[NSString stringWithFormat:@"%@:%@",root_gongLv,getDevice.power];
            cell.electric.frame=CGRectMake(55*HEIGHT_SIZE+10*NOW_SIZE, 40*HEIGHT_SIZE, 130*NOW_SIZE, 20*HEIGHT_SIZE);
            cell.power.frame=CGRectMake(55*HEIGHT_SIZE+150*NOW_SIZE, 40*HEIGHT_SIZE, 80*NOW_SIZE, 20*HEIGHT_SIZE);
            
            if ([getDevice.statueData isEqualToString:@"1"]){
                cell.stateValue.text =root_dengDai ;
                cell.stateValue.textColor=MainColor;
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
            }else if ([getDevice.statueData isEqualToString:@"20"]){                  //6 掉线
                cell.stateValue.text =root_duanKai ;
                cell.stateValue.textColor=COLOR(163, 163, 163, 1);
            }
            
 
                
        }else if ([getDevice.type isEqualToString:@"storage"]){
            
            cell.electric.text =[NSString stringWithFormat:@"%@%@",root_dianChi_baifenBi,getDevice.dayPower];
               cell.power.text =@"";
              cell.electric.frame=CGRectMake(55*HEIGHT_SIZE+10*NOW_SIZE, 40*HEIGHT_SIZE, 180*NOW_SIZE, 20*HEIGHT_SIZE);
            
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
                  cell.stateValue.textColor=MainColor;
            }else if ([getDevice.statueData isEqualToString:@"-1"]){
                cell.stateValue.text =root_duanKai ;
                cell.stateValue.textColor=COLOR(163, 163, 163, 1);
            }else if ([getDevice.statueData isEqualToString:@"20"]){
                cell.stateValue.text =root_duanKai ;
                cell.stateValue.textColor=COLOR(163, 163, 163, 1);
            }else{
                cell.stateValue.text =root_Device_head_186 ;
                cell.stateValue.textColor=COLOR(121, 230, 129, 1);
            }

           

        }else if ([getDevice.type isEqualToString:@"mix"]){
            
            cell.electric.text =[NSString stringWithFormat:@"%@%@",root_dianChi_baifenBi,getDevice.dayPower];
            cell.power.text =@"";
                 cell.electric.frame=CGRectMake(55*HEIGHT_SIZE+10*NOW_SIZE, 40*HEIGHT_SIZE, 180*NOW_SIZE, 20*HEIGHT_SIZE);
            
            if ([getDevice.statueData isEqualToString:@"0"]){          //20 掉线
                cell.stateValue.text =root_dengDai;
                cell.stateValue.textColor=MainColor;
            }else if ([getDevice.statueData isEqualToString:@"1"]){
                cell.stateValue.text =root_MIX_202;
                cell.stateValue.textColor=COLOR(45, 226, 233, 1);
            }else if ([getDevice.statueData isEqualToString:@"3"]){
                cell.stateValue.text =root_cuoWu ;
                cell.stateValue.textColor=COLOR(255, 86, 82, 1);
            }else if ([getDevice.statueData isEqualToString:@"4"]){
                cell.stateValue.text =root_MIX_226 ;
                cell.stateValue.textColor=COLOR(222, 211, 91, 1);
            }else if ([getDevice.statueData isEqualToString:@"5"] || [getDevice.statueData isEqualToString:@"6"] || [getDevice.statueData isEqualToString:@"7"] || [getDevice.statueData isEqualToString:@"8"]){
                cell.stateValue.text =root_zhengChang ;
                cell.stateValue.textColor=COLOR(121, 230, 129, 1);
            }else if ([getDevice.statueData isEqualToString:@"20"]){
                cell.stateValue.text =root_duanKai ;
                cell.stateValue.textColor=COLOR(163, 163, 163, 1);
            }else{
                cell.stateValue.text =root_duanKai ;
                cell.stateValue.textColor=COLOR(163, 163, 163, 1);
            }
            
        }
        
        
            cell.titleLabel.text = getDevice.name;
        cell.titleLabel.textColor = MainColor;
       


   
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



-(void)getPVheadData:(NSDictionary*)content{
    _pvHeadDataArray=[NSMutableArray new];
    _pvHeadDataUnitArray=[NSMutableArray new];
    
    _pvHeadNameArray=[NSMutableArray arrayWithObjects:root_PpvN,root_todayPV,root_Revenue,nil];
   
    if ([content.allKeys containsObject:@"todayEnergy"]) {
        NSArray *energyHArray=@[content[@"todayEnergy"],content[@"totalEnergy"]];
        NSArray *powerHArray;
        if ([content.allKeys containsObject:@"nominal_Power"]) {
           powerHArray=@[content[@"invTodayPpv"],content[@"nominal_Power"]];
        }else{
              powerHArray=@[content[@"invTodayPpv"],content[@"nominalPower"]];
        }
        
        
        for (int i=0; i<powerHArray.count; i++) {
            [self getNewPvDataW:[NSString stringWithFormat:@"%@",powerHArray[i]]];
        }
        
        for (int i=0; i<energyHArray.count; i++) {
            [self getNewPvDataWh:[NSString stringWithFormat:@"%@",energyHArray[i]]];
        }
        
        NSArray *moneyArray=@[content[@"plantMoneyText"],content[@"totalMoneyText"]];
        NSString *moneyUnit=@"";
        for (int i=0; i<moneyArray.count; i++) {
            NSString *headMoney=[NSString stringWithFormat:@"%@",moneyArray[i]];
            if ([headMoney containsString:@"/"]) {
                NSArray *headA=[headMoney componentsSeparatedByString:@"/"];
                [_pvHeadDataArray addObject:[headA objectAtIndex:0]];
                [_pvHeadDataUnitArray addObject:[headA objectAtIndex:1]];
                moneyUnit=[headA objectAtIndex:1];
            }else{
                [_pvHeadDataArray addObject:moneyArray[i]];
                [_pvHeadDataUnitArray addObject:moneyUnit];
            }
        }
        
    }else{
        _pvHeadDataArray=[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",nil];
        _pvHeadDataUnitArray=[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", nil];
    
    }

 
    
}




-(void)getNewPvDataW:(NSString*)data{
    
    if ( [data intValue]>1000 &&[data intValue]<1000000) {
        float KW=(float)[data intValue]/1000;
        [_pvHeadDataUnitArray addObject:@"kW"];
        [_pvHeadDataArray addObject:[NSString stringWithFormat:@"%.1f",KW]];
    }else if([data intValue]>1000000){
        float MW=(float)[data intValue]/1000000;
        [_pvHeadDataUnitArray addObject:@"MW"];
        [_pvHeadDataArray addObject:[NSString stringWithFormat:@"%.1f",MW]];
    }else{
        [_pvHeadDataUnitArray addObject:@"W"];
        [_pvHeadDataArray addObject:data];
    }
}


-(void)getNewPvDataWh:(NSString*)data{
    if ( [data intValue]>1000) {
        float KW=(float)[data intValue]/1000;
          [_pvHeadDataUnitArray addObject:@"MWh"];
        [_pvHeadDataArray addObject:[NSString stringWithFormat:@"%.1f",KW]];
    }else{
        [_pvHeadDataUnitArray addObject:@"kWh"];
        [_pvHeadDataArray addObject:data];
    }
    
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
