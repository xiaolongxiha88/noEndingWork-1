//
//  ossNewDeviceTwoCell.m
//  ShinePhone
//
//  Created by sky on 2018/5/9.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossNewDeviceTwoCell.h"

@implementation ossNewDeviceTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setNameArray:(NSArray *)nameArray {
    float H1=40*HEIGHT_SIZE;
    NSInteger Num=nameArray.count/2+nameArray.count%2;
    float H0=40*HEIGHT_SIZE*Num+10*HEIGHT_SIZE;
       float H01=40*HEIGHT_SIZE*Num;
    
    UIView *View1= [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,H0)];
    View1.backgroundColor =COLOR(242, 242, 242, 1);
    [self.contentView addSubview:View1];
    
    float W=ScreenWidth-20*NOW_SIZE;
    UIView *View2= [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-W)/2.0, 5*HEIGHT_SIZE, W,H01)];
    [View2.layer setMasksToBounds:YES];
    [View2.layer setCornerRadius:(H01/12.0)];
    
    View2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:View2];
    
    for (int i=0; i<Num; i++) {

        UILabel *lableL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0+H1*i,ScreenWidth/2.0, H1)];
        lableL.textColor = COLOR(102, 102, 102, 1);
        lableL.textAlignment=NSTextAlignmentCenter;
        lableL.text=nameArray[0+2*i];
        lableL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [View2 addSubview:lableL];
        
        if (1+2*i<nameArray.count) {
            UILabel *lableR = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2.0, 0+H1*i,ScreenWidth/2.0, H1)];
            lableR.textColor = COLOR(102, 102, 102, 1);
            lableR.textAlignment=NSTextAlignmentCenter;
            lableR.text=nameArray[1+2*i];
            lableR.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [View2 addSubview:lableR];
        }
 
        
        

        
    }
    
}







@end
