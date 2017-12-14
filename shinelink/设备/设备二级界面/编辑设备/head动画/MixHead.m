//
//  MixHead.m
//  ShinePhone
//
//  Created by sky on 2017/11/10.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "MixHead.h"
#import <objc/runtime.h>
#import "PopoverView00.h"

#define kDegreesToRadian(x) (M_PI * (x) / 180.0)

@implementation MixHead

-(void)initUI{
 //   self.backgroundColor=COLOR(247, 247, 247, 1);
    self.backgroundColor=[UIColor whiteColor];
    [self getUIOne];
}

-(void)getUIOne{
    NSInteger allStatue=0;           //0正常状态     1离线状态    2故障
    NSString*allStatueString=[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"lost"]];
  
    
     int L1=[[NSString stringWithFormat:@"%d",[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"uwSysWorkMode"]] intValue]] intValue];
    if ([allStatueString containsString:@"lost"]) {
        allStatue=1;
    }else{
        if (L1==3) {
              allStatue=2;
        }
    }
   
    NSArray *imageNameArray=@[@"newheadSolar.png",@"newheadbat.png",@"newheadgrid.png",@"newheadload.png"];
    float  imageSize=64*NOW_SIZE,imageSize1=60*NOW_SIZE,imageSize2=45*NOW_SIZE;
   float lableH=20*NOW_SIZE;
     float lableW=110*NOW_SIZE;
    float  directionSizeW1=14*NOW_SIZE,directionSizeH1=18*NOW_SIZE,directionSizeW2=12*NOW_SIZE,directionSizeH2=16*NOW_SIZE;
  
    float KH1=2.5*NOW_SIZE;
    float H1=lableH+2*KH1;
    float H0=self.frame.size.height-H1;
    float KH2=(H0-imageSize1)/2+H1-(H1+imageSize);
    float KH3=(KH2-directionSizeW1)/2;
    
     float H2=(H0-imageSize1)/2+H1+imageSize1+KH2;
    float W0=10*NOW_SIZE;
    
    
    /////////////////////////////////////////////////////////////////////////////////lable区域
    
   
    NSString*L1Name1=@"";
    NSArray *statueArray=@[root_MIX_201,root_MIX_202,root_MIX_203,root_MIX_204,root_MIX_205,root_MIX_206,root_MIX_206,root_MIX_207,root_MIX_207];
    if (L1<statueArray.count) {
          L1Name1=statueArray[L1];
    }
  
    
    int L2=[[NSString stringWithFormat:@"%d",[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"priorityChoose"]] intValue]] intValue];
    NSString*L1Name2=@"";
    NSArray *statueArray2=@[root_MIX_208,root_MIX_209,root_MIX_210];
    if (L2<statueArray2.count) {
            L1Name2=statueArray2[L2];
    }
    NSString *Name0=@"";
    if ([L1Name2 isEqualToString:@""]) {
       Name0=[NSString stringWithFormat:@"%@",L1Name1];
    }else{
         Name0=[NSString stringWithFormat:@"%@(%@)",L1Name1,L1Name2];
    }
  
    //root_PCS_fangdian_gonglv     root_Charge_Power
    NSString *valueUp=[NSString stringWithFormat:@"%.1f",[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"ppv"]] floatValue]];
        NSString *valueL2=[NSString stringWithFormat:@"%.1f",[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"SOC"]] floatValue]];
       NSString *valueLeft0=[NSString stringWithFormat:@"%.1f",[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"chargePower"]] floatValue]];
    
    NSString *nameLeft=@"";NSString *valueLeft=@"";
    if ([valueLeft0 floatValue]>0) {
        nameLeft=root_Charge_Power;
            _isBatToRight=NO;
        valueLeft=[NSString stringWithFormat:@"%.1f",[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"chargePower"]] floatValue]];
    }else{
        _isBatToRight=YES;
        nameLeft=root_PCS_fangdian_gonglv;
        valueLeft=[NSString stringWithFormat:@"%.1f",[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"pdisCharge1"]] floatValue]];
    }
    
  NSString *valuedown=@"";
   NSString *valuedown0=[NSString stringWithFormat:@"%.1f",[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"pactouser"]] floatValue]];
    if ([valuedown0 floatValue]>0) {
        _isGridToUp=YES;
        valuedown=[NSString stringWithFormat:@"%.1f",[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"pactouser"]] floatValue]];
    }else{
           _isGridToUp=NO;
        valuedown=[NSString stringWithFormat:@"%.1f",[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"pactogrid"]] floatValue]];
    }
    
          NSString *valueRight=[NSString stringWithFormat:@"%.1f",[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"pLocalLoad"]] floatValue]];
   
    
    NSArray*lableNameArray=@[[NSString stringWithFormat:@"%@:",root_device_260],[NSString stringWithFormat:@"%@:",root_PCS_dianchi_baifenbi],[NSString stringWithFormat:@"%@:",root_MIX_212],[NSString stringWithFormat:@"%@:",root_MIX_211],[NSString stringWithFormat:@"%@:",nameLeft]];
    
        NSArray*lableValueArray=@[valueUp,valueL2,valuedown,valueRight,valueLeft];
    
    NSArray*colorArray=@[COLOR(85, 162, 78, 1),COLOR(85, 162, 78, 1),COLOR(177, 112, 112, 1),COLOR(177, 166, 96, 1),COLOR(85, 162, 78, 1)];
    
      float LableX1=ScreenWidth/2+imageSize/2+KH1;
    float LableY1=H1+imageSize/2-lableH/2;
     float LableY2=(H0-imageSize)/2+H1+imageSize+KH1;
      float LableY22=(H0-imageSize)/2+H1-KH1-lableH;
     float LableY3=H2+imageSize/2-lableH/2;
    
    CGRect rectL0=CGRectMake(0*NOW_SIZE, KH1, ScreenWidth, lableH);
     CGRect rectL1=CGRectMake(LableX1, LableY1, lableW, lableH);
      CGRect rectL2=CGRectMake(W0, LableY2, lableW, lableH);
      CGRect rectL22=CGRectMake(W0, LableY22, lableW, lableH);
     CGRect rectL3=CGRectMake(LableX1, LableY3, lableW, lableH);
      CGRect rectL4=CGRectMake(ScreenWidth-W0-lableW, LableY2, lableW, lableH);
    
    if (allStatue==1) {
          [self getLableUI:rectL0 lableName:root_CNJ_buzaixian lableValue:@"" lableUnit:@"" valueColor:COLOR(136, 136, 136, 1) directorType:3];
    }else if (allStatue==2) {
        [self getLableUI:rectL0 lableName:Name0 lableValue:@"" lableUnit:@"" valueColor:COLOR(177, 112, 112, 1) directorType:3];
    }else{
           [self getLableUI:rectL0 lableName:Name0 lableValue:@"" lableUnit:@"" valueColor:COLOR(85, 162, 78, 1) directorType:3];
    }
    
    
    [self getLableUI:rectL1 lableName:lableNameArray[0] lableValue:lableValueArray[0] lableUnit:@"W" valueColor:colorArray[0] directorType:1];
       [self getLableUI:rectL2 lableName:lableNameArray[1] lableValue:lableValueArray[1] lableUnit:@"%" valueColor:colorArray[1] directorType:1];
      [self getLableUI:rectL22 lableName:lableNameArray[4] lableValue:lableValueArray[4] lableUnit:@"W" valueColor:colorArray[4] directorType:1];
    
    if (_isGridToUp) {
      [self getLableUI:rectL3 lableName:root_device_261 lableValue:lableValueArray[2] lableUnit:@"W" valueColor:colorArray[2] directorType:1];
    }else{
      [self getLableUI:rectL3 lableName:root_device_262 lableValue:lableValueArray[2] lableUnit:@"W" valueColor:COLOR(85, 162, 78, 1) directorType:1];
    }
   
     [self getLableUI:rectL4 lableName:lableNameArray[3] lableValue:lableValueArray[3] lableUnit:@"W" valueColor:colorArray[3] directorType:2];
    
  /////////////////  //五个大图
    CGRect rectW1=CGRectMake(W0, (H0-imageSize)/2+H1, imageSize, imageSize);
       CGRect rectW3=CGRectMake(310*NOW_SIZE-imageSize, (H0-imageSize)/2+H1, imageSize, imageSize);
     CGRect rectH1=CGRectMake((ScreenWidth-imageSize)/2, H1, imageSize, imageSize);
        CGRect rectH2=CGRectMake((ScreenWidth-imageSize)/2, H2, imageSize, imageSize);
    
    CGRect rectM1=CGRectMake((ScreenWidth-imageSize1)/2, (H0-imageSize1)/2+H1, imageSize1, imageSize1);
    CGRect rectM2=CGRectMake((ScreenWidth-imageSize2)/2, (H0-imageSize2)/2+H1, imageSize2, imageSize2);
    
    [self getImageUI:rectW1 imageName:imageNameArray[1]];

      [self getImageUI:rectW3 imageName:imageNameArray[3]];
         [self getImageUI:rectH1 imageName:imageNameArray[0]];
    
    if (_isGridToUp) {
           [self getImageUI:rectH2 imageName:@"newheadgrid.png"];
    }else{
           [self getImageUI:rectH2 imageName:@"newheadgrid2.png"];
    }
    
     //中间动画
    UIImageView*viewW22;
    if (allStatue==2) {
        [self getImageUI:rectM1 imageName:@"newheadAnimal41.png"];
       viewW22=[self getImageTwo:rectM2 imageName:@"newheadAnimal42.png"];
    }else if (allStatue==1) {
        [self getImageUI:rectM1 imageName:@"newheadAnimal31.png"];
        viewW22=[self getImageTwo:rectM2 imageName:@"newheadAnimal32.png"];
    }else{
        [self getImageUI:rectM1 imageName:@"newheadAnimal21.png"];
        viewW22=[self getImageTwo:rectM2 imageName:@"newheadAnimal22.png"];
    }

    
    [self getAnimationThree:viewW22];
    
    
    
    if (allStatue!=1) {
      
        float KW1=(ScreenWidth-imageSize1)/2-W0-imageSize;
        float KW2=(KW1-directionSizeW1-directionSizeW2)/4;
        float DX=imageSize+W0;
        float DX1=(ScreenWidth-imageSize1)/2+imageSize1;
        float TIME=1;
        //方向图
        CGRect rectD1=CGRectMake((ScreenWidth-directionSizeH1)/2, H1+imageSize+KH3, directionSizeH1, directionSizeW1);
        CGRect rectD2=CGRectMake((ScreenWidth-directionSizeH1)/2, (H0-imageSize1)/2+H1+imageSize1+KH3, directionSizeH1, directionSizeW1);
        
        CGRect rectD3=CGRectMake(DX+KW2, (H0-directionSizeH1)/2+H1, directionSizeW1, directionSizeH1);
        CGRect rectD31=CGRectMake(DX+KW2*3+directionSizeW1, (H0-directionSizeH2)/2+H1, directionSizeW2, directionSizeH2);
        
        CGRect rectD4=CGRectMake(DX1+KW2, (H0-directionSizeH2)/2+H1, directionSizeW2, directionSizeH2);
        CGRect rectD41=CGRectMake(DX1+KW2*3+directionSizeW2, (H0-directionSizeH1)/2+H1, directionSizeW1, directionSizeH1);
        
        //上面的流向
        if ([valueUp floatValue]>0) {
            UIImageView*viewD1=[self getImageTwo:rectD1 imageName:@"newheadD1.png"];
            [viewD1.layer addAnimation:[self getAnimationOne:TIME delayTime:0.5] forKey:nil];
        }
        
        
        //下面的流向
        if ([valuedown floatValue]>0) {
            if (_isGridToUp) {
                UIImageView*viewD2=[self getImageTwo:rectD2 imageName:@"newheadD2.png"];
                [viewD2.layer addAnimation:[self getAnimationOne:TIME delayTime:1.5] forKey:nil];
            }else{
                UIImageView*viewD2=[self getImageTwo:rectD2 imageName:@"newheadD1.png"];
                [viewD2.layer addAnimation:[self getAnimationOne:TIME delayTime:1.5] forKey:nil];
            }
        }
        
        
        //左边的流向valueLeft
        if ([valueLeft floatValue]>0) {
            if (_isBatToRight) {
                UIImageView*viewD3=[self getImageTwo:rectD3 imageName:@"newheadD3.png"];
                [viewD3.layer addAnimation:[self getAnimationOne:TIME delayTime:0] forKey:nil];
                
                UIImageView*viewD31=[self getImageTwo:rectD31 imageName:@"newheadD4.png"];
                [viewD31.layer addAnimation:[self getAnimationOne:TIME delayTime:1] forKey:nil];
            }else{
                UIImageView*viewD31=[self getImageTwo:rectD3 imageName:@"newheadD33.png"];
                [viewD31.layer addAnimation:[self getAnimationOne:TIME delayTime:1] forKey:nil];
                
                UIImageView*viewD3=[self getImageTwo:rectD31 imageName:@"newheadD44.png"];
                [viewD3.layer addAnimation:[self getAnimationOne:TIME delayTime:0] forKey:nil];
            }
        }
        
        
        //右边的流向
        if ([valueRight floatValue]>0) {
            UIImageView*viewD4=[self getImageTwo:rectD4 imageName:@"newheadD4.png"];
            [viewD4.layer addAnimation:[self getAnimationOne:TIME delayTime:2] forKey:nil];
            
            UIImageView*viewD41=[self getImageTwo:rectD41 imageName:@"newheadD3.png"];
            [viewD41.layer addAnimation:[self getAnimationOne:TIME delayTime:3] forKey:nil];
        }
        
    }
   
    
    
    [self getNoticeUI];
}


