//
//  energyDemo.m
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "energyDemo.h"
#import "energyDemoCell.h"


@interface energyDemo ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *ImageArray;
@end

@implementation energyDemo

- (void)viewDidLoad {
    [super viewDidLoad];
//       self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.tableView.separatorColor=[UIColor whiteColor];
    
   self.dataArray =[NSMutableArray arrayWithObjects:root_energy_tiaodu_youxian,root_energy_liandong_shezhi,root_energy_dianjia_shezhi,root_energy_dongzuo_shineng,root_energy_kongzhi_youxian,root_energy_lingonglv_shineng,nil];
     self.ImageArray =[NSMutableArray arrayWithObjects:@"智能调整优先设置.png",@"智能联动设置切图.png",@"形状17.png",@"峰谷段动作使能切图.png",@"priority.png",@"enabler.png",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55*HEIGHT_SIZE;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    energyDemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indenty"];
    //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
    if (!cell) {
        cell=[[energyDemoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"indenty"];
    }
    
    [cell.imageLog setImage:[UIImage imageNamed: self.ImageArray [indexPath.row]]];
    cell.tableName.text = _dataArray[indexPath.row];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:root_energy_wenxin_tishi message:root_energy_houxun_kaifang delegate:self cancelButtonTitle:nil otherButtonTitles:root_OK, nil];
    [alert show];


}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
