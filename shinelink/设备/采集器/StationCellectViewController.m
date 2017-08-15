//
//  StationCellectViewController.m
//  ShinePhone
//
//  Created by ZML on 15/5/26.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "StationCellectViewController.h"
#import "EditCellectView.h"
#import "AddCellectViewController2.h"
#import "StationCellectTableViewCell.h"
#import "MJRefresh.h"
#import "ChangeCellectViewController.h"
#import "addDevice.h"
#import "DeviceManageViewController.h"
#import "MainViewController.h"
#import "AddDeviceViewController.h"
#import "ShinePhone-Swift.h"
#import "configWifiSViewController.h"


@interface StationCellectViewController ()<EditCellectViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)EditCellectView *editCellect;
@property(nonatomic,strong)NSMutableArray *arrayData;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSString *SetName;
@property(nonatomic)int page;
@property (nonatomic, strong) UIRefreshControl *control;
@property (nonatomic, strong)  UIImageView *AlertView ;
@property (nonatomic, strong)  NSString *languageValue ;
@property (nonatomic, strong)UIImageView *dirPic;

@end

@implementation StationCellectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = root_caiJiQi_leiBiao;
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_tianjia_1 style:UIBarButtonItemStylePlain target:self action:@selector(buttonPressed)];
    rightItem.tag=10;
    self.navigationItem.rightBarButtonItem=rightItem;
    _arrayData=[NSMutableArray new];
    _page=1;
    [self requestData];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.rightBarButtonItem=nil;
}

-(void)requestData{
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        _languageValue=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }
    
    [self showProgressView];
    NSString *page=[NSString stringWithFormat:@"%d",_page];
    if(_stationId==nil){
    _stationId=@"0";
    }
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"id":_stationId, @"currentPage":page} paramarsSite:@"/newDatalogAPI.do?op=datalogList" sucessBlock:^(id content) {
        [self hideProgressView];
       
        NSArray *noDataArray=[NSArray arrayWithArray:content];
        if (noDataArray.count==0) {
      //       _tableView.mj_footer.hidden=YES;
        }
        
            NSLog(@"datalogList:%@",content);
        [_arrayData addObjectsFromArray:content];
        
        if(_arrayData.count==0){
            
            if (!_AlertView) {
                if ([_languageValue isEqualToString:@"0"]) {
                    _AlertView=[[UIImageView alloc]initWithFrame:CGRectMake(0.1* SCREEN_Width, 100*HEIGHT_SIZE,0.8* SCREEN_Width, 0.294* SCREEN_Width)];
                    _AlertView.image=[UIImage imageNamed:@"Collectors_cn.png"];
                    [self.view addSubview:_AlertView];
                }else{
                    _AlertView=[[UIImageView alloc]initWithFrame:CGRectMake(0.1* SCREEN_Width, 100*HEIGHT_SIZE,0.8* SCREEN_Width, 0.294* SCREEN_Width)];
                    _AlertView.image=[UIImage imageNamed:@"Collectors_en.png"];
                    [self.view addSubview:_AlertView];
                }
            }
            
        }else{
            if (_AlertView) {
                [_AlertView removeFromSuperview];
                _AlertView=nil;
            }
        }
        
        if (_tableView) {
            [_tableView reloadData];
        }else{
            [self initUI];
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
        [self showToastViewWithTitle:root_Networking];
    }];
}

-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - 114) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
 
  //  __unsafe_unretained StationCellectViewController *myself = self;
//        [myself.tableView addLegendFooterWithRefreshingBlock:^{
//          
//           // addLegendFooterWithRefreshingBlock
//            myself->_page++;
//            [myself requestData];
//           
//            [myself->_tableView.mj_footer endRefreshing];
//            
//            
//        }];
    
           if (_arrayData.count>1) {
        
              
               
//        self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//                           _page++;
//                        [self requestData];
//            
//                        [_tableView.mj_footer endRefreshing];
//            
//       
//        }];
               
               MJRefreshAutoNormalFooter *foot=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                   _page++;
                   [self requestData];
                   
                   [_tableView.mj_footer endRefreshing];
                   
                   
               }];
               [foot setTitle:@"" forState:MJRefreshStateIdle];
               _tableView.mj_footer=foot;
               _tableView.mj_footer.automaticallyHidden=YES;
           
    }
    
    [self getDirPic];
    
}

-(void)getDirPic{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *adNum=[ud objectForKey:@"dirDataloggerNumber"];
    if ([_getDirNum integerValue]>[adNum integerValue]||(adNum==nil)) {
             [[NSUserDefaults standardUserDefaults] setObject:_getDirNum forKey:@"dirDataloggerNumber"];
        
        _dirPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width,SCREEN_Height)];
        _dirPic.userInteractionEnabled = YES;
          if ([_languageValue isEqualToString:@"0"]) {
        _dirPic.image = IMAGE(@"采集器_cn.jpg");
          }else{
          _dirPic.image = IMAGE(@"采集器_en.jpg");
          }
        [[UIApplication sharedApplication].keyWindow addSubview:_dirPic];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getNextPic)];
        [_dirPic addGestureRecognizer:tapGestureRecognizer];
    }
    
}

