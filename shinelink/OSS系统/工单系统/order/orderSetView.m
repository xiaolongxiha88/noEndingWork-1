//
//  orderSetView.m
//  ShinePhone
//
//  Created by sky on 2017/12/26.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "orderSetView.h"

@interface orderSetView ()
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation orderSetView

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initUI];
}


-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    
        float lable1W=10*NOW_SIZE;  float lableH=30*HEIGHT_SIZE;    float numH=35*NOW_SIZE;  float firstW=25*NOW_SIZE;
    
    NSString *lableNameString1=@"填写工单表格";
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
    CGSize size0 = [lableNameString1 boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic1 context:nil].size;
    UILabel *lable02 = [[UILabel alloc]initWithFrame:CGRectMake(firstW+lable1W, 0,size0.width, lableH)];
        lable02.textColor =COLOR(51, 51, 51, 1);
    lable02.text=lableNameString1;
    lable02.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    lable02.textAlignment=NSTextAlignmentLeft;
        [_scrollView addSubview:lable02];
 
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
