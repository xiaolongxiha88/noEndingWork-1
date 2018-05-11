//
//  ossNewDeviceList.m
//  ShinePhone
//
//  Created by sky on 2018/4/26.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossNewDeviceList.h"
#import "ossNewDeviceCell.h"
#import "ossNewDeviceTwoCell.h"
#import "ShinePhone-Swift.h"
#import "LRLChannelEditController.h"

@interface ossNewDeviceList ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *oneScrollView;
@property (nonatomic, strong) UIScrollView *twoScrollView;
@property (nonatomic, strong) UIScrollView *threeScrollView;
@property (nonatomic, strong) NSArray *oneParaArray;
@property (nonatomic, strong) NSArray *oneParaArrayNum;
@property (nonatomic, strong) NSArray *cellNameArray;
@property (nonatomic, strong) NSArray *cellNameArray2;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign)float tableW;
@property (nonatomic, assign)BOOL isChangTableView;
@property (nonatomic, strong) NSMutableArray *selectRowNumArray;
@property (nonatomic, strong) DTKDropdownMenuView *rightMenuView;

@property (nonatomic, strong) NSMutableArray<LRLChannelUnitModel *> *topChannelArr;
@property (nonatomic, strong) NSMutableArray<LRLChannelUnitModel *> *bottomChannelArr;
@property (nonatomic, assign) NSInteger chooseIndex;

@property (nonatomic, strong) NSDictionary *forChoiceParameterDic;
@property (nonatomic, strong) NSArray *NetForParameterArray;
@property (nonatomic, strong) NSArray *oldForParameterArray;
@property (nonatomic, strong) NSArray *topArray;
@property (nonatomic, strong) NSArray *battomArray;
@end

@implementation ossNewDeviceList

- (void)viewDidLoad {
    [super viewDidLoad];

    _isChangTableView=NO;
    
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    [self addRightItem];
    [self initUI];
    
}

-(void)initData{
    _oldForParameterArray=@[@"2",@"5",@"4",@"9",@"11",@"12",@"13",@"10"];
    
    NSArray*numArray=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
    _forChoiceParameterDic=@{@"1":@"类型",@"2":@"别名",@" 3":@"安装商",@"4":@"所属电站",@"5":@"所属用户",@"6":@"城市",@"7":@"采集器",@"8":@"最后更新时间",@"9":@"状态",@"10":@"额定功率",@"11":@"今日发电量",@"12":@"累计发电量",@"13":@"当前功率"};
    
    if (_NetForParameterArray.count==0) {
        _topArray=[NSArray arrayWithArray:_oldForParameterArray];
        for (int i=0; i<numArray.count; i++) {
            NSString *keyNum=numArray[i];
            if ([_oldForParameterArray containsObject:keyNum]) {
                
            }
        }
    }
    
    
}

