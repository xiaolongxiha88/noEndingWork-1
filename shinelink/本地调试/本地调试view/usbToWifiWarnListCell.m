//
//  usbToWifiWarnListCell.m
//  ShinePhone
//
//  Created by sky on 2017/12/5.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiWarnListCell.h"

@implementation usbToWifiWarnListCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        float lableH1=30*HEIGHT_SIZE; float lableH2=40*HEIGHT_SIZE;
        _codeLable = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0,200*NOW_SIZE,lableH1)];
        _codeLable.textColor =COLOR(102, 102, 102, 1);
        _codeLable.textAlignment=NSTextAlignmentLeft;
        _codeLable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [self.contentView addSubview:_codeLable];
        
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(215*NOW_SIZE, 0,100*NOW_SIZE,lableH1)];
        _timeLable.textColor =COLOR(102, 102, 102, 1);
        _timeLable.textAlignment=NSTextAlignmentRight;
        _timeLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        [self.contentView addSubview:_timeLable];
        
        UIView *V0=[[UIView alloc] initWithFrame:CGRectMake(0,lableH1-LineWidth, SCREEN_Width, LineWidth)];
        V0.backgroundColor=colorGary;
        [self.contentView addSubview:V0];
        
        _valueLable = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, lableH1,ScreenWidth-20*NOW_SIZE,lableH2)];
        _valueLable.textColor =COLOR(102, 102, 102, 1);
        _valueLable.textAlignment=NSTextAlignmentLeft;
        _valueLable.numberOfLines=0;
        _valueLable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        [self.contentView addSubview:_valueLable];
        
        UIView *V1=[[UIView alloc] initWithFrame:CGRectMake(0,lableH1+lableH2, SCREEN_Width, 10*HEIGHT_SIZE)];
        V1.backgroundColor=COLOR(242, 242, 242, 1);
        [self.contentView addSubview:V1];
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
