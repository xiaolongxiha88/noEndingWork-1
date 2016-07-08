//
//  findViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "findViewController.h"
#import "findTableViewCell.h"
#define Kwidth [UIScreen mainScreen].bounds.size.width
#import "listViewController.h"
#import "commonTableViewController.h"
#import "LZPageViewController.h"
#import "qualityTableViewController.h"
#import "moreTableViewController.h"
#import "extensionListTableViewController.h"

@interface findViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)NSMutableArray *imageDataArray;
@property(nonatomic,strong)NSMutableArray *imageArrayName;
@property(nonatomic,strong)NSMutableArray *imageArrayCount;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)NSString *languageValue;
@end

@implementation findViewController
{
    UITableView *_tableView;
    UIPageControl *_pageControl;
    UIScrollView *_scrollerView;
    NSString *_indenty;
    
      NSArray *arrayImage;
       NSArray *arrayName;
    
    
    //全局变量 用来控制偏移量
    NSInteger pageName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  

    
   
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName :[UIColor whiteColor]
                                                                      }];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self setTitle:root_service];
      [self.navigationController.navigationBar setBarTintColor:COLOR(17, 183, 243, 1)];
    arrayName=@[root_ME_kefu,root_ME_zhibao,root_ME_zengzhi,root_ME_gengduo];
    arrayImage=@[@"客户服务.png",@"质保.png",@"增值服务.png",@"更多.png"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _imageArrayName=[NSMutableArray array];
      _imageArrayCount=[NSMutableArray array];
     _imageDataArray=[NSMutableArray array];
    
    if(!_headerView){
       [self netFind];
    }
 
    //创建tableView的方法
    [self _createTableView];
    [self _createHeaderView];
   
    
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(circulate:) userInfo:nil repeats:YES];

}

-(void)netFind{
    
      //NSMutableArray *dataArray=[NSMutableArray array];

    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    
    if ([currentLanguage isEqualToString:@"zh-Hans-CN"]) {
        _languageValue=@"0";
    }else if ([currentLanguage isEqualToString:@"en-CN"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }

    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"language":_languageValue} paramarsSite:@"/newPlantAPI.do?op=getAdvertisingList" sucessBlock:^(id content) {
        
        NSLog(@"getAdvertisingList: %@", content);
        [ _imageArrayCount addObjectsFromArray:content];
        
        if (_imageArrayCount.count>0) {
            for (int i=0; i<_imageArrayCount.count; i++) {
                [_imageArrayName addObject:content[i][@"name"]];
            }
            
            [self netFind2];
                    }
        
    } failure:^(NSError *error) {
        
        
    }];
    
   


}


-(void)netFind2{

        _imageArray=[NSMutableArray array];

    NSString *getSame;
    NSArray * imageName = [NSArray arrayWithArray:_imageArrayName];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
     NSMutableArray *getImageName = [NSMutableArray arrayWithArray:[user objectForKey:@"AdPicName"]];
    
    for (int j=0; j<_imageArrayName.count; j++) {
        
        if ( ![getImageName containsObject:_imageArrayName[j]]) {
            getSame=@"0";
        }
    }
    
    if ([getSame isEqualToString:@"0"]) {
        
    [user setObject:imageName forKey:@"AdPicName"];
    
    for (int i=0; i<_imageArrayCount.count; i++) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageURL=[NSString stringWithFormat:@"%@/%@",HEAD_URL,_imageArrayName[i]];
        UIImage * result;
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        
        if (data!= nil) {
            result = [UIImage imageWithData:data];
            
            [_imageArray addObject:result];
            [_imageDataArray addObject:data];
            
            if (_imageArray.count==_imageArrayCount.count) {
                
                NSArray * imageDataName = [NSArray arrayWithArray:_imageDataArray];
                 [user setObject:imageDataName forKey:@"AdPicData"];
                
                 dispatch_async(dispatch_get_main_queue(), ^{
                [self _createHeaderView];
                 });
         
        }
        }else{
        
                [_tableView reloadData];
        }
        });
       }
    }else{
    
      NSMutableArray *getImageData = [NSMutableArray arrayWithArray:[user objectForKey:@"AdPicData"]];
        
        for (int k=0; k<getImageData.count; k++) {
             UIImage * result1;
                  result1 = [UIImage imageWithData:getImageData[k]];
               [_imageArray addObject:result1];
            
            if (_imageArray.count==getImageData.count) {
                    [self _createHeaderView];
            }

            
            
        }
        
    
    }
    
    
    
    
    
    
    
}


