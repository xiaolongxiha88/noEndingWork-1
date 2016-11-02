//
//  GFWaterView.m
//  动画
//
//  Created by 李国峰 on 16/6/6.
//  Copyright © 2016年 李国峰. All rights reserved.
//

#import "GFWaterView.h"

@implementation GFWaterView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    // 半径
    CGFloat rabius = 60;
    // 开始角
    CGFloat startAngle = 0;
    
    // 中心点
    CGPoint point = CGPointMake(100*NOW_SIZE, 100*NOW_SIZE);  // 中心店我手动写的,你看看怎么弄合适 自己在搞一下
    
    // 结束角
    CGFloat endAngle = 2*M_PI;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:rabius startAngle:startAngle endAngle:endAngle clockwise:YES];

    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = path.CGPath;       // 添加路径 下面三个同理
    layer.lineWidth = 2*HEIGHT_SIZE;
    layer.strokeColor =COLOR(32, 213, 147, 1).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    
    [self.layer addSublayer:layer];

}

@end
