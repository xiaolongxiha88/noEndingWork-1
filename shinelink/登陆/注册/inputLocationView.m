//
//  inputLocationView.m
//  ShinePhone
//
//  Created by sky on 2018/4/9.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "inputLocationView.h"

@interface inputLocationView ()

@property (nonatomic, strong)NSArray*nameArray;

@end

@implementation inputLocationView

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
}


-(void)initUI{
    self.view.backgroundColor=MainColor;
    
    _nameArray=@[root_WO_chengshi,root_WO_jingdu,root_WO_weidu];
    
    float H=40*HEIGHT_SIZE;
    for (int i=0; i<_nameArray.count; i++) {
        UILabel *PV2Lable2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 40*HEIGHT_SIZE+H*i, 80*NOW_SIZE,30*HEIGHT_SIZE )];
        PV2Lable2.text=_nameArray[i];
        PV2Lable2.textAlignment=NSTextAlignmentRight;
        PV2Lable2.textColor=[UIColor whiteColor];
        PV2Lable2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        PV2Lable2.adjustsFontSizeToFitWidth=YES;
        [self.view addSubview:PV2Lable2];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(95*NOW_SIZE, 40*HEIGHT_SIZE+H*i, 170*NOW_SIZE, 30*HEIGHT_SIZE)];
        textField.layer.borderWidth=1;
        textField.layer.cornerRadius=5;
        textField.tag=2000+i;
        textField.layer.borderColor=[UIColor whiteColor].CGColor;
        textField.textColor = [UIColor whiteColor];
        textField.tintColor = [UIColor whiteColor];
        textField.textAlignment=NSTextAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [self.view addSubview:textField];
        
    }

    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,190*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:20.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_next_go forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(goToSet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
    
}



-(void)goToSet{
    NSMutableArray *locationArray=[NSMutableArray array];
    
    for (int i=0; i<_nameArray.count; i++) {
        UITextField *textField=[self.view viewWithTag:2000+i];
        [locationArray addObject:textField.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
      self.locationArrayBlock(locationArray);
    
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
