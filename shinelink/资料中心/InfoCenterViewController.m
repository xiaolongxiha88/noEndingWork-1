//
//  InfoCenterViewController.m
//  ShinePhone
//
//  Created by sky on 16/9/19.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "InfoCenterViewController.h"
#import "topAvViewController.h"


@interface InfoCenterViewController ()
@property (nonatomic, strong) UIScrollView *ScrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UIView *myView;

@end

@implementation InfoCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=MainColor;
    self.title=@"资料中心";
    
    [self initUI];
    
}

-(void)initUI{

    NSArray *imageArray=[NSArray arrayWithObjects:@"video.png", @"question.png",@"Installation-Manual.png",@"company.png",nil];
    NSArray *NameArray=[NSArray arrayWithObjects:@"视频系统", @"常见问题",@"安装手册",@"公司官网",nil];
     NSArray *contentArray=[NSArray arrayWithObjects:@"视频系统就是好啊非常好啊", @"常见问题常见问题常见问题常见问题",@"安装手册安装手册安装手册",@"公司官网公司官网公司官网",nil];
    
    _ScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _ScrollView.scrollEnabled=YES;
    // _scrollView2.contentSize = CGSizeMake(SCREEN_Width,1050*HEIGHT_SIZE);
    [self.view addSubview:_ScrollView];
    
    
    for (int i=0; i<imageArray.count; i++) {
        
        float leftWidth=5*NOW_SIZE,topWidth=7*HEIGHT_SIZE;
        UIView *myView=[[UIView alloc]initWithFrame:CGRectMake(leftWidth, topWidth+140*i, SCREEN_Width-2*leftWidth, 110*HEIGHT_SIZE)];
        // myView.layer.borderWidth=1;
        myView.layer.cornerRadius=7*HEIGHT_SIZE;
        myView.userInteractionEnabled=YES;
        if (i==0) {
            myView.backgroundColor=COLOR(11, 200, 222, 1);
            UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goAV)];
            [myView addGestureRecognizer:tap];
            
        }else if (i==1){
            myView.backgroundColor=COLOR(217, 83, 83, 1);
            UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goAV)];
            [myView addGestureRecognizer:tap];
        }else if (i==2){
            myView.backgroundColor=COLOR(208, 189, 86, 1);
            UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goAV)];
            [myView addGestureRecognizer:tap];
        }else if (i==3){
            myView.backgroundColor=COLOR(64, 205, 87, 1);
            UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goAV)];
            [myView addGestureRecognizer:tap];
        }
        
        
        [_ScrollView addSubview:myView];
        
        float ImageWidth=16*HEIGHT_SIZE,imageSize=60*HEIGHT_SIZE;
        UIImageView *titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(ImageWidth, ImageWidth, imageSize, imageSize)];
        titleImage.image=[UIImage imageNamed:imageArray[i]];
       [myView addSubview:titleImage];
        
        UILabel *NameLable=[[UILabel alloc]initWithFrame:CGRectMake(0, ImageWidth*2+imageSize, ImageWidth*2+imageSize, 100*HEIGHT_SIZE-(ImageWidth*2+imageSize))];
        NameLable.text=NameArray[i];
         NameLable.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
        NameLable.textAlignment=NSTextAlignmentCenter;
        NameLable.textColor=[UIColor whiteColor];
        [myView addSubview:NameLable];
        
        UIView *myView2=[[UIView alloc]initWithFrame:CGRectMake(ImageWidth*2+imageSize, 0, SCREEN_Width-2*leftWidth-ImageWidth*2-imageSize, 110*HEIGHT_SIZE)];
        myView2.backgroundColor=[UIColor whiteColor];
        myView2.layer.cornerRadius=7*HEIGHT_SIZE;
        [myView addSubview:myView2];
        
        UILabel *contentLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0, SCREEN_Width-2*leftWidth-ImageWidth*2-imageSize-20*NOW_SIZE, 110*HEIGHT_SIZE)];
        contentLable.contentMode=UIViewContentModeScaleAspectFit;
        contentLable.backgroundColor=[UIColor whiteColor];
         contentLable.layer.cornerRadius=7*HEIGHT_SIZE;
           contentLable.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
        contentLable.numberOfLines=0;
             contentLable.textAlignment=NSTextAlignmentCenter;
             contentLable.textColor=[UIColor blackColor];
        contentLable.text=contentArray[i];
         [myView2 addSubview:contentLable];
        
        
        
    }
    
    
    
    
    
    

}


-(void)goAV{

    topAvViewController *testView=[[topAvViewController alloc]init];
    testView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:testView animated:YES];
    
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
