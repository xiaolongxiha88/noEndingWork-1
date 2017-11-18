//
//  payResultView.m
//  ShinePhone
//
//  Created by sky on 2017/11/18.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "payResultView.h"
#import "payResultCell.h"

@interface payResultView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSArray *name1Array;
@end

@implementation payResultView

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}


-(void)initUI{
    
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavigationbarHeight-StatusHeight) style:UITableViewStyleGrouped];
        self.tableView.backgroundColor=[UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        self.tableView.delegate =self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
        
            [_tableView registerClass:[payResultCell class] forCellReuseIdentifier:@"payCell"];
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _name1Array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90*HEIGHT_SIZE;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"payCell";
    payResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell=[[payResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选择了%ld行",(long)indexPath.row);
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
