//
//  storageHead.m
//  ShinePhone
//
//  Created by sky on 2017/8/17.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "storageHead.h"
 #import <objc/runtime.h>
#import "PopoverView00.h"


@implementation storageHead


-(void)initUI{
    [self getPCSHeadUI];
    [self getPCSHead];
}

-(void)getPCSHeadUI{
    NSString *ppv1=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"ppv1"] floatValue]+[[_pcsDataDic objectForKey:@"ppv2"] floatValue]];
    
   NSString *ppv2=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"ppv2"] floatValue]];
    NSString *pCharge=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pCharge"] floatValue]];
    NSString *pDisCharge=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pDisCharge"] floatValue]];
    NSString *capacity=[NSString stringWithFormat:@"%.1f%%",[[_pcsDataDic objectForKey:@"capacity"] floatValue]];
    NSString *pacCharge=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pacCharge"] floatValue]];
    NSString *userLoad=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"userLoad"] floatValue]];
    NSString *pacToGrid=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pacToGrid"] floatValue]];
    NSString *pacToUser=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pacToUser"] floatValue]];
    NSString *pCharge1=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pCharge1"] floatValue]];
    NSString *pCharge2=[NSString stringWithFormat:@"%.1f",[[_pcsDataDic objectForKey:@"pCharge2"] floatValue]];
    
    float lableW=75*NOW_SIZE;float lableH=15*HEIGHT_SIZE;float lableH0=10*HEIGHT_SIZE;
    float H0=8*HEIGHT_SIZE,W1=15*NOW_SIZE,H1=35*HEIGHT_SIZE,imageSize=45*HEIGHT_SIZE,H2=90*HEIGHT_SIZE,W2=82*NOW_SIZE;
    float imageH1=H1+imageSize/2;
    //float imageH12=7*HEIGHT_SIZE,imageW12=12*HEIGHT_SIZE;float WW2=5*NOW_SIZE;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(W1,H1,imageSize,imageSize)];
    imageView1.image = [UIImage imageNamed:@"icon_solor.png"];
    [self addSubview:imageView1];
    UILabel *solorLable=[[UILabel alloc] initWithFrame:CGRectMake(W1+(imageSize-lableW)/2,H1-lableH,lableW,lableH)];
    solorLable.text=root_PCS_guangfu;
    solorLable.textColor=[UIColor whiteColor];
    solorLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable.adjustsFontSizeToFitWidth=YES;
    solorLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable];
    UILabel *solorLableA=[[UILabel alloc] initWithFrame:CGRectMake(W1+imageSize, imageH1-H0-lableH0,37*NOW_SIZE,lableH0+2*HEIGHT_SIZE)];
    solorLableA.text=ppv1;
    solorLableA.textColor=[UIColor whiteColor];
    solorLableA.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableA.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLableA];
