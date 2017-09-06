//
//  meTableViewCell.m
//  shinelink
//
//  Created by sky on 16/2/17.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "meTableViewCell.h"

@implementation meTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.imageLog = [[UIImageView alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 45*HEIGHT_SIZE, 45*HEIGHT_SIZE)];
        
        [self.contentView addSubview:_imageLog];
        
        self.tableName = [[UILabel alloc] initWithFrame:CGRectMake(45*HEIGHT_SIZE+10*NOW_SIZE, 5*HEIGHT_SIZE, 240*NOW_SIZE, 45*HEIGHT_SIZE)];
        
        self.tableName.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
        _tableName.adjustsFontSizeToFitWidth=YES;
        self.tableName.textAlignment = NSTextAlignmentLeft;
        self.tableName.textColor = [UIColor blackColor];
        [self.contentView addSubview:_tableName];
        
        self.imageDetail = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width-30*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*NOW_SIZE, 15*HEIGHT_SIZE)];
        [self.imageDetail setImage:[UIImage imageNamed:@"frag4.png"]];
        [self.contentView addSubview:_imageDetail];
        
        UIView *V0=[[UIView alloc] initWithFrame:CGRectMake(0, 55*HEIGHT_SIZE-LineWidth, SCREEN_Width, LineWidth)];
        V0.backgroundColor=colorGary;
        [self.contentView addSubview:V0];
    }
    
    return self;
}



@end
