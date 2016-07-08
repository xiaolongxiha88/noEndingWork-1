//
//  myListSecond.m
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "myListSecond.h"
#import "myListSecondTableViewCell.h"
#import "AnswerViewController.h"
#import "GetServerViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0

@interface myListSecond ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *nameArray;
@property(nonatomic,strong)NSMutableArray *nameID;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *timeArray;
@property(nonatomic,strong)NSMutableArray *questionAll;
@property(nonatomic,strong)NSMutableArray *imageName;
@property(nonatomic,strong)NSString *titleString;
@property(nonatomic,strong)NSString *typeString;

@property(nonatomic,strong)NSMutableDictionary *allDic;
@property(nonatomic,strong)UIView *headerView;

@end

@implementation myListSecond

-(void)viewDidAppear:(BOOL)animated
{
   // [self.view removeFromSuperview];
    [self netGetAgain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self netGet];
}

-(void)netGetAgain{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userID=[ud objectForKey:@"userID"];
    self.questionAll =[NSMutableArray array];
    
    self.nameArray =[NSMutableArray array];
    self.contentArray =[NSMutableArray array];
    self.timeArray =[NSMutableArray array];
    self.nameID =[NSMutableArray array];
    self.imageName =[NSMutableArray array];
    self.labelArray=[NSMutableArray arrayWithObjects:root_ME_biaoti,root_NBQ_leixing, root_ME_huifu_jilu,nil];
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"questionId":_qusetionId,@"userId":userID} paramarsSite:@"/questionAPI.do?op=getQuestionInfo" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getQuestionInfo=: %@", content);
        if(content){
            _allDic=[NSMutableDictionary dictionaryWithDictionary:content];
            _titleString=content[@"title"];
            _questionAll=[NSMutableArray arrayWithArray:content[@"serviceQuestionReplyBean"]];
            
           // NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
         //   [_questionAll sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
            
            for(int i=0;i<_questionAll.count;i++){
                NSString *nameU=[NSString stringWithFormat:@"%@",_questionAll[i][@"userName"]];
                NSString *nameId=[NSString stringWithFormat:@"%@",_questionAll[i][@"isAdmin"]];
                NSString *timeA=[NSString stringWithFormat:@"%@",_questionAll[i][@"time"]];
                NSString *contentA=[NSString stringWithFormat:@"%@",_questionAll[i][@"message"]];
                //NSString *imageNameA=[NSString stringWithFormat:@"%@",_questionAll[i][@"imageName"]];
//                                NSString *imageNameA=[NSString stringWithFormat:@"%@",_questionAll[i][@"attachment"]];
                                NSString *questionPIC=[NSString stringWithFormat:@"%@",_questionAll[i][@"attachment"]];
                                NSArray *PIC = [questionPIC componentsSeparatedByString:@"_"];
                
                [_nameArray addObject:nameU];
                [_nameID addObject:nameId];
                [_timeArray addObject:timeA];
                [_contentArray addObject:contentA];
                  [_imageName addObject:PIC];
            }
//              [self initUI];
            if (_scrollView) {
                  [self.tableView reloadData];
            }else{
             [self initUI];
            }
        
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
}

-(void)netGet{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userID=[ud objectForKey:@"userID"];
    
  
     self.questionAll =[NSMutableArray array];
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"questionId":_qusetionId,@"userId":userID} paramarsSite:@"/questionAPI.do?op=getQuestionInfo" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getQuestionInfo=: %@", content);
        if(content){
            _allDic=[NSMutableDictionary dictionaryWithDictionary:content];
            _titleString=content[@"title"];
            _questionAll=[NSMutableArray arrayWithArray:content[@"serviceQuestionReplyBean"]];
            
            for(int i=0;i<_questionAll.count;i++){
                NSString *nameU=[NSString stringWithFormat:@"%@",_questionAll[i][@"userName"]];
                NSString *nameId=[NSString stringWithFormat:@"%@",_questionAll[i][@"isAdmin"]];
                NSString *timeA=[NSString stringWithFormat:@"%@",_questionAll[i][@"time"]];
                NSString *contentA=[NSString stringWithFormat:@"%@",_questionAll[i][@"message"]];
                //NSString *imageNameA=[NSString stringWithFormat:@"%@",_questionAll[i][@"attachment"]];
                NSString *questionPIC=[NSString stringWithFormat:@"%@",_questionAll[i][@"attachment"]];
                NSArray *PIC = [questionPIC componentsSeparatedByString:@"_"];

                [_nameArray addObject:nameU];
                [_nameID addObject:nameId];
                [_timeArray addObject:timeA];
                [_contentArray addObject:contentA];
                  [_imageName addObject:PIC];
                
            }
            [self initUI];
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
}

