//
//  usbToWifiControlOne.m
//  ShinePhone
//
//  Created by sky on 2017/10/25.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiControlOne.h"
#import "usbToWifiControlThree.h"
#import "usbModleOne.h"
#import "usbToWifiControlTwo.h"

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
    
    if (_controlType==2) {
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"设置Model" style:UIBarButtonItemStylePlain target:self action:@selector(goToSetModel)];
        self.navigationItem.rightBarButtonItem=rightItem;
    }

    
    [self initUI];
}

-(void)goToSetModel{
    usbToWifiControlThree *go=[[usbToWifiControlThree alloc]init];
        go.CellTypy=3;
       go.CellNumber=40;
//    go.titleString=_nameArray[indexPath.row];
    [self.navigationController pushViewController:go animated:YES];
}


-(void)initUI{
    if (_controlType==1) {
            _nameArray=@[@"开关逆变器(0)",@"安规功能使能(1)",@"有功功率百分比(3)",@"感性载率(4)",@"容性载率(4)",@"容性PF(5)",@"感性PF(5)",@"PV电压(8)",@"选择通信波特率(22)",@"运行PF为1(89)",@"过频降额起点(91)",@"频率-负载限制率(92)",@"Q(v)无功延时(107)",@"过频降额延时(108)",@"Q(v)曲线Q最大值(109)",@"Island使能(230)",@"风扇检查(231)",@"电网N线使能(232)",@"N至GND监测功能使能(235)",@"非标准电网电压范围使能(236)",@"指定的规格设置使能(237)",@"MPPT使能(238)",@"电源启动/重启斜率(20/21)",@"Q(v)切出/切入高压(93/94)",@"Q(v)切出/切入低压(95/96)",@"Q(v)切入/切出功率(97/98)",@"无功曲线切入/切出电压(99/100)",@"检查固件1/2(233/234)",@"PF调整值(101~106)",@"PF限制负载百分比点1~4(110/112/114/116)",@"PF限制功率因数1~4(111/113/115/117)"];
    }
    

    
    
    if (_controlType==2) {
  _nameArray=@[@"通信地址(30)",@"系统时间(45~50)",@"启动电压(17)",@"启动时间(18)",@"故障恢复后重启延迟时间(19)",@"语言(15)",@"国家(16)",@"系统一周(51)",@"AC电压10分钟保护值(80)",@"PV电压高故障(81)",@"Modbus版本(88)",@"PID工作模式(201)",@"PID开关(202)",@"PID工作电压(203)",@"逆变器模块(28~29)",@"逆变器经纬度(122/123)",@"AC1限制电压低/高(52/53)",@"AC1频率限制高/低(54/55)",@"AC2限制电压低/高(56/57)",@"AC2频率限制高/低(58/59)",@"AC3限制电压低/高(60/61)",@"AC3频率限制高/低(62/63)",@"并网电压限制低/高(64/65)",@"并网频率限制低/高(66/67)",@"AC电压限制时间1低/高(68/69)",@"AC电压限制时间2低/高(70/71)",@"AC频率限制时间1低/高(72/73)",@"AC频率限制时间2低/高(74/75)",@"AC电压限制时间3低/高(76/77)",@"AC频率限制时间3低/高(78/79)"];
    }
   
    
//    NSArray *cmdValue=@[
//                        @"30",@"45",@"17",@"18",@"19",@"15",@"16",@"51",@"80",@"81",@"88",@"201",@"202",@"203",@"28",@"122",@"52",@"54",@"56",@"58",@"60",@"62",@"64",@"66",@"68",@"70",@"72",@"74",@"76",@"78"];
    
    
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
    cell.textLabel.text=[NSString stringWithFormat:@"%ld.%@",indexPath.row,_nameArray[indexPath.row]];
    cell.textLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    cell.tintColor = COLOR(102, 102, 102, 1);
    cell.textLabel.textColor=COLOR(102, 102, 102, 1);
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //cell.accessoryView.backgroundColor=[UIColor whiteColor];
    
    
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int TYPT=0;
    
    if (_controlType==1) {
        int OneSetInt=22;
         int twoSetBeginInt=21;
        int twoSetOverInt=28;
        if (indexPath.row<OneSetInt) {
            TYPT=1;
        }else  if (indexPath.row>twoSetBeginInt && indexPath.row<twoSetOverInt) {
            TYPT=2;
        }else{
            TYPT=(int)indexPath.row;
        }
        usbToWifiControlTwo *go=[[usbToWifiControlTwo alloc]init];
        go.CellTypy=TYPT;
        go.OneSetInt=OneSetInt;
        go.twoSetOverInt=twoSetOverInt;
        go.twoSetBeginInt=twoSetBeginInt;
        go.CellNumber=(int)indexPath.row;
        go.titleString=_nameArray[indexPath.row];
        [self.navigationController pushViewController:go animated:YES];
    }else{
        if (indexPath.row==14) {
            [self showAlertViewWithTitle:@"该项暂不能设置，请设置Model。" message:nil cancelButtonTitle:root_OK];
            return;
        }
        if (indexPath.row==15) {
            [self showAlertViewWithTitle:@"该项暂不能设置。" message:nil cancelButtonTitle:root_OK];
            return;
        }
        if (indexPath.row<14) {
            TYPT=1;
        }else{
            TYPT=2;
        }
        usbToWifiControlThree *go=[[usbToWifiControlThree alloc]init];
        go.CellTypy=TYPT;
        go.CellNumber=(int)indexPath.row;
        go.titleString=_nameArray[indexPath.row];
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
