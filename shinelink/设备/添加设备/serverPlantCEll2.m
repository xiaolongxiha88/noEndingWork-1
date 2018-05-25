//
//  serverPlantCEll2.m
//  ShinePhone
//
//  Created by sky on 2018/5/24.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "serverPlantCEll2.h"

@implementation serverPlantCEll2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setNameArray:(NSArray *)nameArray {
//    NSInteger Num=nameArray.count/2+nameArray.count%2;
    
    if (!_allView) {
        
        float H1=20*HEIGHT_SIZE;
        float H2=30*HEIGHT_SIZE;
             float K_H=10*HEIGHT_SIZE;
          float K_H0=10*HEIGHT_SIZE;
        
        float unit_H=H1*2+K_H0;
            float H_all=unit_H*3+H2;
         float H_all_all=unit_H*3+H2+K_H;
        
          float W=ScreenWidth-20*NOW_SIZE;
        
        _allView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,H_all_all)];
        _allView.backgroundColor =COLOR(242, 242, 242, 1);
        [self.contentView addSubview:_allView];
        
      
        UIView *View2= [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-W)/2.0, K_H0/2.0, W,H_all)];
        [View2.layer setMasksToBounds:YES];
        [View2.layer setCornerRadius:(H_all/22.0)];
        View2.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:View2];
        
        UIView *View3= [[UIView alloc]initWithFrame:CGRectMake(0, 0, W,H2)];
        [View3.layer setMasksToBounds:YES];
       // [View3.layer setCornerRadius:(H_all/12.0)];
        View3.backgroundColor = COLOR(122, 199, 249, 1);
        [View2 addSubview:View3];
        
          float image01_K_W=10*NOW_SIZE;
        float image_01_W=15*HEIGHT_SIZE;
        UIImageView *image01=[[UIImageView alloc]initWithFrame:CGRectMake(image01_K_W, (H2-image_01_W)/2.0, image_01_W,image_01_W )];
        image01.image=IMAGE(@"station_sm_icon.png");
        [View3 addSubview:image01];
        
        float W2=150*NOW_SIZE;
        UILabel *lable11 = [[UILabel alloc] initWithFrame:CGRectMake(image01_K_W*2+image_01_W, 0,W2, H2)];
        lable11.textColor = [UIColor whiteColor];
        lable11.textAlignment=NSTextAlignmentLeft;
        lable11.tag=3000;
           lable11.adjustsFontSizeToFitWidth=YES;
              [self changeTheLableText:lable11 nameString:[NSString stringWithFormat:@"%@",_nameValueArray[0]] lableNameString:nameArray[1]];
        lable11.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [View3 addSubview:lable11];
        
        float lable22_W=W-(image01_K_W*4+image_01_W+W2)-8*NOW_SIZE;
        UILabel *lable22 = [[UILabel alloc] initWithFrame:CGRectMake(image01_K_W*3+image_01_W+W2, 0,lable22_W, H2)];
        lable22.textColor = [UIColor whiteColor];
        lable22.adjustsFontSizeToFitWidth=YES;
        lable22.textAlignment=NSTextAlignmentRight;
         lable22.tag=3001;
            [self changeTheLableText:lable22 nameString:[NSString stringWithFormat:@"%@",_nameValueArray[_nameValueArray.count-2]] lableNameString:nameArray[1]];
        lable22.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        [View3 addSubview:lable22];
        
        
        float W_K=5*NOW_SIZE;
        float WW=(W-W_K*3)/3.0;
         float WW1=(W-W_K*3)/3.0;
        
        
        
        for (int i=0; i<nameArray.count-1; i++) {
            
            int w_k=i%2;
            int H_k=i/2;
            
            UIView *View0 = [[UIView alloc]initWithFrame:CGRectMake(WW1+W_K+(WW+W_K)*w_k,H2+unit_H*H_k, WW,unit_H)];
            View0.backgroundColor =[UIColor whiteColor];
            [View2 addSubview:View0];
            
            UILabel *lableL = [[UILabel alloc] initWithFrame:CGRectMake(0, K_H0/2.0,WW, H1)];
            lableL.textColor = MainColor;
            lableL.textAlignment=NSTextAlignmentLeft;
               lableL.adjustsFontSizeToFitWidth=YES;
            lableL.text=nameArray[i+1];
            lableL.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [View0 addSubview:lableL];
            
            UILabel *lableValue = [[UILabel alloc] initWithFrame:CGRectMake(0, K_H0/2.0+H1,WW, H1)];
            lableValue.textColor = COLOR(102, 102, 102, 1);
            lableValue.textAlignment=NSTextAlignmentLeft;
                lableValue.adjustsFontSizeToFitWidth=YES;
            lableValue.tag=2000+i;
              [self changeTheLableText:lableValue nameString:[NSString stringWithFormat:@"%@",_nameValueArray[i+1]] lableNameString:nameArray[i]];
            lableValue.adjustsFontSizeToFitWidth=YES;
            lableValue.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
            [View0 addSubview:lableValue];
            
        }
        
       
        
        NSArray*imageNameArray=@[root_PpvN,root_todayPV,root_Revenue];
        NSArray*imageNamePicArray=@[@"power_sm_icon.png",@"ele_sm_icon.png",@"profit__sm_icon.png"];
        
                    float imageW=20*HEIGHT_SIZE;
           float image_K_W=8*NOW_SIZE;
        float lable2H=30*HEIGHT_SIZE;
        
        
        for (int i=0; i<imageNameArray.count; i++) {
            
            UIView *View0 = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE,H2+unit_H*i, WW1,unit_H)];
            View0.backgroundColor =[UIColor whiteColor];
            [View2 addSubview:View0];
            

            UIImageView *image0=[[UIImageView alloc]initWithFrame:CGRectMake(image_K_W, (unit_H-imageW)/2.0, imageW,imageW )];
            image0.image=IMAGE(imageNamePicArray[i]);
            [View0 addSubview:image0];
            
            
            UILabel *lableL = [[UILabel alloc] initWithFrame:CGRectMake(image_K_W+image_K_W+imageW, (unit_H-lable2H)/2.0,WW1-(image_K_W+image_K_W+imageW), lable2H)];
            lableL.textColor = COLOR(102, 102, 102, 1);
            lableL.textAlignment=NSTextAlignmentLeft;
            lableL.text=imageNameArray[i];
            lableL.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
            [View0 addSubview:lableL];
            
        }
        
        
    }else{
        for (int i=0; i<nameArray.count-1; i++) {
            
            UILabel *lableR=[self.contentView viewWithTag:2000+i];
            [self changeTheLableText:lableR nameString:[NSString stringWithFormat:@"%@",_nameValueArray[i+1]] lableNameString:nameArray[i]];

        }
         UILabel *lableR1=[self.contentView viewWithTag:3000];
              [self changeTheLableText:lableR1 nameString:[NSString stringWithFormat:@"%@",_nameValueArray[0]] lableNameString:nameArray[1]];
        
        UILabel *lableR2=[self.contentView viewWithTag:3001];
        [self changeTheLableText:lableR2 nameString:[NSString stringWithFormat:@"%@",_nameValueArray[_nameValueArray.count-2]] lableNameString:nameArray[1]];
        
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

}








@end
