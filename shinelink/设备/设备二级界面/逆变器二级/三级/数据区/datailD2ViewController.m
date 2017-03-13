//
//  datailD2ViewController.m
//  ShinePhone
//
//  Created by sky on 17/1/24.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "datailD2ViewController.h"
#import "EquipGraphViewController.h"

@interface datailD2ViewController ()
@property (nonatomic, strong) UILabel *upAlert;
@property (nonatomic, strong) UIImageView *upImage;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation datailD2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
       self.view.backgroundColor=MainColor;
  
}

-(void)viewWillAppear:(BOOL)animated{
  [self initUI];
}

-(void)goDown{
    EquipGraphViewController *equipGraph=[[EquipGraphViewController alloc]init];
    equipGraph.SnID=_SnID;
    equipGraph.dictInfo=@{@"equipId":_SnID,
                          @"daySite":@"/newInverterAPI.do?op=getInverterData",
                          @"monthSite":@"/newInverterAPI.do?op=getMonthPac",
                          @"yearSite":@"/newInverterAPI.do?op=getYearPac",
                          @"allSite":@"/newInverterAPI.do?op=getTotalPac"};
    equipGraph.dict=@{@"1":root_PV_POWER,@"9":root_shuchu_gonglv,  @"2":root_PV1_VOLTAGE, @"3":root_PV1_ELEC_CURRENT, @"4":root_PV2_VOLTAGE, @"5":root_PV2_ELEC_CURRENT, @"6":root_R_PHASE_POWER, @"7":root_S_PHASE_POWER, @"8":root_T_PHASE_POWER};
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromBottom;//可更改为其他方式
    transition.duration = 0.6f;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:equipGraph animated:YES];
}

-(void)initUI{
    float lableWidth=SCREEN_Width/2;
    float lableHeight=15*HEIGHT_SIZE;
    float topHeight=0*HEIGHT_SIZE;
  float topHeight0=80*HEIGHT_SIZE;
    
    _upImage= [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width/2-8*NOW_SIZE, 35*HEIGHT_SIZE+20*HEIGHT_SIZE, 16*NOW_SIZE, 12*HEIGHT_SIZE )];
    _upImage.image = IMAGE(@"downGo.png");
    [_upImage.layer addAnimation:[self opacityForever_Animation:2] forKey:nil];
    [self.view addSubview:_upImage];
    
    _upAlert=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width/2-100*NOW_SIZE, 35*HEIGHT_SIZE, 200*NOW_SIZE, 20*HEIGHT_SIZE)];
    _upAlert.text=root_xiahua_chakan_quxiantu;
    _upAlert.textAlignment=NSTextAlignmentCenter;
    _upAlert.textColor=[UIColor whiteColor];
    _upAlert.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_upAlert.layer addAnimation:[self opacityForever_Animation:2] forKey:nil];
    [self.view addSubview:_upAlert];
    
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, topHeight0, SCREEN_Width-20*NOW_SIZE, SCREEN_Height-topHeight0-10*HEIGHT_SIZE)];
    _scrollView.contentSize = CGSizeMake(SCREEN_Width-20*NOW_SIZE,lableHeight*(_timeDataArray.count)+35*HEIGHT_SIZE);
    _scrollView.backgroundColor=COLOR(235, 241, 241, 1);
       [self.view addSubview:_scrollView];
    
    UISwipeGestureRecognizer *upMove=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goDown)];
    upMove.direction=UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:upMove];
    
    
    if ([_timePickerType isEqual:@"1"]) {
         _timeLableName=[NSMutableArray arrayWithObjects:root_shuzhi, root_shijian,nil];
    }else{
    _timeLableName=[NSMutableArray arrayWithObjects:root_shuzhi, root_riqi,nil];
    }
   

    for (int i=0; i<2; i++) {
        UILabel *timeLable=[[UILabel alloc]initWithFrame:CGRectMake(0+lableWidth*i, topHeight, lableWidth,20*HEIGHT_SIZE )];
        timeLable.text=_timeLableName[i];
        timeLable.textAlignment=NSTextAlignmentCenter;
        timeLable.textColor=MainColor;
        timeLable.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
        [_scrollView addSubview:timeLable];
    }
    
    for (int i=0; i<_timeDataArray.count; i++) {
        UILabel *dataLable1=[[UILabel alloc]initWithFrame:CGRectMake(0, topHeight+25*HEIGHT_SIZE+lableHeight*i, lableWidth,lableHeight )];
        NSString*textValue=_dateDataArray[i];
        dataLable1.text=[NSString stringWithFormat:@"%.2f",[textValue floatValue]];
        dataLable1.textAlignment=NSTextAlignmentCenter;
        dataLable1.textColor=COLOR(0, 150, 136, 1);
        dataLable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:dataLable1];
        UILabel *dataLable2=[[UILabel alloc]initWithFrame:CGRectMake(lableWidth, topHeight+25*HEIGHT_SIZE+lableHeight*i, lableWidth,lableHeight )];
        dataLable2.text=_timeDataArray[i];
        dataLable2.textAlignment=NSTextAlignmentCenter;
        dataLable2.textColor=COLOR(0, 150, 136, 1);
        dataLable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:dataLable2];
    }
    
    
}



-(CABasicAnimation *)opacityForever_Animation:(float)time{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    
    animation.autoreverses = YES;
    
    animation.duration = time;
    
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    
    return animation;
    
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
