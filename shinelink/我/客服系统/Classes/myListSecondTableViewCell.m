//
//  myListSecondTableViewCell.m
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "myListSecondTableViewCell.h"
#import "GetServerViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0

@implementation myListSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleView= [[UIView alloc]init];
        _titleView.backgroundColor=mainColor;
        //[self addSubview:_titleView];
        
        _image=[[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 10*HEIGHT_SIZE, 40*NOW_SIZE,40*HEIGHT_SIZE )];
        
        [self.contentView addSubview:_image];
        
        
        _picLabel= [[UILabel alloc] initWithFrame:CGRectMake(220*NOW_SIZE, 10*HEIGHT_SIZE,100*NOW_SIZE, 15*HEIGHT_SIZE)];
        _picLabel.text=root_ME_chakan_tupian;
        _picLabel.textColor=MainColor;
        _picLabel.textAlignment = NSTextAlignmentCenter;
        _picLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
      //  _picLabel.userInteractionEnabled=YES;
       // UITapGestureRecognizer * labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GetPhoto)];
       // [_picLabel addGestureRecognizer:labelTap1];
        [self.contentView addSubview:_picLabel];
        
        
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(55*NOW_SIZE, 10*HEIGHT_SIZE,150*NOW_SIZE, 15*HEIGHT_SIZE) ];
        _nameLabel.font =[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        
        _nameLabel.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
        
        _timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(55*NOW_SIZE, 32*HEIGHT_SIZE,150*NOW_SIZE, 15*HEIGHT_SIZE) ];
        _timeLabel.font =[UIFont systemFontOfSize:10*HEIGHT_SIZE];
        _timeLabel.textColor =COLOR(133, 131, 131, 1);
        _timeLabel.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:_timeLabel];
        
        
        
        _contentLabel =[[UILabel alloc]init];
        _contentLabel.font =[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.textAlignment =NSTextAlignmentLeft;
        _contentLabel.numberOfLines=0;
        [self addSubview:_contentLabel];
        

    }
    return self;
}



@end
