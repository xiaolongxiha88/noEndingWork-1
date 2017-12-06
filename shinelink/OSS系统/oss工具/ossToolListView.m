//
//  ossToolListView.m
//  ShinePhone
//
//  Created by sky on 2017/12/6.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "ossToolListView.h"
#import "ossGetPassWordView.h"
#import "ShinePhone-Swift.h"
#import "usbToWifi00.h"

@interface ossToolListView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *nameArray;
@end

@implementation ossToolListView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


-(void)initUI{
    if (_typeNum==1) {
        _nameArray=@[@"设置本地调试工具密码",@"设置本地调试工具密码",@"查询采集器校验码"];
    }
    
    
    
    
    if (_typeNum==2) {
        _nameArray=@[@"设置本地调试工具密码",@"设置本地调试工具密码"];
    }
    
    

    
    
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0,ScreenWidth,SCREEN_Height-UI_NAVIGATION_BAR_HEIGHT-UI_STATUS_BAR_HEIGHT)];
        _tableView.contentSize=CGSizeMake(SCREEN_Width, 50000*HEIGHT_SIZE);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.tableView.separatorColor=COLOR(186, 186, 186, 1);
        [self.view addSubview:_tableView];
        
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _nameArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.text=[NSString stringWithFormat:@"%@",_nameArray[indexPath.row]];
    cell.textLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    cell.tintColor = COLOR(102, 102, 102, 1);
    cell.textLabel.textColor=COLOR(102, 102, 102, 1);
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //cell.accessoryView.backgroundColor=[UIColor whiteColor];
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        usbToWifi00 *go=[[usbToWifi00 alloc]init];
        [self.navigationController pushViewController:go animated:YES];
    }
   
    if (indexPath.row==1) {
        ossGetPassWordView *go=[[ossGetPassWordView alloc]init];
        [self.navigationController pushViewController:go animated:YES];
    }
    
    if (indexPath.row==2) {
        ossTool *go=[[ossTool alloc]init];
        [self.navigationController pushViewController:go animated:YES];
    }
    
}

// MARK: - 返回cell高度的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40*HEIGHT_SIZE;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