-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
    float Size1=40*HEIGHT_SIZE;
    
    for(int i=0;i<_labelArray.count;i++)
    {
        UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 16*HEIGHT_SIZE+Size1*i, 80*NOW_SIZE,28*HEIGHT_SIZE )];
         PV1Lable.textAlignment=NSTextAlignmentLeft;
        if (i==2) {
            PV1Lable.frame=CGRectMake(15*NOW_SIZE, 16*HEIGHT_SIZE+Size1*i, 160*NOW_SIZE,28*HEIGHT_SIZE );
            PV1Lable.textAlignment=NSTextAlignmentLeft;
        }
        
        PV1Lable.text=_labelArray[i];
       
        PV1Lable.textColor=[UIColor blackColor];
        PV1Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:PV1Lable];
    }
    
    if (_questionPicArray.count>1) {
        UILabel *_picLabel= [[UILabel alloc] initWithFrame:CGRectMake(220*NOW_SIZE, 96*HEIGHT_SIZE,100*NOW_SIZE, 28*HEIGHT_SIZE)];
        _picLabel.text=root_ME_chakan_tupian;
        _picLabel.textColor=MainColor;
        _picLabel.textAlignment = NSTextAlignmentCenter;
        _picLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        _picLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer * labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GetPhoto)];
        [_picLabel addGestureRecognizer:labelTap1];
        [_scrollView addSubview:_picLabel];
    }
   
  
    for(int i=0;i<2;i++)
    {
        UIView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 42*HEIGHT_SIZE+Size1*i, 310*NOW_SIZE,1*HEIGHT_SIZE )];
        image1.backgroundColor=mainColor;
                [_scrollView addSubview:image1];
        
        UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(85*NOW_SIZE, 16*HEIGHT_SIZE+Size1*i, 210*NOW_SIZE,28*HEIGHT_SIZE )];
        if (i==0) {
               PV2Lable.text=_titleString;
        }else{
          PV2Lable.text=_qusetionType;
        }
        
        PV2Lable.textAlignment=NSTextAlignmentLeft;
        PV2Lable.textColor=[UIColor blackColor];
        PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:PV2Lable];
    }
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE+Size1*3, 310*NOW_SIZE,300*HEIGHT_SIZE )];
    image2.userInteractionEnabled = YES;
    image2.image = IMAGE(@"外框@3x.png");
    [_scrollView addSubview:image2];
    
    /*_scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 55*NOW_SIZE+Size1*3, 300*NOW_SIZE,300*NOW_SIZE )];
    _scrollView2.scrollEnabled=YES;
    _scrollView2.contentSize = CGSizeMake(300*NOW_SIZE,600*NOW_SIZE);
    [self.view addSubview:_scrollView2];*/
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 6*HEIGHT_SIZE+Size1*3, 300*NOW_SIZE,290*HEIGHT_SIZE )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
       [_scrollView addSubview:_tableView];
    
    
    CGRect fcRect = [_qusetionContent boundingRectWithSize:CGSizeMake(300*Width, 1000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 *HEIGHT_SIZE]} context:nil];
   // return 110*HEIGHT_SIZE+fcRect.size.height;
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,10*HEIGHT_SIZE+Size1*3,300*NOW_SIZE,35*HEIGHT_SIZE+fcRect.size.height)];
    _tableView.tableHeaderView = _headerView;
    
    
    UILabel *contentLable=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 210*NOW_SIZE,20*HEIGHT_SIZE )];
        contentLable.text=root_wenti_leirong;
    contentLable.textAlignment=NSTextAlignmentLeft;
    contentLable.textColor=[UIColor blackColor];
    contentLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_headerView addSubview:contentLable];
    
    UILabel *contentLable2=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 28*HEIGHT_SIZE, 290*NOW_SIZE,fcRect.size.height )];
    contentLable2.text=_qusetionContent;
    contentLable2.textAlignment=NSTextAlignmentLeft;
    contentLable2.textColor=[UIColor grayColor];
    contentLable2.numberOfLines=0;
    contentLable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_headerView addSubview:contentLable2];
    