- (void)_createTableView {
    
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height-NavigationbarHeight);
    
  
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,Kwidth,self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height-10*HEIGHT_SIZE) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    _indenty = @"indenty";
    //注册单元格类型
    [_tableView registerClass:[findTableViewCell class] forCellReuseIdentifier:_indenty];
}

- (void)_createHeaderView {
    
    if (_headerView) {
        [self.headerView removeFromSuperview];
    }
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,200*HEIGHT_SIZE)];
    _tableView.tableHeaderView = _headerView;
    
  _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,Kwidth,_headerView.bounds.size.height)];
    
    if (_imageArray) {
        for (int i=0; i<_imageArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Kwidth*i,0,Kwidth,_scrollerView.bounds.size.height)];
            imageView.image = _imageArray[i];
            [_scrollerView addSubview:imageView];
            
             _scrollerView.contentSize = CGSizeMake(Kwidth*_imageArray.count,_headerView.bounds.size.height);
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,_headerView.bounds.size.height-20*HEIGHT_SIZE,Kwidth,20*HEIGHT_SIZE)];
            _pageControl.numberOfPages = _imageArray.count;
        }
    }else{
    NSArray *imgArray = @[@"pic_service.png",@"pic_service.png"];
    for (int i=0; i<imgArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Kwidth*i,0,Kwidth,_scrollerView.bounds.size.height)];
        imageView.image = [UIImage imageNamed:imgArray[i]];
        [_scrollerView addSubview:imageView];
        
        _scrollerView.contentSize = CGSizeMake(Kwidth*imgArray.count,_headerView.bounds.size.height);
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,_headerView.bounds.size.height-20*HEIGHT_SIZE,Kwidth,20*HEIGHT_SIZE)];
        _pageControl.numberOfPages = imgArray.count;
         }
    }
    
   
    _scrollerView.pagingEnabled = YES;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.delegate = self;
    [_headerView addSubview:_scrollerView];
    
    //创建分页视图

    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    [_headerView addSubview:_pageControl];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55*HEIGHT_SIZE;
    
}

#pragma mark pageAction的实现方法
- (void)pageAction:(UIPageControl *)control {
    NSInteger page = control.currentPage;
    [_scrollerView setContentOffset:CGPointMake(Kwidth*page,0) animated:YES];
}


#pragma mark _scrollerView的协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat x = scrollView.contentOffset.x / Kwidth;
    _pageControl.currentPage = x;
}

#pragma mark 定时器方法
- (void)circulate:(NSTimer *)timer {
    
    pageName++;
    
    [_scrollerView setContentOffset:CGPointMake(Kwidth*pageName, 0) animated:YES];
    _pageControl.currentPage = pageName;
    
    if (pageName == (_imageArray.count-1)) {
        pageName = -1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    findTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
    //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
    if (!cell) {
        cell=[[findTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
    }
    
    [cell.imageLog setImage:[UIImage imageNamed:arrayImage[indexPath.row]]];
  cell.tableName.text = arrayName[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.row==0) {
    
        LZPageViewController *pageVc = [[LZPageViewController alloc] initWithTitles:@[root_ME_wenti,root_ME_changjian_wenti,] controllersClass:@[[listViewController class],[commonTableViewController class]]];
        pageVc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:pageVc animated:NO];
    }else if (indexPath.row==1){
        qualityTableViewController *page2 = [[qualityTableViewController alloc] init];
          page2.hidesBottomBarWhenPushed=YES;
         page2.title=root_ME_zhibao;
        [self.navigationController pushViewController:page2 animated:NO];
    }else if (indexPath.row==2){
        extensionListTableViewController *page2 = [[extensionListTableViewController alloc] init];
        page2.hidesBottomBarWhenPushed=YES;
        page2.title=root_ME_zengzhi;
        [self.navigationController pushViewController:page2 animated:NO];
    }else if (indexPath.row==3){
        moreTableViewController *page4 = [[moreTableViewController alloc] init];
        page4.hidesBottomBarWhenPushed=YES;
          page4.title=root_ME_gengduo;
        [self.navigationController pushViewController:page4 animated:NO];
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
