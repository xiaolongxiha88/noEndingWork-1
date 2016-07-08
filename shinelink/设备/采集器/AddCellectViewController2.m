//
//  AddCellectViewController.m
//  ShinePhone
//
//  Created by ZML on 15/5/26.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "AddCellectViewController2.h"

@interface AddCellectViewController2 ()
@property(nonatomic,strong)UITextField *cellectId;
@property(nonatomic,strong)UITextField *cellectNo;
@end

@implementation AddCellectViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg4.png");
    self.view.layer.contents = (id)bgImage.CGImage;

    [self initUI];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"add";
}



-(void)initUI{
    //数据采集器序列号
    UIImageView *userBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 50*HEIGHT_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*HEIGHT_SIZE)];
    userBgImageView.userInteractionEnabled = YES;
    userBgImageView.image = IMAGE(@"圆角矩形空心.png");
    [self.view addSubview:userBgImageView];
    
    _cellectId = [[UITextField alloc] initWithFrame:CGRectMake(60*NOW_SIZE, 0, CGRectGetWidth(userBgImageView.frame) - 50*NOW_SIZE, 45*HEIGHT_SIZE)];
    _cellectId.placeholder = root_Enter_DatalogSN;
    _cellectId.textColor = [UIColor grayColor];
    _cellectId.tintColor = [UIColor grayColor];
    [_cellectId setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_cellectId setValue:[UIFont systemFontOfSize:11*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _cellectId.font = [UIFont systemFontOfSize:11*NOW_SIZE];
    [userBgImageView addSubview:_cellectId];
    
    //数据采集器效验码
    UIImageView *pwdBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 110*HEIGHT_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*HEIGHT_SIZE)];
    pwdBgImageView.image = IMAGE(@"圆角矩形空心.png");
    pwdBgImageView.userInteractionEnabled = YES;
    [self.view addSubview:pwdBgImageView];
    
    _cellectNo = [[UITextField alloc] initWithFrame:CGRectMake(60*NOW_SIZE, 0, CGRectGetWidth(pwdBgImageView.frame) - 50*NOW_SIZE, 45*HEIGHT_SIZE)];
    _cellectNo.placeholder = root_Datalog_Valicode;
    _cellectNo.textColor = [UIColor grayColor];
    _cellectNo.tintColor = [UIColor grayColor];
    [_cellectNo setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_cellectNo setValue:[UIFont systemFontOfSize:11*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _cellectNo.font = [UIFont systemFontOfSize:11*NOW_SIZE];
    [pwdBgImageView addSubview:_cellectNo];
    
    UIButton *delButton=[[UIButton alloc]initWithFrame:CGRectMake(40*NOW_SIZE, 210*HEIGHT_SIZE, 100*NOW_SIZE, 35*HEIGHT_SIZE)];
    [delButton setBackgroundImage:IMAGE(@"圆角矩形.png") forState:0];
    [delButton setTitle:root_Cancel forState:UIControlStateNormal];
    [delButton setTitleColor:COLOR(73, 135, 43, 1) forState:UIControlStateNormal];
    [delButton addTarget:self action:@selector(delButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delButton];
    
    UIButton *addButton=[[UIButton alloc]initWithFrame:CGRectMake(180*NOW_SIZE, 210*HEIGHT_SIZE, 100*NOW_SIZE, 35*HEIGHT_SIZE)];
    [addButton setBackgroundImage:IMAGE(@"圆角矩形.png") forState:0];
    [addButton setTitle:root_Yes forState:UIControlStateNormal];
    [addButton setTitleColor:COLOR(73, 135, 43, 1) forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
}


-(void)delButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)addButtonPressed{
    if ([_cellectId.text isEqual:@""]) {
        [self showAlertViewWithTitle:nil message:root_Insert_true_datalog_sn cancelButtonTitle:root_Yes];
        return;
    }
    if ([_cellectNo.text isEqual:@""]) {
        [self showAlertViewWithTitle:nil message:root_Datalog_verification_code_is_incorrect cancelButtonTitle:root_Yes];
        return;
    }
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantID":_stationId,@"datalogSN":_cellectId.text,@"validCode":_cellectNo.text} paramarsSite:@"/datalogA.do?op=add" sucessBlock:^(id content) {
        [self hideProgressView];
        id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if ([[jsonObj objectForKey:@"success"] integerValue] ==0) {
            if ([[jsonObj objectForKey:@"msg"] isEqual:@"errDatalogSN"]) {
                [self showAlertViewWithTitle:nil message:root_Insert_true_datalog_sn cancelButtonTitle:root_Yes];
            }else if ([[jsonObj objectForKey:@"msg"] isEqual:@"errSystemDatalogLimit"]){
                [self showAlertViewWithTitle:nil message:root_Insert_true_datalog_sn cancelButtonTitle:root_Yes];
            }else if ([[jsonObj objectForKey:@"msg"] isEqual:@"errPlantDatalogNumLimit"]){
                [self showAlertViewWithTitle:nil message:root_Insert_true_datalog_sn cancelButtonTitle:root_Yes];
            }else if ([[jsonObj objectForKey:@"msg"] isEqual:@"errDatalogAndValidCode"]){
                [self showAlertViewWithTitle:nil message:root_Insert_datalog_code cancelButtonTitle:root_Yes];
            }else if ([[jsonObj objectForKey:@"msg"] isEqual:@"errDatalogExist"]){
                [self showAlertViewWithTitle:nil message:root_Insert_true_datalog_sn cancelButtonTitle:root_Yes];
            }
        }else{
            [self showAlertViewWithTitle:nil message:root_Added_successfully cancelButtonTitle:root_Yes];
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
}

@end
