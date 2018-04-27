//
//  ossNewDeviceList.m
//  ShinePhone
//
//  Created by sky on 2018/4/26.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossNewDeviceList.h"
#import "ossNewDeviceCell.h"


@interface ossNewDeviceList ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *oneScrollView;
@property (nonatomic, strong) UIScrollView *twoScrollView;
@property (nonatomic, strong) UIScrollView *threeScrollView;
@property (nonatomic, strong) NSArray *oneParaArray;
@property (nonatomic, strong) NSArray *cellNameArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign)float tableH;
@end

@implementation ossNewDeviceList

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

-(void)initUI{
    _oneParaArray=@[@"状态",@"额定功率",@"今日发电量",@"累计发电量",@"当前功率"];
    

    
    float H1=30*HEIGHT_SIZE;
    _oneScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, H1)];
    _oneScrollView.backgroundColor = [UIColor whiteColor];
    _oneScrollView.showsHorizontalScrollIndicator = NO;
    _oneScrollView.bounces = NO;
    [self.view addSubview:_oneScrollView];
    
    float W1=70*NOW_SIZE;
    
    for (int i=0; i<_oneParaArray.count; i++) {
        UIView *View1 = [[UIView alloc]initWithFrame:CGRectMake(0+W1*i, 0*HEIGHT_SIZE, W1,H1)];
        View1.backgroundColor = [UIColor clearColor];
        [_oneScrollView addSubview:View1];
        
        UILabel *lableR = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,W1, H1)];
        lableR.textColor = COLOR(102, 102, 102, 1);
        lableR.textAlignment=NSTextAlignmentCenter;
        lableR.text=_oneParaArray[i];
        lableR.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [View1 addSubview:lableR];
    }
   
    _oneScrollView.contentSize=CGSizeMake(_oneParaArray.count*W1, H1);
    
      float H2=40*HEIGHT_SIZE;
    
  
    _twoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, H1+H2, SCREEN_Width, H1)];
    _twoScrollView.backgroundColor = [UIColor whiteColor];
    _twoScrollView.showsHorizontalScrollIndicator = NO;
    _twoScrollView.delegate=self;
    _twoScrollView.bounces = NO;
    [self.view addSubview:_twoScrollView];
    
    _cellNameArray=@[@"状态",@"额定功率",@"今日发电量",@"累计发电量",@"当前功率",@"当前功率",@"当前功率"];
     _twoScrollView.contentSize=CGSizeMake(_cellNameArray.count*W1, H1);
    
    for (int i=0; i<_cellNameArray.count; i++) {
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0+W1*i, 0,W1, H1)];
        lable1.textColor = COLOR(51, 51, 51, 1);
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.text=_cellNameArray[i];
        lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_twoScrollView addSubview:lable1];
    }
    
    
    float H3=ScreenHeight-H1-H2-H1-(NaviHeight);
    _threeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, H1+H2+H1, SCREEN_Width, H3)];
    _threeScrollView.backgroundColor = [UIColor whiteColor];
    _threeScrollView.showsHorizontalScrollIndicator = NO;
    _threeScrollView.bounces = NO;
        _threeScrollView.delegate=self;
    [self.view addSubview:_threeScrollView];
        _threeScrollView.contentSize=CGSizeMake(_cellNameArray.count*W1, H1);
    
    _tableH=30*HEIGHT_SIZE;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _cellNameArray.count*W1, H3) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight=_tableH;
    [_threeScrollView addSubview:_tableView];
 
    //注册单元格类型
    [_tableView registerClass:[ossNewDeviceCell class] forCellReuseIdentifier:@"CELL1"];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 18;
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
    
    ossNewDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL1" forIndexPath:indexPath];
 
       cell.nameArray=_cellNameArray;
    
    if (!cell) {
        cell=[[ossNewDeviceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL1"];
    }
    
 
    
    
    return cell;
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
