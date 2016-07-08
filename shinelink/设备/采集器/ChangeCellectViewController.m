//
//  ChangeCellectViewController.m
//  ShinePhone
//
//  Created by ZML on 15/6/4.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "ChangeCellectViewController.h"

@interface ChangeCellectViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray *textFieldMutableArray;
@end

@implementation ChangeCellectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg4.png");
    self.view.layer.contents = (id)bgImage.CGImage;

    [self initUI];
}


-(void)initUI{
    NSArray *labelArray=[[NSArray alloc]initWithObjects:root_xuleihao,root_bieming,root_zubie, nil];
    for (int i=0; i<3; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20*NOW_SIZE, (50+i*40)*HEIGHT_SIZE, 100*NOW_SIZE, 40*HEIGHT_SIZE)];
        label.text=labelArray[i];
        label.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        label.textColor=[UIColor whiteColor];
        [self.view addSubview:label];
    }

    _textFieldMutableArray=[NSMutableArray new];
    NSArray *array=[[NSArray alloc]initWithObjects:_datalogSN,_alias,_unitId, nil];
    for (int i=0; i<3; i++) {
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(120*NOW_SIZE, (55+i*40)*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        textField.text=array[i];
        textField.layer.borderWidth=0.5;
        textField.layer.cornerRadius=5;
        textField.layer.borderColor=[UIColor whiteColor].CGColor;
        textField.tintColor = [UIColor whiteColor];
        [textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
        textField.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        textField.textColor=[UIColor whiteColor];
        textField.tag=i;
        textField.delegate=self;
        [self.view addSubview:textField];
        [_textFieldMutableArray addObject:textField];
    }
    
//    UIButton *delButton=[[UIButton alloc]initWithFrame:CGRectMake(80*NOW_SIZE, 350*NOW_SIZE, 60*NOW_SIZE, 21*NOW_SIZE)];
//    [delButton setBackgroundImage:IMAGE(@"圆角矩形.png") forState:0];
//    [delButton setTitle:root_Cancel forState:UIControlStateNormal];
//    [delButton setTitleColor:COLOR(73, 135, 43, 1) forState:UIControlStateNormal];
//    [delButton addTarget:self action:@selector(delButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:delButton];
//    
//    UIButton *addButton=[[UIButton alloc]initWithFrame:CGRectMake(180*NOW_SIZE, 350*NOW_SIZE, 60*NOW_SIZE, 21*NOW_SIZE)];
//    [addButton setBackgroundImage:IMAGE(@"圆角矩形.png") forState:0];
//    [addButton setTitle:root_Yes forState:UIControlStateNormal];
//    [addButton setTitleColor:COLOR(73, 135, 43, 1) forState:UIControlStateNormal];
//    [addButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:addButton];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,250*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
//    [goBut.layer setMasksToBounds:YES];
//    [goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_finish forState:UIControlStateNormal];
     goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
}

-(void)delButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addButtonPressed{
    NSArray *array=[[NSArray alloc]initWithObjects:@"Insert true datalog sn",@"Datalog verification code is incorrect", nil];
    for (int i=0; i<2; i++) {
        if ([[_textFieldMutableArray[i] text] isEqual:@""]) {
            [self showToastViewWithTitle:array[i]];
            return;
        }
    }
    
    NSDictionary *dict=@{@"datalogSN":[_textFieldMutableArray[0] text],
                         @"alias":[_textFieldMutableArray[1] text],
                         @"unitId":[_textFieldMutableArray[2] text]};
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:dict paramarsSite:@"/newDatalogAPI.do?op=updateDatalog" sucessBlock:^(id content) {
        [self hideProgressView];
        id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if ([[jsonObj objectForKey:@"success"] integerValue] ==0) {
            [self showAlertViewWithTitle:nil message:NSLocalizedString(@"Modification fails", @"Modification fails") cancelButtonTitle:root_Yes];
        }else{
            [self showAlertViewWithTitle:nil message:NSLocalizedString(@"Successfully modified", @"Successfully modified") cancelButtonTitle:root_Yes];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
}

@end
