//
//  SPF5000Head.m
//  ShinePhone
//
//  Created by sky on 2017/8/17.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "SPF5000Head.h"
#import <objc/runtime.h>
#import "PopoverView00.h"


@implementation SPF5000Head

-(void)initUI{
    [self getPCSHeadUI];
    [self getPCSHead];
}

-(NSString*)statueString:(int)statue{
    NSString *statueString;
    NSArray *statueArray=@[root_xianZhi,root_chongDian,root_fangDian,root_cuoWu,root_dengDai,root_5000_pv_chongdian,root_5000_ac_chongdian,root_5000_lianhe_chongdian,root_5000_lianhechong_acfang,root_5000_pvchong_acfang,root_5000_acchong_acfang,root_5000_ac_fang,root_5000_pvchong_dianchifang];
    if ((statue>=0) && (statue<13)) {
           statueString=statueArray[statue];
    }else{
        statueString=@"";
    }
    
    
    return statueString;
}

-(void)getPCSHeadUI{
    
    NSString *panelPower=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"panelPower"] floatValue]];
       NSString *gridPower=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"gridPower"] floatValue]];
         NSString *loadPower=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"loadPower"] floatValue]];
         NSString *batPower=[NSString stringWithFormat:@"%.1f",fabsf([[_pcsDataDic objectForKey:@"batPower"] floatValue])];
        NSString *capacity=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"capacity"] floatValue]];
    int PcsStatue=[[_pcsDataDic objectForKey:@"status"] floatValue];
    NSString *statueString=[self statueString:PcsStatue];
    
    
    NSString *vBat=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"vBat"] floatValue]];
    NSString *vpv=[NSString stringWithFormat:@"%.1f/%.1f",[[_pcsDataDic objectForKey:@"vPv1"] floatValue],[[_pcsDataDic objectForKey:@"vPv2"] floatValue]];
    NSString *iChargePV=[NSString stringWithFormat:@"%.1f/%.1f",[[_pcsDataDic objectForKey:@"iPv1"] floatValue],[[_pcsDataDic objectForKey:@"iPv2"] floatValue]];
     NSString *iChargePV0=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"iTotal"] floatValue]];
      NSString *acIn=[NSString stringWithFormat:@"%.1fV/%.1fHZ",[[_pcsDataDic objectForKey:@"vAcInput"] floatValue],[[_pcsDataDic objectForKey:@"fAcInput"] floatValue]];
    NSString *acOut=[NSString stringWithFormat:@"%.1fV/%.1fHZ",[[_pcsDataDic objectForKey:@"vAcOutput"] floatValue],[[_pcsDataDic objectForKey:@"fAcOutput"] floatValue]];
     NSString *loadPercent=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"loadPrecent"] floatValue]];
    
    
    
    float lableW=70*NOW_SIZE;float lableH=15*HEIGHT_SIZE;float lableH0=10*HEIGHT_SIZE;
    float W1=15*NOW_SIZE,H1=35*HEIGHT_SIZE,imageSize=45*HEIGHT_SIZE,H2=90*HEIGHT_SIZE,W2=82*NOW_SIZE;
   float imageSizeBig=70*HEIGHT_SIZE;
     float aAndbW=10*HEIGHT_SIZE;
    float fontSize=10*HEIGHT_SIZE;
  //  float valueLableW=50*NOW_SIZE;
    
    UILabel *lableAll=[[UILabel alloc] initWithFrame:CGRectMake(0, 5*HEIGHT_SIZE,SCREEN_Width,20*HEIGHT_SIZE)];
    lableAll.text=statueString;
    lableAll.textColor=[UIColor whiteColor];
    lableAll.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    lableAll.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lableAll];
    
    //光伏
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(W1,H1,imageSize,imageSize)];
    imageView1.image = [UIImage imageNamed:@"icon_solor.png"];
    [self addSubview:imageView1];
    UILabel *solorLable=[[UILabel alloc] initWithFrame:CGRectMake(W1+(imageSize-lableW)/2,H1-lableH,lableW,lableH)];
    solorLable.text=root_PCS_guangfu;
    solorLable.textColor=[UIColor whiteColor];
    solorLable.font = [UIFont systemFontOfSize:fontSize];
    solorLable.adjustsFontSizeToFitWidth=YES;
    solorLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable];
    UILabel *solorLableA=[[UILabel alloc] initWithFrame:CGRectMake(W1+imageSize+0*NOW_SIZE, H1+imageSize/2-lableH,lableW,lableH)];
    solorLableA.text=panelPower;
    solorLableA.textColor=[UIColor whiteColor];
    solorLableA.adjustsFontSizeToFitWidth=YES;
    solorLableA.font = [UIFont systemFontOfSize:fontSize];
    solorLableA.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLableA];
  
