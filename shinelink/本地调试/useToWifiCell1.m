//
//  useToWifiCell1.m
//  ShinePhone
//
//  Created by sky on 2017/10/19.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "useToWifiCell1.h"
#import "usbModleOne.h"



@implementation useToWifiCell1

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return self;
}


-(void)initUI{
   //    float viewW1=34*HEIGHT_SIZE;
      float titleLabelH1=30*HEIGHT_SIZE;
    
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width,titleLabelH1)];
    _titleView.backgroundColor =COLOR(247, 247, 247, 1);
    _titleView.userInteractionEnabled = YES;
    UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMoreText)];
    [_titleView addGestureRecognizer:forget2];
    [self.contentView addSubview:_titleView];
    
  
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0, 200*NOW_SIZE, titleLabelH1)];
    _titleLabel.textColor = MainColor;
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_titleView addSubview:_titleLabel];
    
    float buttonViewW=50*NOW_SIZE;
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width-buttonViewW, 0, buttonViewW,titleLabelH1)];
    buttonView.backgroundColor =[UIColor clearColor];
    buttonView.userInteractionEnabled = YES;
    [_titleView addSubview:buttonView];
    
    float buttonW=12*NOW_SIZE;    float buttonH=8*HEIGHT_SIZE;
    if (!_moreTextBtn) {
        _moreTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreTextBtn.selected=NO;
        [_moreTextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _moreTextBtn.frame = CGRectMake((buttonViewW-buttonW)/2, (titleLabelH1-buttonH)/2, buttonW, buttonH);
        [buttonView addSubview:_moreTextBtn];
        [_moreTextBtn addTarget:self action:@selector(showMoreText) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    [self initUITwo];
    
    
    
}


-(void)initUITwo{
    float lableH1=20*HEIGHT_SIZE,lableH2=30*HEIGHT_SIZE,lableH3=50*HEIGHT_SIZE;
        float viewW1=34*HEIGHT_SIZE;
    float H;NSArray* nameArray;NSArray* vallNameArray;
    
    if (_cellTypy==0) {
         nameArray=@[@"电压(V)",@"电流(A)",@"电量(kWh)"];
        H=lableH1+lableH2*2+lableH3;
    }else{
           nameArray=@[@"电压(V)",@"电流(A)"];
        H=lableH1+lableH2*2;
    }
    
    if ((_cellTypy==0)||(_cellTypy==2)) {
        vallNameArray=@[@"PV1",@"PV2",@"PV3",@"PV4",@"PV5",@"PV6",@"PV7",@"PV8"];
    }else if(_cellTypy==1){
        vallNameArray=@[@"AC1",@"AC2",@"AC3",@"R",@"S",@"T"];
        
    }else if(_cellTypy==3){
        vallNameArray=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16"];
        
    }
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, viewW1, SCREEN_Width, H)];
    _scrollView.scrollEnabled=YES;
    [self.contentView addSubview:_scrollView];
    
    float w1=50*NOW_SIZE;
    float w2=40*NOW_SIZE;
        float W00=w1+10*NOW_SIZE+w2*vallNameArray.count;
    _scrollView.contentSize=CGSizeMake(W00, H);
    
    for (int i=0; i<nameArray.count; i++) {
        UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE,viewW1+lableH1+lableH2*i, w1, lableH2)];
        lable1.text=nameArray[i];
        lable1.textColor = MainColor;
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [self.contentView addSubview:lable1];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, viewW1+lableH1+lableH2*(i+1), W00,1*HEIGHT_SIZE)];
        lineView.backgroundColor =COLOR(222, 222, 222, 1);
        [self.contentView addSubview:lineView];
        
        if (i==2) {
            lable1.frame=CGRectMake(5*NOW_SIZE,viewW1+lableH1+lableH2*i, w1, lableH3);
            lineView.frame=CGRectMake(0, viewW1+lableH1+lableH2*2+lableH3, W00,1*HEIGHT_SIZE);
        }
    }
    
   
    for (int i=0; i<vallNameArray.count; i++) {
        UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(60*NOW_SIZE+w2*i,viewW1+lableH1, w2, lableH2)];
        lable1.textColor = COLOR(102, 102, 102, 1);
        lable1.text=@"0";
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [self.contentView addSubview:lable1];
        
        UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(60*NOW_SIZE+w2*i,viewW1+lableH1+lableH2, w2, lableH2)];
        lable2.textColor = COLOR(102, 102, 102, 1);
        lable2.text=@"0";
        lable2.textAlignment=NSTextAlignmentCenter;
        lable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [self.contentView addSubview:lable2];
        
        if(_cellTypy==0){
            UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(60*NOW_SIZE+w2*i,viewW1+lableH1+lableH2*2, w2, lableH3)];
            lable2.textColor = COLOR(102, 102, 102, 1);
            lable2.text=@"0";
            lable2.textAlignment=NSTextAlignmentCenter;
            lable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
            [self.contentView addSubview:lable2];
            
        }
    }
    
    
    
    
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
    
   
    
    if (!_scrollView) {
        [self initUI];
    }
    
    

    
    
    
    if (self.model.isShowMoreText){ // 展开状态
        // 计算文本高度
   
        
        [_moreTextBtn setImage:IMAGE(@"oss_more_up.png") forState:UIControlStateNormal];
        
    }else{ // 收缩状态
     
        
        [_moreTextBtn setImage:IMAGE(@"oss_more_down.png") forState:UIControlStateNormal];
    }
}



+ (CGFloat)defaultHeight{
    
    return 38*HEIGHT_SIZE;
}

// MARK: - 获取展开后的高度
+ (CGFloat)moreHeight:(int)CellTyoe{
    float H=120*HEIGHT_SIZE;
    if (CellTyoe==0) {
         H=180*HEIGHT_SIZE;
    }else{
             H=120*HEIGHT_SIZE;
    }
    

    return H;
    
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
