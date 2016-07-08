//
//  EditCellectView.m
//  ShinePhone
//
//  Created by ZML on 15/5/26.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "EditCellectView.h"

@implementation EditCellectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(frame.size.width - 64, 44*HEIGHT_SIZE, 44*NOW_SIZE, 44*HEIGHT_SIZE);
        cancelButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
        [cancelButton setImage:IMAGE(@"btn_cha.png") forState:UIControlStateNormal];
        cancelButton.tag = 1050;
        [cancelButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55*NOW_SIZE, 150*HEIGHT_SIZE, frame.size.width - 110*NOW_SIZE, 200*HEIGHT_SIZE)];
        bgImageView.image = IMAGE(@"bg_list_popver.png");
        bgImageView.userInteractionEnabled = YES;
        [self addSubview:bgImageView];
       
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(0, 0 * CGRectGetHeight(bgImageView.frame)/4, CGRectGetWidth(bgImageView.frame), CGRectGetHeight(bgImageView.frame)/3);
        [addButton setTitle:root_CJQ_tianjia forState:UIControlStateNormal];
        addButton.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];

        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        addButton.tag = 1051;
        [addButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:addButton];
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(0, 1 * CGRectGetHeight(bgImageView.frame)/4, CGRectGetWidth(bgImageView.frame), CGRectGetHeight(bgImageView.frame)/3);
        [deleteButton setTitle:root_CJQ_bianji forState:UIControlStateNormal];
         deleteButton.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
        [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        deleteButton.tag = 1052;
        [deleteButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:deleteButton];
        
        UIButton *uploadStationImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        uploadStationImageButton.frame = CGRectMake(0, 2 * CGRectGetHeight(bgImageView.frame)/4, CGRectGetWidth(bgImageView.frame), CGRectGetHeight(bgImageView.frame)/3);
        [uploadStationImageButton setTitle:root_CJQ_shanchu forState:UIControlStateNormal];
          uploadStationImageButton.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
        [uploadStationImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [uploadStationImageButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        uploadStationImageButton.tag = 1053;
        [uploadStationImageButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:uploadStationImageButton];
        
        UIButton *deviceSet = [UIButton buttonWithType:UIButtonTypeCustom];
        deviceSet.frame = CGRectMake(0, 3* CGRectGetHeight(bgImageView.frame)/4, CGRectGetWidth(bgImageView.frame), CGRectGetHeight(bgImageView.frame)/3);
        [deviceSet setTitle:root_CJQ_peizhi forState:UIControlStateNormal];
          deviceSet.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
        [deviceSet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deviceSet setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        deviceSet.tag = 1054;
        [deviceSet addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:deviceSet];
        
    }
    
    return self;
}

- (void)buttonDidClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(menuDidSelectAtRow:)]) {
        [self.delegate menuDidSelectAtRow:(sender.tag - 1050)];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

@end
