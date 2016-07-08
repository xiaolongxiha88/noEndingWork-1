//
//  ManagementController.m
//  shinelink
//
//  Created by sky on 16/4/21.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ManagementController.h"
#import "loginViewController.h"
#import "changManeger.h"
#import "JPUSHService.h"
#import "CoreDataManager.h"


@interface ManagementController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArray1;
@property (nonatomic, strong) CoreDataManager *manager;

@end

@implementation ManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor=MainColor;
    
     _manager=[CoreDataManager sharedCoreDataManager];
    [self initUI];
 
}

-(void)initUI{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *tel=[ud objectForKey:@"TelNumber"];
    NSString *email=[ud objectForKey:@"email"];
      NSString *agent=[ud objectForKey:@"agentCode"];
    
    self.dataArray1=[NSMutableArray array];
    [self.dataArray1 addObject:@""];
    [self.dataArray1 addObject:tel];
    [self.dataArray1 addObject:email];
     [self.dataArray1 addObject:agent];
    self.dataArray =[NSMutableArray arrayWithObjects:root_WO_xiugai_mima,root_WO_xiugai_shoujihao,root_WO_xiugai_youxiang,root_WO_xiugai_dailishang,nil];
   // self.dataArray1 =[NSMutableArray arrayWithObjects:@"",@"18666666666",@"328657662@qq.com",nil];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240*HEIGHT_SIZE)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    self.tableView.backgroundColor=MainColor;
       self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
      self.tableView.separatorColor=[UIColor whiteColor];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:_tableView];
    
    UIButton *registerUser =  [UIButton buttonWithType:UIButtonTypeCustom];
    registerUser.frame=CGRectMake((SCREEN_Width-150*NOW_SIZE)/2,320*HEIGHT_SIZE, 150*NOW_SIZE, 40*HEIGHT_SIZE);
    [registerUser.layer setMasksToBounds:YES];
    [registerUser.layer setCornerRadius:20.0*HEIGHT_SIZE];
    registerUser.backgroundColor = COLOR(98, 226, 149, 1);
     registerUser.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [registerUser setTitle:root_WO_zhuxiao_zhanhao forState:UIControlStateNormal];
    //[goBut setTintColor:[UIColor colorWithRed:130/ 255.0f green:200 / 255.0f blue:250 / 255.0f alpha:1]];
    [registerUser setTitleColor: [UIColor whiteColor]forState:UIControlStateNormal];
    [registerUser addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    //  goBut.highlighted=[UIColor grayColor];
    [self.view addSubview:registerUser];
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






- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

-(void)registerUser{
    [[UserInfo defaultUserInfo] setUserPassword:nil];
    [[UserInfo defaultUserInfo] setUserName:nil];
      [[UserInfo defaultUserInfo] setServer:nil];
    loginViewController *login =[[loginViewController alloc]init];
    
    [self initCoredata];
    
    [self setAlias];
    self.hidesBottomBarWhenPushed=YES;
    [login.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:login animated:YES];
    
}

-(void)setAlias{
    
    NSString *Alias=@"none";
    [JPUSHService setTags:nil alias:Alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
        NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellDentifier=@"cellDentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellDentifier"];
    }
     cell.backgroundColor=MainColor;
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.text=_dataArray1[indexPath.row];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
     cell.textLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
     cell.detailTextLabel.font=[UIFont systemFontOfSize: 12*HEIGHT_SIZE];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 50*HEIGHT_SIZE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     changManeger *go=[[changManeger alloc]init];
    if (indexPath.row==0) {
        go.type=@"0";
    }else if (indexPath.row==1){
        go.type=@"1";
    }else if (indexPath.row==2){
        go.type=@"2";
    }else if (indexPath.row==3){
        go.type=@"3";
    }
 
    [self.navigationController pushViewController:go animated:YES];
    
}

@end
