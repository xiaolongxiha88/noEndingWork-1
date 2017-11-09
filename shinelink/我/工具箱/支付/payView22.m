//
//  payView22.m
//  ShinePhone
//
//  Created by sky on 2017/11/8.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "payView22.h"
#import "singleSelectTableViewCell.h"


@interface payView22 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *SnArray;
@property(nonatomic,strong)NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *choiceArray;

@end

@implementation payView22

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    
    _SnArray=[NSMutableArray arrayWithArray:@[@"123123123",@"123123113",@"121123123",@"223123123",@"143123123",@"123125123",@"123123173",@"123153123"]];
    _dateArray=[NSMutableArray arrayWithArray:@[@"2013-12-12",@"2013-12-12",@"2013-12-12",@"2013-12-12",@"2013-12-12",@"2013-12-12",@"2013-12-12",@"2013-12-12"]];
    
    _choiceArray=[NSMutableArray new];
    for (int i=0; i<_SnArray.count; i++) {
        [_choiceArray addObject:[NSNumber numberWithBool:NO]];
    }
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    [self initUI];
}


-(void)initUI{
    
    float H0=30*HEIGHT_SIZE;
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, 300*NOW_SIZE,H0)];
    PV2Lable.text=@"添加本账号下GPRS序列号";
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=COLOR(51, 51, 51, 1);
    PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    PV2Lable.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:PV2Lable];
    
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, H0, ScreenWidth, ScreenHeight-NavigationbarHeight-StatusHeight) style:UITableViewStyleGrouped];
        self.tableView.backgroundColor=[UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        self.tableView.delegate =self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
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
    return _SnArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*HEIGHT_SIZE;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    singleSelectTableViewCell *customCell = [[singleSelectTableViewCell alloc] init];
    customCell.titleLabel.text = _SnArray[indexPath.row];
    customCell.dateLabel.text=[NSString stringWithFormat:@"%@:%@",@"到期时间",_dateArray[indexPath.row]];
    
    BOOL isChoice=[_choiceArray[indexPath.row] boolValue];
    if (isChoice) {
        customCell.isSelect = YES;
        [customCell.selectBtn setImage:[UIImage imageNamed:@"Selected_clickPay.png"] forState:UIControlStateNormal];
    }else{
        customCell.isSelect = NO;
        [customCell.selectBtn setImage:[UIImage imageNamed:@"Selected_norPay.png"] forState:UIControlStateNormal];
    }
    __weak singleSelectTableViewCell *weakCell = customCell;
    [customCell setQhxSelectBlock:^(BOOL choice,NSInteger btnTag){
        
        [_choiceArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:choice]];
        
        if (choice) {
            [weakCell.selectBtn setImage:[UIImage imageNamed:@"Selected_clickPay.png"] forState:UIControlStateNormal];
            
          //  [self.tableView reloadData];
        }else{
            
            [weakCell.selectBtn setImage:[UIImage imageNamed:@"Selected_norPay.png"] forState:UIControlStateNormal];
            
            //    [self.tableView reloadData];
            
        }
    }];
    
    cell = customCell;
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选择了%ld行",(long)indexPath.row);
}


-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self addSN];
}

-(void)addSN{
    
    //[[NSUserDefaults standardUserDefaults] setObject:@{} forKey:@"paySN"];
    
    NSDictionary *payDic=[[NSUserDefaults standardUserDefaults] objectForKey:@"paySN"];
    
    NSMutableDictionary *payDic1=[NSMutableDictionary new];
    for (int i=0; i<_choiceArray.count; i++) {
        BOOL isSelect=[_choiceArray[i] boolValue];
        if (isSelect) {
             [payDic1 setObject:_dateArray[i] forKey:_SnArray[i]];
        }
       
    }
    [payDic1 addEntriesFromDictionary:payDic];
    
    [[NSUserDefaults standardUserDefaults] setObject:payDic1 forKey:@"paySN"];
    
//    NSDictionary *payDic2=[[NSUserDefaults standardUserDefaults] objectForKey:@"paySN"];
    
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
