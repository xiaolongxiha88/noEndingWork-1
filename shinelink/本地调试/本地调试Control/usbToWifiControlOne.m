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
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_MAX_374 style:UIBarButtonItemStylePlain target:self action:@selector(goToSetModel)];
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
            _nameArray=@[[NSString stringWithFormat:@"%@(0)",root_MAX_396],
                         [NSString stringWithFormat:@"%@(1)",root_MAX_397],
                         [NSString stringWithFormat:@"%@(3)",root_MAX_398],
                         [NSString stringWithFormat:@"%@(4)",root_MAX_399],
                         [NSString stringWithFormat:@"%@(4)",root_MAX_400],
                         [NSString stringWithFormat:@"%@(5)",root_MAX_401],
                         [NSString stringWithFormat:@"%@(5)",root_MAX_402],
                         [NSString stringWithFormat:@"%@(8)",root_MAX_403],
                         [NSString stringWithFormat:@"%@(22)",root_MAX_404],
                         [NSString stringWithFormat:@"%@(89)",root_MAX_405],
                         [NSString stringWithFormat:@"%@(91)",root_MAX_406],
                         [NSString stringWithFormat:@"%@(92)",root_MAX_407],
                         [NSString stringWithFormat:@"%@(107)",root_MAX_408],
                         [NSString stringWithFormat:@"%@(108)",root_MAX_409],
                         [NSString stringWithFormat:@"%@(109)",root_MAX_410],
                         [NSString stringWithFormat:@"%@(230)",root_MAX_411],
                         [NSString stringWithFormat:@"%@(231)",root_MAX_412],
                         [NSString stringWithFormat:@"%@(232)",root_MAX_413],
                         [NSString stringWithFormat:@"%@(235)",root_MAX_414],
                         [NSString stringWithFormat:@"%@(236)",root_MAX_415],
                         [NSString stringWithFormat:@"%@(237)",root_MAX_416],
                         [NSString stringWithFormat:@"%@(238)",root_MAX_417],
                         [NSString stringWithFormat:@"%@(20/21)",root_MAX_418],
                         [NSString stringWithFormat:@"%@(93/94)",root_MAX_419],
                         [NSString stringWithFormat:@"%@(95/96)",root_MAX_420],
                         [NSString stringWithFormat:@"%@(97/98)",root_MAX_421],
                         [NSString stringWithFormat:@"%@(99/100)",root_MAX_422],
                         [NSString stringWithFormat:@"%@1/2(233/234)",root_MAX_389],
                           [NSString stringWithFormat:@"%@(101~106)",root_MAX_390],
                         [NSString stringWithFormat:@"%@1~4(110/112/114/116)",root_MAX_391],
                         [NSString stringWithFormat:@"%@1~4(111/113/115/117)",root_MAX_392]];
      
    }
    

    
       // [NSString stringWithFormat:@"%@(64/65)",root_MAX_439]
    
    if (_controlType==2) {
  _nameArray=@[[NSString stringWithFormat:@"%@(30)",root_MAX_423],
               [NSString stringWithFormat:@"%@(45~50)",root_5000Control_142],
               [NSString stringWithFormat:@"%@(17)",root_MAX_424],
               [NSString stringWithFormat:@"%@(18)",root_MAX_425],
               [NSString stringWithFormat:@"%@(19)",root_MAX_426],
               [NSString stringWithFormat:@"%@(15)",root_MAX_427],
               [NSString stringWithFormat:@"%@(16)",root_country],
               [NSString stringWithFormat:@"%@(51)",root_MAX_428],
               [NSString stringWithFormat:@"%@(80)",root_MAX_429],
               [NSString stringWithFormat:@"%@(81)",root_MAX_430],
               [NSString stringWithFormat:@"%@(88)",root_MAX_431],
               [NSString stringWithFormat:@"%@(201)",root_MAX_432],
               [NSString stringWithFormat:@"%@(202)",root_MAX_433],
               [NSString stringWithFormat:@"%@(203)",root_MAX_434],
               [NSString stringWithFormat:@"%@(28~29)",root_MAX_435],
               [NSString stringWithFormat:@"%@(122/123)",root_MAX_436],
               [NSString stringWithFormat:@"AC1%@(52/53)",root_MAX_437],
               [NSString stringWithFormat:@"AC1%@(54/55)",root_MAX_438],
               [NSString stringWithFormat:@"AC2%@(56/57)",root_MAX_437],
               [NSString stringWithFormat:@"AC2%@(58/59)",root_MAX_438],
               [NSString stringWithFormat:@"AC3%@(60/61)",root_MAX_437],
               [NSString stringWithFormat:@"AC3%@(62/63)",root_MAX_438],
               [NSString stringWithFormat:@"%@(64/65)",root_MAX_439],
               @"并网频率限制低/高(66/67)",
               @"AC电压限制时间1低/高(68/69)",
               @"AC电压限制时间2低/高(70/71)",
               @"AC频率限制时间1低/高(72/73)",
               @"AC频率限制时间2低/高(74/75)",
               @"AC电压限制时间3低/高(76/77)",
               @"AC频率限制时间3低/高(78/79)"];
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
