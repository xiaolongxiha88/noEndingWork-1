//
//  AvCachTableViewCell.m
//  ShinePhone
//
//  Created by sky on 16/9/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "AvCachTableViewCell.h"

@implementation AvCachTableViewCell

+(instancetype)creatWithTableView:(UITableView *)tableView{
    static NSString *ID=@"Cell";
    AvCachTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[AvCachTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        // cell.selectionStyle = UITableViewCellSelectionStyleNone;//有这个方法不能选中
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return cell;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (self.editing) {
        if (selected) {
            // 编辑状态去掉渲染
            self.contentView.backgroundColor = [UIColor whiteColor];
            self.backgroundView.backgroundColor = [UIColor whiteColor];
            // 左边选择按钮去掉渲染背景
            UIView *view = [[UIView alloc] initWithFrame:self.multipleSelectionBackgroundView.bounds];
            view.backgroundColor = [UIColor whiteColor];
            self.selectedBackgroundView = view;
            
        }
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
//        _numLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 100, 20)];
//        [self.contentView addSubview:_numLabel];
//        _textLabels=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 100, 20)];
//        [self.contentView addSubview:_textLabels];
        
        float imageSize=80*HEIGHT_SIZE,size1=13*HEIGHT_SIZE,size2=5*NOW_SIZE,kongXi=20*NOW_SIZE;
        _typeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(size2, size1, imageSize*1.78, imageSize)];
        [self.contentView addSubview:_typeImageView];
        
        float alertImageSize=40*HEIGHT_SIZE;
        UIImageView *aletImage=[[UIImageView alloc] initWithFrame:CGRectMake(size2+(imageSize*1.78-alertImageSize)/2, size1+(imageSize-alertImageSize)/2, alertImageSize, alertImageSize)];
        aletImage.image=IMAGE(@"AvPlay2.png");
        [self.contentView addSubview:aletImage];
        
        
        self.CellName = [[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize*1.78+kongXi, size1, imageSize+60*NOW_SIZE,imageSize)];
        self.CellName.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
        self.CellName.textAlignment = NSTextAlignmentLeft;
        _CellName.numberOfLines=0;
        self.CellName.textColor = [UIColor blackColor];
        [self.contentView addSubview:_CellName];
        
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 108*HEIGHT_SIZE-2*HEIGHT_SIZE, SCREEN_Width, 2*HEIGHT_SIZE)];
        [view1 setBackgroundColor:colorGary];
        [self.contentView addSubview:view1];
        
    }
    
    return self;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    if (editing) {
        for (UIControl *control in self.subviews){
            if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
                for (UIView *v in control.subviews)
                {
                    if ([v isKindOfClass: [UIImageView class]]) {
                        UIImageView *img=(UIImageView *)v;
                        
                        img.image = [UIImage imageNamed:@"btn1-choose"];
                    }
                }
            }
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"btn1-choose-1"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"btn1-choose"];
                    }
                }
            }
        }
    }
    
}


@end
