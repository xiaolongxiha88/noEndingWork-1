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
  //  isSPF5000Circle
    NSString *isSPF5000Circle=[[NSUserDefaults standardUserDefaults] objectForKey:@"isSPF5000Circle"];
    if ([isSPF5000Circle isEqualToString:@"1"]) {
        [self getSPF5000];
    }else{
        [self isSP];
    }
    
    return _dataArray;
}

-(void)getSPF5000{
    if ([_str isEqualToString:@"1"]) {
        if (_dataArray == nil) {
            NSString *A1=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"eCharge"] floatValue]];
            NSString *A2=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"eAcCharge"] floatValue]];
           
            float D1=[A1 floatValue];   float D2=[A2 floatValue];
            float B1=(D1/(D1+D2))*100;
            float B2=(D2/(D1+D2))*100;
       
            
            //            B1=30; B2=30; B3=30;
            //            A1=@"200";
            _dataArray = [[NSMutableArray alloc]initWithArray:@[
                                                                @{@"number":A1,@"color":@"36c176",@"name":[NSString stringWithFormat:@"%.1f%%",B1]},
                                                                @{@"number":A2,@"color":@"8b80ff",@"name":[NSString stringWithFormat:@"%.1f%%",B2]}
                                                                ]];
            
        }
        
    }else{
        NSString *A1=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"eDisCharge"] floatValue]];
        NSString *A2=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"eAcDisCharge"] floatValue]];
    
        float D1=[A1 floatValue];   float D2=[A2 floatValue];
        float B1=(D1/(D1+D2))*100;
        float B2=(D2/(D1+D2))*100;
       
        _dataArray = [[NSMutableArray alloc]initWithArray:@[
                                                            @{@"number":A1,@"color":@"ffd923",@"name":[NSString stringWithFormat:@"%.1f%%",B1]},
                                                            @{@"number":A2,@"color":@"0eeff6",@"name":[NSString stringWithFormat:@"%.1f%%",B2]},
                                                            ]];
    }
    
}


-(void)isSP{
    if ([_str isEqualToString:@"1"]) {
        if (_dataArray == nil) {
            NSString *A1=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"epvStorageToday"] floatValue]];
            NSString *A2=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"epvUserToday"] floatValue]];
            NSString *A3=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"useGridToday"] floatValue]];
            float D1=[A1 floatValue];   float D2=[A2 floatValue];   float D3=[A3 floatValue];
            float B1=(D1/(D1+D2+D3))*100;
            float B2=(D2/(D1+D2+D3))*100;
            float B3=(D3/(D1+D2+D3))*100;
            
            //            B1=30; B2=30; B3=30;
            //            A1=@"200";
            _dataArray = [[NSMutableArray alloc]initWithArray:@[
                                                                @{@"number":A1,@"color":@"36c176",@"name":[NSString stringWithFormat:@"%.1f%%",B1]},
                                                                @{@"number":A2,@"color":@"8b80ff",@"name":[NSString stringWithFormat:@"%.1f%%",B2]},
                                                                @{@"number":A3,@"color":@"0eeff6",@"name":[NSString stringWithFormat:@"%.1f%%",B3]}]];
            
        }
        
    }else{
        NSString *A1=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"epvStorageToday"] floatValue]];
        NSString *A2=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"useUserToday"] floatValue]];
        NSString *A3=[NSString stringWithFormat:@"%.1f",[[_allDic objectForKey:@"useGridToday"] floatValue]];
        float D1=[A1 floatValue];   float D2=[A2 floatValue];   float D3=[A3 floatValue];
        float B1=(D1/(D1+D2+D3))*100;
        float B2=(D2/(D1+D2+D3))*100;
        float B3=(D3/(D1+D2+D3))*100;
        _dataArray = [[NSMutableArray alloc]initWithArray:@[
                                                            @{@"number":A1,@"color":@"36c176",@"name":[NSString stringWithFormat:@"%.1f%%",B1]},
                                                            @{@"number":A2,@"color":@"ffd923",@"name":[NSString stringWithFormat:@"%.1f%%",B2]},
                                                            @{@"number":A3,@"color":@"0eeff6",@"name":[NSString stringWithFormat:@"%.1f%%",B3]}]];
    }

}

//添加圆形比例图
-(void)addCirclView:(NSMutableArray *)arr{
    if (!circleView1) {
        circleView1 = [[CircleMapView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andWithDataArray:arr andWithCircleRadius:self.frame.size.height/2];
        circleView1.backgroundColor = [UIColor clearColor];
        circleView1.dataArray = self.dataArray;
    }
    [self addSubview:circleView1];
}
@end
