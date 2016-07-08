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
@end

@implementation listViewController

-(void)viewWillAppear:(BOOL)animated{
    [self netquestion];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self.navigationController.navigationBar setBarTintColor:COLOR(17, 183, 243, 1)];
    
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
   
    
    if ([currentLanguage isEqualToString:@"zh-Hans-CN"]) {
        _languageValue=@"0";
    }else if ([currentLanguage isEqualToString:@"en-CN"]){
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }

    self.navigationItem.title = root_ME_wenti_liebiao;
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100*HEIGHT_SIZE)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // self.tableView.separatorStyle=NO;
    self.tableView.backgroundColor=COLOR(240, 242, 239, 1);
    //   self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.scrollEnabled = YES;
    _tableView.showsVerticalScrollIndicator = YES;
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
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"userId":userID} paramarsSite:@"/questionAPI.do?op=questionList" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"questionList=: %@", content);
        if(content){
            _allArray=[NSMutableArray arrayWithArray:content];
            for(int i=0;i<_allArray.count;i++){
                
                NSString *title=[NSString stringWithFormat:@"%@",content[i][@"title"]];
                NSString *status=[NSString stringWithFormat:@"%@",content[i][@"status"]];
                NSString *contentS1=[NSString stringWithFormat:@"%@",content[i][@"content"]];
                NSString *time=[NSString stringWithFormat:@"%@",content[i][@"lastTime"]];
                NSString *question=[NSString stringWithFormat:@"%@",content[i][@"id"]];
                NSString *questiontype=[NSString stringWithFormat:@"%@",content[i][@"questionType"]];
                NSString *questionPIC=[NSString stringWithFormat:@"%@",content[i][@"attachment"]];
                NSArray *PIC = [questionPIC componentsSeparatedByString:@"_"];
                
                 NSArray *contentS2=[NSArray arrayWithArray:content[i][@"serviceQuestionReplyBean"]];
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
                
                [_contentSecondArray addObject:contentS1];
                [_questionPicArray addObject:PIC];
                [_titleArray addObject:title];
                [_statusArray addObject:status];
              
                [_timeArray addObject:time];
                [_questionID addObject:question];
                [_questionTypeArray addObject:questiontype];
            }
            [self.tableView reloadData];
           
        }
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
    
    
    if ([_languageValue isEqualToString:@"0"]) {
        
        if ([_statusArray[indexPath.row] isEqualToString:@"0"]) {
            [cell.coverImageView  setImage:[UIImage imageNamed:@"待处理.png"]];
        }else if ([_statusArray[indexPath.row] isEqualToString:@"1"]){
            [cell.coverImageView  setImage:[UIImage imageNamed:@"处理中.png"]];
        }else if([_statusArray[indexPath.row] isEqualToString:@"2"]){
            [cell.coverImageView  setImage:[UIImage imageNamed:@"已处理.png"]];
        }
    }else{
        if ([_statusArray[indexPath.row] isEqualToString:@"0"]) {
            [cell.coverImageView  setImage:[UIImage imageNamed:@"Pend-ing.png"]];
        }else if ([_statusArray[indexPath.row] isEqualToString:@"1"]){
            [cell.coverImageView  setImage:[UIImage imageNamed:@"Proce-ssing.png"]];
        }else if([_statusArray[indexPath.row] isEqualToString:@"2"]){
            [cell.coverImageView  setImage:[UIImage imageNamed:@"Proce-ssed.png"]];
        }
    
    }
    
   
    
    NSString *contentLabel_1=_answerName[indexPath.row];
    NSString *contentLabel_2=_contentArray[indexPath.row];
    NSString *contentLabel_3=[NSString stringWithFormat:@"%@%@",contentLabel_1,contentLabel_2];
    
    
    cell.titleLabel.text= self.titleArray[indexPath.row];
    cell.contentLabel.text= contentLabel_3;
    cell.timeLabel.text=self.timeArray[indexPath.row];
    
    
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

    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"questionId":_delQuestionID} paramarsSite:@"/questionAPI.do?op=deleteQuestion" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"deleteQuestion=: %@", content);
          id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"deleteQuestion=: %@", jsonObj);
        if([[jsonObj objectForKey:@"success"] integerValue]==1){
           
             [self showAlertViewWithTitle:nil message:root_shanchu_chenggong cancelButtonTitle:root_Yes];
        }else{
        
             [self showAlertViewWithTitle:nil message:root_shanchu_shibai cancelButtonTitle:root_Yes];
        }
        
        [self netquestion];
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myListSecond *second=[[myListSecond alloc]init];
    second.qusetionId=_questionID[indexPath.row];
    second.qusetionType=_questionTypeArray[indexPath.row];
    second.questionPicArray=[NSMutableArray arrayWithArray:_questionPicArray[indexPath.row]];
    second.qusetionContent=_contentSecondArray[indexPath.row];
    [self.navigationController pushViewController:second animated:NO];
    
    
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
