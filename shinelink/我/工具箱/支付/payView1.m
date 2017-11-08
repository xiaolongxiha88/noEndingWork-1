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

@interface payView1 ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *V1;
@property(nonatomic,strong)UIView *V22;
@property(nonatomic,strong)UIView *addV;
@property(nonatomic,strong)UILabel *moneyLable;
@property(nonatomic,strong)UILabel *yearLable;
@property(nonatomic,assign)NSInteger yearNum;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSArray *SnArray;
@property(nonatomic,strong)NSArray *dateArray;
@property (nonatomic, strong) NSMutableArray *choiceArray;

@end

@implementation payView1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:MainColor];
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    
    [self initUI];
    [self initTwo];
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
    [_goBut.layer setCornerRadius:buttonH/3];
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:@"添加本账号GPRS" forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 12*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(goToAddSN) forControlEvents:UIControlEventTouchUpInside];
    [_V22 addSubview:_goBut];
    
    UIButton  * _goBut2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut2.frame=CGRectMake(175*HEIGHT_SIZE,5*HEIGHT_SIZE, buttonW, buttonH);
    [_goBut2 setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut2 setTitle:@"添加其他账号GPRS" forState:UIControlStateNormal];
    _goBut2.titleLabel.font=[UIFont systemFontOfSize: 12*HEIGHT_SIZE];
    [_goBut2 addTarget:self action:@selector(goToAddSN2) forControlEvents:UIControlEventTouchUpInside];
    [_V22 addSubview:_goBut2];
    
    ////////////////////购买
    float H2=HEIGHT_SIZE*50;
    UIView *V2=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-H2-NavigationbarHeight-StatusHeight, SCREEN_Width, H2)];
    V2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:V2];
    
    _moneyLable= [[UILabel alloc] initWithFrame:CGRectMake(20*NOW_SIZE, 0*HEIGHT_SIZE, 160*NOW_SIZE, HEIGHT_SIZE*40)];
    _moneyLable.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
    _moneyLable.textAlignment = NSTextAlignmentLeft;
    _moneyLable.text=@"总计:360";
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
    
}



-(void)goToPay{
    
    NSString *orderString =@"alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2017110409716742&biz_content=%7B%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22out_trade_no%22%3A%22growatt_order_20171107003%22%2C%22product_code%22%3A%22GPRS%E7%BB%AD%E8%B4%B95%E5%B9%B4%22%2C%22subject%22%3A%22App%E6%94%AF%E4%BB%98%E6%B5%8B%E8%AF%95Java%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%220.01%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2F47.91.176.158%2Fcommon%2Fnotify&sign=Vjx95nXWBbIIZnhmdSC49Dyi69D1Rlft4OTKCeFSvjWFsv9je%2FeiH5XuWE5OgJ%2BgP8pumODBDoFeUgFwTI8rfF1xogzAUVYSi2xCVj5e%2Bdv0tXnew5SHjhjrGgOKZhpGfLsrEbmjdqYucEMfo4CHqhW4pCaVQa%2F8vTECqC44ifbMQszSFT0naBKQnQ%2Bx08Jjk6V%2FnwfNpH%2B%2F3INJ5xfQTWEtW4EnhqnzkKTqsSJHCdlj07iWSM2SuzyzEOoAYiVfHTf0m%2FXFyMUX9zGT5zUcBYLAoRNYMq7aTpG5t58hQF97%2FpGx5BsHczvBn1cABV34vvKvKXGspGUTpRmt6Eh2kw%3D%3D&sign_type=RSA2&timestamp=2017-11-07+16%3A08%3A32&version=1.0";
    
    NSString *appScheme = @"ShinePhoneAlipay";
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSLog(@"reslut1212 = %@",resultDic);
    }];
    
    
    
}






-(void)goToAddSN{
    
    payView2 *testView=[[payView2 alloc]init];
    [self.navigationController pushViewController:testView animated:YES];
    
}

-(void)goToAddSN2{
    
    payView22 *testView=[[payView22 alloc]init];
    [self.navigationController pushViewController:testView animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _SnArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*HEIGHT_SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    singleSelectTableViewCell *customCell = [[singleSelectTableViewCell alloc] init];
    customCell.titleLabel.text = _SnArray[indexPath.row];

    BOOL isChoice=[_choiceArray[indexPath.row] boolValue];
    if (isChoice) {
        customCell.isSelect = YES;
        [customCell.selectBtn setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
    }else{
        customCell.isSelect = NO;
        [customCell.selectBtn setImage:[UIImage imageNamed:@"unSelect_btn"] forState:UIControlStateNormal];
    }
    __weak singleSelectTableViewCell *weakCell = customCell;
    [customCell setQhxSelectBlock:^(BOOL choice,NSInteger btnTag){
        
        [_choiceArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:choice]];
        
        if (choice) {
            [weakCell.selectBtn setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
            
            [self.tableView reloadData];
        }else{
            
            [weakCell.selectBtn setImage:[UIImage imageNamed:@"unSelect_btn"] forState:UIControlStateNormal];
            
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


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        //更新UI
        //   [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
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
