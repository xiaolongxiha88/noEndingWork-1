//
//  payView2.m
//  ShinePhone
//
//  Created by sky on 2017/11/8.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "payView2.h"
#import "singleSelectTableViewCell.h"

@interface payView2 ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView*view1;
@property(nonatomic,strong)UITextField *textField2;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *SnArray;
@property(nonatomic,strong)NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *choiceArray;
@end

@implementation payView2

- (void)viewDidLoad {
    [super viewDidLoad];
 
  self.view.backgroundColor=COLOR(242, 242, 242, 1);
    
    _SnArray=[NSMutableArray new];
      _dateArray=[NSMutableArray new];
    
    _choiceArray=[NSMutableArray new];
    for (int i=0; i<_SnArray.count; i++) {
        [_choiceArray addObject:[NSNumber numberWithBool:NO]];
    }
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    [self initUI];
    [self initTwo];
}


-(void)initUI{
    
    float H0=30*HEIGHT_SIZE;
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, 300*NOW_SIZE,H0)];
    PV2Lable.text=@"添加其他账号下GPRS序列号";
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=COLOR(51, 51, 51, 1);
    PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    PV2Lable.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:PV2Lable];
    
    
    if (!_view1) {
        _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, H0, ScreenWidth,120*HEIGHT_SIZE)];
        _view1.backgroundColor =[UIColor whiteColor];
        _view1.userInteractionEnabled = YES;
        [self.view addSubview:_view1];
    }
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 20*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textField2.layer.borderWidth=1;
    _textField2.layer.cornerRadius=5;
    _textField2.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
    _textField2.textColor = COLOR(102, 102, 102, 1);
    _textField2.tintColor = COLOR(102, 102, 102, 1);
    _textField2.textAlignment=NSTextAlignmentCenter;
    _textField2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_view1 addSubview:_textField2];
    
   UIButton  * _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
     _goBut.frame=CGRectMake(60*NOW_SIZE,70*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:@"添加" forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(getNetOne) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:_goBut];
    
}

-(void)initTwo{
    float H0=30*HEIGHT_SIZE;
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 150*HEIGHT_SIZE, 300*NOW_SIZE,H0)];
    PV2Lable.text=@"已添加的GPRS序列号";
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=COLOR(51, 51, 51, 1);
    PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    PV2Lable.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:PV2Lable];
    
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180*HEIGHT_SIZE, ScreenWidth, ScreenHeight-180*HEIGHT_SIZE-NavigationbarHeight-StatusHeight) style:UITableViewStyleGrouped];
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

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self addSN];
}

-(void)addSN{
      NSDictionary *payDic=[[NSUserDefaults standardUserDefaults] objectForKey:@"paySN"];
    
    NSMutableDictionary *payDic1=[NSMutableDictionary new];
    for (int i=0; i<_SnArray.count; i++) {
        [payDic1 setObject:_dateArray[i] forKey:_SnArray[i]];
    }
    [payDic1 addEntriesFromDictionary:payDic];
    
    [[NSUserDefaults standardUserDefaults] setObject:payDic1 forKey:@"paySN"];
    
  //   NSDictionary *payDic2=[[NSUserDefaults standardUserDefaults] objectForKey:@"paySN"];
    
}


-(void)getNetOne{
    NSString *snString= _textField2.text;
    if ([snString isEqualToString:@""]||(snString==nil)) {
           [self showToastViewWithTitle:root_caiJiQi];
        return;
    }
    NSString *serverUrl= [[NSUserDefaults standardUserDefaults] objectForKey:@"server"];
    int serverType=2;
    if ([serverUrl containsString:@"server-cn"]) {
        serverType=2;
    }else if ([serverUrl containsString:@"smten"]) {
        serverType=3;
    }else{
        serverType=1;
    }
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:@{@"datalogSn":snString,@"serverId":[NSNumber numberWithInt:serverType]} paramarsSite:@"/api/v2/renew/datalogSnExist" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"api/v2/renew/datalogSnExist: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            if ([firstDic[@"result"] intValue]==1) {
                NSArray *allArray=firstDic[@"obj"];
                for (int i=0; i<allArray.count; i++) {
                    [_SnArray addObject:allArray[i][@"datalogSn"]];
                    [_dateArray addObject:allArray[i][@"productDate"]];
                      [_choiceArray addObject:[NSNumber numberWithBool:NO]];
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
     //   [customCell.selectBtn setImage:[UIImage imageNamed:@"Selected_clickPay.png"] forState:UIControlStateNormal];
    }else{
        customCell.isSelect = NO;
      //  [customCell.selectBtn setImage:[UIImage imageNamed:@"Selected_norPay.png"] forState:UIControlStateNormal];
    }
 //   __weak singleSelectTableViewCell *weakCell = customCell;

    customCell.selectBtn.userInteractionEnabled=NO;
    
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
        [_tableView reloadData];
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
