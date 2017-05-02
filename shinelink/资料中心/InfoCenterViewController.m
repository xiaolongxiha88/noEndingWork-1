//
//  InfoCenterViewController.m
//  ShinePhone
//
//  Created by sky on 16/9/19.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "InfoCenterViewController.h"
#import "topAvViewController.h"
#import "QZBaseWebVC.h"
#import "questionView.h"
#import "manualTableViewController.h"


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
    self.title=root_ziliao_zhongxin;
    
    [self initUI];
    
}

-(void)initUI{

//    NSArray *imageArray=[NSArray arrayWithObjects:@"video.png", @"question.png",@"Installation-Manual.png",@"company.png",nil];
//    NSArray *NameArray=[NSArray arrayWithObjects:root_shipin_xitong, root_changjian_wenti,root_shouce,root_gongsi_guanwang,nil];
//     NSArray *contentArray=[NSArray arrayWithObjects:root_gongsi_neirong, root_changjian_wenti_neirong,root_shouce_neirong,root_gongsi_guanwang_neirong,nil];
    
    NSArray *imageArray=[NSArray arrayWithObjects:@"Installation-Manual.png", @"question.png",@"video.png",@"company.png",nil];
    NSArray *NameArray=[NSArray arrayWithObjects:root_shouce, root_changjian_wenti,root_shipin_xitong,root_gongsi_guanwang,nil];
    NSArray *contentArray=[NSArray arrayWithObjects:root_shouce_neirong, root_changjian_wenti_neirong,root_gongsi_neirong,root_gongsi_guanwang_neirong,nil];
    
    _ScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _ScrollView.scrollEnabled=YES;
   _ScrollView.contentSize = CGSizeMake(SCREEN_Width,SCREEN_Height+60*HEIGHT_SIZE);
    [self.view addSubview:_ScrollView];
    
    
    for (int i=0; i<imageArray.count; i++) {
        
        float leftWidth=5*NOW_SIZE,topWidth=7*HEIGHT_SIZE;
        UIView *myView=[[UIView alloc]initWithFrame:CGRectMake(leftWidth, topWidth+140*HEIGHT_SIZE*i, SCREEN_Width-2*leftWidth, 110*HEIGHT_SIZE)];
        // myView.layer.borderWidth=1;
        myView.layer.cornerRadius=7*HEIGHT_SIZE;
        myView.userInteractionEnabled=YES;
        if (i==2) {
            myView.backgroundColor=COLOR(11, 200, 222, 1);
            UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goAV)];
            [myView addGestureRecognizer:tap];
            
        }else if (i==1){
            myView.backgroundColor=COLOR(217, 83, 83, 1);
            UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goQuestion)];
            [myView addGestureRecognizer:tap];
        }else if (i==0){
            myView.backgroundColor=COLOR(208, 189, 86, 1);
            UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gomanual)];
            [myView addGestureRecognizer:tap];
        }else if (i==3){
            myView.backgroundColor=COLOR(64, 205, 87, 1);
            UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goHttp)];
            [myView addGestureRecognizer:tap];
        }
        
        
        [_ScrollView addSubview:myView];
        
        float ImageWidth=16*HEIGHT_SIZE,imageSize=60*HEIGHT_SIZE;
        UIImageView *titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(ImageWidth, ImageWidth, imageSize, imageSize)];
        titleImage.image=[UIImage imageNamed:imageArray[i]];
       [myView addSubview:titleImage];
        
      
    
        
        UILabel *NameLable=[[UILabel alloc]initWithFrame:CGRectMake(0, ImageWidth*2+imageSize-10*HEIGHT_SIZE, ImageWidth*2+imageSize, 100*HEIGHT_SIZE-(ImageWidth*2+imageSize)+10*HEIGHT_SIZE)];
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
//        contentLable.contentMode=UIViewContentModeScaleAspectFit;
//        contentLable.backgroundColor=[UIColor whiteColor];
//         contentLable.layer.cornerRadius=7*HEIGHT_SIZE;
           contentLable.font=[UIFont systemFontOfSize:15*HEIGHT_SIZE];
        contentLable.adjustsFontSizeToFitWidth=YES;
        contentLable.numberOfLines=0;
             contentLable.textAlignment=NSTextAlignmentCenter;
             contentLable.textColor=[UIColor blackColor];
        contentLable.text=contentArray[i];
         [myView2 addSubview:contentLable];
        
    }
    
}

-(void)goQuestion{

    questionView *testView=[[questionView alloc]init];
      testView.title=root_changjian_wenti;
    testView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:testView animated:YES];
}

-(void)gomanual{
    
    manualTableViewController *testView=[[manualTableViewController alloc]init];
    testView.title=root_shouce;
    testView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:testView animated:YES];
}



-(void)goHttp{
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
  
    
  
    
    QZBaseWebVC *testView=[[QZBaseWebVC alloc]init];
    testView.title=root_gongsi_guanwang;
    
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        testView.url=@"http://www.growatt.com/";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        testView.url=@"http://ginverter.com/";
    }else{
       testView.url=@"http://ginverter.com/";
    }
    
    
    testView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:testView animated:YES];

}

-(void)goAV{

    topAvViewController *testView=[[topAvViewController alloc]init];
        testView.title=root_shipin_xitong;
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
