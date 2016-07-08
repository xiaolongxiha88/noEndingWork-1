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

#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]

@interface deviceViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,EditStationMenuViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic,strong)EditStationMenuView  *editCellect;
@property (nonatomic, strong) UIAlertController *uploadImageActionSheet;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong) NSMutableArray *DemoPicName;
@property (nonatomic, strong) NSMutableArray *DemoPicName2;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netRequest) name:@"changeName" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
  [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBarTintColor:COLOR(17, 183, 243, 1)];
 
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



#pragma mark - CoreData
-(void)initDatacore{
   
    NSString *coreEnable=[UserInfo defaultUserInfo].coreDataEnable;
     // BOOL firstRun = !_manager.hasStore;
    
    if ([coreEnable isEqualToString:@"1"]){
        [self initDemoData];
        [[UserInfo defaultUserInfo] setCoreDataEnable:@"0"];
    }
    else{
        [self request];
    }
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
    _DemoPicName2=[[NSMutableArray alloc]initWithObjects:@"storageE.png", @"powerE.png", @"inverterE.png",@"chargeE.png",nil];
    _DemoPicName=[[NSMutableArray alloc]initWithObjects:@"storageD.png", @"powerD.png", @"inverterD.png",@"chargeD.png",nil];
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
        [self.navigationController pushViewController:goLog animated:NO];
    }];
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1] icon:@"add@2x.png"];
    
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
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:_plantId paramarsSite:@"/newPlantAPI.do?op=getAllDeviceList" sucessBlock:^(id content) {
        [self hideProgressView];
         NSLog(@"getAllDeviceList:%@",content);
        _typeArr=[NSMutableArray array];
        nameArray=[NSMutableArray array];
        statueArray=[NSMutableArray array];
        dayArray=[NSMutableArray array];
        imageArray=[NSMutableArray array];
        powerArray=[NSMutableArray array];
        SNArray=[NSMutableArray array];
        imageStatueArray=[NSMutableArray array];
        
        [_control endRefreshing];
        
       // id jsonObj=[NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
         self.dataArr = [NSMutableArray arrayWithArray:content[@"deviceList"]];
        for (int i=0; i<_dataArr.count; i++) {
//            [_typeArr addObject:content[@"deviceList"][i][@"deviceType"]];
//            [SNArray addObject:content[@"deviceList"][i][@"deviceSn"]];
//            if ([content[@"deviceList"][i][@"deviceAilas"]isEqualToString:@""]) {
//                [nameArray addObject:content[@"deviceList"][i][@"deviceType"]];
//            }else{
//                [nameArray addObject:content[@"deviceList"][i][@"deviceAilas"]];}
//           
//            NSString *TO=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"energy"]];
//            [totalPowerArray addObject:TO];
//            
//         NSString *ST0=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"lost"]];
//            if ([ST0 isEqualToString:@"1"]) {
//                      [statueArray addObject:@"6"];
//            }else{
//            
//        NSString *ST=[NSString stringWithFormat:@"%@",content[@"deviceList"][i][@"deviceStatus"]];
//             [statueArray addObject:ST];
//            }
//            NSString *SD;
//            if([ST isEqualToString:@"-1"])
//            {SD=@"未连接";
            
//            else{SD=@"已连接";[imageStatueArray addObject:@"connected@2x.png"];}
            
             [imageStatueArray addObject:@"disconnect@2x.png"];
           
            if ([content[@"deviceList"][i][@"deviceType"]isEqualToString:@"inverter"]) {
                 [imageArray addObject:@"inverter2.png"];
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

    //NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
   // _plantId=[ud objectForKey:@"plantID"];
    
    [self netRequest];
    
}

- (void)_createHeaderView {
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,200*HEIGHT_SIZE)];
    _tableView.tableHeaderView = _headerView;
   
    float headHeight=_headerView.bounds.size.height;
    _headPicName=@"head.png";
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,Kwidth,headHeight)];
    imageView.image = [UIImage imageNamed:_headPicName];
    [_headerView addSubview:imageView];

   
    UILabel *Lable1=[[UILabel alloc]initWithFrame:CGRectMake((Kwidth-60*NOW_SIZE)/2, 40*HEIGHT_SIZE, 60*NOW_SIZE,20*HEIGHT_SIZE )];
  
    
    Lable1.text=_head11;
    //Lable1.numberOfLines=0;
    Lable1.textAlignment=NSTextAlignmentCenter;
    Lable1.textColor=[UIColor whiteColor];
    Lable1.font = [UIFont systemFontOfSize:15*HEIGHT_SIZE];
    [_headerView addSubview:Lable1];
    
   
    UILabel *Lable2=[[UILabel alloc]initWithFrame:CGRectMake((Kwidth-60*NOW_SIZE)/2, 58*HEIGHT_SIZE, 60*NOW_SIZE,20*HEIGHT_SIZE )];
    Lable2.text=_head12;
    Lable2.textAlignment=NSTextAlignmentCenter;
    Lable2.textColor=[UIColor whiteColor];
    Lable2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_headerView addSubview:Lable2];
    
    
    UILabel *Lable12=[[UILabel alloc]initWithFrame:CGRectMake((Kwidth-80*NOW_SIZE)/2, 78*HEIGHT_SIZE, 80*NOW_SIZE,25*HEIGHT_SIZE )];
    Lable12.text=_head13;
    Lable12.textAlignment=NSTextAlignmentCenter;
    Lable12.textColor=[UIColor whiteColor];
    Lable12.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_headerView addSubview:Lable12];

    UILabel *Lable7=[[UILabel alloc]initWithFrame:CGRectMake(30*NOW_SIZE, 120*HEIGHT_SIZE, 60*NOW_SIZE,20*HEIGHT_SIZE )];
   
   // _head21=@"1999.99999";
   
    
     Lable7.text=_head21;
    Lable7.textAlignment=NSTextAlignmentCenter;
    Lable7.textColor=[UIColor whiteColor];
    Lable7.font = [UIFont systemFontOfSize:15*HEIGHT_SIZE];
    [_headerView addSubview:Lable7];
    
    UILabel *Lable9=[[UILabel alloc]initWithFrame:CGRectMake(30*NOW_SIZE, 138*HEIGHT_SIZE, 60*NOW_SIZE,20*HEIGHT_SIZE )];
    Lable9.text=_head22;
    Lable9.textAlignment=NSTextAlignmentCenter;
    Lable9.textColor=[UIColor whiteColor];
    Lable9.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_headerView addSubview:Lable9];
    
    UILabel *Lable79=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 160*HEIGHT_SIZE, 90*NOW_SIZE,25*HEIGHT_SIZE )];
    Lable79.text=_head23;
    Lable79.textAlignment=NSTextAlignmentCenter;
    Lable79.textColor=[UIColor whiteColor];
    Lable79.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_headerView addSubview:Lable79];
    
    //_headGet=@"3000";
    UILabel *Lable8=[[UILabel alloc]initWithFrame:CGRectMake(230*NOW_SIZE, 120*HEIGHT_SIZE, 60*NOW_SIZE,20*HEIGHT_SIZE )];
  
   
      Lable8.text=_head31;
    Lable8.textAlignment=NSTextAlignmentCenter;
    Lable8.textColor=[UIColor whiteColor];
    Lable8.font = [UIFont systemFontOfSize:15*HEIGHT_SIZE];
    [_headerView addSubview:Lable8];
    
    UILabel *Lable10=[[UILabel alloc]initWithFrame:CGRectMake(230*NOW_SIZE, 138*HEIGHT_SIZE, 60*NOW_SIZE,20*HEIGHT_SIZE )];
    Lable10.text=_head32;
    Lable10.textAlignment=NSTextAlignmentCenter;
    Lable10.textColor=[UIColor whiteColor];
    Lable10.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_headerView addSubview:Lable10];
    
    UILabel *Lable108=[[UILabel alloc]initWithFrame:CGRectMake(220*NOW_SIZE, 160*HEIGHT_SIZE, 80*NOW_SIZE,25*HEIGHT_SIZE )];
    Lable108.text=_head33;
    Lable108.textAlignment=NSTextAlignmentCenter;
    Lable108.textColor=[UIColor whiteColor];
    Lable108.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_headerView addSubview:Lable108];
    
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
    
    [dict setObject:get.deviceSN forKey:@"inverterId"];
    
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
       if([demoDevice.type isEqualToString:@"inverter"]){
           
            DemoDeviceViewController *sd=[[DemoDeviceViewController alloc ]init];
            sd.hidesBottomBarWhenPushed=YES;
           sd.picName=_DemoPicName[2];
           sd.picName2=_DemoPicName2[2];
           sd.title=@"inverter(Demo)";
            [self.navigationController pushViewController:sd animated:NO];}
        else if([demoDevice.type  isEqualToString:@"storage"]){
            DemoDeviceViewController *sd=[[DemoDeviceViewController alloc ]init];
            sd.hidesBottomBarWhenPushed=YES;
            sd.picName=_DemoPicName[0];
              sd.picName2=_DemoPicName2[0];
               sd.title=@"storage(Demo)";
            [self.navigationController pushViewController:sd animated:NO];}
        else if([demoDevice.type  isEqualToString:@"charge"]){
            DemoDeviceViewController *sd=[[DemoDeviceViewController alloc ]init];
            sd.hidesBottomBarWhenPushed=YES;
            sd.picName=_DemoPicName[3];
              sd.picName2=_DemoPicName2[3];
              sd.title=@"charge(Demo)";
            [self.navigationController pushViewController:sd animated:NO];}
        else if([demoDevice.type  isEqualToString:@"powerRegulator"]){
            DemoDeviceViewController *sd=[[DemoDeviceViewController alloc ]init];
            sd.hidesBottomBarWhenPushed=YES;
            sd.picName=_DemoPicName[1];
              sd.picName2=_DemoPicName2[1];
            sd.title=@"powerRegulator(Demo)";
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
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
