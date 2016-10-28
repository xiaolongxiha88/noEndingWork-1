//
//  extensionListTableViewController.m
//  shinelink
//
//  Created by sky on 16/5/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "extensionListTableViewController.h"
#import "ExtensionTwoViewController.h"
#import "extensionTableViewCell.h"

@interface extensionListTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *idArray;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *imageNameArray;
@property(nonatomic,strong)NSString *languageValue;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation extensionListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
     
    
}


-(void)initUI{

    UIView *greenView=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 5*HEIGHT_SIZE, SCREEN_Width-20*NOW_SIZE, 40*HEIGHT_SIZE)];
    greenView.layer.cornerRadius= 5*HEIGHT_SIZE;
    greenView.layer.masksToBounds = YES;
    greenView.backgroundColor=COLOR(32, 213, 147, 1);
    [self.view addSubview:greenView];
    
    UIImageView *aletImage=[[UIImageView alloc] initWithFrame:CGRectMake(8*HEIGHT_SIZE, 12*HEIGHT_SIZE, 24*HEIGHT_SIZE, 16*HEIGHT_SIZE)];
    aletImage.image=IMAGE(@"增值问题33.png");
    [greenView addSubview:aletImage];
    
    UILabel *CellName = [[UILabel alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width-50*NOW_SIZE, 40*HEIGHT_SIZE)];
    CellName.font=[UIFont systemFontOfSize:17*HEIGHT_SIZE];
    CellName.textColor=[UIColor whiteColor];
    CellName.textAlignment = NSTextAlignmentLeft;
    CellName.text=root_ME_zengzhi;
    [greenView addSubview:CellName];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 50*HEIGHT_SIZE, SCREEN_Width, SCREEN_Height-90*HEIGHT_SIZE) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

       [self netCommon];
}



-(void)netCommon{
    
    _idArray=[NSMutableArray array];
    _titleArray=[NSMutableArray array];
    _imageNameArray=[NSMutableArray array];
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
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"language":_languageValue} paramarsSite:@"/newExtensionAPI.do?op=getExtensionList" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getExtensionList=: %@", content);
        
        if(content){
            NSMutableArray *allDic=[NSMutableArray arrayWithArray:content];
            for (int i=0; i<allDic.count; i++) {
                [_idArray addObject:allDic[i][@"id"]];
                [_titleArray addObject:allDic[i][@"title"]];
                // [_imageNameArray addObject:allDic[i][@"imageName"]];
            }
            
            if (allDic.count==_idArray.count) {
                  [self.tableView reloadData];
            }
          
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _idArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // static NSString *cellDentifier=@"cellDentifier";
    extensionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell==nil) {
        cell=[[extensionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
   // cell.textLabel.text=_titleArray[indexPath.row];
    
    cell.CellName.text=_titleArray[indexPath.row];
    NSString *LableNum=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    cell.LableView.text=LableNum;
    
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50*HEIGHT_SIZE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExtensionTwoViewController *go=[[ExtensionTwoViewController alloc]init];
    go.name2=_titleArray[indexPath.row];
    go.idString=_idArray[indexPath.row];
   // go.imageName=_imageNameArray[indexPath.row];
    
    [self.navigationController pushViewController:go animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
