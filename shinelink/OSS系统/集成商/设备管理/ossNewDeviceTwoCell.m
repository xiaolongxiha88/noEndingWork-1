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
            NSInteger Num=nameArray.count/2+nameArray.count%2;
    
    if (!_allView) {

        float H1=20*HEIGHT_SIZE;
        float H_all=H1*2+5*HEIGHT_SIZE;
        
        float H0=H1*Num*2+5*HEIGHT_SIZE+10*HEIGHT_SIZE;
        float H01=H1*Num*2+5*HEIGHT_SIZE;
        
        _allView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,H0)];
        _allView.backgroundColor =COLOR(242, 242, 242, 1);
        [self.contentView addSubview:_allView];
        
        float W=ScreenWidth-20*NOW_SIZE;
        UIView *View2= [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-W)/2.0, 5*HEIGHT_SIZE, W,H01)];
        [View2.layer setMasksToBounds:YES];
        [View2.layer setCornerRadius:(H01/12.0)];
        
        View2.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:View2];
        
        float WW=W/2.0;
        for (int i=0; i<Num; i++) {
            
            UILabel *lableL = [[UILabel alloc] initWithFrame:CGRectMake(WW*0.28, 0+H_all*i,WW, H1)];
            lableL.textColor = MainColor;
            lableL.textAlignment=NSTextAlignmentLeft;
            lableL.text=nameArray[0+2*i];
            lableL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [View2 addSubview:lableL];
            
            UILabel *lableL1 = [[UILabel alloc] initWithFrame:CGRectMake(WW*0.28, H1+H_all*i,WW, H1)];
            lableL1.textColor = COLOR(102, 102, 102, 1);
            lableL1.textAlignment=NSTextAlignmentLeft;
            
              [self changeTheLableText:lableL1 nameString:[NSString stringWithFormat:@"%@",_nameValueArray[0+2*i]]lableNameString:nameArray[0+2*i]];
          //  lableL1.text=_nameValueArray[0+2*i];
            lableL1.tag=2000+0+2*i;
            lableL1.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
            [View2 addSubview:lableL1];
            
            
            if (1+2*i<nameArray.count) {
                UILabel *lableR = [[UILabel alloc] initWithFrame:CGRectMake(WW*0.28+WW, 0+H_all*i,WW, H1)];
                lableR.textColor = MainColor;
                lableR.textAlignment=NSTextAlignmentLeft;
                lableR.text=nameArray[1+2*i];
                lableR.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
                [View2 addSubview:lableR];
                
                UILabel *lableR1 = [[UILabel alloc] initWithFrame:CGRectMake(WW*0.28+WW, H1+H_all*i,WW, H1)];
                lableR1.textColor = COLOR(102, 102, 102, 1);
                lableR1.textAlignment=NSTextAlignmentLeft;
            //    lableR1.adjustsFontSizeToFitWidth=YES;
                    [self changeTheLableText:lableR1 nameString:[NSString stringWithFormat:@"%@",_nameValueArray[1+2*i]] lableNameString:nameArray[1+2*i]];
                  lableR1.tag=2000+1+2*i;
                lableR1.font = [UIFont systemFontOfSize:11*HEIGHT_SIZE];
                [View2 addSubview:lableR1];
            }
            
        }
        
    }else{
        for (int i=0; i<Num; i++) {
               UILabel *lableR=[self.contentView viewWithTag:2000+0+2*i];
            [self changeTheLableText:lableR nameString:[NSString stringWithFormat:@"%@",_nameValueArray[0+2*i]] lableNameString:nameArray[0+2*i]];
            
               UILabel *lableR1=[self.contentView viewWithTag:2000+1+2*i];
                  [self changeTheLableText:lableR1 nameString:[NSString stringWithFormat:@"%@",_nameValueArray[1+2*i]] lableNameString:nameArray[1+2*i]];
        }
        
    }
 
    
}

-(void)changeTheLableText:(UILabel*)Lable nameString:(NSString*)nameString lableNameString:(NSString*)lableNameString{
    if (((NSNull *)nameString == [NSNull null])) {
        Lable.text=@"---";
    }
    if (nameString==nil || [nameString isEqualToString:@""] || [nameString isEqualToString:@"(null)"]) {
        Lable.text=@"---";
    }else{
        Lable.text=nameString;
    }
    if ([lableNameString isEqualToString:root_oss_505_Status]) {
        Lable.text=[self changeTheDeviceStatue:nameString];
        Lable.textColor =[self changeTheDeviceStatueColor:nameString];
    }
    
}


-(NSString*)changeTheDeviceStatue:(NSString*)numString{
    NSString*valueString=@"";
    
    NSDictionary *statueDic;
    if (_deviceType==1) {
        statueDic=@{@"3":@"故障",@"-1":@"离线",@"0":@"等待",@"1":@"在线"};
    }else if (_deviceType==2) {
        statueDic=@{@"3":@"故障",@"-1":@"离线",@"1":@"充电",@"2":@"放电",@"-2":@"在线"};
    }else if (_deviceType==3) {
        statueDic=@{@"3":@"故障",@"-1":@"离线",@"0":@"等待",@"1":@"自检",@"5":@"在线"};
    }
    if ([statueDic.allKeys containsObject:numString]) {
        valueString=[statueDic objectForKey:numString];
    }else{
        valueString=numString;
    }
    
    return valueString;
}


-(UIColor*)changeTheDeviceStatueColor:(NSString*)numString{
    UIColor*valueColor= COLOR(102, 102, 102, 1);
    
    NSDictionary *statueDic;
    if (_deviceType==1) {
        statueDic=@{@"3":COLOR(210, 53, 53, 1),@"-1":COLOR(170, 170, 170, 1),@"0":COLOR(213, 180, 0, 1),@"1":COLOR(44, 189, 10, 1)};
    }else if (_deviceType==2) {
        statueDic=@{@"3":COLOR(210, 53, 53, 1),@"-1":COLOR(170, 170, 170, 1),@"1":COLOR(44, 189, 10, 1),@"2":COLOR(213, 180, 0, 1),@"-2":COLOR(61, 190, 4, 1)};
    }else if (_deviceType==3) {
        statueDic=@{@"3":COLOR(210, 53, 53, 1),@"-1":COLOR(170, 170, 170, 1),@"0":COLOR(213, 180, 0, 1),@"1":COLOR(209, 148, 0, 1),@"5":COLOR(44, 189, 10, 1)};
    }
    if ([statueDic.allKeys containsObject:numString]) {
        valueColor=[statueDic objectForKey:numString];
    }
    
    return valueColor;
}






@end
