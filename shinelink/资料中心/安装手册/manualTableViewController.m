//
//  manualTableViewController.m
//  ShinePhone
//
//  Created by sky on 16/9/21.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "manualTableViewController.h"
#import "manualTableViewCell.h"
#import "HtmlCommon.h"

@interface manualTableViewController ()
@property(nonatomic,strong)NSMutableArray *idArray;
@property(nonatomic,strong)NSMutableArray *titleArray;
@end

@implementation manualTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor=COLOR(228, 235, 245, 1);
    _idArray=[NSMutableArray array];
    _titleArray=[NSMutableArray array];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getNet];
}


-(void)getNet{

    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSString *_languageValue ;
    
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        _languageValue=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }
    
    NSDictionary *dicGo=@{@"type":@"1",@"language":_languageValue} ;

[self showProgressView];
[BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:dicGo paramarsSite:@"/questionAPI.do?op=getUsQuestionListByType" sucessBlock:^(id content) {
    NSLog(@"getUsQuestionListByType: %@", content);
    [self hideProgressView];
    if (content) {
    
        NSMutableArray *allDic=[NSMutableArray arrayWithArray:content[@"obj"]];
        for (int i=0; i<allDic.count; i++) {
            [_idArray addObject:allDic[i][@"id"]];
            [_titleArray addObject:allDic[i][@"title"]];
        }
        
        if (_idArray.count==allDic.count) {
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
    
    return _titleArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    manualTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[manualTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.CellName.text=_titleArray[indexPath.row];
    
    NSString *LableNum=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
  cell.LableView.text=LableNum;
    
    return cell;
   
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    Common2ViewController *go=[[Common2ViewController alloc]init];
    //    go.titleString=_titleArray[indexPath.row];
    //    go.idString=_idArray[indexPath.row];
    
    HtmlCommon *go=[[HtmlCommon alloc]init];
    
    go.idString=_idArray[indexPath.row];
    
    [self.navigationController pushViewController:go animated:NO];
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120*HEIGHT_SIZE;
    
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
