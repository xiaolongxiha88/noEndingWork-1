//
//  usbToWifiCell2.m
//  ShinePhone
//
//  Created by sky on 2017/10/20.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiCell2.h"
#import "usbModleOne.h"

@implementation usbToWifiCell2




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


-(void)initUI0{
       float titleLabelH1=30*HEIGHT_SIZE;
    if (!_titleView) {
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width,titleLabelH1)];
        _titleView.backgroundColor =COLOR(247, 247, 247, 1);
        _titleView.userInteractionEnabled = YES;
        UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMoreText)];
        [_titleView addGestureRecognizer:forget2];
        [self.contentView addSubview:_titleView];
        
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0, 200*NOW_SIZE, titleLabelH1)];
        _titleLabel.textColor = MainColor;
        _titleLabel.text=@"关于本机";
        _titleLabel.adjustsFontSizeToFitWidth=YES;
        _titleLabel.textAlignment=NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_titleView addSubview:_titleLabel];
        
        float buttonViewW=20*NOW_SIZE;float buttonW=10*NOW_SIZE;
        UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width-buttonViewW, 0, buttonViewW,titleLabelH1)];
        buttonView.backgroundColor =[UIColor clearColor];
        buttonView.userInteractionEnabled = YES;
        [_titleView addSubview:buttonView];
        
        float buttonH=6*HEIGHT_SIZE;
        
        _moreTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreTextBtn.selected=NO;
        [_moreTextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _moreTextBtn.frame = CGRectMake(0, (titleLabelH1-buttonH)/2, buttonW, buttonH);
        [buttonView addSubview:_moreTextBtn];
        [_moreTextBtn addTarget:self action:@selector(showMoreText) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)showMoreText{
    
self.model.isShowMoreText = !self.model.isShowMoreText;
    
    if (!self.model.isShowMoreText) {
        if (_AllView) {
            [_AllView removeFromSuperview];
            _AllView=nil;
        }
    }
    
    if (self.showMoreBlock){
        self.showMoreBlock(self);
    }
    
}

-(void)initUI{
    
     NSArray *nameArray=@[@"厂商信息",@"机器型号",@"序列号",@"Model号",@"固件(外部)版本",@"固件(内部)版本",@"并网倒计时",@"功率百分比",@"PF",@"内部环境温度",@"Boost温度",@"INV温度",@"P Bus电压",@"N Bus电压",@"PID故障信息",@"PID状态"];
    
    float H0=50*HEIGHT_SIZE;
    float H=H0*nameArray.count+30*HEIGHT_SIZE;
    _AllView = [[UIView alloc]initWithFrame:CGRectMake(0, 34*HEIGHT_SIZE, SCREEN_Width,H)];
    _AllView.backgroundColor =[UIColor clearColor];
    [self.contentView addSubview:_AllView];
    
    float lableH=20*HEIGHT_SIZE;
    for (int i=0; i<nameArray.count/2; i++) {
        
        for (int K=0; K<2; K++) {
            UILabel *lable4 = [[UILabel alloc]initWithFrame:CGRectMake(0+SCREEN_Width/2*K, 10*HEIGHT_SIZE+H0*i,SCREEN_Width/2,lableH)];
            lable4.textColor = MainColor;
            lable4.textAlignment=NSTextAlignmentCenter;
            lable4.adjustsFontSizeToFitWidth=YES;
            int T=2*i+K;
            lable4.text=nameArray[T];
            lable4.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [_AllView addSubview:lable4];
            
            UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(0+SCREEN_Width/2*K, 10*HEIGHT_SIZE+H0*i+lableH,SCREEN_Width/2,lableH)];
            lable5.textColor =COLOR(102, 102, 102, 1);
            lable5.textAlignment=NSTextAlignmentCenter;
            lable5.tag=6000+T;
            if (_lable1Array.count>0) {
                NSString *TEXT=[NSString stringWithFormat:@"%@",_lable1Array[T]];
                if ([TEXT isEqualToString:@""]) {
                     lable5.text=@"/";
                }else{
                      lable5.text=TEXT;
                }
                
            }else{
                  lable5.text=@"";
            }
            lable5.adjustsFontSizeToFitWidth=YES;
            lable5.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [_AllView addSubview:lable5];
            
        }
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self initUI0];
    

 
    if (self.model.isShowMoreText){ // 展开状态
        
        [_moreTextBtn setImage:IMAGE(@"MAXup.png") forState:UIControlStateNormal];
        if (!_AllView) {
            [self initUI];
        }else{
            for (int i=0; i<_lable1Array.count; i++) {
                UILabel *lable=[_AllView viewWithTag:6000+i];
                if (_lable1Array.count>0) {
                    NSString *TEXT=[NSString stringWithFormat:@"%@",_lable1Array[i]];
                    if ([TEXT isEqualToString:@""]) {
                        lable.text=@"/";
                    }else{
                        lable.text=TEXT;
                    }
                    // lable.text=_lable1Array[i];
                }else{
                    lable.text=@"";
                }
                
            }
        }
    }else{ // 收缩状态
        [_AllView removeFromSuperview];

        [_moreTextBtn setImage:IMAGE(@"MAXdown.png") forState:UIControlStateNormal];
    }
    
    
    
}

// MARK: - 获取展开后的高度
+ (CGFloat)moreHeight:(int)CellTyoe{
    float H=600*HEIGHT_SIZE;

    return H;
    
}


+ (CGFloat)defaultHeight{
    
    return 38*HEIGHT_SIZE;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
