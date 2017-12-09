//
//  kongZhiNi0.m
//  shinelink
//
//  Created by sky on 16/4/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "kongZhiNi0.h"
#import "KongZhiNi.h"
#import "RKAlertView.h"
#import "MaxControl.h"

#define AlertContent @"Growatt"

@interface kongZhiNi0 ()
@property (nonatomic, strong) NSString *password;
@end

@implementation kongZhiNi0

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=MainColor;
  //  UIImage *bgImage = IMAGE(@"bg4.png");
  //  self.view.layer.contents = (id)bgImage.CGImage;
       self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.separatorColor=[UIColor whiteColor];
    
       [self getPassword];
    
    
      self.dataArray =[NSMutableArray arrayWithObjects:root_NBQ_kaiguan,root_NBQ_youxiao_gonglv,root_NBQ_wuxiao_gonglv,root_NBQ_PF,root_NBQ_shijian,root_NBQ_shidian_dianya,root_shezhi_shidian_dianya_xiaxian,nil];
    if ([_controlType isEqualToString:@"2"]) {
        [_dataArray addObject:@"高级设置"];
    }
    
    if ([_invType isEqualToString:@"1"]) {
         self.dataArray =[NSMutableArray arrayWithObjects:root_NBQ_kaiguan,nil];
    }
    
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    //self.tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
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
    cell.textLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
       cell.tintColor = [UIColor whiteColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //cell.accessoryView.backgroundColor=[UIColor whiteColor];
 
  
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    return 50*HEIGHT_SIZE;
    
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }
    
    if ([_invType isEqualToString:@"1"]) {
        MaxControl *go=[[MaxControl alloc]init];
        go.PvSn=_PvSn;
        go.type=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        [RKAlertView showAlertPlainTextWithTitle:root_Alet_user message:root_kongzhi_Alert cancelTitle:root_cancel confirmTitle:root_OK alertViewStyle:UIAlertViewStylePlainTextInput confrimBlock:^(UIAlertView *alertView) {
            NSLog(@"确认了输入：%@",[alertView textFieldAtIndex:0].text);
            NSString *alert1=[alertView textFieldAtIndex:0].text;
            
            if ([alert1 isEqualToString:_password]) {
                [self.navigationController pushViewController:go animated:YES];
            }else{
                [RKAlertView showNoCancelBtnAlertWithTitle:root_Alet_user message:root_kongzhi_mima confirmTitle:root_OK confrimBlock:^{
                    
                }];
                
            }
            
        } cancelBlock:^{
            NSLog(@"取消了");
        }];
    }else{
        KongZhiNi *go=[[KongZhiNi alloc]init];
        go.PvSn=_PvSn;
        go.type=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        // [self.navigationController pushViewController:go animated:YES]; //DEMO
        
        if ([_controlType isEqualToString:@"2"]) {
            go.controlType=_controlType;
            [self.navigationController pushViewController:go animated:YES];
        }else{
            
        
                
                if ((indexPath.row==0)||(indexPath.row==1)||(indexPath.row==2)||(indexPath.row==3)||(indexPath.row==5)) {
                    
                    [RKAlertView showAlertPlainTextWithTitle:root_Alet_user message:root_kongzhi_Alert cancelTitle:root_cancel confirmTitle:root_OK alertViewStyle:UIAlertViewStylePlainTextInput confrimBlock:^(UIAlertView *alertView) {
                        NSLog(@"确认了输入：%@",[alertView textFieldAtIndex:0].text);
                        NSString *alert1=[alertView textFieldAtIndex:0].text;
                        
                        if ([alert1 isEqualToString:_password]) {
                            [self.navigationController pushViewController:go animated:YES];
                        }else{
                            [RKAlertView showNoCancelBtnAlertWithTitle:root_Alet_user message:root_kongzhi_mima confirmTitle:root_OK confrimBlock:^{
                                
                            }];
                            
                        }
                        
                    } cancelBlock:^{
                        NSLog(@"取消了");
                    }];
                    
                }else if ((indexPath.row==4)||(indexPath.row==5)||(indexPath.row==6)){
                    
                    [self.navigationController pushViewController:go animated:YES];
                }
                
            
        }
    }
  
    


}

-(void)getPassword{
    
    NSDateFormatter *dataFormatter= [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [dataFormatter stringFromDate:[NSDate date]];
    
    
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"type":@"1",@"stringTime":time} paramarsSite:@"/newLoginAPI.do?op=getSetPass" sucessBlock:^(id content) {
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"getUserServerUrl: %@", content1);
        if (content1 != [NSNull null]) {
            _password=content1[@"msg"];
            
            
        }
        
    } failure:^(NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有获取密码，请重新进入页面。" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alertView show];
        
    }];
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
