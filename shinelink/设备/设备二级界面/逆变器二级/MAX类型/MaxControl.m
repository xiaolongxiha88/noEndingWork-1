//
//  MaxControl.m
//  ShinePhone
//
//  Created by sky on 2017/12/9.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "MaxControl.h"

@interface MaxControl ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIAlertView *Alert1;
@property (nonatomic, strong) UIAlertView *Alert2;
@property (nonatomic, strong) NSString *paramId;
@property (nonatomic, strong) NSString *commandValue;
@end

@implementation MaxControl

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=MainColor;
   
    [self initUI];
}


-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
    float buttonSize=80*NOW_SIZE;
    
    if([_type isEqualToString:@"0"]){
        UILabel *buttonLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width/2-100*NOW_SIZE)/2, 60*HEIGHT_SIZE, 100*NOW_SIZE,20*HEIGHT_SIZE )];
        buttonLable.text=root_CNJ_kaiji;
        buttonLable.textAlignment=NSTextAlignmentCenter;
        buttonLable.textColor=[UIColor whiteColor];
        buttonLable.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
        buttonLable.adjustsFontSizeToFitWidth=YES;
        [_scrollView addSubview:buttonLable];
        
        UIButton *firstB=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_Width/2-buttonSize)/2, 85*HEIGHT_SIZE, buttonSize,buttonSize)];
        firstB.tag=2001;
        [firstB setImage:[UIImage imageNamed:@"open@2x.png"] forState:UIControlStateNormal];
        [firstB addTarget:self action:@selector(control) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:firstB];
        
        UILabel *buttonLable0=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width/2-100*NOW_SIZE)/2+SCREEN_Width/2, 60*HEIGHT_SIZE, 100*NOW_SIZE,20*HEIGHT_SIZE )];
        buttonLable0.text=root_CNJ_guanji;
        buttonLable0.textAlignment=NSTextAlignmentCenter;
        buttonLable0.textColor=[UIColor whiteColor];
        buttonLable0.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
        [_scrollView addSubview:buttonLable0];
        
        UIButton *firstB0=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_Width/2-buttonSize)/2+SCREEN_Width/2, 85*HEIGHT_SIZE, buttonSize,buttonSize)];
        firstB0.tag=2002;
        [firstB0 setImage:[UIImage imageNamed:@"open@2x.png"] forState:UIControlStateNormal];
        [firstB0 addTarget:self action:@selector(controlOff) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:firstB0];
    }
}

-(void)control{
    
    _Alert1 = [[UIAlertView alloc] initWithTitle:root_ALET message:root_NBQ_shifou_kaiqi delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_OK, nil];
    
    [_Alert1 show];
    
}

-(void)controlOff{
    
    _Alert2 = [[UIAlertView alloc] initWithTitle:root_ALET message:root_NBQ_shifou_guanbi delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_OK, nil];
    [_Alert2 show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }else if (buttonIndex==1){
        if (_Alert1) {
            _commandValue=@"0101";
            _paramId=@"max_cmd_on_off";
       
                [self finishSet];
           
            
        }else if (_Alert2){
            _commandValue=@"0000";
            _paramId=@"max_cmd_on_off";
         
                [self finishSet];
           
            
        }
        
    }
    
}

-(void)finishSet{
    
    NSDictionary *netDic=@{@"serialNum":_PvSn,@"type":_paramId,@"param1":_commandValue,@"param2":@"",@"param3":@"",@"param4":@""};
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:netDic paramarsSite:@"/newTcpsetAPI.do?op=maxSetApi" sucessBlock:^(id content) {
        //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"maxSetAPI: %@", content1);
        [self hideProgressView];
        
        if (content1) {
            if ([content1[@"success"] integerValue] == 0) {
                if ([content1[@"msg"] integerValue] ==501) {
                    [self showAlertViewWithTitle:nil message:root_xitong_cuoWu cancelButtonTitle:root_Yes];
                    
                }else if ([content1[@"msg"] integerValue] ==502) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_fuwuqi_cuowu cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==503) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_buzaixian cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==504) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_xuliehao_kong cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==505) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_caijiqi_buzai cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==506) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_leixing_buzai cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==507) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_canshu_kong cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==508) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_canshu_buzai_fanwei cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==509) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_shijian_budui cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==701) {
                    [self showAlertViewWithTitle:nil message:root_meiyou_quanxian cancelButtonTitle:root_Yes];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showAlertViewWithTitle:nil message:root_CNJ_canshu_chenggong cancelButtonTitle:root_Yes];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
    }];
    
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