//    UILabel *solorLableA1=[[UILabel alloc] initWithFrame:CGRectMake(W1+imageSize, imageH1+H0,37*NOW_SIZE,lableH0)];
//    solorLableA1.text=ppv2;
//    solorLableA1.textColor=[UIColor whiteColor];
//    solorLableA1.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
//    solorLableA1.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:solorLableA1];
    UILabel *solorLableB1=[[UILabel alloc] initWithFrame:CGRectMake(W1+W2+imageSize/2-65*NOW_SIZE, imageH1+imageSize/2+20*HEIGHT_SIZE,60*NOW_SIZE,lableH0)];
    if([[_pcsDataDic objectForKey:@"status"] intValue]==1){
        solorLableB1.text=pCharge;
    }else{
        solorLableB1.text=pDisCharge;
    }
    
    solorLableB1.textColor=[UIColor whiteColor];
    solorLableB1.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableB1.textAlignment = NSTextAlignmentRight;
    [self addSubview:solorLableB1];
    UILabel *solorLableB2=[[UILabel alloc] initWithFrame:CGRectMake(W1+W2+imageSize/2+44*NOW_SIZE, imageH1+imageSize/2+20*HEIGHT_SIZE,60*NOW_SIZE,lableH0)];
    solorLableB2.text=pacCharge;
    solorLableB2.textColor=[UIColor whiteColor];
    solorLableB2.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableB2.textAlignment = NSTextAlignmentLeft;
    [self addSubview:solorLableB2];
    UILabel *solorLableB3=[[UILabel alloc] initWithFrame:CGRectMake(W1+3*W2+(imageSize-lableW)/2,H1+imageSize+2*HEIGHT_SIZE,lableW,lableH0)];
    if ([pacToGrid floatValue]>0) {
        solorLableB3.text=pacToGrid;
    }else if ([pacToUser floatValue]>0){
        solorLableB3.text=pacToUser;
    }
    solorLableB3.textColor=[UIColor whiteColor];
    solorLableB3.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableB3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLableB3];
    UILabel *solorLableB4=[[UILabel alloc] initWithFrame:CGRectMake(W1+W2+(imageSize-lableW)/2,H1+H2+imageSize+lableH+0*HEIGHT_SIZE,lableW,lableH0)];
    solorLableB4.text=capacity;
    solorLableB4.textColor=[UIColor whiteColor];
    solorLableB4.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableB4.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLableB4];
    UILabel *solorLableB5=[[UILabel alloc] initWithFrame:CGRectMake(W1+2.5*W2+(imageSize-lableW)/2,H1+H2+imageSize+lableH+0*HEIGHT_SIZE,lableW,lableH0)];
    solorLableB5.text=userLoad;
    solorLableB5.textColor=[UIColor whiteColor];
    solorLableB5.font = [UIFont systemFontOfSize:8*HEIGHT_SIZE];
    solorLableB5.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLableB5];
    
    
    
    UILabel *solorLableB6=[[UILabel alloc] initWithFrame:CGRectMake(20*NOW_SIZE,H1+H2+imageSize+5*HEIGHT_SIZE,60*NOW_SIZE,lableH)];
    NSString *B1=root_PCS_danwei;
    solorLableB6.text=[NSString stringWithFormat:@"%@:W",B1];
    solorLableB6.textColor=[UIColor whiteColor];
    solorLableB6.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLableB6.textAlignment = NSTextAlignmentCenter;
    solorLableB6.center=CGPointMake(35*NOW_SIZE, H1+H2+imageSize+5*HEIGHT_SIZE+lableH/2);
    [self addSubview:solorLableB6];
    UIImageView *image00 = [[UIImageView alloc] initWithFrame:CGRectMake(25*NOW_SIZE,H1+H2+imageSize-17*HEIGHT_SIZE,16*NOW_SIZE,16*NOW_SIZE)];
    image00.image = [UIImage imageNamed:@"zhushi11.png"];
    NSString *name1=root_PCS_guangfu_1;  NSString *name11=[NSString stringWithFormat:@"%@:%@W",name1,ppv1];
    NSString *name2=root_PCS_guangfu_2;  NSString *name22=[NSString stringWithFormat:@"%@:%@W",name2,ppv2];
    NSString *name3=root_PCS_chongdian_1;  NSString *name33=[NSString stringWithFormat:@"%@:%@W",name3,pCharge1];
    NSString *name4=root_PCS_chongdian_2;  NSString *name44=[NSString stringWithFormat:@"%@:%@W",name4,pCharge2];
    NSString *name0=root_PCS_fangdian_gonglv;  NSString *name00=[NSString stringWithFormat:@"%@:%@W",name0,pDisCharge];
    NSString *name5=root_PCS_dianchi_baifenbi;  NSString *name55=[NSString stringWithFormat:@"%@:%@",name5,capacity];
    NSString *name6=root_PCS_dianwang_chongdian_gonglv;  NSString *name66=[NSString stringWithFormat:@"%@:%@W",name6,pacCharge];
    NSString *name7=root_PCS_fuzai_gonglv;  NSString *name77=[NSString stringWithFormat:@"%@:%@W",name7,userLoad];
    NSString *name8=root_PCS_to_dianwang;  NSString *name88=[NSString stringWithFormat:@"%@:%@W",name8,pacToGrid];
    NSString *name9=root_PCS_from_dianwang;  NSString *name99=[NSString stringWithFormat:@"%@:%@W",name9,pacToUser];
    
    
    NSArray *lableName=[NSArray arrayWithObjects:name11,name22,name33,name44,name00,name55,name66,name77,name88,name99,nil];
    image00.userInteractionEnabled=YES;
    objc_setAssociatedObject(image00, "firstObject", lableName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [image00 addGestureRecognizer:tapGestureRecognizer];
    image00.center=CGPointMake(35*NOW_SIZE, H1+H2+imageSize-9*HEIGHT_SIZE);
    [self addSubview:image00];
    
    UIView *VV1=[[UIView alloc] initWithFrame:CGRectMake(5*NOW_SIZE,H1+H2+imageSize-28*HEIGHT_SIZE,60*NOW_SIZE,50*NOW_SIZE)];
    VV1.userInteractionEnabled=YES;
    objc_setAssociatedObject(VV1, "firstObject", lableName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer1.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [VV1 addGestureRecognizer:tapGestureRecognizer1];
    [self addSubview:VV1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(W1+W2,H1,imageSize,imageSize)];
    imageView2.image = [UIImage imageNamed:@"icon_sp.png"];
    [self addSubview:imageView2];
    UILabel *solorLable1=[[UILabel alloc] initWithFrame:CGRectMake(W1+W2+(imageSize-lableW)/2,H1-lableH,lableW,lableH)];
    solorLable1.text=root_PCS_chunengji;
    solorLable1.textColor=[UIColor whiteColor];
    solorLable1.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable1.adjustsFontSizeToFitWidth=YES;
    solorLable1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable1];
    
    UIImageView *imageView3= [[UIImageView alloc] initWithFrame:CGRectMake(W1+2*W2,H1,imageSize,imageSize)];
    imageView3.image = [UIImage imageNamed:@"icon_inv.png"];
    [self addSubview:imageView3];
    UILabel *solorLable2=[[UILabel alloc] initWithFrame:CGRectMake(W1+2*W2+(imageSize-lableW)/2,H1-lableH,lableW,lableH)];
    solorLable2.text=root_PCS_nibianqi;
    solorLable2.textColor=[UIColor whiteColor];
    solorLable2.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable2.adjustsFontSizeToFitWidth=YES;
    solorLable2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable2];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(W1+3*W2,H1,imageSize,imageSize)];
    imageView4.image = [UIImage imageNamed:@"icon_grid.png"];
    [self addSubview:imageView4];
    UILabel *solorLable3=[[UILabel alloc] initWithFrame:CGRectMake(W1+3*W2+(imageSize-lableW)/2,H1-lableH,lableW,lableH)];
    solorLable3.text=root_PCS_dianwang;
    solorLable3.textColor=[UIColor whiteColor];
    solorLable3.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable3.adjustsFontSizeToFitWidth=YES;
    solorLable3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable3];
    
    UIImageView *imageView12 = [[UIImageView alloc] initWithFrame:CGRectMake(W1+W2,H1+H2,imageSize,imageSize)];
    imageView12.image = [UIImage imageNamed:@"icon_bat.png"];
    [self addSubview:imageView12];
    UILabel *solorLable4=[[UILabel alloc] initWithFrame:CGRectMake(W1+W2+(imageSize-lableW)/2,H1+H2+imageSize,lableW,lableH)];
    solorLable4.text=root_PCS_dianyuan;
    solorLable4.textColor=[UIColor whiteColor];
    solorLable4.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable4.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable4];
    
    UIImageView *imageView22 = [[UIImageView alloc] initWithFrame:CGRectMake(W1+2.5*W2,H1+H2,imageSize,imageSize)];
    imageView22.image = [UIImage imageNamed:@"icon_load.png"];
    [self addSubview:imageView22];
    UILabel *solorLable5=[[UILabel alloc] initWithFrame:CGRectMake(W1+2.5*W2+(imageSize-lableW)/2,H1+H2+imageSize,lableW,lableH)];
    solorLable5.text=root_PCS_fuzhai;
    solorLable5.textColor=[UIColor whiteColor];
    solorLable5.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable5.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable5];
    
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
    
   // float H0=7*HEIGHT_SIZE,
   float W1=15*NOW_SIZE,H1=35*HEIGHT_SIZE,imageSize=45*HEIGHT_SIZE,H2=90*HEIGHT_SIZE,W2=82*NOW_SIZE;
    float imageH1=H1+imageSize/2;  float imageH12=7*HEIGHT_SIZE,imageW12=12*HEIGHT_SIZE;float WW2=5*NOW_SIZE;
    
    //上—1-0
    CGPoint pointStart=CGPointMake(W1+imageSize, imageH1);
    CGPoint pointtEnd=CGPointMake(W1+W2, imageH1);
    
