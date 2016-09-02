//
//  AvCell.m
//  ShinePhone
//
//  Created by sky on 16/9/2.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "AvCell.h"

@implementation AvCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        float imageSize=80*HEIGHT_SIZE,size1=13*HEIGHT_SIZE,size2=5*NOW_SIZE,kongXi=20*NOW_SIZE;
        _typeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(size2, size1, imageSize*1.78, imageSize)];
        [self.contentView addSubview:_typeImageView];
        
        float alertImageSize=40*HEIGHT_SIZE;
        UIImageView *aletImage=[[UIImageView alloc] initWithFrame:CGRectMake(size2+(imageSize*1.78-alertImageSize)/2, size1+(imageSize-alertImageSize)/2, alertImageSize, alertImageSize)];
           aletImage.image=IMAGE(@"AvPlay2.png");
        [self.contentView addSubview:aletImage];
        
        
        self.CellName = [[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize*1.78+kongXi, size1, imageSize+60*NOW_SIZE,imageSize)];
        self.CellName.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
        self.CellName.textAlignment = NSTextAlignmentLeft;
        _CellName.numberOfLines=0;
        self.CellName.textColor = [UIColor blackColor];
        [self.contentView addSubview:_CellName];
        
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 108*HEIGHT_SIZE-2*HEIGHT_SIZE, SCREEN_Width, 2*HEIGHT_SIZE)];
        [view1 setBackgroundColor:colorGary];
        [self.contentView addSubview:view1];
        
    }
     return self;
}




@end