//    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 35*HEIGHT_SIZE+fcRect.size.height, 290*NOW_SIZE,1*HEIGHT_SIZE)];
//    line1.backgroundColor=[UIColor grayColor];
//    [_headerView addSubview:line1];
    
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 315*HEIGHT_SIZE+Size1*3, 310*NOW_SIZE,30*HEIGHT_SIZE )];
    image3.userInteractionEnabled = YES;
    image3.image = IMAGE(@"frame2@2x.png");
    UITapGestureRecognizer * forget=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Answer)];
    [image3 addGestureRecognizer:forget];
    
    [_scrollView addSubview:image3];
    
    
    UILabel *answerLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0, 290*NOW_SIZE,30*HEIGHT_SIZE )];
    answerLable.text=root_ME_huifu;
    answerLable.textAlignment=NSTextAlignmentCenter;
    answerLable.textColor=MainColor;
    answerLable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [image3 addSubview:answerLable];
    
}




-(void)Answer{
    AnswerViewController *AN=[[AnswerViewController alloc]init];
    AN.qusetionId=_qusetionId;
    [self.navigationController pushViewController:AN animated:NO];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myListSecondTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[myListSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell.contentView setBackgroundColor: [UIColor whiteColor] ];
    
    if ([_nameID[indexPath.row] isEqualToString:@"1"]) {
          cell.image.image = IMAGE(@"客服.png");
        cell.nameLabel.textColor = COLOR(63, 163, 220, 1);
    }else{
    cell.image.image = IMAGE(@"客户.png");
         cell.nameLabel.textColor =[UIColor blackColor];
    }
      NSMutableArray *PICarray=[NSMutableArray arrayWithArray:_imageName[indexPath.row]];
    
    if (PICarray.count>1) {
        cell.picLabel.hidden=NO;
        [cell.picArray addObject:PICarray];
    }else{
        cell.picLabel.hidden=YES;
    }
    cell.nameLabel.text= self.nameArray[indexPath.row];
    cell.timeLabel.text= self.timeArray[indexPath.row];
    cell.contentLabel.text= self.contentArray[indexPath.row];
   
    cell.content=self.contentArray[indexPath.row];
    CGRect fcRect = [cell.content boundingRectWithSize:CGSizeMake(300*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 *HEIGHT_SIZE]} context:nil];
    cell.contentLabel.frame =CGRectMake(5*NOW_SIZE, 55*HEIGHT_SIZE, 280*Width, fcRect.size.height);
    
    cell.titleView.frame=CGRectMake(0, 70*HEIGHT_SIZE+fcRect.size.height,SCREEN_WIDTH, 2*HEIGHT_SIZE);
  //  cell.timeLabel.frame=CGRectMake(SCREEN_WIDTH-100*NOW_SIZE, 45*NOW_SIZE+fcRect.size.height,100*NOW_SIZE, 20*NOW_SIZE );
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contentArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGRect fcRect = [self.contentArray[indexPath.row] boundingRectWithSize:CGSizeMake(300*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*HEIGHT_SIZE]} context:nil];
    return 70*HEIGHT_SIZE+fcRect.size.height;
    
}

-(void)GetPhoto{
    GetServerViewController *get=[[GetServerViewController alloc]init];
    
    get.picArray=[NSMutableArray arrayWithArray:_questionPicArray];
    
    [self.navigationController pushViewController:get animated:NO];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *PICarray=[NSMutableArray arrayWithArray:_imageName[indexPath.row]];
  if (PICarray.count>1)
  {
     // NSMutableArray *test=[NSMutableArray arrayWithObject:_imageName[indexPath.row]];
      
      GetServerViewController *get=[[GetServerViewController alloc]init];
      
      get.picArray=[NSMutableArray arrayWithArray:PICarray];
      
      [self.navigationController pushViewController:get animated:NO];
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
