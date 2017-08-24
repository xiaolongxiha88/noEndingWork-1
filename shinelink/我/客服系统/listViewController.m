//
//  listViewController.m
//  shinelink
//
//  Created by sky on 16/2/29.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "listViewController.h"
#import "listTableViewCell.h"
#import "myListSecond.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0

@interface listViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *questionTypeArray;
@property(nonatomic,strong)NSMutableArray *statusArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *contentSecondArray;
@property(nonatomic,strong)NSMutableArray *timeArray;
@property(nonatomic,strong)NSMutableArray *allArray;
@property(nonatomic,strong)NSMutableArray *questionID;
@property(nonatomic,strong)NSMutableArray *questionPicArray;
@property(nonatomic,strong)NSMutableArray *answerName;
@property(nonatomic,strong)NSString *delQuestionID;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong)  NSString *languageValue ;
@property (nonatomic, strong)  UIImageView *AlertView ;
@end

@implementation listViewController

-(void)viewWillAppear:(BOOL)animated{
      [self hideProgressView];
    [self netquestion];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self.navigationController.navigationBar setBarTintColor:MainColor];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
 //   [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        _languageValue=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }

    self.navigationItem.title = root_ME_wenti_liebiao;
    
    float H1=[[UIApplication sharedApplication] statusBarFrame].size.height;
    float H2=self.navigationController.navigationBar.frame.size.height;
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-H1-H2-30*HEIGHT_SIZE)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // self.tableView.separatorStyle=NO;
    self.tableView.backgroundColor=COLOR(240, 242, 239, 1);
    //   self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.scrollEnabled = YES;
    _tableView.showsVerticalScrollIndicator = YES;
  //  self.tableView.contentSize = [self.tableView sizeThatFits:CGSizeMake(CGRectGetWidth(self.tableView.bounds), CGFLOAT_MAX)];
    
    [self.view addSubview:_tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
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

-(void)netquestion{

    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userID=[ud objectForKey:@"userID"];
    
    self.titleArray =[NSMutableArray array];
    self.statusArray =[NSMutableArray array];
    self.contentArray =[NSMutableArray array];
    self.timeArray =[NSMutableArray array];
    self.questionID=[NSMutableArray array];
    self.questionTypeArray=[NSMutableArray array];
    self.questionPicArray=[NSMutableArray array];
    self.contentSecondArray=[NSMutableArray array];
    self.answerName=[NSMutableArray array];
    
      [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL_Demo paramars:@{@"userId":userID} paramarsSite:@"/api/v2/question/list" sucessBlock:^(id content1) {
        [self hideProgressView];
 
        if(content1){
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content1 options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"/api/v2/question/list:%@",jsonObj);
            
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:jsonObj];
            if ([firstDic[@"result"] intValue]==1) {
                
                _allArray=[NSMutableArray arrayWithArray:firstDic[@"obj"]];
                
                if(_allArray.count==0){
                    
                    if (!_AlertView) {
                        if ([_languageValue isEqualToString:@"0"]) {
                            _AlertView=[[UIImageView alloc]initWithFrame:CGRectMake(0.1* SCREEN_Width, 100*HEIGHT_SIZE,0.8* SCREEN_Width, 0.294* SCREEN_Width)];
                            _AlertView.image=[UIImage imageNamed:@"Prompt_message_cn2.png"];
                            [self.view addSubview:_AlertView];
                        }else{
                            _AlertView=[[UIImageView alloc]initWithFrame:CGRectMake(0.1* SCREEN_Width, 100*HEIGHT_SIZE,0.8* SCREEN_Width, 0.294* SCREEN_Width)];
                            _AlertView.image=[UIImage imageNamed:@"Prompt message_en2.png"];
                            [self.view addSubview:_AlertView];
                        }
                    }
                    
                    //                if (_tableView) {
                    //                    [_tableView removeFromSuperview];
                    //                    _tableView=nil;
                    //                }
                    [self.tableView reloadData];
                    
                }
                
                if (_allArray.count>0) {
                    
                    NSArray *content = [_allArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                        
                        //      return [obj2[@"status"] compare:obj1[@"status"]]; //升序
                        return [obj1[@"status"] compare:obj2[@"status"]];
                        
                    }];
                    
                    if (_AlertView) {
                        [_AlertView removeFromSuperview];
                        _AlertView=nil;
                    }
                    
                    for(int i=0;i<content.count;i++){
                        
                        
                        NSString *title=[NSString stringWithFormat:@"%@",content[i][@"title"]];
                        NSString *status=[NSString stringWithFormat:@"%@",content[i][@"status"]];
                        NSString *contentS1=[NSString stringWithFormat:@"%@",content[i][@"content"]];
                        NSString *time=[NSString stringWithFormat:@"%@",content[i][@"lastTime"]];
                        NSString *question=[NSString stringWithFormat:@"%@",content[i][@"id"]];
                        NSString *questiontype=[NSString stringWithFormat:@"%@",content[i][@"questionType"]];
                        NSString *questionPIC=[NSString stringWithFormat:@"%@",content[i][@"attachment"]];
                        NSArray *PIC = [questionPIC componentsSeparatedByString:@"_"];
                        
                        NSArray *contentS2=[NSArray arrayWithArray:content[i][@"questionReply"]];
                        if (contentS2.count>0) {
                            if(contentS2[0] != nil && ![(NSArray*)contentS2[0] isKindOfClass:[NSNull class]] && ((NSArray*)contentS2[0]).count !=0)
                            {
                                
                                
                                if ([contentS2[0][@"message"] length]>0) {
                                    NSString *contentS3=[NSString stringWithFormat:@"%@",contentS2[0][@"message"]];
                                    [_contentArray addObject:contentS3];
                                    
                                    NSString *contentS4=[NSString stringWithFormat:@"%@:",contentS2[0][@"userName"]];
                                    [_answerName addObject:contentS4];
                                    
                                }else{
                                    [_answerName addObject:root_wenti_leirong];
                                    [_contentArray addObject:contentS1];
                                }
                            }else{
                                [_answerName addObject:root_wenti_leirong];
                                [_contentArray addObject:contentS1];
                            }
                        }else{
                            [_answerName addObject:root_wenti_leirong];
                            [_contentArray addObject:contentS1];

                        }
                       
                        
                        
                        
                        [_contentSecondArray addObject:contentS1];
                        [_questionPicArray addObject:PIC];
                        [_titleArray addObject:title];
                        [_statusArray addObject:status];
                        
                        [_timeArray addObject:time];
                        [_questionID addObject:question];
                        [_questionTypeArray addObject:questiontype];
                    }
                    if (_titleArray.count==_allArray.count) {
                        
                        [self.tableView reloadData];
                    }
                    
                    //   NSLog(@"questionList=22");
                }
                
            }else{
            [self showToastViewWithTitle:root_server_error];
            }
            
           
        }
        //  NSLog(@"questionList=33");
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableViewDelegate&DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    listTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[listTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
     [cell.contentView setBackgroundColor: [UIColor whiteColor] ];
    
    //_statusArray[indexPath.row]=@"1";
    if (_statusArray.count>0) {
        
            if ([_statusArray[indexPath.row] isEqualToString:@"0"]) {
              cell.coverImageView.backgroundColor=COLOR(227, 74, 33, 1);
                cell.imageLabel.text=root_daichuli;
            }else if ([_statusArray[indexPath.row] isEqualToString:@"1"]){
                cell.coverImageView.backgroundColor=COLOR(94, 195, 53, 1);
                cell.imageLabel.text=root_chulizhong;
            }else if([_statusArray[indexPath.row] isEqualToString:@"2"]){
                cell.coverImageView.backgroundColor=COLOR(157, 157, 157, 1);
                cell.imageLabel.text=root_yichuli;
            }else if([_statusArray[indexPath.row] isEqualToString:@"3"]){
                cell.coverImageView.backgroundColor=COLOR(227, 164, 33, 1);
                cell.imageLabel.text=root_daigengjin;
            }
   
    }
    
   
    if (_titleArray.count>0) {
        NSString *contentLabel_1=_answerName[indexPath.row];
        NSString *contentLabel_2=_contentArray[indexPath.row];
        NSString *contentLabel_3=[NSString stringWithFormat:@"%@%@",contentLabel_1,contentLabel_2];

        cell.titleLabel.text= self.titleArray[indexPath.row];
        cell.contentLabel.text= contentLabel_3;
        cell.timeLabel.text=self.timeArray[indexPath.row];
    }
   
    
 
    
    
      // cell.statusLabel.text= self.statusArray[indexPath.row];
    
    //cell.content=self.contentArray[indexPath.row];
    
    
//    CGRect fcRect = [cell.content boundingRectWithSize:CGSizeMake(300*Width, 1000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*HEIGHT_SIZE]} context:nil];
//     cell.contentLabel.frame =CGRectMake(10*NOW_SIZE, 45*HEIGHT_SIZE, 300*NOW_SIZE, fcRect.size.height);
//   cell.timeLabel.frame=CGRectMake(SCREEN_WIDTH-210*NOW_SIZE, 80*HEIGHT_SIZE+fcRect.size.height,200*NOW_SIZE, 20*HEIGHT_SIZE );
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
     //NSLog(@"content=%@",cell.content);
  
//    cell.view1.frame=CGRectMake(0, 80*HEIGHT_SIZE+fcRect.size.height+20*HEIGHT_SIZE,SCREEN_Width, 10*HEIGHT_SIZE );
 
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellDidLongPressed:)];
    longPressGesture.minimumPressDuration = 1.0f;
    [cell addGestureRecognizer:longPressGesture];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)cellDidLongPressed:(id)sender{
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
   // UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    _delQuestionID=_questionID[indexPath.row];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: root_ME_shanchu_liebiao style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
        [self delQuestion];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
    
    
    [self presentViewController: alertController animated: YES completion: nil];
    
}


