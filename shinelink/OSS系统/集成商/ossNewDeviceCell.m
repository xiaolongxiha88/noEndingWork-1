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
   float H1=40*HEIGHT_SIZE;

    float W_K_0=12*NOW_SIZE;             //平均空隙
    float W_all=0;
    
    for (int i=0; i<nameArray.count; i++) {
        
        NSString *nameString=nameArray[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
            float W_all_0=W_K_0*2+size.width;
        
        UILabel *lableR = [[UILabel alloc] initWithFrame:CGRectMake(W_all, 0,W_all_0, H1)];
        lableR.textColor = COLOR(102, 102, 102, 1);
        lableR.textAlignment=NSTextAlignmentCenter;
        lableR.text=nameString;
        lableR.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [self.contentView addSubview:lableR];
        
             W_all=W_all+W_all_0;
        
    }
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
