//
//  orderFirst.m
//  ShinePhone
//
//  Created by sky on 2017/6/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "orderFirst.h"
#import "orderCellOne.h"
#import "orderCellTwo.h"
#import "orderCellThree.h"
#import "Model.h"


static NSString *cellOne = @"cellOne";
static NSString *cellTwo = @"cellTwo";
static NSString *cellThree = @"cellThree";


@interface orderFirst ()<UITableViewDataSource,UITableViewDelegate>{
    float H2;
    float H1;
    float allH;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *titleStatusArray;
@property(nonatomic,strong)NSMutableArray *isShowArray;


@property(nonatomic,strong)NSString *contentString;

@end

@implementation orderFirst{
    NSArray<Model*> *_modelList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    H2=self.navigationController.navigationBar.frame.size.height;
    H1=[[UIApplication sharedApplication] statusBarFrame].size.height;
   
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"待接收",@"title",@"ssssaasdasdasdasdasdasdasdasdasdadsadasdsadasdasdasdasdasdasdasdasdasdssss",@"content", nil];
     NSMutableArray<Model *> *arrM = [NSMutableArray arrayWithCapacity:3];
    for (int i=0; i<3; i++) {
        Model *model = [[Model alloc] initWithDict:dic];
        [arrM addObject:model];
    }
       _modelList = arrM.copy;
    
    [self initData];
   
}

-(void)initData{
    _titleArray=[NSArray arrayWithObjects:@"待接收",@"服务中",@"已完成", nil];
    _isShowArray=[NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];

     [self initHeadView];
}

-(void)initUI{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0, SCREEN_Width,SCREEN_Height-H2-H1 )];
        _tableView.delegate = self;
        _tableView.dataSource = self;
         _tableView.tableHeaderView=_headView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            [self.tableView registerClass:[orderCellOne class] forCellReuseIdentifier:cellOne];
          [self.tableView registerClass:[orderCellTwo class] forCellReuseIdentifier:cellTwo];
         [self.tableView registerClass:[orderCellThree class] forCellReuseIdentifier:cellThree];
        [self.view addSubview:_tableView];
    }
    
    
}


-(void)initHeadView{
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width,90*HEIGHT_SIZE )];
    _headView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:_headView];
    
    float titleLabelH1=30*HEIGHT_SIZE; float firstW1=10*HEIGHT_SIZE;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstW1, 0, SCREEN_Width-(2*firstW1), titleLabelH1)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text=@"接收接收接收接收接收";
    titleLabel.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_headView addSubview:titleLabel];

    float ImageW1=16*HEIGHT_SIZE;
    UIImageView *titleImage= [[UIImageView alloc]initWithFrame:CGRectMake(firstW1, titleLabelH1+1*HEIGHT_SIZE, ImageW1, ImageW1)];
    titleImage.image=IMAGE(@"workorder_icon.png");
    [_headView addSubview:titleImage];
    
    float titleLabelH2=20*HEIGHT_SIZE;float headW=SCREEN_Width-(2*firstW1);
    UILabel *titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(firstW1+ImageW1+5*NOW_SIZE, titleLabelH1,headW, titleLabelH2)];
    titleLabel2.textColor = COLOR(51, 51, 51, 1);
    titleLabel2.text=@"基本信息";
    titleLabel2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_headView addSubview:titleLabel2];
   
       NSArray *headName=[NSArray arrayWithObjects:@"姓名",@"联系方式", nil];
     NSArray *headValue=[NSArray arrayWithObjects:@"张三",@"123123211123", nil];
    for (int i=0; i<headName.count; i++) {
        UILabel *titleLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(firstW1+(headW/2)*i, titleLabelH1+titleLabelH2,headW/2, titleLabelH2)];
        titleLabel3.textColor = COLOR(102, 102, 102, 1);
        titleLabel3.textAlignment=NSTextAlignmentLeft;
        NSString *name=[NSString stringWithFormat:@"%@:%@",headName[i],headValue[i]];
        titleLabel3.text=name;
        titleLabel3.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_headView addSubview:titleLabel3];
    }
    
    UILabel *titleLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(firstW1, titleLabelH1+titleLabelH2*2,headW, titleLabelH2)];
    titleLabel4.textColor = COLOR(102, 102, 102, 1);
    titleLabel4.textAlignment=NSTextAlignmentLeft;
    NSString *name1=[NSString stringWithFormat:@"%@:%@",@"类型",@"维修服务"];
    titleLabel4.text=name1;
    titleLabel4.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_headView addSubview:titleLabel4];
    
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _modelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        orderCellOne *cell = [tableView dequeueReusableCellWithIdentifier:cellOne forIndexPath:indexPath];
            Model *model = _modelList[indexPath.row];
        cell.model = model;
    
        [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
            NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
            [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
           return cell;
    }else if (indexPath.row==1) {
        orderCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:cellTwo forIndexPath:indexPath];
        cell.titleLabel.text=_titleArray[indexPath.row];
        cell.titleString=_titleArray[indexPath.row];
        cell.contentString=@"jaidjsaidaadasdsadddddddddddddddddasd";
        [cell setShowMoreData:^(NSArray* dataArray){
             NSString *dataString=dataArray.firstObject;
            [_isShowArray setObject:dataString atIndexedSubscript:indexPath.row];
            
        }];
        
        [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
            NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
            [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        return cell;
    }else if (indexPath.row==2) {
        orderCellThree *cell = [tableView dequeueReusableCellWithIdentifier:cellThree forIndexPath:indexPath];
        cell.titleLabel.text=_titleArray[indexPath.row];
        cell.titleString=_titleArray[indexPath.row];
        cell.contentString=@"jaidjsaida22222222222222222222222222222222";
        [cell setShowMoreData:^(NSArray* dataArray){
               NSString *dataString=dataArray.firstObject;
            [_isShowArray setObject:dataString atIndexedSubscript:indexPath.row];
            
        }];
        
        [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
            NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
            [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        return cell;
    }else{
    
        return nil;
    }

    
 
}

// MARK: - 返回cell高度的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat H=H1+H2;
      Model *model = _modelList[indexPath.row];
    
    if (model.isShowMoreText){
        if (indexPath.row==0) {
             return [orderCellOne moreHeight:H];
        }else if (indexPath.row==1){
           return [orderCellTwo moreHeight:_contentString];
        }else if (indexPath.row==2){
               return [orderCellThree moreHeight:_contentString];
        }else{
            return 1*HEIGHT_SIZE;
        }
       
    } else{
        if (indexPath.row==0) {
           return [orderCellOne defaultHeight];
        }else if (indexPath.row==1){
          return [orderCellTwo defaultHeight];
        }else if (indexPath.row==2){
          return [orderCellThree defaultHeight];
        }else{
            return 1*HEIGHT_SIZE;
        }
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
