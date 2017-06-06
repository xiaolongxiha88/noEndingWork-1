//
//  myListSecondTableViewCell.m
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "myListSecondTableViewCell.h"
#import "GetServerViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0


@interface myListSecondTableViewCell ()<UIWebViewDelegate>
{
   
}

@end

@implementation myListSecondTableViewCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleView= [[UIView alloc]init];
        _titleView.backgroundColor=mainColor;
        //[self addSubview:_titleView];
        float imageSize=40*HEIGHT_SIZE;float leftW=10*NOW_SIZE;
        _image=[[UIImageView alloc]initWithFrame:CGRectMake(leftW, 10*HEIGHT_SIZE, imageSize,imageSize )];
        _image.layer.masksToBounds=YES;
        _image.layer.cornerRadius=imageSize/2.0;
        [self.contentView addSubview:_image];
        
        
        _picLabel= [[UILabel alloc] initWithFrame:CGRectMake(220*NOW_SIZE, 10*HEIGHT_SIZE,90*NOW_SIZE, 20*HEIGHT_SIZE)];
        _picLabel.text=root_ME_chakan_tupian;
        _picLabel.textColor=COLOR(153, 153, 153, 1);
        _picLabel.textAlignment = NSTextAlignmentRight;
        _picLabel.font = [UIFont systemFontOfSize:13*HEIGHT_SIZE];
        _picLabel.adjustsFontSizeToFitWidth=YES;
      //  _picLabel.userInteractionEnabled=YES;
       // UITapGestureRecognizer * labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GetPhoto)];
       // [_picLabel addGestureRecognizer:labelTap1];
        [self.contentView addSubview:_picLabel];
        
        
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(2*leftW+imageSize, 10*HEIGHT_SIZE,150*NOW_SIZE, 20*HEIGHT_SIZE) ];
        _nameLabel.font =[UIFont systemFontOfSize:12*HEIGHT_SIZE];
        _nameLabel.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
        
        _timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(2*leftW+imageSize, 30*HEIGHT_SIZE,150*NOW_SIZE, 20*HEIGHT_SIZE) ];
        _timeLabel.font =[UIFont systemFontOfSize:10*HEIGHT_SIZE];
        _timeLabel.textColor =COLOR(153, 153, 153, 1);
        _timeLabel.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:_timeLabel];
        
        
        
        
//        _contentLabel.font =[UIFont systemFontOfSize:14*HEIGHT_SIZE];
//        _contentLabel.textColor = [UIColor grayColor];
//        _contentLabel.textAlignment =NSTextAlignmentLeft;
//        _contentLabel.numberOfLines=0;
        
        
        _contentLabel =[[UIWebView alloc]init];
           _contentLabel.delegate = self;
        _contentLabel.scrollView.bounces=YES;
        _contentLabel.userInteractionEnabled=NO;
        _contentLabel.opaque=NO;
        _contentLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:_contentLabel];
        

    }
    return self;
}


- (void)showProgressView {
    [MBProgressHUD hideHUDForView:self animated:YES];
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

- (void)hideProgressView {
    [MBProgressHUD hideHUDForView:self animated:YES];
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    //  [LWLoadingView showInView:self.view];
    //[self showProgressView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //[LWLoadingView hideInViwe:self.view];
   // [self hideProgressView];
    float Lsize=11*HEIGHT_SIZE;
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%f",Lsize];
    [_contentLabel stringByEvaluatingJavaScriptFromString:jsString];
    
    [_contentLabel stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#666666'"];
    
  //  "document.getElementById("p").height;"
// [_contentLabel stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '90%'"];
    
}


@end
