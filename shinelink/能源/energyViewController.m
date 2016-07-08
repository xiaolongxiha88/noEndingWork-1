//
//  energyViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "energyViewController.h"
#import "energyTableViewCell.h"
#import "engrgySencondViewController.h"
#import "homeDeviceViewController.h"
#import "EquitGraph2ViewController.h"
#import "EquipGraphViewController.h"

@interface energyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) EquitGraph2ViewController  *home;
@property (nonatomic, strong) EquitGraph2ViewController  *PvHome;
@end

@implementation energyViewController
{
 NSString *_indenty;
    NSMutableArray* imageArray;
    NSMutableArray *nameArray;
    NSMutableArray *monthArray;
    NSMutableArray *dayArray;
    NSMutableArray *monthDateArray;
    NSMutableArray *dayDateArray;

}

-(void)viewWillAppear:(BOOL)animated{

       [self netEnergy];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:COLOR(17, 183, 243, 1)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName :[UIColor whiteColor]
                                                                      }];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self setTitle:root_energy];
    
  
    
       nameArray=[[NSMutableArray alloc]initWithObjects:root_energy_guangfu_dianliang,root_energy_chuneng_dianliang,root_energy_jiating_yongdian,root_energy_jiating_shebei, nil];
    

    
        monthArray=[[NSMutableArray alloc]initWithObjects:root_energy_chuneng_yue,root_energy_chuneng_yue,root_energy_chuneng_yue,root_energy_chuneng_zuishengdian,nil];
    
   
    monthDateArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",nil];
    dayDateArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",nil];
    
    dayArray=[[NSMutableArray alloc]initWithObjects:root_energy_chuneng_ri,root_energy_chuneng_ri,root_energy_chuneng_ri,root_energy_chuneng_zuihaodian, nil];
 imageArray=[[NSMutableArray alloc]initWithObjects:@"solar4.png",@"storage4.png",@"家庭用电量.png",@"家庭用电设备.png", nil];
    

    // Do any additional setup after loading the view.
    [self _createTableView];
 
}

-(void)netEnergy{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *plantID=[ud objectForKey:@"plantID"];
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"plantId":plantID} paramarsSite:@"/newEnergyAPI.do?op=getEnergyList" sucessBlock:^(id content) {
        
        NSLog(@"getEnergyList: %@", content);
        if (content) {
            NSString *A1=[NSString stringWithFormat:@"%@%@",monthArray[2],content[@"familyEnergy"][@"monthEnergy"]];
            NSString *A2=[NSString stringWithFormat:@"%@%@",monthArray[3],content[@"familyDevice"][@"mostEnergy"]];
             NSString *A3=[NSString stringWithFormat:@"%@%@",monthArray[0],content[@"photovoltaicEnergy"][@"monthEnergy"]];
             NSString *A4=[NSString stringWithFormat:@"%@%@",monthArray[1],content[@"storageEnergy"][@"monthEnergy"]];
            
            NSString *B1=[NSString stringWithFormat:@"%@%@",dayArray[2],content[@"familyEnergy"][@"todayEnergy"]];
            NSString *B2=[NSString stringWithFormat:@"%@%@",dayArray[3],content[@"familyDevice"][@"mostPower"]];
            NSString *B3=[NSString stringWithFormat:@"%@%@",dayArray[0],content[@"photovoltaicEnergy"][@"todayEnergy"]];
            NSString *B4=[NSString stringWithFormat:@"%@%@",dayArray[1],content[@"storageEnergy"][@"todayEnergy"]];
            
            [monthDateArray replaceObjectAtIndex:0 withObject:A3];
            [monthDateArray replaceObjectAtIndex:1 withObject:A4];
            [monthDateArray replaceObjectAtIndex:2 withObject:A1];
            [monthDateArray replaceObjectAtIndex:3 withObject:A2];
            
            [dayDateArray replaceObjectAtIndex:0 withObject:B3];
            [dayDateArray replaceObjectAtIndex:1 withObject:B4];
            [dayDateArray replaceObjectAtIndex:2 withObject:B1];
            [dayDateArray replaceObjectAtIndex:3 withObject:B2];
            
            [_tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    

    

}

- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    _indenty = @"indenty";
    //注册单元格类型
    [_tableView registerClass:[energyTableViewCell class] forCellReuseIdentifier:_indenty];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return imageArray.count;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        
        energyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
        //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
        if (!cell) {
            cell=[[energyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
        }
        
        [cell.coverImageView  setImage:[UIImage imageNamed:imageArray[indexPath.row]]];
        cell.titleLabel.text = nameArray[indexPath.row];
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.stateValue.text = monthDateArray[indexPath.row];
        cell.electricValue.text =dayDateArray[indexPath.row];
            cell.state.text=monthArray[indexPath.row];
    cell.electric.text=dayArray[indexPath.row];
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==2){
        
        if (_PvHome) {
            [_PvHome removeFromParentViewController];
        }
        _home=[[EquitGraph2ViewController alloc]init];
     
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        NSString *plantID=[ud objectForKey:@"plantID"];
        _home.plantID=plantID;
        _home.titleString=root_energy_jiating_yongdian;
        _home.dicType=@"2";
        _home.dictInfo=@{@"equipId":plantID,
                        @"daySite":@"/newPlantDetailAPI.do?type=1",
                        @"monthSite":@"/newPlantDetailAPI.do?type=2",
                        @"yearSite":@"/newPlantDetailAPI.do?type=3",
                        @"allSite":@"/newPlantDetailAPI.do?type=4"};
        _home.hidesBottomBarWhenPushed=YES;
   [self.navigationController pushViewController:_home animated:YES];
        
    }
    
    
    if (indexPath.row==3) {
        homeDeviceViewController *home=[[homeDeviceViewController alloc]init];
        home.titleString=root_energy_jiating_shebei;
           home.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:home animated:YES];
        
    }
    
    if (indexPath.row==0) {
       _PvHome=[[EquitGraph2ViewController alloc]init];
   _PvHome.titleString=root_energy_guangfu_dianliang;
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        NSString *plantID=[ud objectForKey:@"plantID"];
        _PvHome.plantID=plantID;
        _PvHome.dicType=@"2";
        _PvHome.dictInfo=@{@"equipId":plantID,
                              @"daySite":@"/newPlantDetailAPI.do?type=1",
                              @"monthSite":@"/newPlantDetailAPI.do?type=2",
                              @"yearSite":@"/newPlantDetailAPI.do?type=3",
                              @"allSite":@"/newPlantDetailAPI.do?type=4"};
          _PvHome.hidesBottomBarWhenPushed=YES;
              [self.navigationController pushViewController:_PvHome animated:YES];
        
    }
    
    if (indexPath.row==1) {
        _PvHome=[[EquitGraph2ViewController alloc]init];
          _PvHome.titleString=root_energy_chuneng_dianliang;
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        NSString *plantID=[ud objectForKey:@"plantID"];
        _PvHome.plantID=plantID;
        _PvHome.dicType=@"3";
        _PvHome.dictInfo=@{@"equipId":plantID,
                           @"daySite":@"/newPlantDetailAPI.do?op=getStroageAllEnergy&type=1",
                           @"monthSite":@"/newPlantDetailAPI.do?op=getStroageAllEnergy&type=2",
                           @"yearSite":@"/newPlantDetailAPI.do?op=getStroageAllEnergy&type=3",
                           @"allSite":@"/newPlantDetailAPI.do?op=getStroageAllEnergy&type=4"};
         _PvHome.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:_PvHome animated:YES];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65*HEIGHT_SIZE;
    
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