-(void)initUI{
    _oneParaArray=@[@"状态",@"额定功率",@"今日发电量",@"累计发电量",@"当前功率"];
    
    float H1=40*HEIGHT_SIZE;
    _oneScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, H1)];
    _oneScrollView.backgroundColor = [UIColor whiteColor];
    _oneScrollView.showsHorizontalScrollIndicator = NO;
    _oneScrollView.bounces = NO;
    [self.view addSubview:_oneScrollView];
    

   //   float W11=90*NOW_SIZE;
    float W_all=0;
    _selectRowNumArray=[NSMutableArray new];
    for (int i=0; i<_oneParaArray.count; i++) {
        
        NSString *nameString=_oneParaArray[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        float image0H=12*HEIGHT_SIZE;
        float image0W=5*HEIGHT_SIZE;
         float W_K=3*NOW_SIZE;
          float W_K_0=12*NOW_SIZE;             //平均空隙
        float W_all_0=W_K_0*2+size.width+image0W+W_K;

        UIView *View1 = [[UIView alloc]initWithFrame:CGRectMake(0+W_all, 0*HEIGHT_SIZE, W_all_0,H1)];
        View1.backgroundColor = [UIColor clearColor];
        [_oneScrollView addSubview:View1];
        
                W_all=W_all+W_all_0;
        
        UILabel *lableR = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,W_all_0, H1)];
        lableR.textColor = COLOR(102, 102, 102, 1);
        lableR.textAlignment=NSTextAlignmentCenter;
        lableR.userInteractionEnabled=YES;
        lableR.tag=2000+i;
        UITapGestureRecognizer *labelTapR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeTheRowNum:)];
        [lableR addGestureRecognizer:labelTapR];
        lableR.text=_oneParaArray[i];
        lableR.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [View1 addSubview:lableR];
        
        [_selectRowNumArray addObject:[NSNumber numberWithBool:NO]];
        
        UIImageView *image0=[[UIImageView alloc]initWithFrame:CGRectMake((W_all_0+size.width)/2.0+W_K, (H1-image0H)/2.0, image0W,image0H )];
        image0.userInteractionEnabled=YES;
            image0.tag=3000+i;
        image0.image=IMAGE(@"oss_up_down.png");
        [View1 addSubview:image0];
        
    }
   
    _oneScrollView.contentSize=CGSizeMake(W_all+20*NOW_SIZE, H1);
    
      float H2=50*HEIGHT_SIZE;
        float W1=80*NOW_SIZE;
    
    UIView *View2= [[UIView alloc]initWithFrame:CGRectMake(0, H1, ScreenWidth,H2)];
    View2.backgroundColor = COLOR(242, 242, 242, 1);
    [self.view addSubview:View2];
    
    float imageW=22*HEIGHT_SIZE;
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, (H2-imageW)/2, imageW,imageW )];
    image2.userInteractionEnabled=YES;
    image2.image=IMAGE(@"OSS_list.png");
    UITapGestureRecognizer *labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changTableView)];
    [image2 addGestureRecognizer:labelTap1];
    [View2 addSubview:image2];
    
    float View01_W=ScreenWidth-20*NOW_SIZE-imageW-10*NOW_SIZE;
    float imageH1=30*HEIGHT_SIZE;
    UIView *View01= [[UIView alloc]initWithFrame:CGRectMake(20*NOW_SIZE+imageW, (H2-imageH1)/2.0, View01_W,imageH1)];
    View01.backgroundColor = [UIColor whiteColor];
    [View01.layer setMasksToBounds:YES];
        View01.userInteractionEnabled=YES;
    [View01.layer setCornerRadius:(imageH1/2.0)];
    UITapGestureRecognizer *labelTap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToSearch)];
    [View01 addGestureRecognizer:labelTap3];
    [View2 addSubview:View01];
    
        float imageH2=20*HEIGHT_SIZE;
      float imageW2=imageH2*(34/36.0);
    float W22=(View01.frame.size.width-imageW2)/2.0;
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(W22, (imageH1-imageH2)/2, imageW2,imageH2 )];
    image3.userInteractionEnabled=YES;
    image3.image=IMAGE(@"oss_search.png");
    [View01 addSubview:image3];
  
    _twoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, H1+H2, SCREEN_Width, H1)];
    _twoScrollView.backgroundColor = [UIColor whiteColor];
    _twoScrollView.showsHorizontalScrollIndicator = NO;
    _twoScrollView.delegate=self;
    _twoScrollView.bounces = NO;
    [self.view addSubview:_twoScrollView];
    
    _cellNameArray2=@[@"别名",@"状态",@"当前功率",@"今日发电"];
    _cellNameArray=@[@"状态",@"额定功率",@"今日发电量",@"累计发电量",@"当前功率",@"当前功率",@"当前功率"];
     _twoScrollView.contentSize=CGSizeMake(_cellNameArray.count*W1, H1);
    

    float W_K_0=12*NOW_SIZE;             //平均空隙
    float W1_all=0;
    
    for (int i=0; i<_cellNameArray.count; i++) {
        NSString *nameString=_cellNameArray[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        float W_all_0=W_K_0*2+size.width;
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0+W1_all, 0,W_all_0, H1)];
        lable1.textColor = COLOR(51, 51, 51, 1);
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.text=_cellNameArray[i];
        lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_twoScrollView addSubview:lable1];
        
                     W1_all=W1_all+W_all_0;
    }
    
      _tableW=_cellNameArray.count*W1;
    float H3=ScreenHeight-H1-H2-H1-(NaviHeight);
    _threeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, H1+H2+H1, SCREEN_Width, H3)];
    _threeScrollView.backgroundColor = [UIColor whiteColor];
    _threeScrollView.showsHorizontalScrollIndicator = NO;
    _threeScrollView.bounces = NO;
        _threeScrollView.delegate=self;
    [self.view addSubview:_threeScrollView];
        _threeScrollView.contentSize=CGSizeMake(_tableW, H1);
    

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _tableW, H3) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   _tableView.backgroundColor=COLOR(242, 242, 242, 1);
    [_threeScrollView addSubview:_tableView];
 
    //注册单元格类型
    [_tableView registerClass:[ossNewDeviceCell class] forCellReuseIdentifier:@"CELL1"];
     [_tableView registerClass:[ossNewDeviceTwoCell class] forCellReuseIdentifier:@"CELL2"];
    
}