//    //上—1-1
//    CGPoint pointStart0=CGPointMake(W1+imageSize, imageH1+H0);
//    CGPoint pointtEnd0=CGPointMake(W1+W2, imageH1+H0);
    
    //上—2-1
    CGPoint pointStart1=CGPointMake(W1+W2+imageSize, imageH1-imageH12);
    CGPoint pointtEnd1=CGPointMake(W1+2*W2, imageH1-imageH12);
    
    //上—2-2
    CGPoint pointStart2=CGPointMake(W1+W2+imageSize, imageH1+imageH12);
    CGPoint pointtEnd2=CGPointMake(W1+2*W2-imageW12, imageH1+imageH12);
    CGPoint pointtEnd21=CGPointMake(W1+2*W2-imageW12, imageH1+imageH12+33*HEIGHT_SIZE);
    CGPoint pointtEnd22=CGPointMake(W1+3*W2-imageW12-WW2-1.5*NOW_SIZE, imageH1+imageH12+33*HEIGHT_SIZE);
    //上—3
    CGPoint pointStart3=CGPointMake(W1+2*W2+imageSize, imageH1);
    CGPoint pointtEnd3=CGPointMake(W1+3*W2, imageH1);
    
    //下—1
    CGPoint pointtStartW1=CGPointMake(W1+W2+imageSize/2, imageH1+imageSize/2);
    CGPoint pointtEndW1=CGPointMake(W1+W2+imageSize/2, imageH1+H2-imageSize/2);
    
    //下—2
    CGPoint pointtStartW2=CGPointMake(W1+2*W2+1.5*imageSize-WW2, imageH1);
    CGPoint pointtEndW2=CGPointMake(W1+2*W2+1.5*imageSize-WW2, imageH1+H2-imageSize/2);
    
    
    NSArray *startArray=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart],[NSValue valueWithCGPoint:pointStart],[NSValue valueWithCGPoint:pointStart1], [NSValue valueWithCGPoint:pointtStartW1], [NSValue valueWithCGPoint:pointStart3], [NSValue valueWithCGPoint:pointStart2], [NSValue valueWithCGPoint:pointtEnd2], [NSValue valueWithCGPoint:pointtEnd21], [NSValue valueWithCGPoint:pointtEnd22], [NSValue valueWithCGPoint:pointtStartW2], nil];
    
    NSArray *endArray=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd],[NSValue valueWithCGPoint:pointtEnd],[NSValue valueWithCGPoint:pointtEnd1], [NSValue valueWithCGPoint:pointtEndW1], [NSValue valueWithCGPoint:pointtEnd3], [NSValue valueWithCGPoint:pointtEnd2], [NSValue valueWithCGPoint:pointtEnd21], [NSValue valueWithCGPoint:pointtEnd22], [NSValue valueWithCGPoint:pointtEndW2], [NSValue valueWithCGPoint:pointtEndW2], nil];
    
    if (_animationNumber==0) {
        _animationNumber=1;
        for (int i=0; i<startArray.count; i++) {
            NSArray *P=[NSArray arrayWithObjects:[startArray objectAtIndex:i],[endArray objectAtIndex:i], nil];
            [self getHeadLayer:P];
        }
    }
    
    float TIME=8;
    //路径一
    NSArray *startArray0=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart],[NSValue valueWithCGPoint:pointStart1], [NSValue valueWithCGPoint:pointStart3], [NSValue valueWithCGPoint:pointtStartW2],nil];
    
    NSArray *endArray0=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd],[NSValue valueWithCGPoint:pointtEnd1], [NSValue valueWithCGPoint:pointtStartW2],[NSValue valueWithCGPoint:pointtEndW2],nil];
    
    [self getHeadAnimation:startArray0 second:endArray0 three:TIME];
    
    ////////////////////////////////
    NSArray *startArray01=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart],[NSValue valueWithCGPoint:pointStart1], [NSValue valueWithCGPoint:pointStart3], [NSValue valueWithCGPoint:pointtStartW2],nil];
    
    NSArray *endArray01=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd],[NSValue valueWithCGPoint:pointtEnd1], [NSValue valueWithCGPoint:pointtStartW2],[NSValue valueWithCGPoint:pointtEndW2],nil];
    
    [self getHeadAnimation:startArray01 second:endArray01 three:TIME];
    
    float pacToUser=[[_pcsDataDic objectForKey:@"pacToUser"] floatValue];
    float pacToGrid=[[_pcsDataDic objectForKey:@"pacToGrid"] floatValue];
    int status=[[_pcsDataDic objectForKey:@"status"] intValue];
    
    // status=2;
    if (pacToGrid>0) {
        //路径二
        NSArray *startArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointStart3], nil];
        NSArray *endArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd3], nil];
        [self getHeadAnimation:startArray02 second:endArray02 three:TIME*0.27];
    }
    
    if( (pacToUser>0)&&(status==1)) {
        //路径三
        NSArray *startArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd3],[NSValue valueWithCGPoint:pointtStartW2],  [NSValue valueWithCGPoint:pointtEnd22], [NSValue valueWithCGPoint:pointtEnd21], [NSValue valueWithCGPoint:pointtEnd2],nil];
        NSArray *endArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtStartW2], [NSValue valueWithCGPoint:pointtEnd22], [NSValue valueWithCGPoint:pointtEnd21], [NSValue valueWithCGPoint:pointtEnd2], [NSValue valueWithCGPoint:pointStart2],nil];
        
        [self getHeadAnimation:startArray02 second:endArray02 three:TIME*1.4];
    }
    
    if (pacToUser>0) {
        NSArray *startArray022=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEnd3],[NSValue valueWithCGPoint:pointtStartW2],  [NSValue valueWithCGPoint:pointtEnd22], nil];
        NSArray *endArray022=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtStartW2], [NSValue valueWithCGPoint:pointtEnd22], [NSValue valueWithCGPoint:pointtEndW2], nil];
        
        [self getHeadAnimation:startArray022 second:endArray022 three:TIME*0.46];
        
    }
    
    
    
    if (status==1) {
        NSArray *startArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtStartW1], nil];
        NSArray *endArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEndW1], nil];
        [self getHeadAnimation:startArray02 second:endArray02 three:TIME*0.33];
    }
    if (status==2) {
        NSArray *startArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtEndW1], nil];
        NSArray *endArray02=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:pointtStartW1], nil];
        [self getHeadAnimation:startArray02 second:endArray02 three:TIME*0.33];
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
