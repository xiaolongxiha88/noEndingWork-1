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
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    [self.contentView addGestureRecognizer:tapGestureRecognizer];
    
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
    _titleLabel.text=[NSString stringWithFormat:@"%d.%@",_CellNumber,_titleString];
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
    
    if (_CellNumber==0 || _CellNumber==2 || _CellNumber==8 || _CellNumber==14 || _CellNumber==15 || _CellNumber==16 || _CellNumber==17 || _CellNumber==18 || _CellNumber==19 || _CellNumber==20) {
        _textLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 25*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textLable.text=@"点击选择";
        _textLable.textAlignment=NSTextAlignmentCenter;
        _textLable.textColor=COLOR(102, 102, 102, 1);;
        _textLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        _textLable.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:_textLable];
    }else{
        _textField2 = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 25*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textField2.layer.borderWidth=1;
        _textField2.layer.cornerRadius=5;
        _textField2.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        _textField2.textColor = COLOR(102, 102, 102, 1);;
        _textField2.tintColor = COLOR(102, 102, 102, 1);;
        _textField2.textAlignment=NSTextAlignmentCenter;
        _textField2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_view1 addSubview:_textField2];
        
    }

    

    
    UILabel *PV2Lable1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 70*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    PV2Lable1.text=[NSString stringWithFormat:@"(读取值:%@)",_readValue];
    PV2Lable1.textAlignment=NSTextAlignmentCenter;
    PV2Lable1.textColor=COLOR(102, 102, 102, 1);
    PV2Lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    PV2Lable1.adjustsFontSizeToFitWidth=YES;
    [_view1 addSubview:PV2Lable1];
    
    _goBut.frame=CGRectMake(60*NOW_SIZE,115*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_view1 addSubview:_goBut];
}


-(void)initThreeUI{
    if (_view1) {
        [_view1 removeFromSuperview];
        _view1=nil;
    }
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40*HEIGHT_SIZE, ScreenWidth,300*HEIGHT_SIZE)];
    _view1.backgroundColor =[UIColor clearColor];
    _view1.userInteractionEnabled = YES;
    [self.contentView addSubview:_view1];
     _lableNameArray=@[@[@"电源启动斜率(20)",@"电源重启斜率(21)"],@[@"Q(v)切出高压(93)",@"Q(v)切入高压(94)"],@[@"Q(v)切出低压(95)",@"Q(v)切入低压(96)"],@[@"Q(v)切入功率(97)",@"Q(v)切出功率(98)"],@[@"无功曲线切入电压(99)",@"无功曲线切出电压(100)"],@[@"检查固件1(233)",@"检查固件2(234)"]];
    NSArray *nameArray=[NSArray arrayWithArray:_lableNameArray[_CellNumber-21]];
    

    
    float H=100*HEIGHT_SIZE;
    for (int i=0; i<2; i++) {
        UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE+H*i, 300*NOW_SIZE,20*HEIGHT_SIZE )];
        PV2Lable.text=nameArray[i];
        PV2Lable.textAlignment=NSTextAlignmentLeft;
        PV2Lable.textColor=COLOR(102, 102, 102, 1);;
        PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        PV2Lable.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:PV2Lable];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 25*HEIGHT_SIZE+H*i, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        textField.layer.borderWidth=1;
        textField.layer.cornerRadius=5;
        textField.tag=2000+i;
        textField.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        textField.textColor = COLOR(102, 102, 102, 1);;
        textField.tintColor = COLOR(102, 102, 102, 1);;
        textField.textAlignment=NSTextAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_view1 addSubview:textField];
        
        UILabel *PV2Lable1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 70*HEIGHT_SIZE+H*i, 300*NOW_SIZE,20*HEIGHT_SIZE )];
        PV2Lable1.text=[NSString stringWithFormat:@"(读取值:%@)",_readValue];
        PV2Lable1.textAlignment=NSTextAlignmentCenter;
        PV2Lable1.textColor=COLOR(102, 102, 102, 1);
        PV2Lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        PV2Lable1.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:PV2Lable1];
    }
   
    
    _goBut.frame=CGRectMake(60*NOW_SIZE,215*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_view1 addSubview:_goBut];
}


