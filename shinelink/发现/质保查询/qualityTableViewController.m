//
//  qualityTableViewController.m
//  shinelink
//
//  Created by sky on 16/4/7.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "qualityTableViewController.h"
#import "qualityCell.h"

@interface qualityTableViewController ()<UITableViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *dataDict;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSMutableArray *maturityTimeArray;
@property (nonatomic, strong) NSMutableArray *outTimeArray;
@property (nonatomic, strong) NSMutableArray *SNArray;
@property (nonatomic, strong) NSMutableArray *HasArray;
@property (nonatomic, strong) NSMutableArray *model;
@property (nonatomic, strong) NSMutableDictionary *PicDict;
@property (nonatomic, strong) NSString *picName;
@property (nonatomic, strong) NSString *picEnble;
@property (nonatomic, strong) NSMutableArray *picArray;
@end

@implementation qualityTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle=NO;
    //　self.view.tableView.separatorStyle = NO;
    [self initData];
}

-(void)initData{
    _typeArray=[NSMutableArray array];
    _maturityTimeArray=[NSMutableArray array];
    _outTimeArray=[NSMutableArray array];
    _SNArray=[NSMutableArray array];
        _HasArray=[NSMutableArray array];
      _model=[NSMutableArray array];
     _picArray=[NSMutableArray array];
    _PicDict=[NSMutableDictionary new];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *plantId=[ud objectForKey:@"plantID"];
      [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":plantId,@"pageNum":@"1", @"pageSize":@"20"} paramarsSite:@"/newQualityAPI.do?op=getQualityInformation" sucessBlock:^(id content) {
        [self hideProgressView];
      
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            NSArray *jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
               NSLog(@"getQualityInformation==%@", jsonObj);
            NSArray *allArray=[NSArray arrayWithArray:jsonObj];
            for (int i=0; i<allArray.count; i++) {
                [_typeArray addObject:allArray[i][@"deviceType"]];
                [_maturityTimeArray addObject:allArray[i][@"maturityTime"]];
                [_outTimeArray addObject:allArray[i][@"outTime"]];
                [_SNArray addObject:allArray[i][@"deviceSN"]];
                  [_model addObject:allArray[i][@"model"]];
                NSString *HAS=[NSString stringWithFormat:@"%@",allArray[i][@"isHas"]];
                [_HasArray addObject:HAS];
               //    [_picArray addObject:@""];
                

          }
            
                [self.tableView reloadData];
         [self getPic];
        _picEnble=@"1";
           
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
   
    }];
    
    
    
}

-(void)getPic{
  
   
    for (int i=0; i<_model.count; i++) {
     
      
            
            //_picEnble=@"0";
            _picName=_model[i];
            [self showProgressView];
            [BaseRequest requestImageWithMethodByGet:HEAD_URL paramars:@{@"model":_picName} paramarsSite:@"/newPlantAPI.do?op=getAdvertisingImages" sucessBlock:^(id content) {
                [self hideProgressView];
                
               // [_PicDict setObject:content forKey:_picName];
               [_picArray addObject:content];
                
                   //
                
                if (_picArray.count==_model.count) {
                   [self.tableView reloadData];
                    _picEnble=@"0";
                }
                
                
            } failure:^(NSError *error) {
                [self hideProgressView];
                
            }];

       [NSThread sleepForTimeInterval:0.2];
        
    }
    
    
    

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



-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10*HEIGHT_SIZE)];
    
    [headerView setBackgroundColor:[UIColor redColor]];
    
    return headerView;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _SNArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 108*HEIGHT_SIZE;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    qualityCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[qualityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.name.text=_typeArray[indexPath.row];
    if ([_HasArray[indexPath.row] isEqualToString:@"1"]) {
          cell.alia.text=root_ME_you;
    }else{
     cell.alia.text=root_ME_meiyou;
    }
    cell.SN.text=_SNArray[indexPath.row];
     cell.beginTime.text=_outTimeArray[indexPath.row];
     cell.overTime.text=_maturityTimeArray[indexPath.row];
    if (_picArray.count>0) {
          [cell.typeImageView setImage:_picArray[indexPath.row]];
    }

    // Configure the cell...
    
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
