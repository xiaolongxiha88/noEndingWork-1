//
//  findViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//


#import "aboutTableViewCell.h"
#import "aboutViewController.h"
#import "aboutOneTableViewCell.h"
#import "protocol.h"
#define Kwidth [UIScreen mainScreen].bounds.size.width


@interface aboutViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong) NSString *serviceNum;
@property (nonatomic, strong) NSString *currentVersion;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *appUrl;
@end

@implementation aboutViewController
{
    UITableView *_tableView;
    UIPageControl *_pageControl;
    UIScrollView *_scrollerView;
    NSString *_indenty;
    NSString *_indenty1;
    
   
    
    
    //全局变量 用来控制偏移量
    NSInteger pageName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    _currentVersion = [appInfo objectForKey:@"CFBundleVersion"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    //创建tableView的方法
    [self _createTableView];
    
    //创建tableView的头视图
    [self _createHeaderView];
    
    [self netAbout];
    
}

-(void)netAbout{

    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"admin":@"admin"} paramarsSite:@"/newUserAPI.do?op=getServicePhoneNum" sucessBlock:^(id content) {
        NSLog(@"getServicePhoneNum: %@", content);
        [self hideProgressView];
        if (content) {
            _serviceNum=content[@"servicePhoneNum"];
            
            [_tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
    
}

- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
  
    
    [self.view addSubview:_tableView];
  
}

- (void)_createHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,200*HEIGHT_SIZE)];
    UIColor *color=COLOR(218, 237, 244, 1);
    
    //UIColor *color=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_list_popver"]];
    [headerView setBackgroundColor:color];
    
    
    double imageSize=80*HEIGHT_SIZE;
    
    UIImageView *userImage= [[UIImageView alloc] initWithFrame:CGRectMake((Kwidth-imageSize)/2, 60*HEIGHT_SIZE, imageSize, imageSize)];
    [userImage setImage:[UIImage imageNamed:@"logo3.png"]];
    userImage.layer.masksToBounds=YES;
    userImage.layer.cornerRadius=imageSize/4.0;
//    [userImage setUserInteractionEnabled:YES];
    
   
    
    UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake((Kwidth-140*NOW_SIZE)/2, 150*HEIGHT_SIZE, 140*NOW_SIZE,20*HEIGHT_SIZE)];
    version.font=[UIFont systemFontOfSize:12*HEIGHT_SIZE];
    version.textAlignment = NSTextAlignmentCenter;
    NSString *version1=root_WO_banbenhao;
    NSString *version2=_currentVersion;
    NSString *version3=[NSString stringWithFormat:@"%@%@",version1,version2];
    version.text=version3;
    version.textColor = [UIColor blackColor];
    [headerView addSubview:version];
    
//    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pickUpImage)];
//    longPressGesture.minimumPressDuration = 1.0f;
//    [userImage addGestureRecognizer:longPressGesture];
    
    
    _tableView.tableHeaderView = headerView;
    [headerView addSubview:userImage];
    
}

- (void)pickUpImage{
    NSLog(@"取照片");
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
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
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55*HEIGHT_SIZE;
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell11=@"cell1";
       // static NSString *cell22=@"cell2";
     static NSString *cell33=@"cell3";
     static NSString *cell44=@"cell4";
    aboutTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:cell11];
    //aboutOneTableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:cell22];
    aboutTableViewCell *cell4=[tableView dequeueReusableCellWithIdentifier:cell44];
    aboutOneTableViewCell *cell3=[tableView dequeueReusableCellWithIdentifier:cell33];
    if(indexPath.row==0)
    {
        if (!cell1) {
            cell1=[[aboutTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell11];
        }
        [cell1.imageLog setImage:[UIImage imageNamed:@"user-agreement.png"]];
        cell1.tableName.text = root_WO_xieyi;
        
        return cell1;
    }   else if(indexPath.row==1)
    {
        if (!cell3) {
            cell3=[[aboutOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell33];
        }
        [cell3.imageLog setImage:[UIImage imageNamed:@"service3.png"]];
        cell3.tableName.text = root_WO_kefu_dianhua;
        cell3.tableDetail.text=_serviceNum;
        
          return cell3;
    } else if(indexPath.row==2)
    {
        if (!cell4) {
            cell4=[[aboutTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell44];
        }
        [cell4.imageLog setImage:[UIImage imageNamed:@"update.png"]];
        cell4.tableName.text = root_WO_jiancha_gengxin;
        
        return cell4;
    }
    else return nil;

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if(indexPath.row==0)
    {
        protocol *go0=[[protocol alloc]init];
        [self.navigationController pushViewController:go0 animated:NO];
    }
    
    if(indexPath.row==2)
    {
        [self checkUpdate];
    }
}




-(void)checkUpdate{

    
 [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:@"http://itunes.apple.com" paramars:@{@"admin":@"admin"} paramarsSite:@"/lookup?id=1128270005" sucessBlock:^(id content) {
        NSLog(@"getServicePhoneNum: %@", content);
        [self hideProgressView];
        
        
        if (content) {
            NSArray *resultArray = [content objectForKey:@"results"];
            
            if(resultArray.count>0){
            NSDictionary *resultDict = [resultArray objectAtIndex:0];
            //                DLog(@"version is %@",[resultDict objectForKey:@"version"]);
             _appVersion = [resultDict objectForKey:@"version"];
            
            //_appVersion=content[@"results"][@"version"];
            
            if ([_appVersion doubleValue] > [_currentVersion doubleValue]) {
                NSString *oneK=root_WO_zuixin_banben; NSString *twoK=root_WO_shifou_gengxin;
                NSString *msg = [NSString stringWithFormat:@"%@%@,%@?",oneK,_appVersion,twoK];
               _appUrl = [resultDict objectForKey:@"trackViewUrl"];
               // _appUrl = content[@"results"][@"trackViewUrl"];
            
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:root_Alet_user message:msg delegate:self cancelButtonTitle:root_WO_zanbu otherButtonTitles:root_WO_liji_gengxin, nil];
                alertView.tag = 1000;
                [alertView show];
                          }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:root_Alet_user message:root_WO_shi_zuixin_banben delegate:self cancelButtonTitle:nil otherButtonTitles:root_OK, nil];
                alertView.tag = 1001;
                [alertView show];
           
            }
            
        }else{
         UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:root_Alet_user message:root_WO_pingguo_fuwuqi_shibai delegate:self cancelButtonTitle:nil otherButtonTitles:root_OK, nil];
             [alertView1 show];
        }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:root_Alet_user message:root_WO_pingguo_fuwuqi_shibai delegate:self cancelButtonTitle:nil otherButtonTitles:root_OK, nil];
         [alertView2 show];
    }];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex) {
        if (alertView.tag == 1000) {
            if(_appUrl)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_appUrl]];
            }
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
