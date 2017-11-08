//
//  singleSelectTableViewCell.m
//  singleSelectedDemo
//
//  Created by qhx on 2017/7/27.
//  Copyright © 2017年 quhengxing. All rights reserved.
//

#import "singleSelectTableViewCell.h"

@implementation singleSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         float W=20*HEIGHT_SIZE;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*NOW_SIZE, 5*HEIGHT_SIZE, ScreenWidth-W*2, 20*HEIGHT_SIZE)];
        self.titleLabel.textColor = COLOR(102, 102, 102, 1);
        self.titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [self.contentView addSubview:self.titleLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*NOW_SIZE, 25*HEIGHT_SIZE, ScreenWidth-W*2, 20*HEIGHT_SIZE)];
        self.dateLabel.textColor = COLOR(102, 102, 102, 1);
        self.dateLabel.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [self.contentView addSubview:self.dateLabel];
        
        float W1=(50*HEIGHT_SIZE-W)/2;
        self.selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,  50*HEIGHT_SIZE)];
        self.selectBtn.imageEdgeInsets = UIEdgeInsetsMake(W1, ScreenWidth-W-W1, W1, W1);//设置边距
        [self.selectBtn addTarget:self action:@selector(selectPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectBtn];
        
    }
    return self;
}

- (void)selectPressed:(UIButton *)sender{
    self.isSelect = !self.isSelect;
    if (self.qhxSelectBlock) {
        self.qhxSelectBlock(self.isSelect,sender.tag);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
