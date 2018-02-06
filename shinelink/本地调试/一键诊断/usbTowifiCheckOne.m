//
//  usbTowifiCheckOne.m
//  ShinePhone
//
//  Created by sky on 2018/1/27.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "usbTowifiCheckOne.h"
#import "checkOneView.h"
#import "checkTwoView.h"
#import "checkThreeView.h"
#import "checkFourView.h"

@interface usbTowifiCheckOne ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong)NSArray*nameArray;
@end

@implementation usbTowifiCheckOne

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


-(void)initUI{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, SCREEN_Width, SCREEN_Height)];
        _scrollView.scrollEnabled=YES;
       _scrollView.backgroundColor=COLOR(242, 242, 242, 1);
        _scrollView.contentSize=CGSizeMake(SCREEN_Width, 1000*HEIGHT_SIZE);
        [self.view addSubview:_scrollView];
    }

    _nameArray=@[@"I-V曲线检测",@"故障录波检测",@"实时录波检测",@"一键诊断"];
        NSArray*noteArray=@[@"可远程排查组串发电异常。",@"可远程、快速、精确的进行故障定位，可大幅降低售后运维成本。",@"可实时观察逆变器电压电流质量等。",@"初装上电前一键检测电站环境信息，包括I-V曲线扫描，电网侧电压波形，THDV以及线路阻抗。"];
    NSArray*imageArray=@[@"max_iv_graph.png",@"max_fault.png",@"max_real_time.png",@"max_onekey.png"];
    
   float H0=80*HEIGHT_SIZE;
    float imageH=70*HEIGHT_SIZE;float lableH1=30*HEIGHT_SIZE;
      float W0=(H0-imageH)/2;
    float lableH2=45*HEIGHT_SIZE;
    float H=95*HEIGHT_SIZE;
    float W1=SCREEN_Width-3*W0-H0;
    for (int i=0; i<_nameArray.count; i++) {
        UIView* view0=[[UIView alloc]initWithFrame:CGRectMake(W0,W0+H*i, SCREEN_Width-2*W0, H0)];
        view0.layer.borderWidth =  1;
        view0.layer.cornerRadius = 5;
        view0.layer.borderColor=[UIColor clearColor].CGColor;
        view0.tag=2000+i;
        view0.backgroundColor=[UIColor whiteColor];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PresentGo:)];
        [view0 addGestureRecognizer:tapGestureRecognizer];
        [_scrollView addSubview:view0];
        
        UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(W0,(H0-imageH)/2, imageH,imageH)];
        image3.userInteractionEnabled=YES;
        image3.image=IMAGE(imageArray[i]);
        [view0 addSubview:image3];
        
        UILabel *lable0 = [[UILabel alloc]initWithFrame:CGRectMake(H0, 10*HEIGHT_SIZE,W1,lableH1)];
        lable0.textColor =[UIColor blackColor];
        lable0.textAlignment=NSTextAlignmentLeft;
        lable0.text=_nameArray[i];
        lable0.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [view0 addSubview:lable0];
        
        UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(H0, lableH1+0*HEIGHT_SIZE,W1,lableH2)];
        lable5.textColor =COLOR(102, 102, 102, 1);
        lable5.textAlignment=NSTextAlignmentLeft;
        lable5.text=noteArray[i];
        lable5.numberOfLines=0;
       // lable5.adjustsFontSizeToFitWidth=YES;
        lable5.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        [view0 addSubview:lable5];
    }
    
}


-(void)PresentGo:(UITapGestureRecognizer*)tap{
    NSInteger Num=tap.view.tag;
    if (Num==2000) {
        checkOneView *goView=[[checkOneView alloc]init];
        goView.title=_nameArray[0];
        [self.navigationController pushViewController:goView animated:YES];
    }else  if (Num==2001) {
        checkTwoView *goView=[[checkTwoView alloc]init];
            goView.title=_nameArray[1];
        goView.charType=1;
        [self.navigationController pushViewController:goView animated:YES];
    }else  if (Num==2002) {
        checkTwoView *goView=[[checkTwoView alloc]init];
            goView.title=_nameArray[2];
          goView.charType=2;
        [self.navigationController pushViewController:goView animated:YES];
    }else  if (Num==2003) {
        checkFourView *goView=[[checkFourView alloc]init];
            goView.title=_nameArray[3];
        [self.navigationController pushViewController:goView animated:YES];
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
