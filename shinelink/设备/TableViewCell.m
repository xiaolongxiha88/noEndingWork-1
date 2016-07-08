//
//  TableViewCell.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "TableViewCell.h"
#import "EGOCache.h"

#define labelWidth  38*NOW_SIZE
#define labelWidth1  38*NOW_SIZE
#define labelHeight  20*HEIGHT_SIZE
#define fontSize  11*HEIGHT_SIZE
#define labelColor  grayColor


@interface TableViewCell ()



@end

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     self.backgroundColor = [UIColor clearColor];

    double imageSize=55*HEIGHT_SIZE;
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, imageSize, imageSize)];
    self.coverImageView.layer.masksToBounds=YES;
    self.coverImageView.layer.cornerRadius=imageSize/2.0;
    [self.contentView addSubview:_coverImageView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+10*NOW_SIZE, 0, 120*NOW_SIZE, 50*HEIGHT_SIZE)];
    self.titleLabel.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:_titleLabel];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width-30*NOW_SIZE, 25*HEIGHT_SIZE, 20*NOW_SIZE, 15*HEIGHT_SIZE)];
    arrowView.image = IMAGE(@"frag4.png");
    [self.contentView addSubview:arrowView];
    
//    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width-60*NOW_SIZE, 0*NOW_SIZE, 30*NOW_SIZE,50*NOW_SIZE)];
//    self.detail.text = root_xianQing;
//    self.detail.font=[UIFont systemFontOfSize:14*NOW_SIZE];
//    self.detail.textAlignment = NSTextAlignmentLeft;
//    self.detail.textColor = [UIColor labelColor];
//    [self.contentView addSubview:_detail];
    
    
    /*self.state = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+80*NOW_SIZE, 18*NOW_SIZE, labelWidth1, labelHeight)];
    self.state.text = @"状态：";
    self.state.font=[UIFont systemFontOfSize:fontSize];
    self.state.textAlignment = NSTextAlignmentLeft;
    self.state.textColor = [UIColor labelColor];
    [self.contentView addSubview:_state];*/
    
//   _stateView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width/5+80*NOW_SIZE+labelWidth1, 18*NOW_SIZE, labelWidth1/2, labelWidth1/2)];
//    _stateView.layer.masksToBounds=YES;
//    _stateView.layer.cornerRadius=labelWidth1/2/2.0;
//    [self.contentView addSubview:_stateView];
    
    self.stateValue = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+140*NOW_SIZE, 0*NOW_SIZE, 105*NOW_SIZE, 50*HEIGHT_SIZE)];
    self.stateValue.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    self.stateValue.textAlignment = NSTextAlignmentLeft;
   self.stateValue.textColor = [UIColor labelColor];
    [self.contentView addSubview:_stateValue];
    
    self.power = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+10*NOW_SIZE, 40*HEIGHT_SIZE, labelWidth1, labelHeight)];
    self.power.text = root_gongLv;
    self.power.font=[UIFont systemFontOfSize:fontSize];
    self.power.textAlignment = NSTextAlignmentRight;
    self.power.textColor = [UIColor labelColor];
    [self.contentView addSubview:_power];
    
    self.powerValue = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+10*NOW_SIZE+labelWidth, 40*HEIGHT_SIZE, labelWidth+20*NOW_SIZE, labelHeight)];
    self.powerValue.font=[UIFont systemFontOfSize:fontSize];
    self.powerValue.textAlignment = NSTextAlignmentLeft;
    self.powerValue.textColor = [UIColor labelColor];
    [self.contentView addSubview:_powerValue];
    
    self.electric = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+60*NOW_SIZE+labelWidth1, 40*HEIGHT_SIZE, labelWidth1+70*NOW_SIZE, labelHeight)];
    self.electric.font=[UIFont systemFontOfSize:fontSize];
    self.electric.textAlignment = NSTextAlignmentRight;
    self.electric.textColor = [UIColor labelColor];
    [self.contentView addSubview:_electric];
    
    self.electricValue = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+130*NOW_SIZE+labelWidth1+labelWidth, 40*HEIGHT_SIZE, labelWidth+30*NOW_SIZE, labelHeight)];
    self.electricValue.font=[UIFont systemFontOfSize:fontSize];
    self.electricValue.textAlignment = NSTextAlignmentLeft;
    self.electricValue.textColor = [UIColor labelColor];
    [self.contentView addSubview:_electricValue];
    
 
    
    
    
    
}
    
      return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
