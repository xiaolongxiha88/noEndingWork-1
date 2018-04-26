//
//  ossNewDeviceCell.m
//  ShinePhone
//
//  Created by sky on 2018/4/26.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossNewDeviceCell.h"

@implementation ossNewDeviceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        
 
    }
    
    return self;
}



- (void)setNameArray:(NSArray *)nameArray {
    float W1=70*NOW_SIZE;       float H1=30*HEIGHT_SIZE;
    
    for (int i=0; i<nameArray.count; i++) {
        UILabel *lableR = [[UILabel alloc] initWithFrame:CGRectMake(0+W1*i, 0,W1, H1)];
        lableR.textColor = COLOR(102, 102, 102, 1);
        lableR.textAlignment=NSTextAlignmentCenter;
        lableR.text=nameArray[i];
        lableR.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [self.contentView addSubview:lableR];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
