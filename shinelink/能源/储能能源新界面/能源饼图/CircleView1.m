//
//  CircleView.m
//  YCT
//
//  Created by 余晋龙 on 16/9/21.
//  Copyright © 2016年 bzjc. All rights reserved.
//


#define TITLE_HEIGHT 60
#define PIE_HEIGHT 200
#define Radius 65.5 //圆形比例图的半径

#import "CircleView1.h"
#import "CircleMapView.h"


@interface CircleView1()
{
 CircleMapView *circleView1;
    id delegate;
}
@end
@implementation CircleView1
-(instancetype)initWithFrame:(CGRect)frame andUrlStr:(NSString *)str andAllDic:(NSDictionary*)dic
{
    if (self = [super initWithFrame:frame]) {
        _str = str;
        _allDic=[NSDictionary dictionaryWithDictionary:dic];
        [self addCirclView:self.dataArray];  //添加饼状图
    }
    return self;
}
-(NSMutableArray *)dataArray{
    if ([_str isEqualToString:@"1"]) {
        if (_dataArray == nil) {
            NSString *A1=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"epvGridToday"] floatValue]];
            NSString *A2=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"epvStorageToday"] floatValue]];
                NSString *A3=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"epvUserToday"] floatValue]];
            float D1=[A1 intValue];   float D2=[A2 intValue];   float D3=[A3 intValue];
            float B1=(D1/(D1+D2+D3))*100;
            float B2=(D2/(D1+D2+D3))*100;
            float B3=(D3/(D1+D2+D3))*100;

//            B1=30; B2=30; B3=30;
//            A1=@"200";
            _dataArray = [[NSMutableArray alloc]initWithArray:@[
                                                                @{@"number":A1,@"color":@"376efb",@"name":[NSString stringWithFormat:@"%.1f%%",B1]},
                                                                @{@"number":A2,@"color":@"20db76",@"name":[NSString stringWithFormat:@"%.1f%%",B2]},
                                                                @{@"number":A3,@"color":@"81fafe",@"name":[NSString stringWithFormat:@"%.1f%%",B3]}]];
            
        }

    }else{
        NSString *A1=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"useGridToday"] floatValue]];
        NSString *A2=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"useStorageToday"] floatValue]];
        NSString *A3=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"useUserToday"] floatValue]];
        float D1=[A1 intValue];   float D2=[A2 intValue];   float D3=[A3 intValue];
        float B1=(D1/(D1+D2+D3))*100;
        float B2=(D2/(D1+D2+D3))*100;
        float B3=(D3/(D1+D2+D3))*100;
        _dataArray = [[NSMutableArray alloc]initWithArray:@[
                                                            @{@"number":A1,@"color":@"376efb",@"name":[NSString stringWithFormat:@"%.1f%%",B1]},
                                                            @{@"number":A2,@"color":@"20db76",@"name":[NSString stringWithFormat:@"%.1f%%",B2]},
                                                            @{@"number":A3,@"color":@"ffd923",@"name":[NSString stringWithFormat:@"%.1f%%",B3]}]];
    }
    
    return _dataArray;
}
//添加圆形比例图
-(void)addCirclView:(NSMutableArray *)arr{
    if (!circleView1) {
        circleView1 = [[CircleMapView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, PIE_HEIGHT) andWithDataArray:arr andWithCircleRadius:Radius];
        circleView1.backgroundColor = [UIColor clearColor];
        circleView1.dataArray = self.dataArray;
    }
    [self addSubview:circleView1];
}
@end
