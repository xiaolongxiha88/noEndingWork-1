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
    
  
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0, 200*NOW_SIZE, titleLabelH1)];
    _titleLabel.textColor = MainColor;
    _titleLabel.text=_titleString;
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
  
    
    if (self.model.isShowMoreText){
        if (_scrollView) {
            [_scrollView removeFromSuperview];
            _scrollView=nil;
        }
           [self initUITwo];
    }
 
    
    
    
}



-(void)initUITwo{
    float lableH1=20*HEIGHT_SIZE,lableH2=30*HEIGHT_SIZE;
        float viewW1=34*HEIGHT_SIZE;
    float H;NSArray* nameArray;NSArray* vallNameArray;
    
    if (_cellTypy==2) {
         nameArray=@[@"电压",@"频率",@"电流",@"功率"];
        H=lableH1+lableH2*nameArray.count;
    }else{
           nameArray=@[@"电压",@"电流"];
        H=lableH1+lableH2*nameArray.count;
    }
    
    if ((_cellTypy==0)||(_cellTypy==3)) {
        vallNameArray=@[@"PV1",@"PV2",@"PV3",@"PV4",@"PV5",@"PV6",@"PV7",@"PV8"];
    }else if(_cellTypy==2){
        vallNameArray=@[@"R",@"S",@"T"];
        
    }else if(_cellTypy==1){
        vallNameArray=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16"];
        
    }
    

    
    float w1=50*NOW_SIZE;
    float w2=50*NOW_SIZE;
        float W00=w1+10*NOW_SIZE+w2*vallNameArray.count;
    if (W00<ScreenWidth) {
        W00=ScreenWidth;
        w2=(ScreenWidth-w1-10*NOW_SIZE)/3;
    }
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(w1+10*NOW_SIZE, viewW1, SCREEN_Width, H)];
    _scrollView.scrollEnabled=YES;
    [self.contentView addSubview:_scrollView];
    _scrollView.contentSize=CGSizeMake(W00, H);
    
    
    if (_nameView) {
        [_nameView removeFromSuperview];
        _nameView=nil;
    }
    _nameView = [[UIView alloc]initWithFrame:CGRectMake(0, viewW1, w1,H)];
    _nameView.backgroundColor =[UIColor clearColor];
    [self.contentView addSubview:_nameView];
    
    UIView *lineView0 = [[UIView alloc]initWithFrame:CGRectMake(0, lableH1, W00,LineWidth)];
    lineView0.backgroundColor =COLOR(222, 222, 222, 1);
    [_nameView addSubview:lineView0];
    
    for (int i=0; i<nameArray.count; i++) {
        UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE,lableH1+lableH2*i, w1, lableH2)];
        lable1.text=nameArray[i];
        lable1.textColor = MainColor;
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_nameView addSubview:lable1];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, lableH1+lableH2*(i+1), W00,LineWidth)];
        lineView.backgroundColor =COLOR(222, 222, 222, 1);
        [_nameView addSubview:lineView];
        
        if (i==2) {
            lable1.frame=CGRectMake(5*NOW_SIZE,lableH1+lableH2*i, w1, lableH2);
            lineView.frame=CGRectMake(0, lableH1+lableH2*2+lableH2, W00,LineWidth);
        }
    }
    
   
    for (int i=0; i<vallNameArray.count; i++) {
        UILabel *lable0 = [[UILabel alloc]initWithFrame:CGRectMake(w2*i,0, w2, lableH1)];
        lable0.textColor = COLOR(153, 153, 153, 1);
        lable0.text=vallNameArray[i];
          lable0.adjustsFontSizeToFitWidth=YES;
        lable0.textAlignment=NSTextAlignmentCenter;
        lable0.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:lable0];
        
        UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(w2*i,0+lableH1, w2, lableH2)];
        lable1.textColor = COLOR(102, 102, 102, 1);
        if (_lable1Array.count>0) {
            lable1.text=_lable1Array[i];
        }else{
            lable1.text=@"";
        }
        lable1.adjustsFontSizeToFitWidth=YES;
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:lable1];
        
        UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(w2*i,0+lableH1+lableH2, w2, lableH2)];
        lable2.textColor = COLOR(102, 102, 102, 1);
     
        if (_lable2Array.count>0) {
              lable2.text=_lable2Array[i];
        }else{
            lable2.text=@"";
        }
        lable2.textAlignment=NSTextAlignmentCenter;
        lable2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:lable2];
        
        if(_cellTypy==2){
            UILabel *lable3= [[UILabel alloc]initWithFrame:CGRectMake(w2*i,0+lableH1+lableH2*2, w2, lableH2)];
            lable3.textColor = COLOR(102, 102, 102, 1);
          //  lable3.text=_lable3Array[i];
            if (_lable3Array.count>0) {
                lable3.text=_lable3Array[i];
            }else{
                lable3.text=@"";
            }
              lable3.adjustsFontSizeToFitWidth=YES;
            lable3.textAlignment=NSTextAlignmentCenter;
            lable3.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [_scrollView addSubview:lable3];
            

            UILabel *lable4= [[UILabel alloc]initWithFrame:CGRectMake(w2*i,0+lableH1+lableH2*3, w2, lableH2)];
            lable4.textColor = COLOR(102, 102, 102, 1);
            //  lable3.text=_lable3Array[i];
            if (_lable4Array.count>0) {
                lable4.text=_lable4Array[i];
            }else{
                lable4.text=@"";
            }
            lable4.adjustsFontSizeToFitWidth=YES;
            lable4.textAlignment=NSTextAlignmentCenter;
            lable4.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [_scrollView addSubview:lable4];
            
            
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
    
  
        [self initUI];
    
    

    if (self.model.isShowMoreText){ // 展开状态
  
        [_moreTextBtn setImage:IMAGE(@"MAXup.png") forState:UIControlStateNormal];
        
    }else{ // 收缩状态
     
        [_scrollView removeFromSuperview];
        [_nameView removeFromSuperview];
        [_moreTextBtn setImage:IMAGE(@"MAXdown.png") forState:UIControlStateNormal];
    }
}



+ (CGFloat)defaultHeight{
    
    return 38*HEIGHT_SIZE;
}

// MARK: - 获取展开后的高度
+ (CGFloat)moreHeight:(int)CellTyoe{
    float H=120*HEIGHT_SIZE;
    if (CellTyoe==2) {
         H=190*HEIGHT_SIZE;
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
