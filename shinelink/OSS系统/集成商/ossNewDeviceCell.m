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
   float H1=30*HEIGHT_SIZE;

    float W_K_0=12*NOW_SIZE;             //平均空隙
    float W_all=10*NOW_SIZE;
    
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,H1-1*HEIGHT_SIZE, SCREEN_Width-(2*10*NOW_SIZE),1*HEIGHT_SIZE)];
        _lineView.backgroundColor = COLOR(222, 222, 222, 1);
        [self.contentView addSubview:_lineView];
        
        for (int i=0; i<nameArray.count; i++) {
            
            NSString *nameString=nameArray[i];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
            CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            
            float W_all_0=W_K_0*2+size.width;
            
            UILabel *lableR = [[UILabel alloc] initWithFrame:CGRectMake(W_all, 0,W_all_0-5*NOW_SIZE, H1)];
            lableR.textColor = COLOR(102, 102, 102, 1);
            lableR.textAlignment=NSTextAlignmentLeft;
            lableR.tag=2000+i;
            NSString *name=[NSString stringWithFormat:@"%@",_nameValueArray[i]];
            if (((NSNull *)name == [NSNull null])) {
                lableR.text=@"---";
            }
            if (name==nil || [name isEqualToString:@""] || [name isEqualToString:@"(null)"]) {
                lableR.text=@"---";
            }else{
                lableR.text=_nameValueArray[i];
            }
            
            lableR.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
            [self.contentView addSubview:lableR];
            
            W_all=W_all+W_all_0;
            
        }
        
    }else{
        for (int i=0; i<_nameValueArray.count; i++) {
              UILabel *lableR=[self.contentView viewWithTag:2000+i];
            NSString *name=[NSString stringWithFormat:@"%@",_nameValueArray[i]];
            if (((NSNull *)name == [NSNull null])) {
                lableR.text=@"---";
            }
            if (name==nil || [name isEqualToString:@""] || [name isEqualToString:@"(null)"]) {
                lableR.text=@"---";
            }else{
                lableR.text=_nameValueArray[i];
            }
            
        }
      
        
    }

    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
