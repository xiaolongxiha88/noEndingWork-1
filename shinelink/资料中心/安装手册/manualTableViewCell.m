//
//  manualTableViewCell.m
//  ShinePhone
//
//  Created by sky on 16/9/21.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "manualTableViewCell.h"

@implementation manualTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        _contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 0, SCREEN_Width, 110*HEIGHT_SIZE)];
        _contentImage.image = IMAGE(@"manual_bg.jpg");
        [self.contentView addSubview:_contentImage];
        
        
        
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 50*HEIGHT_SIZE, SCREEN_Width, 40*HEIGHT_SIZE)];
        topView.backgroundColor=COLOR(17, 183, 243, 0.8);
         [self.contentView addSubview:topView];
        
        
        
        _LableView=[[UILabel alloc]initWithFrame:CGRectMake(25*NOW_SIZE, 10*HEIGHT_SIZE, 19*HEIGHT_SIZE, 19*HEIGHT_SIZE)];
        [_LableView setBackgroundColor:COLOR(32, 213, 147, 1)];
        _LableView.layer.cornerRadius= _LableView.bounds.size.width/2;
        
        _LableView.textAlignment=NSTextAlignmentCenter;
        _LableView.textColor=[UIColor whiteColor];
        _LableView.layer.masksToBounds = YES;
        [topView addSubview:_LableView];
        
        
      
        
        
        self.CellName = [[UILabel alloc] initWithFrame:CGRectMake(50*NOW_SIZE, 5*HEIGHT_SIZE, SCREEN_Width-50*NOW_SIZE, 30*HEIGHT_SIZE)];
        self.CellName.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
        self.CellName.textAlignment = NSTextAlignmentLeft;
        _CellName.text=@"都是一些常见问题啦";
        
        self.CellName.textColor = [UIColor blackColor];
        [topView addSubview:_CellName];
        
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 110*HEIGHT_SIZE-2*HEIGHT_SIZE, SCREEN_Width, 1*HEIGHT_SIZE)];
        [view1 setBackgroundColor:COLOR(164, 171, 174, 1)];
        [self.contentView addSubview:view1];
        
    }
    return self;
}
@end
