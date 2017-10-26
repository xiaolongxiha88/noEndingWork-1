//
//  usbToWifiControlOne.m
//  ShinePhone
//
//  Created by sky on 2017/10/25.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiControlOne.h"
#import "usbToWifiControlCell1.h"
#import "usbModleOne.h"

static NSString *cellOne = @"cell1";

@interface usbToWifiControlOne ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *nameArray;
@property(nonatomic,strong)NSArray *name2Array;
@property(nonatomic,strong) NSArray* cellTitleNameArray;
@end

@implementation usbToWifiControlOne{
    NSArray<usbModleOne*> *_modelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


-(void)initUI{
    _nameArray=@[@"开关逆变器(0)",@"安规功能使能(1)",@"PF CMD记忆使能(2)",@"有功功率百分比(3)",@"无功功率百分比(4)",@"功率因数(5)",@"PV电压(8)",@"选择通信波特率(22)",@"设置PF模式(89)",@"过频降额起点(91)",@"频率-负载限制率(92)",@"Q(v)无功延时(107)",@"过频降额延时(108)",@"Q(v)曲线Q最大值(109)",@"Island使能(230)",@"风扇检查(231)",@"电网N线使能(232)",@"N至GND监测功能使能(235)",@"非标准电网电压范围使能(236)",@"指定的规格设置使能(237)",@"MPPT使能(238)",@"电源启动/重启斜率(20/21)",@"Q(v)切出/切入高压(93/94)",@"Q(v)切出/切入低压(95/96)",@"Q(v)切出/切入功率(97/98)",@"无功曲线切入/切出电压(99/100)",@"检查固件1/2(233/234)",@"PF调整值(101~106)",@"PF限制负载百分比点1~4(110/112/114/116)",@"PF限制功率因数1~4(111/113/115/117)"];
   
    
    
    NSMutableArray<usbModleOne *> *arrM = [NSMutableArray arrayWithCapacity:_nameArray.count];
    for (int i=0; i<_nameArray.count; i++) {
        usbModleOne *model = [[usbModleOne alloc] initWithDict];
        [arrM addObject:model];
    }
    _modelList = arrM.copy;
    
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0,ScreenWidth,SCREEN_Height-UI_NAVIGATION_BAR_HEIGHT-UI_STATUS_BAR_HEIGHT)];
        _tableView.contentSize=CGSizeMake(SCREEN_Width, 50000*HEIGHT_SIZE);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self.tableView registerClass:[usbToWifiControlCell1 class] forCellReuseIdentifier:cellOne];
        
        [self.view addSubview:_tableView];
        
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _nameArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int TYPT=0;
    if (indexPath.row<21) {
        TYPT=1;
    }else  if (indexPath.row>20 && indexPath.row<27) {
        TYPT=2;
    }else{
          TYPT=(int)indexPath.row;
    }
    
    usbToWifiControlCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellOne forIndexPath:indexPath];

    if (!cell) {
        cell=[[usbToWifiControlCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellOne];
    }
    usbModleOne *model = _modelList[indexPath.row];
    [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
        NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
        [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    cell.CellTypy=TYPT;
    cell.CellNumber=(int)indexPath.row;
    cell.model = model;
    cell.titleString=_nameArray[indexPath.row];
    return cell;
}


// MARK: - 返回cell高度的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     int TYPT=0;
    if (indexPath.row<21) {
        TYPT=1;
    }else  if (indexPath.row>20 && indexPath.row<27) {
        TYPT=2;
    }else{
        TYPT=(int)indexPath.row;
    }
        usbModleOne *model = _modelList[indexPath.row];
        
        if (model.isShowMoreText){
            
            return [usbToWifiControlCell1 moreHeight:TYPT];
            
        }else{
            
            return [usbToWifiControlCell1 defaultHeight];
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
