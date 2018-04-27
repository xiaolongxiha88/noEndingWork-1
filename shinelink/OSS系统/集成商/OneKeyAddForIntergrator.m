//
//  OneKeyAddForIntergrator.m
//  ShinePhone
//
//  Created by sky on 2018/4/27.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "OneKeyAddForIntergrator.h"

@interface OneKeyAddForIntergrator ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *oneView;
@end

@implementation OneKeyAddForIntergrator

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}

-(void)initUI{
    float H1=30*HEIGHT_SIZE;
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    
    float W1=SCREEN_Width/3.0;
    NSArray *nameArray=@[@"1.添加用户",@"2.添加电站",@"3.添加设备"];
    for (int i=0; i<3; i++) {
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0+W1*i, 0,W1, H1)];
        if (i==0) {
             lable1.textColor = MainColor;
              lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        }else{
            lable1.textColor = COLOR(154, 154, 154, 1);
            lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        }
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.text=nameArray[i];
        [self.view addSubview:lable1];
        
        
    }
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, H1, SCREEN_Width, ScreenHeight-H1)];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
}


-(void)initOneView{
    _oneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, ScreenHeight)];
    [_scrollView addSubview:_oneView];
    
    NSArray *name1Array=@[@"服务器",@"账号",@"密码",@"确认密码",@"时区",@"手机号"];
    
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
