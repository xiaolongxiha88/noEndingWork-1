//
//  MixHead.m
//  ShinePhone
//
//  Created by sky on 2017/11/10.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "MixHead.h"

#define kDegreesToRadian(x) (M_PI * (x) / 180.0)

@implementation MixHead

-(void)initUI{
 //   self.backgroundColor=COLOR(247, 247, 247, 1);
    self.backgroundColor=[UIColor whiteColor];
    [self getUIOne];
}

-(void)getUIOne{
    NSArray *imageNameArray=@[@"newheadSolar.png",@"newheadbat.png",@"newheadgrid.png",@"newheadload.png"];
    float  imageSize=64*NOW_SIZE,imageSize1=60*NOW_SIZE,imageSize2=50*NOW_SIZE;
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
    NSString *Name0=@"市电充电旁路带载";
    NSArray*lableNameArray=@[[NSString stringWithFormat:@"%@:",@"PV功率"],[NSString stringWithFormat:@"%@:",@"电池百分比"],[NSString stringWithFormat:@"%@:",@"并网功率"],[NSString stringWithFormat:@"%@:",@"用电功率"],[NSString stringWithFormat:@"%@:",@"放电功率"]];
        NSArray*lableValueArray=@[[NSString stringWithFormat:@"%.1f",234.0],[NSString stringWithFormat:@"%.f",99.0],[NSString stringWithFormat:@"%.1f",234.0],[NSString stringWithFormat:@"%.1f",234.0],[NSString stringWithFormat:@"%.1f",234.0]];
    NSArray*colorArray=@[COLOR(85, 162, 78, 1),COLOR(85, 162, 78, 1),COLOR(177, 112, 112, 1),COLOR(177, 166, 96, 1),COLOR(85, 162, 78, 1)];
    
      float LableX1=ScreenWidth/2+imageSize/2+KH1;
    float LableY1=H1+imageSize/2-lableH/2;
     float LableY2=(H0-imageSize)/2+H1+imageSize+KH1;
     float LableY3=H2+imageSize/2-lableH/2;
    
    CGRect rectL0=CGRectMake(0*NOW_SIZE, KH1, ScreenWidth, lableH);
     CGRect rectL1=CGRectMake(LableX1, LableY1, lableW, lableH);
      CGRect rectL2=CGRectMake(W0, LableY2, lableW, lableH);
      CGRect rectL22=CGRectMake(W0, LableY2+lableH, lableW, lableH);
     CGRect rectL3=CGRectMake(LableX1, LableY3, lableW, lableH);
      CGRect rectL4=CGRectMake(ScreenWidth-W0-lableW, LableY2, lableW, lableH);
    
       [self getLableUI:rectL0 lableName:Name0 lableValue:@"" lableUnit:@"" valueColor:colorArray[0] directorType:3];
    [self getLableUI:rectL1 lableName:lableNameArray[0] lableValue:lableValueArray[0] lableUnit:@"W" valueColor:colorArray[0] directorType:1];
       [self getLableUI:rectL2 lableName:lableNameArray[1] lableValue:lableValueArray[1] lableUnit:@"%" valueColor:colorArray[1] directorType:1];
      [self getLableUI:rectL22 lableName:lableNameArray[4] lableValue:lableValueArray[4] lableUnit:@"W" valueColor:colorArray[4] directorType:1];
     [self getLableUI:rectL3 lableName:lableNameArray[2] lableValue:lableValueArray[2] lableUnit:@"W" valueColor:colorArray[2] directorType:1];
     [self getLableUI:rectL4 lableName:lableNameArray[3] lableValue:lableValueArray[3] lableUnit:@"W" valueColor:colorArray[3] directorType:2];
    
  /////////////////  //五个大图
    CGRect rectW1=CGRectMake(W0, (H0-imageSize)/2+H1, imageSize, imageSize);
       CGRect rectW3=CGRectMake(310*NOW_SIZE-imageSize, (H0-imageSize)/2+H1, imageSize, imageSize);
     CGRect rectH1=CGRectMake((ScreenWidth-imageSize)/2, H1, imageSize, imageSize);
        CGRect rectH2=CGRectMake((ScreenWidth-imageSize)/2, H2, imageSize, imageSize);
    
    CGRect rectM1=CGRectMake((ScreenWidth-imageSize1)/2, (H0-imageSize1)/2+H1, imageSize1, imageSize1);
    CGRect rectM2=CGRectMake((ScreenWidth-imageSize2)/2, (H0-imageSize2)/2+H1, imageSize2, imageSize2);
    
    [self getImageUI:rectW1 imageName:imageNameArray[1]];
      [self getImageUI:rectM1 imageName:@"newheadAnimal2.png"];
      [self getImageUI:rectW3 imageName:imageNameArray[3]];
         [self getImageUI:rectH1 imageName:imageNameArray[0]];
      [self getImageUI:rectH2 imageName:imageNameArray[2]];
    
    //中间动画
     UIImageView*viewW22=[self getImageTwo:rectM2 imageName:@"newheadAnimal1.png"];
    [self getAnimationThree:viewW22];
    
    
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
    UIImageView*viewD1=[self getImageTwo:rectD1 imageName:@"newheadD1.png"];
    [viewD1.layer addAnimation:[self getAnimationOne:TIME delayTime:0.5] forKey:nil];
    
       //下面的流向
    if (_isGridToUp) {
        UIImageView*viewD2=[self getImageTwo:rectD2 imageName:@"newheadD2.png"];
        [viewD2.layer addAnimation:[self getAnimationOne:TIME delayTime:1.5] forKey:nil];
    }else{
        UIImageView*viewD2=[self getImageTwo:rectD2 imageName:@"newheadD22.png"];
        [viewD2.layer addAnimation:[self getAnimationOne:TIME delayTime:1.5] forKey:nil];
    }
   
        //左边的流向
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

           //右边的流向
    UIImageView*viewD4=[self getImageTwo:rectD4 imageName:@"newheadD4.png"];
    [viewD4.layer addAnimation:[self getAnimationOne:TIME delayTime:2] forKey:nil];
    
    UIImageView*viewD41=[self getImageTwo:rectD41 imageName:@"newheadD3.png"];
    [viewD41.layer addAnimation:[self getAnimationOne:TIME delayTime:3] forKey:nil];
    
    
    

    
    
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
