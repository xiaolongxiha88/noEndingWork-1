//
//  orderCellThree.m
//  ShinePhone
//
//  Created by sky on 2017/6/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "orderCellThree.h"

@implementation orderCellThree

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        float viewW1=34*HEIGHT_SIZE;
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width,viewW1)];
        _titleView.backgroundColor =COLOR(242, 242, 242, 1);
        _titleView.userInteractionEnabled = YES;
        UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMoreText)];
        [_titleView addGestureRecognizer:forget2];
        [self.contentView addSubview:_titleView];
        
        float ImageW1=26*HEIGHT_SIZE;  float firstW1=5*HEIGHT_SIZE;
        _titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(firstW1, (viewW1-ImageW1)/2, ImageW1, ImageW1)];
        _titleImage.image=IMAGE(@"yuan_2.png");
        [_titleView addSubview:_titleImage];
        
        float titleLabelH1=30*HEIGHT_SIZE;
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstW1*2+ImageW1, (viewW1-titleLabelH1)/2, 150*NOW_SIZE, titleLabelH1)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [_titleView addSubview:_titleLabel];
        
        float buttonViewW=50*NOW_SIZE;
        UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width-buttonViewW, 0, buttonViewW,viewW1)];
        buttonView.backgroundColor =[UIColor clearColor];
        buttonView.userInteractionEnabled = YES;
        [_titleView addSubview:buttonView];
        
        float buttonW=12*NOW_SIZE;    float buttonH=8*HEIGHT_SIZE;
        _moreTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreTextBtn.selected=NO;
        [_moreTextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _moreTextBtn.frame = CGRectMake((buttonViewW-buttonW)/2, (viewW1-buttonH)/2, buttonW, buttonH);
        [buttonView addSubview:_moreTextBtn];
        [_moreTextBtn addTarget:self action:@selector(showMoreText) forControlEvents:UIControlEventTouchUpInside];
        
        float View2H=4*NOW_SIZE;
        UIView *View2 = [[UIView alloc]initWithFrame:CGRectMake(0, viewW1, SCREEN_Width,View2H)];
        View2.backgroundColor =[UIColor whiteColor];
        [self.contentView addSubview:View2];
        
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, viewW1+View2H*2,SCREEN_Width - 30 , 0)];
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        
        _cellFirstH=viewW1+View2H;
        _isShowMoreText=NO;
        
    }
    return self;
}

- (void)showMoreText{
    
    _moreTextBtn.selected = !_moreTextBtn.selected;
    NSString *boolValue;
    if (_moreTextBtn.selected) {
        boolValue=@"1";
    }else{
        boolValue=@"0";
    }
    NSArray *dataArray=[NSArray arrayWithObjects:boolValue,_contentString, nil];
    if (self.showMoreBlock){
        self.showMoreData(dataArray);
        self.showMoreBlock(self);
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.text = _titleString;
    
    _contentLabel.text =_contentString;
    if (_moreTextBtn.selected){ // 展开状态
        // 计算文本高度
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
        
        NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
        
        // self.model.content：内容字符串
        CGSize size = [_contentString boundingRectWithSize:CGSizeMake(SCREEN_Width - 30, 0) options:option attributes:attribute context:nil].size;
        
        [_contentLabel setFrame:CGRectMake(15, 30, SCREEN_Width - 30, size.height)];
        
        [_moreTextBtn setImage:IMAGE(@"oss_more_up.png") forState:UIControlStateNormal];
    }else{ // 收缩状态
        
        [_contentLabel setFrame:CGRectMake(15, 30, SCREEN_Width - 30, 0)];
        
        [_moreTextBtn setImage:IMAGE(@"oss_more_down.png") forState:UIControlStateNormal];
    }
}

// MARK: - 获取默认高度
+ (CGFloat)defaultHeight{
    
    return 38*HEIGHT_SIZE;
}

// MARK: - 获取展开后的高度
+ (CGFloat)moreHeight:(NSString *)content{
    
    // 展开后得高度 = 计算出文本内容的高度 + 固定控件的高度
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(SCREEN_Width - 30, 0) options:option attributes:attribute context:nil].size;
    
    return size.height + 50*HEIGHT_SIZE;
    
}





@end