-(void)getNoticeUI{
    
 
    
    
 NSString *mix192=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"vPv1"] floatValue]];
    NSString *mix193=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"pPv1"] floatValue]];
    NSString *mix194=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"vPv2"] floatValue]];
    NSString *mix195=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"pPv2"] floatValue]];
    
     NSString *mix196=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"vBat"] floatValue]];
     NSString *mix197=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"vAc1"] floatValue]];
     NSString *mix198=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"fAc"] floatValue]];
     NSString *mix199=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"upsVac1"] floatValue]];
    NSString *mix200=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"upsFac"] floatValue]];
  
    NSString *name11=[NSString stringWithFormat:@"%@:%@V",root_MIX_192,mix192];
    NSString *name22=[NSString stringWithFormat:@"%@:%@W",root_MIX_193,mix193];
    NSString *name33=[NSString stringWithFormat:@"%@:%@V",root_MIX_194,mix194];
    NSString *name44=[NSString stringWithFormat:@"%@:%@W",root_MIX_195,mix195];
    
    NSString *name55=[NSString stringWithFormat:@"%@:%@V",root_MIX_196,mix196];
    NSString *name66=[NSString stringWithFormat:@"%@:%@V",root_MIX_197,mix197];
    NSString *name77=[NSString stringWithFormat:@"%@:%@Hz",root_MIX_198,mix198];
    NSString *name88=[NSString stringWithFormat:@"%@:%@V",root_MIX_199,mix199];
        NSString *name99=[NSString stringWithFormat:@"%@:%@Hz",root_MIX_200,mix200];
      NSArray *lableName=[NSArray arrayWithObjects:name11,name22,name33,name44,name55,name66,name77,name88,name99,nil];
    
    
    UIView *VV1=[[UIView alloc] initWithFrame:CGRectMake(20*NOW_SIZE,self.frame.size.height-40*NOW_SIZE,40*NOW_SIZE,40*NOW_SIZE)];
    VV1.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAnotherView:)];
    [VV1 addGestureRecognizer:tapGestureRecognizer];
        objc_setAssociatedObject(VV1, "firstObject", lableName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:VV1];
    
    float imageW=20*NOW_SIZE;
    UIImageView *image00 = [[UIImageView alloc] initWithFrame:CGRectMake(5*NOW_SIZE,5*NOW_SIZE,imageW,imageW)];
    image00.image = [UIImage imageNamed:@"newheadnotes.png"];
    image00.userInteractionEnabled=YES;
    [VV1 addSubview:image00];
    
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