-(void)getNextPic{
        [_dirPic removeFromSuperview];
}

-(void)refreshStateChange:(UIRefreshControl *)control{
    
    _page++;
    [self requestData];
    
}


#pragma mark - EditCellectViewDelegate
- (void)menuDidSelectAtRow:(NSInteger)row {
    if (row==0) {
        //取消菜单
        [_editCellect removeFromSuperview];
        return;
    }
    
    
    if (row==4) {
        [_editCellect removeFromSuperview];
        
        _SetName=_arrayData[_indexPath.row][@"device_type"];
        NSString *demoName1=@"ShineWIFI";           //新wifi
        NSString *demoName2=@"ShineLan";            //旧wifi
        NSString *demoName3=@"ShineWifiBox";          //旧wifi
        NSString *demoName5=@"ShineLanBox";
          NSString *demoName4=@"ShineWIFI-S";          //wifi-S
        
       //_SetName=@"ShineWIFI-S";
        
        BOOL result1 = [_SetName compare:demoName1 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
        BOOL result2 = [_SetName compare:demoName2 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
        BOOL result3 = [_SetName compare:demoName3 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
          BOOL result5 = [_SetName compare:demoName5 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
          BOOL result4 = [_SetName compare:demoName4 options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame;
        
        if (result1) {
            AddDeviceViewController *rootView = [[AddDeviceViewController alloc]init];
            rootView.SnString=_arrayData[_indexPath.row][@"datalog_sn"];
            rootView.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:rootView animated:YES];
        }else if (result2){
            MainViewController *rootView = [[MainViewController alloc]init];
            [self.navigationController pushViewController:rootView animated:YES];
            
        }else if (result3){
            MainViewController *rootView = [[MainViewController alloc]init];
            [self.navigationController pushViewController:rootView animated:YES];
            
        }else if (result4){
            configWifiSViewController *rootView = [[configWifiSViewController alloc]init];
            rootView.SnString=_arrayData[_indexPath.row][@"datalog_sn"];
            rootView.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:rootView animated:YES];
        }else if(result5){
            
            RfStickSwift *rootView=[[RfStickSwift alloc]init];
             [self.navigationController pushViewController:rootView animated:YES];
        }
        
        
    }else{
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [_editCellect removeFromSuperview];
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }
    if (row==1) {
        [_editCellect removeFromSuperview];
         addDevice *addCellect=[[addDevice alloc]init];
        addCellect.stationId=_stationId;
        [self.navigationController pushViewController:addCellect animated:YES];
    }
    if (row==2) {
        [_editCellect removeFromSuperview];
        ChangeCellectViewController *change=[[ChangeCellectViewController alloc]init];
        change.datalogSN=_arrayData[_indexPath.row][@"datalog_sn"];
        change.alias=_arrayData[_indexPath.row][@"alias"];
        change.unitId=_arrayData[_indexPath.row][@"unit_id"];
        [self.navigationController pushViewController:change animated:YES];
    }
    if (row==3) {
        [_editCellect removeFromSuperview];
        
        
        [self showProgressView];
        [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"datalogSN":_arrayData[_indexPath.row][@"datalog_sn"]} paramarsSite:@"/newDatalogAPI.do?op=delDatalog" sucessBlock:^(id content) {
            [self hideProgressView];
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            if ([[jsonObj objectForKey:@"success"] integerValue] ==0) {
                [self showAlertViewWithTitle:nil message:root_shanchu_shibai  cancelButtonTitle:root_Yes];
            }else{
                [self showAlertViewWithTitle:nil message:root_shanChu_chengGong cancelButtonTitle:root_Yes];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            [self hideProgressView];
            [self showToastViewWithTitle:root_Networking];
        }];
    }
    
  }
   
    
    
}




#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"stationcellidentifier";
    StationCellectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[StationCellectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellDidLongPressed:)];
    longPressGesture.minimumPressDuration = 0.5f;
    [cell addGestureRecognizer:longPressGesture];
    
    [cell setData:_arrayData[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25*HEIGHT_SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1*HEIGHT_SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180*HEIGHT_SIZE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)buttonPressed{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
    }else{
        addDevice *addCellect=[[addDevice alloc]init];
        addCellect.stationId=_stationId;
        [self.navigationController pushViewController:addCellect animated:YES];
    }
}

- (void)cellDidLongPressed:(UIGestureRecognizer *)recognizer{
    if(recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:self.tableView];
        self.indexPath = [self.tableView indexPathForRowAtPoint:point];
        if(_indexPath == nil) return ;
        _editCellect = [[EditCellectView alloc] initWithFrame:self.view.bounds];
        _editCellect.delegate = self;
        _editCellect.tintColor = [UIColor blackColor];
        _editCellect.dynamic = NO;
        _editCellect.dataloggerType=_arrayData[_indexPath.row][@"device_type"];
        _editCellect.blurRadius = 10.0f;
        [[UIApplication sharedApplication].keyWindow addSubview:_editCellect];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    
//        __unsafe_unretained StationCellectViewController *myself = self;
//     [myself->_tableView.footer endRefreshing];
    
 

}

@end
