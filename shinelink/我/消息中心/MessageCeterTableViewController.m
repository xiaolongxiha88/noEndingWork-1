//
//  MessageCeterTableViewController.m
//  shinelink
//
//  Created by sky on 16/6/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "MessageCeterTableViewController.h"
#import "messgeSecondViewController.h"

@interface MessageCeterTableViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *timeArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableDictionary *messageDic;
@property (nonatomic, strong) UIAlertView *Alert1;

@end

@implementation MessageCeterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
//   self.titleArray =[NSMutableArray arrayWithObjects:@"第一111",@"第二222",@"第三333",nil];
//       self.timeArray =[NSMutableArray arrayWithObjects:@"第一111",@"第二222",@"第三333",nil];
//       self.contentArray =[NSMutableArray arrayWithObjects:@"123213123213123123",@"sdaasdasdadsasdasdasd",@"sssssssssssssssssssssss",nil];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }

    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_wo_qingkong_message style:UIBarButtonItemStylePlain target:self action:@selector(clearData)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    [self initData];
    
}

-(void)clearData{

    _Alert1 = [[UIAlertView alloc] initWithTitle:root_Alet_user message:root_wo_qingkong_lishi_shuju delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_OK, nil];
    
    [_Alert1 show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }else if (buttonIndex==1){
       
         NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        [userDefaultes setObject:nil forKey:@"MessageTitleArray"];
        [userDefaultes setObject:nil forKey:@"MessageTimeArray"];
        [userDefaultes setObject:nil forKey:@"MessageContentArray"];
    }
    [self.navigationController popViewControllerAnimated:NO];
}


-(void)initData{

 NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
      //[userDefaultes setObject:_messegeDic forKey:@"MessageDic"];
    
    _messageDic=[NSMutableDictionary dictionaryWithDictionary:[userDefaultes dictionaryForKey:@"MessageDic"]];
    _titleArray =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"MessageTitleArray"]];
   
    
    _timeArray =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"MessageTimeArray"]];

    
    _contentArray =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"MessageContentArray"]];
    
    if (_messageDic.count>2) {
        [_titleArray addObject:_messageDic[@"title"]];
        [_timeArray addObject:_messageDic[@"time"]];
        [_contentArray addObject:_messageDic[@"content"]];
        
        [userDefaultes setObject:_titleArray forKey:@"MessageTitleArray"];
        [userDefaultes setObject:_timeArray forKey:@"MessageTimeArray"];
        [userDefaultes setObject:_contentArray forKey:@"MessageContentArray"];
            [userDefaultes setObject:nil forKey:@"MessageDic"];
    }
    
   
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=_titleArray[indexPath.row];
    cell.detailTextLabel.text=_timeArray[indexPath.row];
    cell.detailTextLabel.textColor=COLOR(113, 113, 113, 1);
    cell.detailTextLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    cell.textLabel.textColor=COLOR(60, 60, 60, 1);
    return cell;
    
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50*HEIGHT_SIZE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    messgeSecondViewController *go=[[messgeSecondViewController alloc]init];
    go.titleString=_titleArray[indexPath.row];
    go.contentString=_contentArray[indexPath.row];
    
    [self.navigationController pushViewController:go animated:NO];
    
    
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