-(void)initFourUI{
    if (_view1) {
        [_view1 removeFromSuperview];
        _view1=nil;
    }
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40*HEIGHT_SIZE, ScreenWidth,800*HEIGHT_SIZE)];
    _view1.backgroundColor =[UIColor clearColor];
    _view1.userInteractionEnabled = YES;
    [self.contentView addSubview:_view1];
    
   // self.contentView.frame=CGRectMake(0,0, ScreenWidth,2*ScreenWidth);
    
    
    NSArray* nameArray=@[@[@"PF调整值1(101)",@"PF调整值2(102)",@"PF调整值3(103)",@"PF调整值4(104)",@"PF调整值5(105)",@"PF调整值6(106)",],@[@"PF限制负载百分比点1(110)",@"PF限制负载百分比点2(112)",@"PF限制负载百分比点3(114)",@"PF限制负载百分比点4(116)"],@[@"PF限制功率因数点1(111)",@"PF限制功率因数点2(113)",@"PF限制功率因数点3(115)",@"PF限制功率因数点4(117)"]];
  
    if (_CellNumber==27) {
        _nameArray0=nameArray[0];
            _goBut.frame=CGRectMake(60*NOW_SIZE,615*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    }else if (_CellNumber==28) {
        _nameArray0=nameArray[1];
          _goBut.frame=CGRectMake(60*NOW_SIZE,415*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    }else if (_CellNumber==29) {
        _nameArray0=nameArray[2];
          _goBut.frame=CGRectMake(60*NOW_SIZE,415*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    }

    [_view1 addSubview:_goBut];
    
    float H=100*HEIGHT_SIZE;
    for (int i=0; i<_nameArray0.count; i++) {
        UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE+H*i, 300*NOW_SIZE,20*HEIGHT_SIZE )];
        PV2Lable.text=_nameArray0[i];
        PV2Lable.textAlignment=NSTextAlignmentLeft;
        PV2Lable.textColor=COLOR(102, 102, 102, 1);;
        PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        PV2Lable.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:PV2Lable];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 25*HEIGHT_SIZE+H*i, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        textField.layer.borderWidth=1;
        textField.layer.cornerRadius=5;
              textField.tag=2000+i;
        textField.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        textField.textColor = COLOR(102, 102, 102, 1);;
        textField.tintColor = COLOR(102, 102, 102, 1);;
        textField.textAlignment=NSTextAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_view1 addSubview:textField];
        
        UILabel *PV2Lable1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 70*HEIGHT_SIZE+H*i, 300*NOW_SIZE,20*HEIGHT_SIZE )];
        PV2Lable1.text=[NSString stringWithFormat:@"(读取值:%@)",_readValue];
        PV2Lable1.textAlignment=NSTextAlignmentCenter;
        PV2Lable1.textColor=COLOR(102, 102, 102, 1);
        PV2Lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        PV2Lable1.adjustsFontSizeToFitWidth=YES;
        [_view1 addSubview:PV2Lable1];
    }
    
    
 
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    if (_CellTypy==1) {
        if (_textField2) {
            [_textField2 resignFirstResponder];
        }
    }else  if (_CellTypy==2) {
        for (int i=0; i<2; i++) {
            UITextField *text=[_view1 viewWithTag:2000+i];
            [text resignFirstResponder];
        }
    }else{
        for (int i=0; i<_nameArray0.count; i++) {
            UITextField *text=[_view1 viewWithTag:2000+i];
            [text resignFirstResponder];
        }
        
    }
    
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
        if (_CellTypy==1) {
           [self initTwoUI];
        }else  if (_CellTypy==2) {
           [self initThreeUI];
        }else{
            [self initFourUI];
        }
        
        
        [_moreTextBtn setImage:IMAGE(@"MAXup.png") forState:UIControlStateNormal];
        
    }else{ // 收缩状态
        if (_view1) {
            [_view1 removeFromSuperview];
            _view1=nil;
        }
        if (_goBut) {
            [_goBut removeFromSuperview];
            _goBut=nil;
        }
        
        [_moreTextBtn setImage:IMAGE(@"MAXdown.png") forState:UIControlStateNormal];
    }
}



+ (CGFloat)defaultHeight{
    
    return 38*HEIGHT_SIZE;
}


+ (CGFloat)moreHeight:(int)CellTyoe{
    float H=0;
    
    if (CellTyoe==1) {
         H=240*HEIGHT_SIZE;
    }else  if (CellTyoe==2){
              H=340*HEIGHT_SIZE;
    }else if ((CellTyoe==29)||(CellTyoe==28)){
        H=670*HEIGHT_SIZE;
    }if (CellTyoe==27){
        H=870*HEIGHT_SIZE;
    }
    
    return H;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