- (void)addRightItem
{
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"添加设备" iconName:@"DTK_jiangbei" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        
        IntegratorFirst *searchView=[[IntegratorFirst alloc]init];
        [self.navigationController pushViewController:searchView animated:YES];
        
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"展示参数" iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
   
        [self goToChoiceParameter];
        
    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"设备分配" iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        
    }];
    
    _rightMenuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2] icon:@"add@2x.png"];
    //  menuView.intrinsicContentSize=CGSizeMake(44.f, 44.f);
    // menuView.translatesAutoresizingMaskIntoConstraints=true;
    _rightMenuView.dropWidth =150.f;
    _rightMenuView.titleFont = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    _rightMenuView.textColor =COLOR(102, 102, 102, 1);
    _rightMenuView.cellSeparatorColor =COLOR(229, 229, 229, 1);
    _rightMenuView.textFont = [UIFont systemFontOfSize:14.f];
    _rightMenuView.animationDuration = 0.2f;
    
    // _rightMenuView.userInteractionEnabled=YES;
    
    if (deviceSystemVersion>=11.0) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self.rightMenuView action:@selector(pullTheTableView)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightMenuView];
    }
    
    
}

-(void)goToChoiceParameter{
    LRLChannelEditController *channelEdit = [[LRLChannelEditController alloc] initWithTopDataSource:self.topChannelArr andBottomDataSource:self.bottomChannelArr andInitialIndex:self.chooseIndex];
    
    //编辑后的回调
    __weak ossNewDeviceList *weakSelf = self;
    channelEdit.removeInitialIndexBlock = ^(NSMutableArray<LRLChannelUnitModel *> *topArr, NSMutableArray<LRLChannelUnitModel *> *bottomArr){
        weakSelf.topChannelArr = topArr;
        weakSelf.bottomChannelArr = bottomArr;
      //  LRLChannelUnitModel *model =weakSelf.topChannelArr[1];
        NSLog(@"删除了初始选中项的回调:\n保留的频道有: %@", topArr);
    };
    channelEdit.chooseIndexBlock = ^(NSInteger index, NSMutableArray<LRLChannelUnitModel *> *topArr, NSMutableArray<LRLChannelUnitModel *> *bottomArr){
        weakSelf.topChannelArr = topArr;
        weakSelf.bottomChannelArr = bottomArr;
        weakSelf.chooseIndex = index;
        NSLog(@"选中了某一项的回调:\n保留的频道有: %@, 选中第%ld个频道", topArr, index);
    };
    
    channelEdit.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:channelEdit animated:YES completion:nil];
    
}

-(NSMutableArray<LRLChannelUnitModel *> *)topChannelArr{
    if (!_topChannelArr) {
        //这里模拟从本地获取的频道数组
        _topChannelArr = [NSMutableArray array];
        for (int i = 0; i < 50; ++i) {
            LRLChannelUnitModel *channelModel = [[LRLChannelUnitModel alloc] init];
            channelModel.name = [NSString stringWithFormat:@"标题%d", i];
            channelModel.cid = [NSString stringWithFormat:@"%d", i];
            channelModel.isTop = YES;
            [_topChannelArr addObject:channelModel];
        }
    }
    return _topChannelArr;
}
-(NSMutableArray<LRLChannelUnitModel *> *)bottomChannelArr{
    if (!_bottomChannelArr) {
        _bottomChannelArr = [NSMutableArray array];
        for (int i = 30; i < 50; ++i) {
            LRLChannelUnitModel *channelModel = [[LRLChannelUnitModel alloc] init];
            channelModel.name = [NSString stringWithFormat:@"标题气温气温%d", i];
            channelModel.cid = [NSString stringWithFormat:@"%d", i];
            channelModel.isTop = NO;
            [_bottomChannelArr addObject:channelModel];
        }
        
    }
    return _bottomChannelArr;
}



