//
//  toolOneView.m
//  ShinePhone
//
//  Created by sky on 2017/11/13.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "toolOneView.h"
#import "meConfigerViewController.h"
#import "payView1.h"
#import "useToWifiView1.h"

#import "MMScanViewController.h"
#import "useToWifiView1.h"

@interface toolOneView ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation toolOneView




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=MainColor;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorColor=[UIColor whiteColor];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
    self.dataArray =[NSMutableArray arrayWithObjects:root_ME_239,root_ME_240,@"流量续费",nil];
    }else{
     self.dataArray =[NSMutableArray arrayWithObjects:root_ME_239,root_ME_240,nil];
    }
    
    
  
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    

    
    
}



- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
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
    // static NSString *cellDentifier=@"cellDentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor=MainColor;
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.tintColor = [UIColor lightGrayColor];
    cell.textLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 50*HEIGHT_SIZE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row==0) {
        meConfigerViewController *rootView = [[meConfigerViewController alloc]init];
        rootView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:rootView animated:YES];
        
    }else if (indexPath.row==1){
        MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeAll onFinish:^(NSString *result, NSError *error) {
            if (error) {
                NSLog(@"error: %@",error);
            } else {
                
                useToWifiView1 *rootView = [[useToWifiView1 alloc]init];
                rootView.isShowScanResult=1;
                rootView.SN=result;
                [self.navigationController pushViewController:rootView animated:NO];
                
                NSLog(@"扫描结果：%@",result);
                
            }
        }];
        scanVc.titleString=root_scan_242;
        scanVc.scanBarType=1;
        [self.navigationController pushViewController:scanVc animated:YES];
        
//        usbToWifi00 *rootView = [[usbToWifi00 alloc]init];
//        [self.navigationController pushViewController:rootView animated:YES];
        
    }else if (indexPath.row==2){
        payView1 *rootView = [[payView1 alloc]init];
        [self.navigationController pushViewController:rootView animated:YES];
    }else if (indexPath.row==3){
  
    }
    
    
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
