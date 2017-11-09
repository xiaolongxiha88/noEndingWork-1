//
//  payView1.m
//  ShinePhone
//
//  Created by sky on 2017/11/8.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "payView1.h"
#import <AlipaySDK/AlipaySDK.h>
#import "singleSelectTableViewCell.h"
#import "payView2.h"
#import "payView22.h"
#import "payView3.h"

#define  moneyValue 20;
@interface payView1 ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *V1;
@property(nonatomic,strong)UIView *V22;
@property(nonatomic,strong)UIView *addV;
@property(nonatomic,strong)UILabel *moneyLable;
@property(nonatomic,strong)UILabel *yearLable;
@property(nonatomic,assign)NSInteger yearNum;
@property(nonatomic,assign)NSInteger AllMoney;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *SnArray;
@property(nonatomic,strong)NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *choiceArray;

@end

@implementation payView1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:MainColor];
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    
    [self initUI];
  
}

-(void)viewWillAppear:(BOOL)animated{
    if (!_tableView) {
          [self initTwo];
    }else{
        _SnArray=[NSMutableArray new];
        _dateArray=[NSMutableArray new];
          NSDictionary *payDic=[[NSUserDefaults standardUserDefaults] objectForKey:@"paySN"];
        for (int i=0; i<payDic.allKeys.count; i++) {
            [_SnArray addObject:payDic.allKeys[i]];
              [_dateArray addObject:[payDic objectForKey:payDic.allKeys[i]]];
        }
        _choiceArray=[NSMutableArray new];
        for (int i=0; i<_SnArray.count; i++) {
            [_choiceArray addObject:[NSNumber numberWithBool:YES]];
        }
        [_tableView reloadData];
        [self getAllMoney];
    }
    
}

-(void)initUI{
    
    _yearNum=1;
    
     float H0=30*HEIGHT_SIZE;
    _V1=[[UIView alloc]initWithFrame:CGRectMake(0, 0*HEIGHT_SIZE, SCREEN_Width, H0)];
    _V1.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_V1];
    
    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width-20*NOW_SIZE, H0)];
    VL1.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    VL1.textAlignment = NSTextAlignmentLeft;
    VL1.text=@"添加GPRS采集器序列号";
    VL1.textColor =COLOR(51, 51, 51, 1);
    [_V1 addSubview:VL1];
    
    _V22=[[UIView alloc]initWithFrame:CGRectMake(0, H0, SCREEN_Width,  ScreenHeight-170*HEIGHT_SIZE-NavigationbarHeight-StatusHeight)];
    _V22.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_V22];
    
    float buttonH=30*HEIGHT_SIZE; float buttonW=115*NOW_SIZE;
    UIButton  * _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(30*NOW_SIZE,5*HEIGHT_SIZE, buttonW, buttonH);
    [_goBut.layer setMasksToBounds:YES];
    [_goBut.layer setCornerRadius:buttonH/2];
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:@"添加本账号GPRS" forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 12*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(goToAddSN2) forControlEvents:UIControlEventTouchUpInside];
    [_V22 addSubview:_goBut];
    
    UIButton  * _goBut2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut2.frame=CGRectMake(175*HEIGHT_SIZE,5*HEIGHT_SIZE, buttonW, buttonH);
    [_goBut2 setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut2.layer setMasksToBounds:YES];
    [_goBut2.layer setCornerRadius:buttonH/2];
    [_goBut2 setTitle:@"添加其他账号GPRS" forState:UIControlStateNormal];
    _goBut2.titleLabel.font=[UIFont systemFontOfSize: 12*HEIGHT_SIZE];
    [_goBut2 addTarget:self action:@selector(goToAddSN) forControlEvents:UIControlEventTouchUpInside];
    [_V22 addSubview:_goBut2];
    
    ////////////////////购买
    float H2=HEIGHT_SIZE*50;
    UIView *V2=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-H2-NavigationbarHeight-StatusHeight, SCREEN_Width, H2)];
    V2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:V2];
    
    _moneyLable= [[UILabel alloc] initWithFrame:CGRectMake(20*NOW_SIZE, 0*HEIGHT_SIZE, 160*NOW_SIZE, HEIGHT_SIZE*40)];
    _moneyLable.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
    _moneyLable.textAlignment = NSTextAlignmentLeft;
    _moneyLable.text=@"总计:0";
    _moneyLable.textColor =[UIColor redColor];
    [V2 addSubview:_moneyLable];
    
      float W2=80*NOW_SIZE;
    UIButton *registerUser =  [UIButton buttonWithType:UIButtonTypeCustom];
    registerUser.frame=CGRectMake(SCREEN_Width-W2,0, W2, H2);
    registerUser.backgroundColor =MainColor;
    registerUser.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [registerUser setTitle:@"结算" forState:UIControlStateNormal];
    [registerUser setTitleColor: [UIColor whiteColor]forState:UIControlStateNormal];
    [registerUser addTarget:self action:@selector(goToPay) forControlEvents:UIControlEventTouchUpInside];
    [V2 addSubview:registerUser];
    
 
    ///////////////////////年限
    UIView *V3=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-H2-NavigationbarHeight-StatusHeight-H2-10*HEIGHT_SIZE, SCREEN_Width, H2)];
    V3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:V3];
    
    UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(20*NOW_SIZE, 0*HEIGHT_SIZE, 150*NOW_SIZE, H2)];
    VL2.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    VL2.textAlignment = NSTextAlignmentLeft;
    VL2.text=@"购买年限:";
    VL2.textColor =COLOR(51, 51, 51, 1);
    [V3 addSubview:VL2];
    
    float W3=30*NOW_SIZE;  float x1=190*NOW_SIZE;
    UIButton *addButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.tag=2000;
    addButton.frame=CGRectMake(x1,(H2-W3)/2, W3, W3);
    [addButton setBackgroundImage:IMAGE(@"pay4.png") forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(changeYear:) forControlEvents:UIControlEventTouchUpInside];
    [V3 addSubview:addButton];
    
    float yearW4=60*NOW_SIZE;
    _yearLable= [[UILabel alloc] initWithFrame:CGRectMake(x1+W3, 0*HEIGHT_SIZE, yearW4, H2)];
    _yearLable.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    _yearLable.textAlignment = NSTextAlignmentCenter;
    _yearLable.text=[NSString stringWithFormat:@"%ld%@",_yearNum,root_YEAR];
    _yearLable.textColor =COLOR(51, 51, 51, 1);
    [V3 addSubview:_yearLable];
    
    UIButton *addButton1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    addButton1.frame=CGRectMake(x1+W3+yearW4,(H2-W3)/2, W3, W3);
        addButton1.tag=2001;
    [addButton1 setBackgroundImage:IMAGE(@"pay3.png") forState:UIControlStateNormal];
    [addButton1 addTarget:self action:@selector(changeYear:) forControlEvents:UIControlEventTouchUpInside];
    [V3 addSubview:addButton1];
    
}

