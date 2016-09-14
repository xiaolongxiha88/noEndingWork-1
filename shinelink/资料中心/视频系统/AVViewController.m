//
//  AVViewController.m
//  ShinePhone
//
//  Created by sky on 16/9/1.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "AVViewController.h"
#import "HcdCacheVideoPlayer.h"
#import "UIImage+ImageEffects.h"
#import "AvCell.h"
#import "Reachability.h"

@interface AVViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) HcdCacheVideoPlayer *play;
@property (nonatomic, strong)UIButton *backButton;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSString *netType;

@end

@implementation AVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    self.title = @"视频中心";
    
    //self.view.backgroundColor=MainColor;
    
    [self initData];
    [self initUI];
    

    
}


-(NSString *)getNetconnType{

    NSString *netconnType = @"";
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:// 没有网络
        {
            
            netconnType = @"no network";
        }
            break;
            
        case ReachableViaWiFi:// Wifi
        {
            netconnType = @"Wifi";
        }
            break;
            
        case ReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
              netconnType = @"运营商网络";
                 }
            break;
            
        default:
            break;
    }
    
    return netconnType;

}



-(void)initData{

  // _AvUrl=@"http://cdn.growatt.com/app/xpg.mp4";
  _AvUrl=@"http://cdn.growatt.com/app/7-20k.mp4";

    
   _tableCellName =[NSMutableArray arrayWithObjects:@"我是第一个视频",@"我是第二个视频但是我很黄很暴力",@"我不是第一个视频但是我不黄不暴力",nil];
    _tableCellPic =[NSMutableArray arrayWithObjects:@"pic_service.png",@"pic_service.png",@"pic_service.png",nil];
}





-(void)initUI{

    // CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width * 0.5625)];
    UIImage *sourceImage = [UIImage imageNamed:@"pic_service.png"];
    //UIImage *lastImage = [sourceImage applyDarkEffect];//一句代码搞定毛玻璃效果
 //   _imageView.image = lastImage;
     _imageView.image = sourceImage;
    [_imageView setUserInteractionEnabled:YES];
    [self.view addSubview:_imageView];

    
    float image2Size=0.25*[UIScreen mainScreen].bounds.size.width;
    
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0.5*([UIScreen mainScreen].bounds.size.width-image2Size),0.5*([UIScreen mainScreen].bounds.size.width * 0.5625-image2Size),image2Size,image2Size)];
    _imageView2.image = [UIImage imageNamed:@"AvPlay2.png"];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playAV)];
    [_imageView2 addGestureRecognizer:tap];
    [_imageView2 setUserInteractionEnabled:YES];
    [_imageView addSubview:_imageView2];
    
    
    _scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(0, _imageView.frame.origin.y+_imageView.frame.size.height, SCREEN_Width, SCREEN_Height)];
    _scrollView2.scrollEnabled=YES;
    _scrollView2.contentSize = CGSizeMake(SCREEN_Width,1050*HEIGHT_SIZE);
    [self.view addSubview:_scrollView2];
    
   float imageButtonSiz=20*HEIGHT_SIZE;

    
    UILabel *CachLable= [[UILabel alloc] initWithFrame:CGRectMake(5*NOW_SIZE,5*HEIGHT_SIZE,SCREEN_Width-10*NOW_SIZE,40*HEIGHT_SIZE)];
    CachLable.text=@"温馨提示:播放视频，同时会存储视频，存储完请确定是否保存视频";
    CachLable.textColor=MainColor;
    CachLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    CachLable.numberOfLines=0;
    CachLable.textAlignment = NSTextAlignmentLeft;
    [_scrollView2 addSubview:CachLable];
    
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0,10*HEIGHT_SIZE+CGRectGetMaxY(CachLable.frame),SCREEN_Width,4*HEIGHT_SIZE)];
    line1.backgroundColor=COLOR(194, 195, 204, 0.75);
    [_scrollView2 addSubview:line1];
    
    NSString *contentLabelText=_contentLabelTextValue;
    _contentLabel= [[UILabel alloc] initWithFrame:CGRectMake(5*NOW_SIZE,20*HEIGHT_SIZE+imageButtonSiz*2,SCREEN_Width-10*NOW_SIZE,10*HEIGHT_SIZE)];
    _contentLabel.text=contentLabelText;
    _contentLabel.textColor=[UIColor blackColor];
    _contentLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.numberOfLines=0;
     CGRect fcRect = [contentLabelText boundingRectWithSize:CGSizeMake(300*NOW_SIZE, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 *HEIGHT_SIZE]} context:nil];
     _contentLabel.frame=CGRectMake(5*NOW_SIZE,25*HEIGHT_SIZE+imageButtonSiz*2,SCREEN_Width-10*NOW_SIZE,fcRect.size.height);
       [_scrollView2 addSubview:_contentLabel];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0,35*HEIGHT_SIZE+imageButtonSiz*2+fcRect.size.height,SCREEN_Width,4*HEIGHT_SIZE)];
    line2.backgroundColor=COLOR(194, 195, 204, 0.75);
    [_scrollView2 addSubview:line2];
    
    UILabel *nameLable= [[UILabel alloc] initWithFrame:CGRectMake(5*NOW_SIZE,52*HEIGHT_SIZE+imageButtonSiz*2+fcRect.size.height,SCREEN_Width-10*NOW_SIZE,10*HEIGHT_SIZE)];
    nameLable.text=@"相关视频";
    nameLable.textColor=[UIColor blackColor];
    nameLable.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
    nameLable.textAlignment = NSTextAlignmentLeft;
        [_scrollView2 addSubview:nameLable];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0,75*HEIGHT_SIZE+imageButtonSiz*2+fcRect.size.height,SCREEN_Width,4*HEIGHT_SIZE)];
    line3.backgroundColor=COLOR(194, 195, 204, 0.75);
    [_scrollView2 addSubview:line3];
    
    
    float tableViewHeight=80*HEIGHT_SIZE+imageButtonSiz*2+fcRect.size.height;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewHeight, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollView2 addSubview:_tableView];
    
}





