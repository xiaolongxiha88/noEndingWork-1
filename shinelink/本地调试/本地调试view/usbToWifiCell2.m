//
//  usbToWifiCell2.m
//  ShinePhone
//
//  Created by sky on 2017/10/20.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiCell2.h"

@implementation usbToWifiCell2




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


-(void)initUI{
    
    NSArray *nameArray=@[@"序列号",@"厂商信息",@"PV输入功率",@"PV总电量",@"固件(外部)版本",@"固件(内部)版本",@"总工作时长",@"电网频率",@"逆变器温度",@"Boost温度",@"IPM温度",@"IPF",@"P Bus电压",@"N Bus电压",@"限制的最大输出功率",@"实际输出功率百分比",@"降额模式",@"不匹配的串",@"断开的串",@"电流不平衡的串",@"PID故障码",@"PID状态"];
    
    float H0=50*HEIGHT_SIZE;
    float H=H0*nameArray.count+30*HEIGHT_SIZE;
    _AllView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width,H)];
    _AllView.backgroundColor =[UIColor clearColor];
    [self.contentView addSubview:_AllView];
    
    float lableH=20*HEIGHT_SIZE;
    for (int i=0; i<nameArray.count/2; i++) {
        
        for (int K=0; K<2; K++) {
            UILabel *lable4 = [[UILabel alloc]initWithFrame:CGRectMake(0+SCREEN_Width/2*K, 10*HEIGHT_SIZE+H0*i,SCREEN_Width/2,lableH)];
            lable4.textColor = MainColor;
            lable4.textAlignment=NSTextAlignmentCenter;
            int T=2*i+K;
            lable4.text=nameArray[T];
            lable4.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [_AllView addSubview:lable4];
            
            UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(0+SCREEN_Width/2*K, 10*HEIGHT_SIZE+H0*i+lableH,SCREEN_Width/2,lableH)];
            lable5.textColor =COLOR(102, 102, 102, 1);
            lable5.textAlignment=NSTextAlignmentCenter;
            if (_lable1Array.count>0) {
                  lable5.text=_lable1Array[T];
            }else{
                  lable5.text=@"";
            }
         
            lable5.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [_AllView addSubview:lable5];
            
        }
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!_AllView) {
           [self initUI];
    }
 
    
    
}

// MARK: - 获取展开后的高度
+ (CGFloat)moreHeight:(int)CellTyoe{
    float H=600*HEIGHT_SIZE;

    return H;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
