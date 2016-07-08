//
//  findViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "meViewController.h"
#import "meTableViewCell.h"
#import "aboutViewController.h"
#import "userdataViewController.h"
#import "listViewController.h"
#import "ManagementController.h"
#import "stationTableView.h"
#import "MessageCeterTableViewController.h"

#define Kwidth [UIScreen mainScreen].bounds.size.width


@interface meViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;

@end

@implementation meViewController
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
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName :[UIColor whiteColor]
                                                                      }];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self setTitle:root_ME];
      [self.navigationController.navigationBar setBarTintColor:COLOR(17, 183, 243, 1)];
    arrayName=@[root_WO_zhiliao_guanli,root_WO_xitong_shezhi,root_WO_xiaoxi_zhongxin,root_WO_guanyu];
    arrayImage=@[@"ziliao.png",@"系统设置.png",@"message.png",@"关于.png"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //创建tableView的方法
    [self _createTableView];
    
    //创建tableView的头视图
    [self _createHeaderView];
    
  
    
}

- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    _indenty = @"indenty";
    //注册单元格类型
    [_tableView registerClass:[meTableViewCell class] forCellReuseIdentifier:_indenty];
}

- (void)_createHeaderView {
    
    if (_tableView.tableHeaderView) {
        [_tableView.tableHeaderView removeFromSuperview];
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,200*HEIGHT_SIZE)];
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,Kwidth,200*HEIGHT_SIZE)];
    
    [bgImgView setImage:[UIImage imageNamed:@"mebg.png"]];
    [headerView addSubview:bgImgView];
    
    [headerView sendSubviewToBack:bgImgView];
    
//    UIColor *color=[UIColor colorWithPatternImage:[UIImage imageNamed:@"mebg.png"]];
// [headerView setBackgroundColor:color];
    
    
    
    double imageSize=120*HEIGHT_SIZE;
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSData *pic=[ud objectForKey:@"userPic"];
    
   UIImageView *userImage= [[UIImageView alloc] initWithFrame:CGRectMake((Kwidth-imageSize)/2, 25*HEIGHT_SIZE, imageSize, imageSize)];
    //  [userImage setImage:[UIImage imageNamed:@"1.jpg"]];
    userImage.layer.masksToBounds=YES;
    userImage.layer.cornerRadius=imageSize/2.0;
    [userImage setUserInteractionEnabled:YES];
    
    
    
    if((pic==nil) || (pic.length==0)){
        [userImage setImage:[UIImage imageNamed:@"touxiang.png"]];
    }else{
        UIImage *image = [UIImage imageWithData: pic];
        [userImage setImage:image];
   
    }
    
    UITapGestureRecognizer * longPressGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickUpImage)];
//    longPressGesture.minimumPressDuration = 1.0f;
     [userImage addGestureRecognizer:longPressGesture];
    
    NSUserDefaults *ud1=[NSUserDefaults standardUserDefaults];
    NSString *reUsername=[ud1 objectForKey:@"userName"];
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake((Kwidth-200*NOW_SIZE)/2, 150*HEIGHT_SIZE, 200*NOW_SIZE, 20*HEIGHT_SIZE)];
    PV2Lable.text=reUsername;
    PV2Lable.textAlignment=NSTextAlignmentCenter;
    PV2Lable.textColor=[UIColor whiteColor];
    PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [headerView addSubview:PV2Lable];
    
    
    _tableView.tableHeaderView = headerView;
    [headerView addSubview:userImage];

}

- (void)pickUpImage{
    NSLog(@"取照片");
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: root_paiZhao style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
         //处理点击拍照
        self.cameraImagePicker = [[UIImagePickerController alloc] init];
        self.cameraImagePicker.allowsEditing = YES;
        self.cameraImagePicker.delegate = self;
        self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_cameraImagePicker animated:YES completion:nil];

    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_xiangkuang_xuanQu style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        self.photoLibraryImagePicker.allowsEditing = YES;
        self.photoLibraryImagePicker.delegate = self;
        self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
    }


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrayName.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55*HEIGHT_SIZE;
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
     [[UserInfo defaultUserInfo] setUserPic:imageData];
//    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
//    [dataImageDict setObject:imageData forKey:@"image"];
    
    [self _createHeaderView];
 
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    meTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
    //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
    if (!cell) {
        cell=[[meTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
    }
    
    [cell.imageLog setImage:[UIImage imageNamed:arrayImage[indexPath.row]]];
    cell.tableName.text = arrayName[indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.row==0) {
         ManagementController *aboutView = [[ManagementController alloc]init];
          aboutView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:aboutView animated:NO];
    }
    
    if (indexPath.row==1) {
        stationTableView *aboutView = [[stationTableView alloc]init];
          aboutView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:aboutView animated:NO];
    }
    
    if (indexPath.row==2) {
        MessageCeterTableViewController *aboutView = [[MessageCeterTableViewController alloc]init];
        aboutView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:aboutView animated:NO];
    }
   
    if (indexPath.row==3) {
        aboutViewController *aboutView = [[aboutViewController alloc]init];
          aboutView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:aboutView animated:YES];
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
