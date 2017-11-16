//
//  newEnergyDetailData.m
//  ShinePhone
//
//  Created by sky on 17/5/3.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "newEnergyDetailData.h"

@interface newEnergyDetailData ()
@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation newEnergyDetailData

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
    
}


-(void)initUI{

       NSArray *nameArray=@[root_shijian,root_guangfu_chanchu_1,root_nengyuan_chanch_1,root_yongdian_xiaohao,root_yongdian_xiaohao_1];
    if (_lableNameArray.count>0) {
        nameArray=[NSArray arrayWithArray:_lableNameArray];
    }
    
    for (int i=0; i<5; i++) {
  
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE+60*NOW_SIZE*i, 5*HEIGHT_SIZE, 60*NOW_SIZE, 40*HEIGHT_SIZE)];
        VL1.font=[UIFont systemFontOfSize:13*HEIGHT_SIZE];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=nameArray[i];
        VL1.textColor =COLOR(163, 255, 188, 1);
        [self.view addSubview:VL1];
    }

    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 45*HEIGHT_SIZE, 300*NOW_SIZE, SCREEN_Height-110*HEIGHT_SIZE)];
  //  _scrollView.contentSize = CGSizeMake(SCREEN_Width-20*NOW_SIZE,lableHeight*(_timeDataArray.count)+35*HEIGHT_SIZE);
    _scrollView.backgroundColor=COLOR(235, 241, 241, 1);
    [self.view addSubview:_scrollView];
    
    NSArray *time=[_getDetaiDataArray objectAtIndex:0];
    NSArray *D1=[_getDetaiDataArray objectAtIndex:1];
    NSArray *D2=[_getDetaiDataArray objectAtIndex:2];
    NSArray *D3=[_getDetaiDataArray objectAtIndex:3];
     NSArray *D4=[_getDetaiDataArray objectAtIndex:4];
    
    for (int i=0; i<time.count; i++) {
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+60*NOW_SIZE*0, 5*HEIGHT_SIZE+20*HEIGHT_SIZE*i, 60*NOW_SIZE, 20*HEIGHT_SIZE)];
        VL1.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=time[i];
        VL1.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL1];
        
        UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+60*NOW_SIZE*1, 5*HEIGHT_SIZE+20*HEIGHT_SIZE*i, 64*NOW_SIZE, 20*HEIGHT_SIZE)];
        VL2.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL2.adjustsFontSizeToFitWidth=YES;
        VL2.textAlignment = NSTextAlignmentCenter;
        //NSString *a1=D1[i];
        VL2.text=[NSString stringWithFormat:@"%.2f",[D1[i] floatValue]];
        VL2.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL2];
        
        UILabel *VL3= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+60*NOW_SIZE*2, 5*HEIGHT_SIZE+20*HEIGHT_SIZE*i, 64*NOW_SIZE, 20*HEIGHT_SIZE)];
        VL3.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL3.adjustsFontSizeToFitWidth=YES;
        VL3.textAlignment = NSTextAlignmentCenter;
      //  VL3.text=D2[i];
         VL3.text=[NSString stringWithFormat:@"%.2f",[D2[i] floatValue]];
        VL3.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL3];
        
        UILabel *VL4= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+60*NOW_SIZE*3, 5*HEIGHT_SIZE+20*HEIGHT_SIZE*i, 64*NOW_SIZE, 20*HEIGHT_SIZE)];
        VL4.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL4.adjustsFontSizeToFitWidth=YES;
        VL4.textAlignment = NSTextAlignmentCenter;
       // VL4.text=D3[i];
          VL4.text=[NSString stringWithFormat:@"%.2f",[D3[i] floatValue]];
        VL4.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL4];
        
        UILabel *VL5= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+60*NOW_SIZE*4, 5*HEIGHT_SIZE+20*HEIGHT_SIZE*i, 64*NOW_SIZE, 20*HEIGHT_SIZE)];
        VL5.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL5.adjustsFontSizeToFitWidth=YES;
        VL5.textAlignment = NSTextAlignmentCenter;
         VL5.text=[NSString stringWithFormat:@"%.2f",[D4[i] floatValue]];
      //  VL5.text=D4[i];
        VL5.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL5];
        
    }
    
    _scrollView.contentSize = CGSizeMake(SCREEN_Width-20*NOW_SIZE,20*HEIGHT_SIZE*time.count+100*HEIGHT_SIZE);
    
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
