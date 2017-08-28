//
//  newEnergyDetaiTwo.m
//  ShinePhone
//
//  Created by sky on 17/5/3.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "newEnergyDetaiTwo.h"

@interface newEnergyDetaiTwo ()
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation newEnergyDetaiTwo

- (void)viewDidLoad {
    [super viewDidLoad];
   
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)COLOR(0, 156, 255, 1).CGColor, (__bridge id)COLOR(11, 182, 255, 1).CGColor];
    gradientLayer.locations = nil;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view.layer addSublayer:gradientLayer];
    self.tabBarController.tabBar.hidden = YES;
    
    [self initUI];
    [self initUI2];
}

-(void)initUI{
    NSArray *nameArray=@[root_shijian,root_shishi_SOC];
    
    for (int i=0; i<2; i++) {
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE+150*NOW_SIZE*i, 0*HEIGHT_SIZE, 150*NOW_SIZE, 30*HEIGHT_SIZE)];
        VL1.font=[UIFont systemFontOfSize:13*HEIGHT_SIZE];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=nameArray[i];
        VL1.textColor =[UIColor greenColor];
        [self.view addSubview:VL1];
    }
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 30*HEIGHT_SIZE, 300*NOW_SIZE, 230*HEIGHT_SIZE)];
    //  _scrollView.contentSize = CGSizeMake(SCREEN_Width-20*NOW_SIZE,lableHeight*(_timeDataArray.count)+35*HEIGHT_SIZE);
    _scrollView.backgroundColor=COLOR(235, 241, 241, 1);
    [self.view addSubview:_scrollView];
    
    NSArray *time=[_getDetaiDataArray1 objectAtIndex:0];
    NSArray *D1=[_getDetaiDataArray1 objectAtIndex:1];
    
    for (int i=0; i<time.count; i++) {
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+60*NOW_SIZE*0, 5*HEIGHT_SIZE+20*HEIGHT_SIZE*i, 150*NOW_SIZE, 20*HEIGHT_SIZE)];
        VL1.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=time[i];
        VL1.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL1];
        
        UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+150*NOW_SIZE*1, 5*HEIGHT_SIZE+20*HEIGHT_SIZE*i, 150*NOW_SIZE, 20*HEIGHT_SIZE)];
        VL2.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL2.adjustsFontSizeToFitWidth=YES;
        VL2.textAlignment = NSTextAlignmentCenter;
        //NSString *a1=D1[i];
        VL2.text=[NSString stringWithFormat:@"%.2f",[D1[i] floatValue]];
        VL2.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL2];
    }
    _scrollView.contentSize = CGSizeMake(SCREEN_Width-20*NOW_SIZE,20*HEIGHT_SIZE*time.count+60*HEIGHT_SIZE);
    
    
}


-(void)initUI2{
    NSArray *nameArray=@[root_shijian,root_mianban_dianliang,root_yongdian_xiaohao];
    
    for (int i=0; i<3; i++) {
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE+100*NOW_SIZE*i, 280*HEIGHT_SIZE, 100*NOW_SIZE, 30*HEIGHT_SIZE)];
        VL1.font=[UIFont systemFontOfSize:13*HEIGHT_SIZE];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=nameArray[i];
        VL1.textColor =[UIColor greenColor];
        [self.view addSubview:VL1];
    }
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 310*HEIGHT_SIZE, 300*NOW_SIZE, 190*HEIGHT_SIZE)];
    //  _scrollView.contentSize = CGSizeMake(SCREEN_Width-20*NOW_SIZE,lableHeight*(_timeDataArray.count)+35*HEIGHT_SIZE);
    _scrollView.backgroundColor=COLOR(235, 241, 241, 1);
    [self.view addSubview:_scrollView];
    
    NSArray *time=[_getDetaiDataArray2 objectAtIndex:0];
    NSArray *D1=[_getDetaiDataArray2 objectAtIndex:1];  
    
    for (int i=0; i<time.count; i++) {
       // NSArray *A=[NSArray arrayWithObject:D1[i]];
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+60*NOW_SIZE*0, 5*HEIGHT_SIZE+20*HEIGHT_SIZE*i, 100*NOW_SIZE, 20*HEIGHT_SIZE)];
        VL1.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=time[i];
        VL1.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL1];
        
        UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+100*NOW_SIZE*1, 5*HEIGHT_SIZE+20*HEIGHT_SIZE*i, 100*NOW_SIZE, 20*HEIGHT_SIZE)];
        VL2.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL2.adjustsFontSizeToFitWidth=YES;
        VL2.textAlignment = NSTextAlignmentCenter;
        NSString *a1=[NSString stringWithFormat:@"%@",[D1[i] objectAtIndex:0]];
        VL2.text=[NSString stringWithFormat:@"%.2f",[a1 floatValue]];
        VL2.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL2];
        
        UILabel *VL3= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+100*NOW_SIZE*2, 5*HEIGHT_SIZE+20*HEIGHT_SIZE*i, 100*NOW_SIZE, 20*HEIGHT_SIZE)];
        VL3.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL3.adjustsFontSizeToFitWidth=YES;
        VL3.textAlignment = NSTextAlignmentCenter;
        //NSString *a1=D1[i];
        NSString *a2=[NSString stringWithFormat:@"%@",[D1[i] objectAtIndex:1]];
        VL3.text=[NSString stringWithFormat:@"%.2f",[a2 floatValue]];
       // VL3.text=[NSString stringWithFormat:@"%.2f",[D1[i] floatValue]];
        VL3.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL3];
        
    }
    _scrollView.contentSize = CGSizeMake(SCREEN_Width-20*NOW_SIZE,20*HEIGHT_SIZE*time.count+60*HEIGHT_SIZE);
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
