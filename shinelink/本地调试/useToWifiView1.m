//
//  useToWifiView1.m
//  ShinePhone
//
//  Created by sky on 2017/10/18.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "useToWifiView1.h"

@interface useToWifiView1 ()
@property(nonatomic,strong)UIView *firstView;
@property(nonatomic,strong)UIView *secondView;
@property(nonatomic,strong)UIView *thirdView;
@property(nonatomic,strong)UIView *fourView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic,strong)NSMutableArray *firstViewDataArray;
@property(nonatomic,strong)NSMutableArray *secondDataArray;
@property(nonatomic,strong)NSMutableArray *thirdDataArray;
@property(nonatomic,strong)NSMutableArray *fourDataArray;

@property(nonatomic,assign) float firstH;


@end

@implementation useToWifiView1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    
    _firstH=170*HEIGHT_SIZE;
    
    [self initUI];
}



-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    
    
    [self initFirstUI];
}


-(void)initFirstUI{
    float W1=5*NOW_SIZE;float H1=8*HEIGHT_SIZE;float H2=50*HEIGHT_SIZE;float imageH=30*HEIGHT_SIZE;
    float W2=(H2-imageH)/2;  float lableH=30*HEIGHT_SIZE;float lableW=60*NOW_SIZE;
    _firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, _firstH)];
    _firstView.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_firstView];
    NSArray *picName=@[@"max_ele.png",@"max_power.png",@"max_worning.png"];
    NSArray *colorArray=@[COLOR(88, 196, 95, 1),COLOR(0, 156, 255, 1),COLOR(221, 120, 120, 1)];
    NSArray *nameArray=@[root_energy_fadianliang,root_gongLv,root_cuoWu];
    NSArray *dataNameArray=@[root_Device_head_182,root_Device_head_183,root_dangqian_gonglv,root_usbTowifi_189,root_cuoWu,root_usbTowifi_190];
    _firstViewDataArray=[NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6"]];
   
    
     float W0=SCREEN_Width-2*W1;
    for (int i=0; i<picName.count; i++) {
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(W1, H1+(H1+H2)*i, W0, H2)];
        view1.backgroundColor=[UIColor whiteColor];
        [_firstView addSubview:view1];
        
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(W2,(H2-imageH)/2, imageH,imageH)];
        image2.image=IMAGE(picName[i]);
        [view1 addSubview:image2];
        
        UILabel *titleLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(2*W2+imageH, (H2-lableH)/2,lableW,lableH)];
        titleLabel3.textColor = colorArray[i];
        titleLabel3.textAlignment=NSTextAlignmentLeft;
        titleLabel3.text=nameArray[i];
        titleLabel3.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [view1 addSubview:titleLabel3];
        
         float image3W=6*NOW_SIZE;float image3W1=5*NOW_SIZE;float imageH2=10*HEIGHT_SIZE;
        if((i==0)||(i==2)){
        UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(W0-image3W-image3W1,(H2-imageH2)/2, image3W,imageH2)];
        image3.image=IMAGE(@"MAXright.png");
        [view1 addSubview:image3];
        }
        
        float  titleLabel3X=2*W2+imageH+lableW;
        float  lable4W=(W0-image3W-image3W1*2-titleLabel3X)/2;
        float lableH2=20*HEIGHT_SIZE;float lableH3=10*HEIGHT_SIZE;
        for (int K=0; K<2; K++) {
            UILabel *lable4 = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel3X+lable4W*K, 8*HEIGHT_SIZE,lable4W,lableH2)];
            lable4.textColor = colorArray[i];
            lable4.textAlignment=NSTextAlignmentCenter;
            int T=2*i+K;
            lable4.text=_firstViewDataArray[T];
            lable4.font = [UIFont systemFontOfSize:20*HEIGHT_SIZE];
            [view1 addSubview:lable4];
            
            UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel3X+lable4W*K, 32*HEIGHT_SIZE,lable4W,lableH3)];
            lable5.textColor =COLOR(153, 153, 153, 1);
            lable5.textAlignment=NSTextAlignmentCenter;
            lable5.text=dataNameArray[T];
            lable5.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
            [view1 addSubview:lable5];
            
        }
        
    }
    
    [self initSecondUI];
}




-(void)initSecondUI{
    float W1=5*NOW_SIZE; float W0=SCREEN_Width-2*W1;
    float H=110*HEIGHT_SIZE;
    float view1H= CGRectGetMaxY(_firstView.frame);
    _secondView=[[UIView alloc]initWithFrame:CGRectMake(W1, view1H+10*HEIGHT_SIZE, W0, H)];
    _secondView.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_secondView];
    
    
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(1*NOW_SIZE, 3*HEIGHT_SIZE, 3*NOW_SIZE, 14*HEIGHT_SIZE)];
    V1.backgroundColor=MainColor;
    [_secondView addSubview:V1];
    
    float lableH1=20*HEIGHT_SIZE;
    UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(7*NOW_SIZE, 0,200*NOW_SIZE,lableH1)];
    lable5.textColor =COLOR(51, 51, 51, 1);
    lable5.textAlignment=NSTextAlignmentLeft;
    lable5.text=@"设备控制";
    lable5.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_secondView addSubview:lable5];
    
    float H2=80*HEIGHT_SIZE;
    UIView *V2=[[UIView alloc]initWithFrame:CGRectMake(0, 25*HEIGHT_SIZE, W0, H2)];
    V2.backgroundColor=[UIColor whiteColor];
    [_secondView addSubview:V2];
    
       NSArray *picName=@[@"max_set.png",@"max_parameter.png",@"max_product.png"];
     NSArray *nameArray=@[@"设置配置",@"参数设置",@"产品设置"];
    
    float imageH=30*HEIGHT_SIZE;float V2H1=15*HEIGHT_SIZE;
    for (int i=0; i<picName.count; i++) {
        UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake((W0/3-imageH)/2+W0/3*i,V2H1, imageH,imageH)];
        image3.image=IMAGE(picName[i]);
        [V2 addSubview:image3];
        
        UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(0+W0/3*i, V2H1+imageH+5*HEIGHT_SIZE,W0/3,lableH1)];
        lable5.textColor =COLOR(102, 102, 102, 1);
        lable5.textAlignment=NSTextAlignmentCenter;
        lable5.text=nameArray[i];
        lable5.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [V2 addSubview:lable5];
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
