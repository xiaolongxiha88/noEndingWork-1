//
//  payResultCell.m
//  ShinePhone
//
//  Created by sky on 2017/11/18.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "payResultCell.h"

@implementation payResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float H=20*HEIGHT_SIZE;
        
        float W=20*NOW_SIZE;
       
            _lable1 = [[UILabel alloc] initWithFrame:CGRectMake(W, 0*HEIGHT_SIZE+H*0, ScreenWidth-20*NOW_SIZE, H)];
            _lable1.textColor = COLOR(102, 102, 102, 1);
            _lable1.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
            _lable1.textAlignment=NSTextAlignmentLeft;
            [self.contentView addSubview:_lable1];
        
        _lable2 = [[UILabel alloc] initWithFrame:CGRectMake(W, 0*HEIGHT_SIZE+H*1, ScreenWidth-20*NOW_SIZE, H)];
        _lable2.textColor = COLOR(102, 102, 102, 1);
        _lable2.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        _lable2.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:_lable2];
        
        _lable3 = [[UILabel alloc] initWithFrame:CGRectMake(W, 0*HEIGHT_SIZE+H*2, ScreenWidth-20*NOW_SIZE, H)];
        _lable3.textColor = COLOR(102, 102, 102, 1);
        _lable3.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        _lable3.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:_lable3];
        
        _lable4= [[UILabel alloc] initWithFrame:CGRectMake(W, 0*HEIGHT_SIZE+H*3, ScreenWidth-20*NOW_SIZE, H)];
        _lable4.textColor = COLOR(102, 102, 102, 1);
        _lable4.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        _lable4.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:_lable4];
 
        
        UIView *V0 = [[UIView alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 5*HEIGHT_SIZE+H*4, ScreenWidth, 5*HEIGHT_SIZE)];
        V0.backgroundColor=colorGary;
          [self.contentView addSubview:V0];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

 
}

@end