//电网
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(W1,H1+imageSize+aAndbW,imageSize,imageSize)];
    imageView4.image = [UIImage imageNamed:@"icon_grid.png"];
    [self addSubview:imageView4];
    UILabel *solorLable3=[[UILabel alloc] initWithFrame:CGRectMake(W1+(imageSize-lableW)/2,H1+imageSize*2+10*HEIGHT_SIZE,lableW,lableH)];
    solorLable3.text=root_PCS_dianwang;
    solorLable3.textColor=[UIColor whiteColor];
    solorLable3.font = [UIFont systemFontOfSize:fontSize];
    solorLable3.adjustsFontSizeToFitWidth=YES;
    solorLable3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable3];
    
    UILabel *solorLableB2=[[UILabel alloc] initWithFrame:CGRectMake(W1+imageSize+0*NOW_SIZE, H1+imageSize/2-lableH+imageSize+aAndbW,lableW,lableH)];
    solorLableB2.text=gridPower;
    solorLableB2.textColor=[UIColor whiteColor];
     solorLableB2.adjustsFontSizeToFitWidth=YES;
    solorLableB2.font = [UIFont systemFontOfSize:fontSize];
    solorLableB2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLableB2];
    
    //SPF5000
    float SPF5000H=15*HEIGHT_SIZE;
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_Width-imageSizeBig)/2,H1+SPF5000H,imageSizeBig,imageSizeBig)];
    imageView2.image = [UIImage imageNamed:@"icon_sp.png"];
    [self addSubview:imageView2];
    UILabel *solorLable1=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_Width-imageSizeBig)/2+(imageSizeBig-lableW)/2,H1+SPF5000H-lableH,lableW,lableH)];
    solorLable1.text=root_PCS_chunengji;
    solorLable1.textColor=[UIColor whiteColor];
    solorLable1.font = [UIFont systemFontOfSize:fontSize];
    solorLable1.adjustsFontSizeToFitWidth=YES;
    solorLable1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable1];
    
    UILabel *solorLableB5=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/2+6*NOW_SIZE,self.frame.size.height-imageSize-30*HEIGHT_SIZE,lableW,lableH)];
    solorLableB5.text=batPower;
    solorLableB5.textColor=[UIColor whiteColor];
    solorLableB5.font = [UIFont systemFontOfSize:fontSize];
    solorLableB5.adjustsFontSizeToFitWidth=YES;
    solorLableB5.textAlignment = NSTextAlignmentLeft;
    [self addSubview:solorLableB5];
    
    //负载
    UIImageView *imageView22 = [[UIImageView alloc] initWithFrame:CGRectMake(W1+3*W2,H1+imageSize/2+aAndbW/2,imageSize,imageSize)];
    imageView22.image = [UIImage imageNamed:@"icon_load.png"];
    [self addSubview:imageView22];
    UILabel *solorLable5=[[UILabel alloc] initWithFrame:CGRectMake(W1+3*W2+(imageSize-lableW)/2,H1+imageSize/2+aAndbW/2-lableH,lableW,lableH)];
    solorLable5.text=root_PCS_fuzhai;
    solorLable5.textColor=[UIColor whiteColor];
       solorLable5.adjustsFontSizeToFitWidth=YES;
    solorLable5.font = [UIFont systemFontOfSize:fontSize];
    solorLable5.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable5];
    
    UILabel *solorLableB1=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_Width+imageSizeBig)/2+0*NOW_SIZE, H1+SPF5000H+imageSizeBig/2-lableH,lableW,lableH)];
    solorLableB1.text=loadPower;
    solorLableB1.textColor=[UIColor whiteColor];
         solorLableB1.adjustsFontSizeToFitWidth=YES;
    solorLableB1.font = [UIFont systemFontOfSize:fontSize];
    solorLableB1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLableB1];
    
    
    //电池
    UIImageView *imageView12 = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_Width-imageSize)/2,self.frame.size.height-imageSize-15*HEIGHT_SIZE,imageSize,imageSize)];
    imageView12.image = [UIImage imageNamed:@"icon_bat.png"];
    [self addSubview:imageView12];
    UILabel *solorLable4=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_Width-imageSize)/2+(imageSize-lableW)/2,self.frame.size.height-15*HEIGHT_SIZE,lableW,lableH0)];
      solorLable4.text=[NSString stringWithFormat:@"%@:%@",root_PCS_dianyuan,capacity];
    solorLable4.textColor=[UIColor whiteColor];
       solorLable4.adjustsFontSizeToFitWidth=YES;
    solorLable4.font = [UIFont systemFontOfSize:fontSize];
    solorLable4.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable4];
    
    
    
    
    UILabel *solorLableB6=[[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE,H1+H2+imageSize+8*HEIGHT_SIZE,40*NOW_SIZE,lableH)];
    NSString *B1=root_PCS_danwei;
    solorLableB6.text=[NSString stringWithFormat:@"%@:W",B1];
    solorLableB6.textColor=[UIColor whiteColor];
    solorLableB6.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableB6.textAlignment = NSTextAlignmentCenter;
    solorLableB6.adjustsFontSizeToFitWidth=YES;
   // solorLableB6.center=CGPointMake(35*NOW_SIZE, H1+H2+imageSize+5*HEIGHT_SIZE+lableH/2);
    [self addSubview:solorLableB6];
    UIImageView *image00 = [[UIImageView alloc] initWithFrame:CGRectMake(10*NOW_SIZE,H1+H2+imageSize-6*HEIGHT_SIZE,15*NOW_SIZE,15*NOW_SIZE)];
    image00.image = [UIImage imageNamed:@"zhushi11.png"];
    
  NSString *name11=[NSString stringWithFormat:@"%@:%@V",root_5000xianqing_dianchi_dianya,vBat];
  NSString *name22=[NSString stringWithFormat:@"%@:%@V",root_5000xianqing_PV_dianya,vpv];
    NSString *name33=[NSString stringWithFormat:@"%@:%@A",root_5000xianqing_PV_dianliu,iChargePV];
    NSString *name44=[NSString stringWithFormat:@"%@:%@A",root_5000xianqing_zongChongdian_dianliu,iChargePV0];
    
    NSString *name55=[NSString stringWithFormat:@"%@:%@",root_5000xianqing_ac_shuru,acIn];
    NSString *name66=[NSString stringWithFormat:@"%@:%@",root_5000xianqing_ac_shuchu,acOut];
    NSString *name77=[NSString stringWithFormat:@"%@:%@W",root_5000xianqing_fuzai_gonglv,loadPower];
    NSString *name88=[NSString stringWithFormat:@"%@:%@",root_5000xianqing_fuzai_baifengbi,loadPercent];
    
  
    
    NSArray *lableName=[NSArray arrayWithObjects:name11,name22,name33,name44,name55,name66,name77,name88,nil];
    image00.userInteractionEnabled=YES;
    objc_setAssociatedObject(image00, "firstObject", lableName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [image00 addGestureRecognizer:tapGestureRecognizer];
//    image00.center=CGPointMake(25*NOW_SIZE, H1+H2+imageSize-5*HEIGHT_SIZE);
    [self addSubview:image00];
    
    UIView *VV1=[[UIView alloc] initWithFrame:CGRectMake(0*NOW_SIZE,H1+H2+imageSize-28*HEIGHT_SIZE,60*NOW_SIZE,50*NOW_SIZE)];
    VV1.userInteractionEnabled=YES;
    objc_setAssociatedObject(VV1, "firstObject", lableName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer1.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [VV1 addGestureRecognizer:tapGestureRecognizer1];
    [self addSubview:VV1];
    
}

#pragma mark - 弹框提示
-(void)showAnotherView:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIView *lable = (UIView*) tap.view;
    NSArray* lableNameArray = objc_getAssociatedObject(lable, "firstObject");
    
    PopoverView00 *popoverView = [PopoverView00 popoverView00];
    [popoverView showToView:lable withActions:[self QQActions:lableNameArray]];
}

