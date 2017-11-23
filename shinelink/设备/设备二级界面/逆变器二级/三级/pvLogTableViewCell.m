//
//  pvLogTableViewCell.m
//  shinelink
//
//  Created by sky on 16/4/1.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "pvLogTableViewCell.h"

@implementation pvLogTableViewCell


//- (void)awakeFromNib {
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _scrollView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width,40*HEIGHT_SIZE)];
        //UIImage *bgImage = IMAGE(@"bg4.png");
        
       _scrollView.backgroundColor = MainColor;
           [self addSubview:_scrollView];
        
        float Size1=10*NOW_SIZE;
        float WText=150*NOW_SIZE,H=20*HEIGHT_SIZE;
//       _SN=[[UILabel alloc]initWithFrame:CGRectMake(Size1, 0*HEIGHT_SIZE, wSize,H )];
//        _SN.text=root_NBQ_xunliehao;
//        _SN.textAlignment=NSTextAlignmentRight;
//        _SN.textColor=[UIColor whiteColor];
//        _SN.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
//        _SN.adjustsFontSizeToFitWidth=YES;
//        [_scrollView addSubview:_SN];
        
        _SNText=[[UILabel alloc]initWithFrame:CGRectMake(Size1, 0*HEIGHT_SIZE, WText,H )];
        _SNText.textAlignment=NSTextAlignmentLeft;
        _SNText.textColor=[UIColor whiteColor];
         _SNText.adjustsFontSizeToFitWidth=YES;
        _SNText.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:_SNText];
        
//        _type=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 0*HEIGHT_SIZE, wSize,H)];
//        _type.text=root_NBQ_leixing;
//        _type.textAlignment=NSTextAlignmentRight;
//        _type.textColor=[UIColor whiteColor];
//        _type.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
//        _type.adjustsFontSizeToFitWidth=YES;
//        [_scrollView addSubview:_type];
        
        _typtText=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE+Size1, 0*HEIGHT_SIZE, WText,H)];
        //_typtText.text=@"序列号";
        _typtText.textAlignment=NSTextAlignmentLeft;
        _typtText.textColor=[UIColor whiteColor];
          _typtText.adjustsFontSizeToFitWidth=YES;
        _typtText.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:_typtText];
        
//        _event=[[UILabel alloc]initWithFrame:CGRectMake(Size1, H, wSize,H)];
//        _event.text=root_NBQ_shijianhao;
//        _event.textAlignment=NSTextAlignmentRight;
//        _event.textColor=[UIColor whiteColor];
//          _event.adjustsFontSizeToFitWidth=YES;
//        _event.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
//         _event.adjustsFontSizeToFitWidth=YES;
//        [_scrollView addSubview:_event];
        
        _eventText=[[UILabel alloc]initWithFrame:CGRectMake(Size1, H, WText,H )];
        _eventText.textAlignment=NSTextAlignmentLeft;
        _eventText.textColor=[UIColor whiteColor];
            _eventText.adjustsFontSizeToFitWidth=YES;
        _eventText.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:_eventText];
        
//        _Log=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE, H, wSize,H)];
//        _Log.text=root_NBQ_biaoshi;
//        _Log.textAlignment=NSTextAlignmentRight;
//        _Log.textColor=[UIColor whiteColor];
//        _Log.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
//        _Log.adjustsFontSizeToFitWidth=YES;
//        [_scrollView addSubview:_Log];
        
        _LogText=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE+Size1, H, WText,H)];
        _LogText.textAlignment=NSTextAlignmentLeft;
        _LogText.textColor=[UIColor whiteColor];
         _LogText.adjustsFontSizeToFitWidth=YES;
        _LogText.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:_LogText];
        
        _contentLabel =[[UILabel alloc]init];
        _contentLabel.font =[UIFont systemFontOfSize:12*HEIGHT_SIZE];
        _contentLabel.textColor = [UIColor redColor];
        _contentLabel.textAlignment =NSTextAlignmentLeft;
        _contentLabel.numberOfLines=0;
        [self addSubview:_contentLabel];
        
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.font =[UIFont systemFontOfSize:12*HEIGHT_SIZE];
        _timeLabel.textColor = [UIColor grayColor];
           _timeLabel.adjustsFontSizeToFitWidth=YES;
        _timeLabel.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}

@end
