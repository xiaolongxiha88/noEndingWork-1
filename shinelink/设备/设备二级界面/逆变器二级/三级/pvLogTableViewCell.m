//
//  pvLogTableViewCell.m
//  shinelink
//
//  Created by sky on 16/4/1.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "pvLogTableViewCell.h"

@implementation pvLogTableViewCell


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
        
        _scrollView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width,65*HEIGHT_SIZE)];
        //UIImage *bgImage = IMAGE(@"bg4.png");
        
       _scrollView.backgroundColor = COLOR(92, 205, 246, 1);
           [self addSubview:_scrollView];
        
        float wSize=60*NOW_SIZE,Size1=15*NOW_SIZE,Size2=40*HEIGHT_SIZE;
       _SN=[[UILabel alloc]initWithFrame:CGRectMake(Size1, 15*HEIGHT_SIZE, 60*NOW_SIZE,20*HEIGHT_SIZE )];
        _SN.text=root_NBQ_xunliehao;
        _SN.textAlignment=NSTextAlignmentLeft;
        _SN.textColor=[UIColor whiteColor];
        _SN.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:_SN];
        _SNText=[[UILabel alloc]initWithFrame:CGRectMake(Size1+wSize, 15*HEIGHT_SIZE, 85*NOW_SIZE,20*HEIGHT_SIZE )];
        _SNText.textAlignment=NSTextAlignmentLeft;
        _SNText.textColor=[UIColor whiteColor];
        _SNText.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:_SNText];
        
        _type=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 15*HEIGHT_SIZE, 60*NOW_SIZE,20*HEIGHT_SIZE )];
        _type.text=root_NBQ_leixing;
        _type.textAlignment=NSTextAlignmentLeft;
        _type.textColor=[UIColor whiteColor];
        _type.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:_type];
        _typtText=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE+wSize, 15*HEIGHT_SIZE, 100*NOW_SIZE,20*HEIGHT_SIZE )];
        //_typtText.text=@"序列号";
        _typtText.textAlignment=NSTextAlignmentLeft;
        _typtText.textColor=[UIColor whiteColor];
        _typtText.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:_typtText];
        
        _event=[[UILabel alloc]initWithFrame:CGRectMake(Size1, Size2, 70*NOW_SIZE,20*HEIGHT_SIZE )];
        _event.text=root_NBQ_shijianhao;
        _event.textAlignment=NSTextAlignmentLeft;
        _event.textColor=[UIColor whiteColor];
        _event.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:_event];
        _eventText=[[UILabel alloc]initWithFrame:CGRectMake(Size1+70*NOW_SIZE, Size2, 85*NOW_SIZE,20*HEIGHT_SIZE )];
       // _eventText.text=@"序列号";
        _eventText.textAlignment=NSTextAlignmentLeft;
        _eventText.textColor=[UIColor whiteColor];
        _eventText.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:_eventText];
        
        _Log=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE, Size2, 60*NOW_SIZE,20*HEIGHT_SIZE )];
        _Log.text=root_NBQ_biaoshi;
        _Log.textAlignment=NSTextAlignmentLeft;
        _Log.textColor=[UIColor whiteColor];
        _Log.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:_Log];
        _LogText=[[UILabel alloc]initWithFrame:CGRectMake(220*NOW_SIZE, Size2, 100*NOW_SIZE,20*HEIGHT_SIZE )];
       // _LogText.text=@"序列号";
        _LogText.textAlignment=NSTextAlignmentLeft;
        _LogText.textColor=[UIColor whiteColor];
        _LogText.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:_LogText];
        
        _contentLabel =[[UILabel alloc]init];
        _contentLabel.font =[UIFont systemFontOfSize:16*HEIGHT_SIZE];
        _contentLabel.textColor = [UIColor redColor];
        _contentLabel.textAlignment =NSTextAlignmentLeft;
        _contentLabel.numberOfLines=0;
        [self addSubview:_contentLabel];
        
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.font =[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}

@end