- (void)getAnimationThree:(UIImageView *)view

{
    
    CABasicAnimation *rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    
    rotationAnimation.duration = 2;
    
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}


-(CABasicAnimation *)getAnimationOne:(float)time  delayTime:(float)delayTime
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.beginTime = CACurrentMediaTime() + delayTime;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}




-(void)getImageUI:(CGRect)frameRect imageName:(NSString*)imageName{
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:frameRect];
    imageView1.image = [UIImage imageNamed:imageName];
    [self addSubview:imageView1];
}

-(UIImageView *)getImageTwo:(CGRect)frameRect imageName:(NSString*)imageName{
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:frameRect];
    imageView1.image = [UIImage imageNamed:imageName];
    [self addSubview:imageView1];
    return imageView1;
}

-(void)getLableUI:(CGRect)frameRect lableName:(NSString*)lableName lableValue:(NSString*)lableValue lableUnit:(NSString*)lableUnit  valueColor:(UIColor*)valueColor directorType:(int)directorType{
    
    UILabel *solorLable=[[UILabel alloc] initWithFrame:frameRect];
  
      solorLable.textColor=COLOR(136, 136, 136, 1);
    if (directorType==3) {
        solorLable.textColor=valueColor;
    }
    NSUInteger length0 = [lableName length];
     NSUInteger length1 = [lableValue length];
    NSString *allName=[NSString stringWithFormat:@"%@%@%@",lableName,lableValue,lableUnit];
     NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:allName];
    [attrString addAttribute:NSForegroundColorAttributeName value:valueColor range:NSMakeRange(length0, length1)];
      solorLable.attributedText=attrString;

    solorLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    solorLable.adjustsFontSizeToFitWidth=YES;
    if (directorType==1) {
           solorLable.textAlignment = NSTextAlignmentLeft;
    }else  if (directorType==2) {
            solorLable.textAlignment = NSTextAlignmentRight;
    }else{
            solorLable.textAlignment = NSTextAlignmentCenter;
         solorLable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    }

    [self addSubview:solorLable];
    
}



@end
