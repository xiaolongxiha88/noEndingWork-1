//
//  DemoDeviceViewController.m
//  shinelink
//
//  Created by sky on 16/5/17.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "DemoDeviceViewController.h"
#import "Line2View.h"

#define SizeH 45*HEIGHT_SIZE
#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]

@interface DemoDeviceViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) Line2View *line2View;
@property (nonatomic, strong) NSMutableDictionary *dicData;
@end

@implementation DemoDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,750*NOW_SIZE);
    [self.view addSubview:_scrollView];

    [self addGraph];
     [self addbutton];
}



-(void)addbutton{
    
    float SizeH2=10*HEIGHT_SIZE;
    UIButton *firstB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*HEIGHT_SIZE,50*HEIGHT_SIZE )];
    [firstB setImage:[UIImage imageNamed:@"控制.jpg"] forState:UIControlStateNormal];
    [firstB addTarget:self action:@selector(clickDemo) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:firstB];
    UILabel *firstL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    firstL.text=root_kongzhi;
    firstL.textAlignment=NSTextAlignmentCenter;
    firstL.textColor=[UIColor blackColor];
    firstL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:firstL];
    
    UIButton *secondB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*HEIGHT_SIZE,50*HEIGHT_SIZE )];
    [secondB setImage:[UIImage imageNamed:@"参数.png"] forState:UIControlStateNormal];
    [secondB addTarget:self action:@selector(clickDemo) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:secondB];
    UILabel *secondL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE+74*NOW_SIZE, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    secondL.text=root_canshu;
    secondL.textAlignment=NSTextAlignmentCenter;
    secondL.textColor=[UIColor blackColor];
    secondL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:secondL];
    
    UIButton *threeB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*2, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*HEIGHT_SIZE,50*HEIGHT_SIZE )];
    [threeB setImage:[UIImage imageNamed:@"数据.png"] forState:UIControlStateNormal];
    [threeB addTarget:self action:@selector(clickDemo) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:threeB];
    UILabel *threeL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE+74*NOW_SIZE*2, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    threeL.text=root_shuju;
    threeL.textAlignment=NSTextAlignmentCenter;
    threeL.textColor=[UIColor blackColor];
    threeL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:threeL];
    
    UIButton *fourB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*3, 490*HEIGHT_SIZE-SizeH-SizeH2, 50*HEIGHT_SIZE,50*HEIGHT_SIZE )];
    [fourB addTarget:self action:@selector(clickDemo) forControlEvents:UIControlEventTouchUpInside];
    [fourB setImage:[UIImage imageNamed:@"日志.png"] forState:UIControlStateNormal];
    
    [self.scrollView addSubview:fourB];
    UILabel *fourL=[[UILabel alloc]initWithFrame:CGRectMake(14*NOW_SIZE+74*NOW_SIZE*3, 540*HEIGHT_SIZE-SizeH-SizeH2, 70*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    fourL.text=root_rizhi;
    fourL.textAlignment=NSTextAlignmentCenter;
    fourL.textColor=[UIColor blackColor];
    fourL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.scrollView addSubview:fourL];
}


-(void)addGraph{
    _line2View = [[Line2View alloc] initWithFrame:CGRectMake(0, 265*HEIGHT_SIZE-SizeH, SCREEN_Width,280*HEIGHT_SIZE )];
    self.line2View.flag=@"1";
    self.line2View.frameType=@"1";
    [self.scrollView addSubview:self.line2View];
    //   self.line2View = [[Line2View alloc] initWithFrame:CGRectMake(0, 275*NOW_SIZE, SCREEN_Width,250*NOW_SIZE )];
    //    [self.scrollView addSubview:self.line2View];
    _dicData=[NSMutableDictionary new];
    [_dicData setObject:@"155.0" forKey:@"08:30"];
    [_dicData setObject:@"166.0" forKey:@"09:30"];
    [_dicData setObject:@"156.0" forKey:@"10:30"];
    [_dicData setObject:@"177.0" forKey:@"11:30"];
    [_dicData setObject:@"155.0" forKey:@"12:30"];
    [_dicData setObject:@"152.0" forKey:@"13:30"];
    [_dicData setObject:@"167.0" forKey:@"14:30"];
    [_dicData setObject:@"182.0" forKey:@"15:30"];
    [_dicData setObject:@"131.0" forKey:@"16:30"];
    [_dicData setObject:@"155.0" forKey:@"17:30"];
    
    
            [self.line2View refreshLineChartViewWithDataDict:_dicData];
            [self addProcess];
 
}

-(void)addProcess{
    UIView *processView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200*HEIGHT_SIZE)];
    UIImage *bgImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:_picName]];
    processView.layer.contents = (id)bgImage.CGImage;
    [self.scrollView addSubview:processView];
    
    float imageSize=150*HEIGHT_SIZE;
   UIImageView *coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_Width-imageSize)/2, (200*HEIGHT_SIZE-imageSize)/2, imageSize, imageSize)];
    [coverImageView setImage:[UIImage imageNamed:_picName2]];
    [processView addSubview:coverImageView];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

-(void)clickDemo{

    UIAlertView  *alert= [[UIAlertView alloc] initWithTitle:root_Alet_user message:root_Demo_tishi delegate:self cancelButtonTitle:root_Yes  otherButtonTitles:nil, nil];
    
    [alert show];

}



@end
