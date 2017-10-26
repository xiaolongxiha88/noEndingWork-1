//
//  usbToWifiControlCell1.m
//  ShinePhone
//
//  Created by sky on 2017/10/25.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiControlCell1.h"
#import "usbModleOne.h"


@implementation usbToWifiControlCell1

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return self;
}

-(void)initUI{

    float titleLabelH1=30*HEIGHT_SIZE;
    
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    if (_titleView) {
        [_titleView removeFromSuperview];
        _titleView=nil;
    }
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width,titleLabelH1)];
    _titleView.backgroundColor =COLOR(247, 247, 247, 1);
    _titleView.userInteractionEnabled = YES;
    UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMoreText)];
    [_titleView addGestureRecognizer:forget2];
    [self.contentView addSubview:_titleView];
    
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0, 280*NOW_SIZE, titleLabelH1)];
    _titleLabel.textColor = MainColor;
    _titleLabel.text=_titleString;
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
    
    _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:@"设置" forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
        [_goBut addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
    
    
 
}


-(void)initTwoUI{
    if (_view1) {
        [_view1 removeFromSuperview];
        _view1=nil;
    }
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40*HEIGHT_SIZE, ScreenWidth,200*HEIGHT_SIZE)];
    _view1.backgroundColor =[UIColor clearColor];
    _view1.userInteractionEnabled = YES;
    [self.contentView addSubview:_view1];
    
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    PV2Lable.text=_titleString;
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=COLOR(102, 102, 102, 1);;
    PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    PV2Lable.adjustsFontSizeToFitWidth=YES;
    [_view1 addSubview:PV2Lable];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 30*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textField2.layer.borderWidth=1;
    _textField2.layer.cornerRadius=5;
    _textField2.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
    _textField2.textColor = COLOR(102, 102, 102, 1);;
    _textField2.tintColor = COLOR(102, 102, 102, 1);;
    _textField2.textAlignment=NSTextAlignmentCenter;
    _textField2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_view1 addSubview:_textField2];
    
    UILabel *PV2Lable1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 75*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    PV2Lable1.text=[NSString stringWithFormat:@"(读取值:%@)",_readValue];
    PV2Lable1.textAlignment=NSTextAlignmentCenter;
    PV2Lable1.textColor=COLOR(102, 102, 102, 1);
    PV2Lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    PV2Lable1.adjustsFontSizeToFitWidth=YES;
    [_view1 addSubview:PV2Lable1];
    
    _goBut.frame=CGRectMake(60*NOW_SIZE,115*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_view1 addSubview:_goBut];
}


-(void)finishSet{
    
    
}


- (void)showMoreText{
    
    self.model.isShowMoreText = !self.model.isShowMoreText;
    
    
    if (self.showMoreBlock){
        self.showMoreBlock(self);
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self initUI];
    
    if (self.model.isShowMoreText){ // 展开状态
           [self initTwoUI];
        [_moreTextBtn setImage:IMAGE(@"MAXup.png") forState:UIControlStateNormal];
        
    }else{ // 收缩状态
        
        [_moreTextBtn setImage:IMAGE(@"MAXdown.png") forState:UIControlStateNormal];
    }
}



+ (CGFloat)defaultHeight{
    
    return 38*HEIGHT_SIZE;
}


+ (CGFloat)moreHeight:(int)CellTyoe{
    float H=240*HEIGHT_SIZE;
 
    return H;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
