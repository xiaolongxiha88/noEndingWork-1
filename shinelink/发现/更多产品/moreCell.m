//
//  moreCell.m
//  shinelink
//
//  Created by sky on 16/4/8.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "moreCell.h"

@implementation moreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        
        float imageSize=80*HEIGHT_SIZE,size1=10*HEIGHT_SIZE,size2=5*NOW_SIZE,kongXi=20*NOW_SIZE;
        
        _typeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(size2, size1, imageSize, imageSize)];
        
        [self.contentView addSubview:_typeImageView];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+kongXi, size1/2, imageSize+60*NOW_SIZE, 30*HEIGHT_SIZE)];
        self.name.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
     
        self.name.textAlignment = NSTextAlignmentLeft;
        self.name.textColor = [UIColor blackColor];
        [self.contentView addSubview:_name];
        
        _image=[[UIImageView alloc]init];
        [self.contentView addSubview:_image];
        
        
        self.imageLog = [[UILabel alloc] init];
        self.imageLog.font=[UIFont systemFontOfSize:12*HEIGHT_SIZE];
        self.imageLog.textAlignment = NSTextAlignmentCenter;
        self.imageLog.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_imageLog];

        
        
        
        self.connent = [[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+kongXi, size1+20*HEIGHT_SIZE, 200*NOW_SIZE, 60*HEIGHT_SIZE)];
        self.connent.font=[UIFont systemFontOfSize:12*HEIGHT_SIZE];
       
        //self.connent.numberOfLines=0;
        self.connent.textAlignment = NSTextAlignmentLeft;
        self.connent.textColor = [UIColor grayColor];
       // self.connent.userInteractionEnabled=YES;
        //self.connent.editable=NO;
        self.connent.numberOfLines=0;
        [self.contentView addSubview:_connent];
        

        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 10*HEIGHT_SIZE+22*HEIGHT_SIZE*4, SCREEN_Width, 10*HEIGHT_SIZE)];
        [view1 setBackgroundColor:colorGary];
        [self.contentView addSubview:view1];
    }
    
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
