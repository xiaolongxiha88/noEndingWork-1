//
//  extensionTableViewCell.m
//  ShinePhone
//
//  Created by sky on 16/10/28.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "extensionTableViewCell.h"

@implementation extensionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        
        _LableView=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 15*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE)];
        [_LableView setBackgroundColor:COLOR(32, 213, 147, 1)];
        _LableView.layer.cornerRadius= _LableView.bounds.size.width/2;
        
        _LableView.textAlignment=NSTextAlignmentCenter;
        _LableView.textColor=[UIColor whiteColor];
        _LableView.layer.masksToBounds = YES;
        [self.contentView addSubview:_LableView];
        
        
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width-30*NOW_SIZE, 18*HEIGHT_SIZE, 18*NOW_SIZE, 14*HEIGHT_SIZE)];
        arrowView.image = IMAGE(@"frag4.png");
        [self.contentView addSubview:arrowView];
        
        
        self.CellName = [[UILabel alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 10*HEIGHT_SIZE, SCREEN_Width-50*NOW_SIZE, 30*HEIGHT_SIZE)];
        self.CellName.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
        self.CellName.textAlignment = NSTextAlignmentLeft;
        
        
        self.CellName.textColor = [UIColor blackColor];
        [self.contentView addSubview:_CellName];
        
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 50*HEIGHT_SIZE-2*HEIGHT_SIZE, SCREEN_Width, 1*HEIGHT_SIZE)];
        [view1 setBackgroundColor:colorGary];
        [self.contentView addSubview:view1];
        
    }
    return self;
}

@end
