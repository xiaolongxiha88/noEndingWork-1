//
//  AvCachViewController.m
//  ShinePhone
//
//  Created by sky on 16/9/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "AvCachViewController.h"
#import "AvCachTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AVViewController.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define APPCOLOR [UIColor colorWithRed:101.0/255 green:163.0/255 blue:57.0/255 alpha:1.0]


@interface AvCachViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *myTableView;
//底部控件
@property (nonatomic,strong)UIView *footerView;
@property (nonatomic,strong)UIButton *allDelButton;
@property (nonatomic,strong)UIButton *delButton;
/** 标记是否全选 */
@property (nonatomic ,assign)BOOL isSelected;
@property (nonatomic, strong) NSMutableArray *tableCellPic;
@property (nonatomic, strong) NSMutableArray *tableCellName;
@property (nonatomic, strong) NSMutableArray *tableCellUrl;
@property (nonatomic, strong) NSMutableArray *tableCellContent;


@property (nonatomic, strong) NSMutableArray *cachWay;
@property (nonatomic, strong)NSFileManager *fileManager;

@end

@implementation AvCachViewController
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray = [NSMutableArray arrayWithObjects:@"我是第一个视频",@"我是第二个视频但是我很黄很暴力",@"我不是第一个视频但是我不黄不暴力",nil];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"编辑列表";
    
    self.view.backgroundColor=MainColor;
    CGFloat footH=40*HEIGHT_SIZE;
    
    [self initData];
    // Do any additional setup after loading the view, typically from a nib.
       self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-footH-self.navigationController.navigationBar.frame.size.height-[[UIApplication sharedApplication] statusBarFrame].size.height)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.backgroundColor = [UIColor whiteColor];
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:self.myTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editList)];
    
    
   // CGFloat footY=SCREENHEIGHT-footH;
   // float footerViewH=CGRectGetMaxY(_myTableView.frame);
    _footerView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_Height-footH-self.navigationController.navigationBar.frame.size.height-[[UIApplication sharedApplication] statusBarFrame].size.height, SCREENWIDTH, footH)];
    _footerView.alpha=0;
    _footerView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:_footerView];
    
    _allDelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _allDelButton.frame=CGRectMake(0, 0,  _footerView.frame.size.width*0.5, footH);
    [_allDelButton setTitle:@"全选" forState:UIControlStateNormal];
    [_allDelButton addTarget:self action:@selector(allDelBtn) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_allDelButton];
    
    _delButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _delButton.frame=CGRectMake(_footerView.frame.size.width*0.5, 0, _footerView.frame.size.width*0.5, footH);
    [_delButton setTitle:@"删除" forState:UIControlStateNormal];
    [_delButton setBackgroundColor:APPCOLOR];
    [_delButton addTarget:self action:@selector(deltButn) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_delButton];
}

-(void)initData{

    _dataArray = [NSMutableArray array];
     _tableCellPic = [NSMutableArray array];
    _cachWay=[NSMutableArray array];
    
     _tableCellName=[NSMutableArray array];
     _tableCellUrl=[NSMutableArray array];
     _tableCellContent=[NSMutableArray array];
    
//    _tableCellPic =[NSMutableArray arrayWithObjects:@"pic_service.png",@"pic_service.png",@"pic_service.png",nil];
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSMutableArray *AvPicUrl3 =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"AvPicUrl"]];
    NSMutableArray *AvUrl3 =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"AvUrl"]];
    NSMutableArray *AvName3 =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"AvName"]];
    NSMutableArray *AvOutline3 =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"AvOutline"]];
    
    
    
    _fileManager=[NSFileManager defaultManager];
    //这里自己写需要保存数据的路径
    NSString *cachPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSArray *childFiles = [_fileManager subpathsAtPath:cachPath];
    for (NSString *fileName in childFiles) {
        //如有需要，加入条件，过滤掉不想删除的文件
        NSLog(@"%@", fileName);
        if ([fileName.pathExtension isEqualToString:@"mp4"]) {
            
            NSArray *arr = [fileName componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"*"]];
            
            NSString *AvName1=[arr lastObject];
            
                        NSArray *arr1 = [AvName1 componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"."]];
            
            NSString *AvName=[arr1 firstObject];
            
           
            
            NSString *absolutePath=[cachPath stringByAppendingPathComponent:fileName];
          
            if (![AvName isEqualToString:@"temp"]) {
                
                for (int i=0; i<AvUrl3.count; i++) {
                    
                    NSString *AV=[NSString stringWithFormat:@"%@",AvUrl3[i]];
                    
                    
                    if( [AV containsString:AvName]){
                        [_tableCellName addObject:AvName3[i]];
                         [_tableCellUrl addObject:AvUrl3[i]];
                         [_tableCellPic addObject:AvPicUrl3[i]];
                          [_dataArray addObject:AvName3[i]];
                             [_cachWay addObject:absolutePath];
                        [_tableCellContent addObject:AvOutline3[i]];
                        
                    }
                    
                }
                
           
        
                
            }
            
      
            
           // [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    
   
    

    
}