- (NSArray<PopoverAction *> *)QQActions:(NSArray*)lableNameArray {
    // 发起多人聊天 action
    NSMutableArray *actionArray=[NSMutableArray new];
    for (int i=0; i<lableNameArray.count; i++) {
        PopoverAction *Action = [PopoverAction actionWithImage:nil title:lableNameArray[i] handler:^(PopoverAction *action) {
#pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
            
        }];
        [actionArray addObject:Action];
    }
    return actionArray;
}



-(void)getPCSHead{
    //    [_animationView removeFromSuperview];
    //    _animationView=nil;
    
    float imageSizeBig=70*HEIGHT_SIZE;    float aAndbW=10*HEIGHT_SIZE; float SPF5000H=15*HEIGHT_SIZE;
    float W1=15*NOW_SIZE,H1=35*HEIGHT_SIZE,imageSize=45*HEIGHT_SIZE,W2=(SCREEN_Width-imageSizeBig)/2;
    float imageH1=H1+imageSize/2;
   float W3=82*NOW_SIZE;
    //光伏-储能机
    CGPoint pointStart=CGPointMake(W1+imageSize, imageH1);
    CGPoint pointtEnd=CGPointMake(W1+W2, imageH1);
    
        //电网-储能机
        CGPoint pointStart0=CGPointMake(W1+imageSize, imageH1+imageSize+aAndbW);
        CGPoint pointtEnd0=CGPointMake(W1+W2, imageH1+imageSize+aAndbW);
    
    //储能机-负载
    CGPoint pointStart1=CGPointMake((SCREEN_Width+imageSizeBig)/2, H1+SPF5000H+imageSizeBig/2);
    CGPoint pointtEnd1=CGPointMake(W1+3*W3, H1+SPF5000H+imageSizeBig/2);
    
   //储能机-电池
    CGPoint pointStart2=CGPointMake(SCREEN_Width/2, H1+SPF5000H+imageSizeBig);
    CGPoint pointtEnd2=CGPointMake(SCREEN_Width/2, self.frame.size.height-imageSize-15*HEIGHT_SIZE);

    
    
    NSArray *startArray=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart], [NSValue valueWithCGPoint:pointStart0], [NSValue valueWithCGPoint:pointStart1], [NSValue valueWithCGPoint:pointStart2], nil];
    
    NSArray *endArray=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd],[NSValue valueWithCGPoint:pointtEnd0],[NSValue valueWithCGPoint:pointtEnd1],[NSValue valueWithCGPoint:pointtEnd2],nil];
    
    if (_animationNumber==0) {
        _animationNumber=1;
        for (int i=0; i<startArray.count; i++) {
            NSArray *P=[NSArray arrayWithObjects:[startArray objectAtIndex:i],[endArray objectAtIndex:i], nil];
            [self getHeadLayer:P];
        }
    }
    
    
 
    float TIME=8; float TIME2=5;
    //路径一 光伏到电池
    NSArray *startArray0=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart],[NSValue valueWithCGPoint:pointStart2], nil];
    NSArray *endArray0=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd],[NSValue valueWithCGPoint:pointtEnd2], nil];
    
    
    /////路径二 电网到电池
    NSArray *startArray01=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart0],[NSValue valueWithCGPoint:pointStart2], nil];
    NSArray *endArray01=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd0],[NSValue valueWithCGPoint:pointtEnd2], nil];

    
    /////路径三 电网到负载
    NSArray *startArray03=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart0],[NSValue valueWithCGPoint:pointStart1], nil];
    NSArray *endArray03=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd0],[NSValue valueWithCGPoint:pointtEnd1], nil];
  
    
    
    /////路径四 电池到负载
    NSArray *startArray04=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd2],[NSValue valueWithCGPoint:pointStart1], nil];
    NSArray *endArray04=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart2],[NSValue valueWithCGPoint:pointtEnd1], nil];
    

       int PcsStatue=[[_pcsDataDic objectForKey:@"status"] floatValue];
    
    if (!_isStorageLost) {
        
        if (PcsStatue==5 || PcsStatue==7 || PcsStatue==8 || PcsStatue==9 || PcsStatue==12) {
            [self getHeadAnimation:startArray0 second:endArray0 three:TIME2];          //路径一 光伏到电池
        }
        if (PcsStatue==6 || PcsStatue==7 || PcsStatue==8 || PcsStatue==10) {
            [self getHeadAnimation:startArray01 second:endArray01 three:TIME2];         /////路径二 电网到电池
        }
        if (PcsStatue==8 || PcsStatue==9 || PcsStatue==10 || PcsStatue==11) {
            [self getHeadAnimation:startArray03 second:endArray03 three:TIME];         /////路径三 电网到负载
        }
        if (PcsStatue==2 || PcsStatue==12) {
            [self getHeadAnimation:startArray04 second:endArray04 three:TIME2];           /////路径四 电池到负载
        }
    }
    

    
}


