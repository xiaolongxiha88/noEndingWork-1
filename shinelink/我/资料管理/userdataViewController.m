//
//  userdataViewController.m
//  shinelink
//
//  Created by sky on 16/2/25.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "userdataViewController.h"
#import "editViewController.h"
#define Kwidth [UIScreen mainScreen].bounds.size.width
#define moveHeight 190*NOW_SIZE
#define moveHeight2 12*NOW_SIZE

@interface userdataViewController ()<UINavigationBarDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation userdataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(toEdit)];
    [self.navigationItem setRightBarButtonItem:right];
    
    [self initUI];
}

-(void)toEdit{
    editViewController *toView=[[editViewController alloc]init];
    [self.navigationController pushViewController:toView animated:NO];

}

-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
    
    NSArray *imageArray=[NSArray arrayWithObjects:@"iconfont-gongsijianjie@3x.png", @"icon---Email---Full@3x.png", @"iconfont-nengyuanlei@3x.png", @"iconfont-address@3x.png",nil];
    NSArray *labelArray=[NSArray arrayWithObjects:@"公司名字:", @"邮箱:", @"电话:", @"地址:", nil];
     NSArray *labelArray2=[NSArray arrayWithObjects:@"古瑞瓦特", @"1314520@qq.com", @"1866666666", @"那个屯", nil];;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,180*NOW_SIZE)];
    UIColor *color=[UIColor colorWithRed:130/ 255.0f green:200 / 255.0f blue:250 / 255.0f alpha:1];
    [headerView setBackgroundColor:color];
    [_scrollView addSubview:headerView];

    double imageSize=150;
    UIImageView *userImage= [[UIImageView alloc] initWithFrame:CGRectMake((Kwidth-imageSize)/2, (180*NOW_SIZE-imageSize)/2, imageSize, imageSize)];
    [userImage setImage:[UIImage imageNamed:@"1.jpg"]];
    userImage.layer.masksToBounds=YES;
    userImage.layer.cornerRadius=imageSize/2.0;
      [headerView addSubview:userImage];
      for (int i=0; i<4; i++)
    {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,17*NOW_SIZE+i*60*NOW_SIZE+moveHeight,40*NOW_SIZE, 40*NOW_SIZE)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds=YES;
        imageView.image=[UIImage imageNamed:imageArray[i]];
        [_scrollView addSubview:imageView];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(70*NOW_SIZE,10*NOW_SIZE+i*60*NOW_SIZE+moveHeight+moveHeight2, 70*NOW_SIZE, 30*NOW_SIZE)];
        label.text=labelArray[i];
        label.textAlignment=NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15*NOW_SIZE];
        label.textColor=[UIColor grayColor];
        [_scrollView addSubview:label];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,40*NOW_SIZE+i*60*NOW_SIZE+moveHeight+moveHeight2, 260*NOW_SIZE, 1)];
        line.backgroundColor=[UIColor grayColor];
        [_scrollView addSubview:line];
        
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(150*NOW_SIZE,10*NOW_SIZE+i*60*NOW_SIZE+moveHeight+moveHeight2, 180*NOW_SIZE, 30*NOW_SIZE)];
        label2.text=labelArray2[i];
        label2.font = [UIFont systemFontOfSize:15*NOW_SIZE];
        label2.textColor=[UIColor grayColor];
        [_scrollView addSubview:label2];
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