-(void)delQuestion{

    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"questionId":_delQuestionID} paramarsSite:@"/questionAPI.do?op=deleteQuestion" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"deleteQuestion=: %@", content);
          id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"deleteQuestion=: %@", jsonObj);
        if([[jsonObj objectForKey:@"success"] integerValue]==1){
           
             [self showAlertViewWithTitle:nil message:root_shanchu_chenggong cancelButtonTitle:root_Yes];
        }else{
            if ([[jsonObj objectForKey:@"success"] integerValue] ==0) {
                if ([[jsonObj objectForKey:@"msg"]integerValue]==501) {
                  [self showAlertViewWithTitle:nil message:root_shanchu_shibai cancelButtonTitle:root_Yes];
                }else if ([[jsonObj objectForKey:@"msg"]integerValue] ==701) {
                    [self showAlertViewWithTitle:nil message:root_zhanghu_meiyou_quanxian cancelButtonTitle:root_Yes];
                }
            }

            
            
        }
        
        [self netquestion];
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_questionID.count>0) {
        myListSecond *second=[[myListSecond alloc]init];
        second.qusetionId=_questionID[indexPath.row];
        second.qusetionType=_questionTypeArray[indexPath.row];
        second.questionPicArray=[NSMutableArray arrayWithArray:_questionPicArray[indexPath.row]];
        second.qusetionContent=_contentSecondArray[indexPath.row];
        [self.navigationController pushViewController:second animated:NO];
    }else{
      [self netquestion];
    }
   
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
//    CGRect fcRect = [self.contentArray[indexPath.row] boundingRectWithSize:CGSizeMake(300*Width, 1000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 *HEIGHT_SIZE]} context:nil];
//    return 110*HEIGHT_SIZE+fcRect.size.height;
    
    return 60*HEIGHT_SIZE;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}


@end