-(void)getHeadAnimation:(NSArray*)startPoint0 second:(NSArray*)endPoint0 three:(float)time{
    
    //    [_animationView removeFromSuperview];
    //    _animationView=nil;
    
    CGPoint startPoint=[[startPoint0 objectAtIndex:0] CGPointValue];
    
    UIImageView  *_animationView = [[UIImageView alloc] initWithFrame:CGRectMake(startPoint.x-2*NOW_SIZE,startPoint.y-2*HEIGHT_SIZE,6*HEIGHT_SIZE,4*HEIGHT_SIZE)];
    _animationView.image = [UIImage imageNamed:@"yuan.png"];
    [self addSubview:_animationView];
    
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    
    for (int i=0; i<startPoint0.count; i++) {
        CGPoint startPoint00=[[startPoint0 objectAtIndex:i] CGPointValue];
        CGPoint endPoint00=[[endPoint0 objectAtIndex:i] CGPointValue];
        [movePath moveToPoint:startPoint00];
        [movePath addLineToPoint:endPoint00];
    }
    
    
    
    CAKeyframeAnimation * posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = movePath.CGPath;
    posAnim.removedOnCompletion = YES;
    // [movePath addQuadCurveToPoint:CGPointMake(100, 300) controlPoint:CGPointMake(300, 100)];
    
    
    //    CABasicAnimation *animation1= [CABasicAnimation animationWithKeyPath:@"position"];
    //    //animation1.duration = 2.5; // 持续时间
    //    // animation1.repeatCount = MAXFLOAT; // 重复次数
    //    animation1.fromValue = [NSValue valueWithCGPoint:startPoint]; // 起始帧
    //    animation1.toValue = [NSValue valueWithCGPoint:endPoint]; // 终了帧
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    animation2.duration = 0.6; // 动画持续时间
    animation2.repeatCount = MAXFLOAT; // 重复次数
    animation2.autoreverses = YES; // 动画结束时执行逆动画
    animation2.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation2.toValue = [NSNumber numberWithFloat:1.5]; // 结束时的倍率
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate=self;
    // 动画选项设定
    //NSString *durationTime=time;
    group.duration = time;
    group.repeatCount = MAXFLOAT;
    
    group.animations = [NSArray arrayWithObjects:posAnim, animation2, nil];
    // 添加动画
    // NSString *animationKey=[startPoint0 objectAtIndex:3];
    [_animationView.layer addAnimation:group forKey:@"animation"];
    
}



-(void)getHeadLayer:(NSArray*)startPoint0{
    CGPoint startPoint=[[startPoint0 objectAtIndex:0] CGPointValue];
    CGPoint endPoint=[[startPoint0 objectAtIndex:1] CGPointValue];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CAShapeLayer *trackLayer = [CAShapeLayer new];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    trackLayer.path = path.CGPath;
    trackLayer.frame = self.bounds;
    trackLayer.lineWidth=1;
    trackLayer.fillColor = nil;
    trackLayer.strokeColor =COLOR(229, 220, 120, 1).CGColor;
    [self.layer addSublayer:trackLayer];
}



@end
