//
//  PvLogTableViewController.m
//  shinelink
//
//  Created by sky on 16/3/31.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "PvLogTableViewController.h"
#import "pvLogTableViewCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0

@interface PvLogTableViewController ()
@property(nonatomic,strong)NSMutableArray *SNTextArray;
@property(nonatomic,strong)NSMutableArray *typtTextArray;
@property(nonatomic,strong)NSMutableArray *eventTextArray;
@property(nonatomic,strong)NSMutableArray *LogTextArray;
@property(nonatomic,strong)NSMutableArray *contentTextArray;
@property(nonatomic,strong)NSMutableArray *timeTextArray;

@end

@implementation PvLogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   
    self.tableView.separatorColor=[UIColor grayColor];
    [self netLog];

    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
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


-(void)netLog{
      self.SNTextArray=[NSMutableArray array];
     self.typtTextArray=[NSMutableArray array];
     self.eventTextArray=[NSMutableArray array];
    self.LogTextArray =[NSMutableArray array];
    self.contentTextArray=[NSMutableArray array];
        self.timeTextArray=[NSMutableArray array];
    
//_PvSn=@"SAMP524004";
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{_type:_PvSn,@"pageNum":@"1", @"pageSize":@"20"} paramarsSite:_address sucessBlock:^(id content) {
        [self hideProgressView];
            NSLog(@"getInverterAlarm: %@", content);
        if (content) {
          
             NSMutableArray *allArray=[NSMutableArray arrayWithArray:content];
            for(int i=0;i<allArray.count;i++){
                
                NSString *SN=[NSString stringWithFormat:@"%@",content[i][@"deviceSerialNum"]];
                NSString *TY=[NSString stringWithFormat:@"%@",content[i][@"deviceType"]];
                NSString *EV=[NSString stringWithFormat:@"%@",content[i][@"eventId"]];
                 NSString *LOG=[NSString stringWithFormat:@"%@",content[i][@"eventName"]];
                NSString *time=[NSString stringWithFormat:@"%@",content[i][@"occurTime"]];
                NSString *CO=[NSString stringWithFormat:@"%@",content[i][@"eventName"]];
                [self.SNTextArray addObject:SN];
                [self.typtTextArray addObject:TY];
                [self.eventTextArray addObject:EV];
                [self.LogTextArray addObject:LOG];
                [self.contentTextArray addObject:CO];
                 [self.timeTextArray addObject:time];
                
                [self.tableView reloadData];
            }

        }
    } failure:^(NSError *error) {
        [self hideProgressView];
     
    }];

}
- (void)showProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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

    
    return _SNTextArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGRect fcRect = [self.contentTextArray[indexPath.row] boundingRectWithSize:CGSizeMake(300*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 *Width]} context:nil];
    return 125*HEIGHT_SIZE+fcRect.size.height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    pvLogTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[pvLogTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.SNText.text=_SNTextArray[indexPath.row];
      cell.typtText.text=_typtTextArray[indexPath.row];
      cell.eventText.text=_eventTextArray[indexPath.row];
      cell.LogText.text=_LogTextArray[indexPath.row];
    cell.timeLabel.text=self.timeTextArray[indexPath.row];
    cell.contentLabel.text=self.contentTextArray[indexPath.row];
    cell.content=self.contentTextArray[indexPath.row];
   
    
    CGRect fcRect = [cell.content boundingRectWithSize:CGSizeMake(300*Width, 1000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 *Width]} context:nil];
    cell.contentLabel.frame =CGRectMake(10*Width, 65*Width, 300*Width, fcRect.size.height);
    cell.timeLabel.frame=CGRectMake(SCREEN_WIDTH-210*NOW_SIZE, 105*HEIGHT_SIZE+fcRect.size.height,200*NOW_SIZE, 20*HEIGHT_SIZE );
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
