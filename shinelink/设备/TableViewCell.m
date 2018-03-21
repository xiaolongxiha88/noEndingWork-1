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

//- (void)awakeFromNib {
//    // Initialization code
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     self.backgroundColor = [UIColor clearColor];

    double imageSize=55*HEIGHT_SIZE;
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, imageSize, imageSize)];
    self.coverImageView.layer.masksToBounds=YES;
    self.coverImageView.layer.cornerRadius=imageSize/2.0;
    [self.contentView addSubview:_coverImageView];
    
    float titleLabelW=140*NOW_SIZE;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+10*NOW_SIZE, 0, titleLabelW, 50*HEIGHT_SIZE)];
    self.titleLabel.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
    self.titleLabel.adjustsFontSizeToFitWidth=YES;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:_titleLabel];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width-30*NOW_SIZE, 25*HEIGHT_SIZE, 20*NOW_SIZE, 15*HEIGHT_SIZE)];
    arrowView.image = IMAGE(@"frag4.png");
    [self.contentView addSubview:arrowView];

    float stateValueW=SCREEN_Width-30*NOW_SIZE-_coverImageView.bounds.size.width-170*NOW_SIZE;
    self.stateValue = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+150*NOW_SIZE-7*NOW_SIZE, 0*NOW_SIZE, stateValueW, 50*HEIGHT_SIZE)];
    self.stateValue.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    _stateValue.adjustsFontSizeToFitWidth=YES;
    self.stateValue.textAlignment = NSTextAlignmentLeft;
   self.stateValue.textColor = [UIColor labelColor];
    [self.contentView addSubview:_stateValue];
    
    
    self.power = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+10*NOW_SIZE, 40*HEIGHT_SIZE, labelWidth1, labelHeight)];
    self.power.font=[UIFont systemFontOfSize:fontSize];
    _power.adjustsFontSizeToFitWidth=YES;
    self.power.textAlignment = NSTextAlignmentLeft;
    self.power.textColor = [UIColor labelColor];
 
            [self.contentView addSubview:_power];
  

    
    self.powerValue = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+10*NOW_SIZE+labelWidth, 40*HEIGHT_SIZE, labelWidth+20*NOW_SIZE, labelHeight)];
    self.powerValue.font=[UIFont systemFontOfSize:fontSize];
    self.powerValue.textAlignment = NSTextAlignmentLeft;
        _powerValue.adjustsFontSizeToFitWidth=YES;
    self.powerValue.textColor = [UIColor labelColor];
  
        [self.contentView addSubview:_powerValue];


    
    self.electric = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+60*NOW_SIZE+labelWidth1, 40*HEIGHT_SIZE, labelWidth1+70*NOW_SIZE, labelHeight)];
    self.electric.font=[UIFont systemFontOfSize:fontSize];
    _electric.adjustsFontSizeToFitWidth=YES;
    self.electric.textAlignment = NSTextAlignmentRight;
    self.electric.textColor = [UIColor labelColor];
    [self.contentView addSubview:_electric];

    
    
    
    self.electricValue = [[UILabel alloc] initWithFrame:CGRectMake(_coverImageView.bounds.size.width+130*NOW_SIZE+labelWidth1+labelWidth, 40*HEIGHT_SIZE, labelWidth+30*NOW_SIZE, labelHeight)];
    self.electricValue.font=[UIFont systemFontOfSize:fontSize];
    self.electricValue.textAlignment = NSTextAlignmentLeft;
       _electricValue.adjustsFontSizeToFitWidth=YES;
    self.electricValue.textColor = [UIColor labelColor];
    [self.contentView addSubview:_electricValue];

 
 
    
 
    UIView *V0=[[UIView alloc] initWithFrame:CGRectMake(0, 65*HEIGHT_SIZE-LineWidth, SCREEN_Width, LineWidth)];
    V0.backgroundColor=colorGary;
    [self.contentView addSubview:V0];
    
    
    
}
    
      return self;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
