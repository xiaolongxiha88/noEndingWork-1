//
//  payResultView.m
//  ShinePhone
//
//  Created by sky on 2017/11/18.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "payResultView.h"
#import "payResultCell.h"
#import "resultDetailView.h"


@interface payResultView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *resultArray;
@property(nonatomic,strong)NSMutableArray *moneyArray;
@property(nonatomic,strong)NSMutableArray *timeArray;
@property(nonatomic,strong)NSMutableArray *SNArray;
@property(nonatomic,strong)NSMutableArray *AllArray;

@end

@implementation payResultView

- (void)viewDidLoad {
    [super viewDidLoad];


    
    [self initUI];
    [self getNetOne];
    
    if (_isShowAlert) {
            [self showAlertViewWithTitle:@"支付结果" message:_noticeString cancelButtonTitle:root_OK];
    }
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
    return _AllArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90*HEIGHT_SIZE;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"payCell";
    NSArray *nameArray=@[@"支付结果",@"支付金额",@"支付时间",@"采集器序列号"];
    
    payResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell=[[payResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.lable1.text=[NSString stringWithFormat:@"%@:%@",nameArray[0],_resultArray[indexPath.row]];
        cell.lable2.text=[NSString stringWithFormat:@"%@:%@",nameArray[1],_moneyArray[indexPath.row]];
     cell.lable3.text=[NSString stringWithFormat:@"%@:%@",nameArray[2],_timeArray[indexPath.row]];
     cell.lable4.text=[NSString stringWithFormat:@"%@:%@",nameArray[3],_SNArray[indexPath.row]];
       
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    resultDetailView *goView=[[resultDetailView alloc]init];
    goView.allDic=[NSDictionary dictionaryWithDictionary:_AllArray[indexPath.row]];
    [self.navigationController pushViewController:goView animated:YES];
    
}



-(void)getNetOne{
 
    NSString *userName= [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *serverUrl0= [[NSUserDefaults standardUserDefaults] objectForKey:@"server"];
    
 //   serverUrl0=@"http://server.growatt.com";//DEMO
   
    int serverID=2;
    if ([serverUrl0 containsString:@"smten"]) {
        serverID=3;
    }else if ([serverUrl0 containsString:@"server-cn"]) {
        serverID=2;
    }else{
                serverID=1;
    }
    
    _resultArray=[NSMutableArray new];
    _moneyArray=[NSMutableArray new];
    _timeArray=[NSMutableArray new];
    _SNArray=[NSMutableArray new];
    _AllArray=[NSMutableArray new];
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL_Demo_2 paramars:@{@"username":userName,@"serverId":[NSString stringWithFormat:@"%d",serverID]} paramarsSite:@"/api/v2/renew/getOrderRecord" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v2/renew/getOrderRecord: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            if ([firstDic[@"result"] intValue]==1) {
                NSArray *allArray=firstDic[@"obj"];
                for (int i=0; i<allArray.count; i++) {
                    NSDictionary *dic=allArray[i];
                    NSString *result=[self changeResult:[dic objectForKey:@"status"]];
                    [ _resultArray addObject:result];
                        [ _moneyArray addObject:[dic objectForKey:@"money"]];
                      [ _timeArray addObject:[dic objectForKey:@"gmt_create"]];
                      [ _SNArray addObject:[dic objectForKey:@"datalogSn"]];
                       [ _AllArray addObject:allArray[i]];
                }
                [_tableView reloadData];
            }else{
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",firstDic[@"msg"]]];
            }
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
        
    }];
    
}


-(NSString*)changeResult:(NSString*)result{
    NSString *ResultString;
    int resultInt=[result intValue];
    if (resultInt==1) {
        ResultString=@"续费成功";
    }else if (resultInt==2) {
        ResultString=@"待支付";
    }else if (resultInt==3 || resultInt==4 ||resultInt==6) {
        ResultString=@"支付成功，续费中";
    }else if (resultInt==5) {
        ResultString=@"支付失败";
    }else{
        ResultString=result;
    }
     
    return ResultString;
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