-(void)editList
{
    self.isSelected = NO;//全选状态的切换
    NSString *string = !self.myTableView.editing?@"完成":@"编辑";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:string style:UIBarButtonItemStyleDone target:self action:@selector(editList)];
    if (self.dataArray.count) {
        [UIView animateWithDuration:0.25 animations:^{
            _footerView.alpha=!self.myTableView.editing?1:0;
            
        }];
    }
    else{
        [UIView animateWithDuration:0.25 animations:^{
            
            self.footerView.alpha=0;
        }];
    }
    
//    if ( _footerView.alpha==1) {
//           CGFloat footH=40*HEIGHT_SIZE;
//       self.myTableView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-footH-self.navigationController.navigationBar.frame.size.height-[[UIApplication sharedApplication] statusBarFrame].size.height);
//    }
    
    self.myTableView.editing = !self.myTableView.editing;
}

#pragma mark - 多选删除

-(void)deltButn
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除视频" message:@"确定删除视频?" delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_OK, nil];
    alertView.tag = 1002;
    [alertView show];
  }



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

        if (alertView.tag == 1002) {
            if (buttonIndex==1) {
                
                
    NSMutableArray *deleteArrarys = [NSMutableArray array];
    NSMutableArray *deleteArrarys2 = [NSMutableArray array];
    NSMutableArray *deleteArrarys3 = [NSMutableArray array];
                    NSMutableArray *deleteArrarys4 = [NSMutableArray array];
                
                    NSMutableArray *deleteArrarys6 = [NSMutableArray array];
                    NSMutableArray *deleteArrarys7 = [NSMutableArray array];
                
    
    for (NSIndexPath *indexPath in self.myTableView.indexPathsForSelectedRows) {
        [deleteArrarys addObject:self.dataArray[indexPath.row]];
        [deleteArrarys2 addObject:self.tableCellPic[indexPath.row]];
        [deleteArrarys3 addObject:self.cachWay[indexPath.row]];
              [deleteArrarys4 addObject:_tableCellUrl[indexPath.row]];
       
         [deleteArrarys6 addObject:_tableCellContent[indexPath.row]];
         [deleteArrarys7 addObject:_tableCellName[indexPath.row]];
    }
    [UIView animateWithDuration:0 animations:^{
        [self.dataArray removeObjectsInArray:deleteArrarys];
        [self.tableCellPic removeObjectsInArray:deleteArrarys2];
        [self.cachWay removeObjectsInArray:deleteArrarys3];
         [_tableCellUrl removeObjectsInArray:deleteArrarys4];
     
         [_tableCellContent removeObjectsInArray:deleteArrarys6];
         [_tableCellName removeObjectsInArray:deleteArrarys7];
        
        for (int i=0;i<deleteArrarys3.count; i++) {
            [_fileManager removeItemAtPath:deleteArrarys3[i] error:nil];
        }
        
        [self.myTableView reloadData];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            if (!self.dataArray.count)
            {
                self.footerView.alpha=1;
            }
        } completion:^(BOOL finished) {
            self.isSelected = NO;//全选之后又去掉几个选中状态
        }];
    }];
        }
        }
    
}




#pragma mark - 全选删除
-(void)allDelBtn
{
    self.isSelected = !self.isSelected;
    
    for (int i = 0; i<self.dataArray.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        if (self.isSelected) {
            [self.myTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }else{//反选
            [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AvCachTableViewCell *cell = [AvCachTableViewCell creatWithTableView:tableView];
   // cell.typeImageView.image=IMAGE(_tableCellPic[indexPath.row]);
    
    NSURL* imagePath = [NSURL URLWithString:_tableCellPic[indexPath.row]];
    [cell.typeImageView sd_setImageWithURL:imagePath placeholderImage:[UIImage imageNamed:@"pic_service.png"]];
    
    cell.CellName.text=_dataArray[indexPath.row];
    
//    cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
//    cell.textLabels.text=self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    AVViewController *goAV=[[AVViewController alloc]init];
    
    goAV.AvUrl=_tableCellUrl[indexPath.row];
    goAV.AvPicUrl=_tableCellPic[indexPath.row];
    goAV.contentLabelTextValue=_tableCellContent[indexPath.row];
    goAV.title=_tableCellName[indexPath.row];
    
    
    [self.navigationController pushViewController:goAV animated:YES];
    
}


#pragma mark - 左滑删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableCellPic removeObjectAtIndex:indexPath.row];
         [_tableCellUrl removeObjectAtIndex:indexPath.row];

          [_tableCellContent removeObjectAtIndex:indexPath.row];
          [_tableCellName removeObjectAtIndex:indexPath.row];
        

        
         [_fileManager removeItemAtPath:_cachWay[indexPath.row] error:nil];
        
        [self.cachWay removeObjectAtIndex:indexPath.row];
        
        
        
        
        [self.myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108*HEIGHT_SIZE;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

@end
