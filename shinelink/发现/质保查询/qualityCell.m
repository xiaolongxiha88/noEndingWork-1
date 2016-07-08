//
//  qualityCell.m
//  shinelink
//
//  Created by sky on 16/4/7.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "qualityCell.h"

@implementation qualityCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        _nameArray=[NSMutableArray arrayWithObjects:root_ME_youwu_zhibao, root_zhibao_xunliehao,root_ME_chuchang_shijian,root_ME_daoqi_shijian,nil];
        //NSMutableArray *textArray=[NSMutableArray arrayWithObjects:@"12344413", @"124312321",@"123123132",@"1231233",nil];
        
        float imageSize=50*HEIGHT_SIZE,size1=26*HEIGHT_SIZE,size2=5*NOW_SIZE;//kongXi=5*NOW_SIZE;
         _typeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(size2, size1, imageSize, imageSize)];
      
        [self.contentView addSubview:_typeImageView];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize, size1, imageSize+22*NOW_SIZE, imageSize)];
        self.name.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        //self.name.text=@"逆变器";
        self.name.textAlignment = NSTextAlignmentCenter;
        self.name.textColor = [UIColor blackColor];
        [self.contentView addSubview:_name];
        
        for (int i=0; i<_nameArray.count; i++) {
            UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+imageSize+20*NOW_SIZE, 10*HEIGHT_SIZE+22*HEIGHT_SIZE*i, 80*NOW_SIZE, 15*HEIGHT_SIZE)];
            nameLabel.font=[UIFont systemFontOfSize:10*HEIGHT_SIZE];
            nameLabel.text=_nameArray[i];
            nameLabel.textAlignment = NSTextAlignmentRight;
            nameLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:nameLabel];
        }
        
        _alia=[[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+imageSize+25*NOW_SIZE+80*NOW_SIZE, 10*HEIGHT_SIZE+22*HEIGHT_SIZE*0, 100*NOW_SIZE, 15*HEIGHT_SIZE)];
        _alia.font=[UIFont systemFontOfSize:10*HEIGHT_SIZE];
        //_alia.text=textArray[0];
        _alia.textAlignment = NSTextAlignmentLeft;
        _alia.textColor = [UIColor blackColor];
        [self.contentView addSubview:_alia];
        
        _SN=[[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+imageSize+25*NOW_SIZE+80*NOW_SIZE, 10*HEIGHT_SIZE+22*HEIGHT_SIZE*1, 100*NOW_SIZE, 15*HEIGHT_SIZE)];
        _SN.font=[UIFont systemFontOfSize:10*HEIGHT_SIZE];
      //  _SN.text=textArray[0];
        _SN.textAlignment = NSTextAlignmentLeft;
        _SN.textColor = [UIColor blackColor];
        [self.contentView addSubview:_SN];
        
        _beginTime=[[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+imageSize+25*NOW_SIZE+80*NOW_SIZE, 10*HEIGHT_SIZE+22*HEIGHT_SIZE*2, 100*NOW_SIZE, 15*HEIGHT_SIZE)];
        _beginTime.font=[UIFont systemFontOfSize:10*HEIGHT_SIZE];
      //  _beginTime.text=textArray[0];
        _beginTime.textAlignment = NSTextAlignmentLeft;
        _beginTime.textColor = [UIColor blackColor];
        [self.contentView addSubview:_beginTime];
        
        _overTime=[[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+imageSize+25*NOW_SIZE+80*NOW_SIZE, 10*HEIGHT_SIZE+22*HEIGHT_SIZE*3, 100*NOW_SIZE, 15*HEIGHT_SIZE)];
        _overTime.font=[UIFont systemFontOfSize:10*HEIGHT_SIZE];
        //_overTime.text=textArray[0];
        _overTime.textAlignment = NSTextAlignmentLeft;
        _overTime.textColor = [UIColor blackColor];
        [self.contentView addSubview:_overTime];
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 10*HEIGHT_SIZE+22*HEIGHT_SIZE*4, SCREEN_Width, 10*HEIGHT_SIZE)];
        [view1 setBackgroundColor:COLOR(240, 242, 239, 1)];
        [self.contentView addSubview:view1];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
