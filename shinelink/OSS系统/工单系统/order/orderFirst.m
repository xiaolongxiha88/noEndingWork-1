//
//  orderFirst.m
//  ShinePhone
//
//  Created by sky on 2017/6/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "orderFirst.h"
#import "orderCellOne.h"
#import "orderCellTwo.h"
#import "orderCellThree.h"


static NSString *cellOne = @"cellOne";
static NSString *cellTwo = @"cellTwo";
static NSString *cellThree = @"cellThree";

@interface orderFirst ()<UITableViewDataSource,UITableViewDelegate>{
    float H2;
    float H1;
    float allH;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *titleStatusArray;
@property(nonatomic,strong)NSMutableArray *isShowArray;


@property(nonatomic,strong)NSString *contentString;

@end

@implementation orderFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    H2=self.navigationController.navigationBar.frame.size.height;
    H1=[[UIApplication sharedApplication] statusBarFrame].size.height;
    allH=40*HEIGHT_SIZE;
    
    [self initData];
   
}

-(void)initData{
    _titleArray=[NSArray arrayWithObjects:@"待接收",@"服务中",@"已完成", nil];
    _isShowArray=[NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];

     [self initUI];
}

-(void)initUI{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0, SCREEN_Width,SCREEN_Height-allH-H2-H1 )];
        _tableView.delegate = self;
        _tableView.dataSource = self;
       // _tableView.tableHeaderView=_headView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            [self.tableView registerClass:[orderCellOne class] forCellReuseIdentifier:cellOne];
          [self.tableView registerClass:[orderCellTwo class] forCellReuseIdentifier:cellTwo];
         [self.tableView registerClass:[orderCellThree class] forCellReuseIdentifier:cellThree];
        [self.view addSubview:_tableView];
    }
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        orderCellOne *cell = [tableView dequeueReusableCellWithIdentifier:cellOne forIndexPath:indexPath];
        cell.titleLabel.text=_titleArray[indexPath.row];
        cell.titleString=_titleArray[indexPath.row];
        cell.contentString=@"jaidjsaida";
        [cell setShowMoreData:^(NSArray* dataArray){
            NSString *dataString=dataArray.firstObject;
            [_isShowArray setObject:dataString atIndexedSubscript:indexPath.row];
            
        }];
        
        [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
            NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
            [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
           return cell;
    }else if (indexPath.row==1) {
        orderCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:cellTwo forIndexPath:indexPath];
        cell.titleLabel.text=_titleArray[indexPath.row];
        cell.titleString=_titleArray[indexPath.row];
        cell.contentString=@"jaidjsaidaadasdsadddddddddddddddddasd";
        [cell setShowMoreData:^(NSArray* dataArray){
             NSString *dataString=dataArray.firstObject;
            [_isShowArray setObject:dataString atIndexedSubscript:indexPath.row];
            
        }];
        
        [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
            NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
            [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        return cell;
    }else if (indexPath.row==2) {
        orderCellThree *cell = [tableView dequeueReusableCellWithIdentifier:cellThree forIndexPath:indexPath];
        cell.titleLabel.text=_titleArray[indexPath.row];
        cell.titleString=_titleArray[indexPath.row];
        cell.contentString=@"jaidjsaida22222222222222222222222222222222";
        [cell setShowMoreData:^(NSArray* dataArray){
               NSString *dataString=dataArray.firstObject;
            [_isShowArray setObject:dataString atIndexedSubscript:indexPath.row];
            
        }];
        
        [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
            NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
            [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        return cell;
    }else{
    
        return nil;
    }

    
 
}

// MARK: - 返回cell高度的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSInteger I=indexPath.row;
    NSString *isShowOrHide=_isShowArray[indexPath.row];
    if ([isShowOrHide isEqualToString:@"1"]){
        if (indexPath.row==0) {
             return [orderCellOne moreHeight:_contentString];
        }else if (indexPath.row==1){
           return [orderCellTwo moreHeight:_contentString];
        }else if (indexPath.row==2){
               return [orderCellThree moreHeight:_contentString];
        }else{
            return 1*HEIGHT_SIZE;
        }
       
    } else{
        if (indexPath.row==0) {
           return [orderCellOne defaultHeight];
        }else if (indexPath.row==1){
          return [orderCellTwo defaultHeight];
        }else if (indexPath.row==2){
          return [orderCellThree defaultHeight];
        }else{
            return 1*HEIGHT_SIZE;
        }
    }
    
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
