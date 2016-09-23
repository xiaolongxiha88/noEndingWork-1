//
//  questionView.m
//  ShinePhone
//
//  Created by sky on 16/9/20.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "questionView.h"
#import "QuestionTableViewCell.h"
#import "HtmlCommon.h"

@interface questionView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *idArray;
@property(nonatomic,strong)NSMutableArray *titleArray;

@end

@implementation questionView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _idArray=[NSMutableArray array];
    _titleArray=[NSMutableArray array];
    
    

    [self initUI];
    
}


-(void)getNet{
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSString *_languageValue ;
    
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        _languageValue=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }
    
    NSDictionary *dicGo=@{@"type":@"0",@"language":_languageValue} ;
    
    [self showProgressView];
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:dicGo paramarsSite:@"/questionAPI.do?op=getUsQuestionListByType" sucessBlock:^(id content) {
        NSLog(@"getUsQuestionListByType: %@", content);
        [self hideProgressView];
        if (content) {
            
            NSMutableArray *allDic=[NSMutableArray arrayWithArray:content[@"obj"]];
            for (int i=0; i<allDic.count; i++) {
                [_idArray addObject:allDic[i][@"id"]];
                [_titleArray addObject:allDic[i][@"title"]];
            }
            if (_idArray.count==allDic.count) {
                [self.tableView reloadData];
            }
            
            
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
    
    
}


-(void)initUI{

    UIView *greenView=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 5*HEIGHT_SIZE, SCREEN_Width-20*NOW_SIZE, 40*HEIGHT_SIZE)];
    greenView.layer.cornerRadius= 5*HEIGHT_SIZE;
    greenView.layer.masksToBounds = YES;
    greenView.backgroundColor=COLOR(32, 213, 147, 1);
    [self.view addSubview:greenView];
    
    UIImageView *aletImage=[[UIImageView alloc] initWithFrame:CGRectMake(8*HEIGHT_SIZE, 8*HEIGHT_SIZE, 24*HEIGHT_SIZE, 24*HEIGHT_SIZE)];
    aletImage.image=IMAGE(@"question_icon.png");
    [greenView addSubview:aletImage];
    
    UILabel *CellName = [[UILabel alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width-50*NOW_SIZE, 40*HEIGHT_SIZE)];
     CellName.font=[UIFont systemFontOfSize:17*HEIGHT_SIZE];
    CellName.textColor=[UIColor whiteColor];
   CellName.textAlignment = NSTextAlignmentLeft;
    CellName.text=root_changjian_wenti;
     [greenView addSubview:CellName];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 50*HEIGHT_SIZE, SCREEN_Width, SCREEN_Height-50*HEIGHT_SIZE) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
        [self getNet];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50*HEIGHT_SIZE;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QuestionTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[QuestionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
     cell.CellName.text=_titleArray[indexPath.row];
    NSString *LableNum=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    cell.LableView.text=LableNum;
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    Common2ViewController *go=[[Common2ViewController alloc]init];
    //    go.titleString=_titleArray[indexPath.row];
    //    go.idString=_idArray[indexPath.row];
    
    HtmlCommon *go=[[HtmlCommon alloc]init];
    
    go.idString=_idArray[indexPath.row];
    
    [self.navigationController pushViewController:go animated:NO];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
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