-(void)initTwo{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40*HEIGHT_SIZE, ScreenWidth, ScreenHeight-170*HEIGHT_SIZE-NavigationbarHeight-StatusHeight) style:UITableViewStyleGrouped];
       self.tableView.backgroundColor=[UIColor whiteColor];
        self.tableView.delegate =self;
        self.tableView.dataSource = self;
        [_V22 addSubview:self.tableView];
    }
    
    
}

-(void)changeYear:(UIButton*)button{
    if (button.tag==2000) {
        if (_yearNum>1) {
               _yearNum=_yearNum-1;
        }else{
            _yearNum=1;
        }
     
    }else if (button.tag==2001) {
        if (_yearNum<10) {
            _yearNum=_yearNum+1;
        }else{
            _yearNum=10;
        }
    }
      _yearLable.text=[NSString stringWithFormat:@"%ld%@",_yearNum,root_YEAR];
    
         [self getAllMoney];
    
}



-(void)goToPay{
    
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"invoiceEnable"];
    
    payView3 *testView=[[payView3 alloc]init];
    testView.AllMoney=_AllMoney;
    [self.navigationController pushViewController:testView animated:YES];
    

//    
    
    
}


-(void)getAllMoney{
    float allMoney=0;
     for (int i=0; i<_choiceArray.count; i++) {
         BOOL isSelect=[_choiceArray[i] boolValue];
         if (isSelect) {
             allMoney=allMoney+moneyValue;
         }
    }
    
    _AllMoney=allMoney*_yearNum;
    _moneyLable.text=[NSString stringWithFormat:@"%@:%ld",@"总计",_AllMoney];
    
}



-(void)goToAddSN{
    [self reLoadData];
    payView2 *testView=[[payView2 alloc]init];
    [self.navigationController pushViewController:testView animated:YES];
    
}

-(void)goToAddSN2{
    [self reLoadData];
    payView22 *testView=[[payView22 alloc]init];
    [self.navigationController pushViewController:testView animated:YES];
    
}

-(void)reLoadData{
    NSMutableDictionary *payDic1=[NSMutableDictionary new];
    for (int i=0; i<_SnArray.count; i++) {
        [payDic1 setObject:_dateArray[i] forKey:_SnArray[i]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:payDic1 forKey:@"paySN"];
    
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
        }else{
            
            [weakCell.selectBtn setImage:[UIImage imageNamed:@"Selected_norPay.png"] forState:UIControlStateNormal];
        }
        [self getAllMoney];
    }];
    
    cell = customCell;
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选择了%ld行",(long)indexPath.row);
}





- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [_SnArray removeObjectAtIndex:indexPath.row];
        [_dateArray removeObjectAtIndex:indexPath.row];
      [_choiceArray removeObjectAtIndex:indexPath.row];
        [_tableView reloadData];
             [self getAllMoney];
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