//-(void)downAV{
//    
////   _play = [HcdCacheVideoPlayer sharedInstance];
////    [HcdCacheVideoPlayer clearAllVideoCache];
//    
//    [_imageView removeFromSuperview];
//    [_imageView2 removeFromSuperview];
//    [_backButton removeFromSuperview];
//    _backButton=nil;
//    
//    //CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
//    
//    
//    _play = [HcdCacheVideoPlayer sharedInstance];
//    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.5625)];
//    [self.view addSubview:videoView];
//    
//    _play.cachAV=YES;
//    
//    [_play playWithUrl:[NSURL URLWithString:_AvUrl] showView:videoView andSuperView:self.view];
//    
//    
//}


-(void)playAV{
    
      _netType=[self getNetconnType];
    
    if (![_netType isEqualToString:@"Wifi"]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"手机没有连接到wifi信号，是否继续观看?" delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_OK, nil];
        alertView.tag = 1002;
        [alertView show];
        
    }else{
    
    
    
    [_imageView removeFromSuperview];
    [_imageView2 removeFromSuperview];
    [_backButton removeFromSuperview];
    _backButton=nil;
    
   //CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    
        _play = [HcdCacheVideoPlayer sharedInstance];
        UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.5625)];
        [self.view addSubview:videoView];
    
        [_play playWithUrl:[NSURL URLWithString:_AvUrl] showView:videoView andSuperView:self.view];
    
    
        //[play playWithUrl:[NSURL URLWithString:@"http://pan.baidu.com/s/1c1Y95fy"] showView:videoView andSuperView:self.view];
       // NSLog(@"getSize=%f", [HcdCacheVideoPlayer allVideoCacheSize]);
    
    }
    
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==1) {
    
        [_imageView removeFromSuperview];
        [_imageView2 removeFromSuperview];
        [_backButton removeFromSuperview];
        _backButton=nil;
        
        //CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        
        
        _play = [HcdCacheVideoPlayer sharedInstance];
        UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.5625)];
        [self.view addSubview:videoView];
        
        [_play playWithUrl:[NSURL URLWithString:_AvUrl] showView:videoView andSuperView:self.view];
        
    }
    
    
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableCellName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AvCell *cell =[tableView dequeueReusableCellWithIdentifier:@"AVcell"];
    if (!cell) {
        cell = [[AvCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AVcell"];
    }
    cell.typeImageView.image=IMAGE(_tableCellPic[indexPath.row]);
    cell.CellName.text=_tableCellName[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 108*HEIGHT_SIZE;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
//    _AvUrl=@"http://cdn.growatt.com/app/2.mp4";
//    [self playAV];
    
    AVViewController *testView=[[AVViewController alloc]init];
    [self.navigationController pushViewController:testView animated:YES];
    
 }


-(void)viewDidDisappear:(BOOL)animated{
    
    
     [_play removeAllObserver];
    
    [_play stop];
   
    _play=nil;
    
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
