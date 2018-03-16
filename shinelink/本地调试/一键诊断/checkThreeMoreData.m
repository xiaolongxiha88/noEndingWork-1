//
//  checkThreeMoreData.m
//  ShinePhone
//
//  Created by sky on 2018/3/5.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "checkThreeMoreData.h"

@interface checkThreeMoreData ()
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation checkThreeMoreData

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
    
    NSArray *nameArray=@[root_shijian,@"R",@"S",@"T"];

    float lableW=75*NOW_SIZE;
        float lableH=35*NOW_SIZE;
    for (int i=0; i<nameArray.count; i++) {
        
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE+lableW*i, 5*HEIGHT_SIZE, lableW, 40*HEIGHT_SIZE)];
            VL1.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
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
    

    
    for (int i=0; i<_getDetaiDataArray.count; i++) {
        NSArray *nameArray0=_getDetaiDataArray[i];
        NSString *name1=[NSString stringWithFormat:@"%d",1+2*i];
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+lableW*0, 5*HEIGHT_SIZE+lableH*i, lableW, lableH)];
        VL1.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL1.adjustsFontSizeToFitWidth=YES;
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=name1;
        VL1.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL1];
        
        UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+lableW*1, 5*HEIGHT_SIZE+lableH*i, lableW, lableH)];
        VL2.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL2.adjustsFontSizeToFitWidth=YES;
        VL2.textAlignment = NSTextAlignmentCenter;
        //NSString *a1=D1[i];
        VL2.text=[NSString stringWithFormat:@"%@%%",nameArray0[0]];
        VL2.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL2];
        
        UILabel *VL3= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+lableW*2, 5*HEIGHT_SIZE+lableH*i,lableW, lableH)];
        VL3.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL3.adjustsFontSizeToFitWidth=YES;
        VL3.textAlignment = NSTextAlignmentCenter;
        //  VL3.text=D2[i];
        VL3.text=[NSString stringWithFormat:@"%@%%",nameArray0[1]];
        VL3.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL3];
        
        UILabel *VL4= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE+lableW*3, 5*HEIGHT_SIZE+lableH*i, lableW, lableH)];
        VL4.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
        VL4.adjustsFontSizeToFitWidth=YES;
        VL4.textAlignment = NSTextAlignmentCenter;
        // VL4.text=D3[i];
        VL4.text=[NSString stringWithFormat:@"%@%%",nameArray0[2]];
        VL4.textColor =[UIColor grayColor];
        [_scrollView addSubview:VL4];
        

        
    }
    
    _scrollView.contentSize = CGSizeMake(SCREEN_Width-lableH,lableH*_getDetaiDataArray.count+100*HEIGHT_SIZE);
    
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