-(void)goToSearch{
    IntegratorFirst *searchView=[[IntegratorFirst alloc]init];

    [self.navigationController pushViewController:searchView animated:YES];
}

-(void)changeTheRowNum:(UITapGestureRecognizer*)tap{
  NSInteger  tagNum=tap.view.tag-2000;
 
    BOOL isSelect=[_selectRowNumArray[tagNum] boolValue];
    isSelect = !isSelect;

    for (int i=0; i<_selectRowNumArray.count; i++) {
                    UIImageView *image0=[self.view viewWithTag:3000+i];
        if (i!=tagNum) {
            image0.image=IMAGE(@"oss_up_down.png");
                [_selectRowNumArray replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
        }else{
            if (isSelect) {
                image0.image=IMAGE(@"oss_up.png");
            }else{
                image0.image=IMAGE(@"oss_down.png");
            }
     
                [_selectRowNumArray replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:isSelect]];
        }

    }
   
}

-(void)changTableView{
    _isChangTableView=!_isChangTableView;
    if (_isChangTableView) {
        [_twoScrollView removeFromSuperview];
             _threeScrollView.frame=CGRectMake(_threeScrollView.frame.origin.x, _threeScrollView.frame.origin.y-40*HEIGHT_SIZE, _threeScrollView.frame.size.width, _threeScrollView.frame.size.height+40*HEIGHT_SIZE);
    }else{
         [self.view addSubview:_twoScrollView];
                  _threeScrollView.frame=CGRectMake(_threeScrollView.frame.origin.x, _threeScrollView.frame.origin.y+40*HEIGHT_SIZE, _threeScrollView.frame.size.width, _threeScrollView.frame.size.height-40*HEIGHT_SIZE);
    }
    
    [_tableView removeFromSuperview];
    _tableView=nil;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _tableW, _threeScrollView.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
      _tableView.backgroundColor=COLOR(242, 242, 242, 1);
    [_threeScrollView addSubview:_tableView];
    
    //注册单元格类型
    [_tableView registerClass:[ossNewDeviceCell class] forCellReuseIdentifier:@"CELL1"];
    [_tableView registerClass:[ossNewDeviceTwoCell class] forCellReuseIdentifier:@"CELL2"];
    
   // [_tableView reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float H=40*HEIGHT_SIZE;

    if (_isChangTableView) {
          NSInteger Num=_cellNameArray2.count/2+_cellNameArray2.count%2;
        H=Num*40*HEIGHT_SIZE+10*HEIGHT_SIZE;
    }
    return H;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.twoScrollView) {
        if (self.twoScrollView.contentOffset.x != self.threeScrollView.contentOffset.x) {
            self.threeScrollView.contentOffset = CGPointMake(self.twoScrollView.contentOffset.x, 0);
        }
    } else if (scrollView == self.threeScrollView) {
        if (self.threeScrollView.contentOffset.x != self.twoScrollView.contentOffset.x) {
            self.twoScrollView.contentOffset = CGPointMake(self.threeScrollView.contentOffset.x, 0);
        }
    } else if ([scrollView isKindOfClass:[UITableView class]]) {

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_isChangTableView) {
        ossNewDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL1" forIndexPath:indexPath];
        
        cell.nameArray=_cellNameArray;
        
        if (!cell) {
            cell=[[ossNewDeviceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL1"];
        }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ossNewDeviceTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL2" forIndexPath:indexPath];
        
        cell.nameArray=_cellNameArray2;
        
        if (!cell) {
            cell=[[ossNewDeviceTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL2"];
        }
        
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
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
