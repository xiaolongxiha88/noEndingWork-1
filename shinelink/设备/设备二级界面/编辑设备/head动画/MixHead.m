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
   float lableH=20*NOW_SIZE,lableW=imageSize*1.4;
    
    float  directionSizeW1=14*NOW_SIZE,directionSizeH1=18*NOW_SIZE,directionSizeW2=12*NOW_SIZE,directionSizeH2=16*NOW_SIZE;
  
    float KH1=2.5*NOW_SIZE;
    float H1=lableH+2*KH1;
    float H0=self.frame.size.height-H1;
    float KH2=(H0-imageSize1)/2+H1-(H1+imageSize);
    float KH3=(KH2-directionSizeW1)/2;
    
     float H2=(H0-imageSize1)/2+H1+imageSize1+KH2;
    
    //五个大图
    CGRect rectW1=CGRectMake(10*NOW_SIZE, (H0-imageSize)/2+H1, imageSize, imageSize);
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
    
    
    float KW1=(ScreenWidth-imageSize1)/2-10*NOW_SIZE-imageSize;
      float KW2=(KW1-directionSizeW1-directionSizeW2)/4;
      float DX=imageSize+10*NOW_SIZE;
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
    
    
    
    /////////////////////////////////////////////////////////////////////////////////lable区域
      CGRect rectL1=CGRectMake(0*NOW_SIZE, 2.5*NOW_SIZE, ScreenWidth, lableH);
   [self getLableUI:rectL1 lableName:@"市电充电旁路带载" lableValue:@"" lableUnit:@"" valueColor:COLOR(85, 162, 78, 1)];
    
    
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

-(void)getLableUI:(CGRect)frameRect lableName:(NSString*)lableName lableValue:(NSString*)lableValue lableUnit:(NSString*)lableUnit  valueColor:(UIColor*)valueColor {
    
    UILabel *solorLable=[[UILabel alloc] initWithFrame:frameRect];
      solorLable.textColor=COLOR(136, 136, 136, 1);
    NSUInteger length0 = [lableName length];
     NSUInteger length1 = [lableValue length];
    NSString *allName=[NSString stringWithFormat:@"%@%@%@",lableName,lableValue,lableUnit];
     NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:allName];
    [attrString addAttribute:NSForegroundColorAttributeName value:valueColor range:NSMakeRange(length0, length1)];
      solorLable.attributedText=attrString;

    solorLable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    solorLable.adjustsFontSizeToFitWidth=YES;
    solorLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:solorLable];
    
}



@end
