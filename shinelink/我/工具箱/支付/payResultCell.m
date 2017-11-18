//
//  payResultCell.m
//  ShinePhone
//
//  Created by sky on 2017/11/18.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "payResultCell.h"

@implementation payResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float H=20*HEIGHT_SIZE;
        
        NSArray *nameArray=@[@"支付结果",@"支付金额",@"支付时间",@"采集器序列号"];
        for (int i=0; i<nameArray.count; i++) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE+H*i, ScreenWidth-20*NOW_SIZE, H)];
            lable.textColor = COLOR(102, 102, 102, 1);
            lable.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
            lable.textAlignment=NSTextAlignmentLeft;
            lable.text=nameArray[i];
            [self.contentView addSubview:lable];
        }
        
        UIView *V0 = [[UIView alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 5*HEIGHT_SIZE+H*nameArray.count, ScreenWidth, 5*HEIGHT_SIZE)];
        V0.backgroundColor=colorGary;
          [self.contentView addSubview:V0];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

 
}

@end
