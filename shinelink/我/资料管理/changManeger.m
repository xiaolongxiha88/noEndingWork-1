//
//  changManeger.m
//  shinelink
//
//  Created by sky on 16/4/21.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "changManeger.h"

@interface changManeger ()
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UITextField *textField1;
@property (nonatomic, strong)UITextField *textField2;
@property (nonatomic, strong)UITextField *textField3;
@property (nonatomic, strong)UITextField *textField4;
@property (nonatomic, strong) NSString *param1;
@property (nonatomic, strong) NSString *param2;
@property (nonatomic, strong) NSString *param3;
@property (nonatomic, strong) NSString *param1Name;
@property (nonatomic, strong) NSString *param2Name;
@property (nonatomic, strong) NSString *param3Name;
@property (nonatomic, strong) NSString *accountName;
@property (nonatomic, strong) NSString *address;
@end

@implementation changManeger

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *bgImage = IMAGE(@"bg4.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
    self.view.backgroundColor=MainColor;
    
    [self initUI];
    
}

-(void)initUI{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    float Size1=40*HEIGHT_SIZE;
    
      if([_type isEqualToString:@"0"]){
    UILabel *PV1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE, 140*NOW_SIZE,30*HEIGHT_SIZE )];
    PV1.text=root_Alet_user_pwd;
    PV1.textAlignment=NSTextAlignmentRight;
    PV1.textColor=[UIColor whiteColor];
    PV1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [self.view addSubview:PV1];
    
//    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE,75*NOW_SIZE+30*NOW_SIZE, 150*NOW_SIZE,1*NOW_SIZE )];
//    line3.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:line3];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(160*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE, 150*NOW_SIZE,30*HEIGHT_SIZE )];
          _textField.layer.borderWidth=1;
           _textField.textAlignment=NSTextAlignmentLeft;
          _textField.layer.cornerRadius=5;
          _textField.layer.borderColor=[UIColor whiteColor].CGColor;
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
    _textField.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    //_textField.delegate=self;
    [self.view addSubview:_textField];
          
          UILabel *PV2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1, 140*NOW_SIZE,30*HEIGHT_SIZE )];
          PV2.text=root_chongFu_miMa;
          PV2.textAlignment=NSTextAlignmentRight;
          PV2.textColor=[UIColor whiteColor];
          PV2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
          [self.view addSubview:PV2];
//          
//          UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE,75*NOW_SIZE+30*NOW_SIZE+Size1, 150*NOW_SIZE,1*NOW_SIZE )];
//          line4.backgroundColor=[UIColor whiteColor];
//          [self.view addSubview:line4];
          
          _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(160*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1, 150*NOW_SIZE,30*HEIGHT_SIZE )];
          _textField1.layer.borderWidth=1;
          _textField1.layer.cornerRadius=5;
          _textField1.layer.borderColor=[UIColor whiteColor].CGColor;
          _textField1.textAlignment=NSTextAlignmentLeft;
          _textField1.textColor = [UIColor whiteColor];
          _textField1.tintColor = [UIColor whiteColor];
          _textField1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
          //_textField.delegate=self;
          [self.view addSubview:_textField1];
          
      }

    if([_type isEqualToString:@"1"]){
        UILabel *PV2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1, 140*NOW_SIZE,30*HEIGHT_SIZE )];
        PV2.text=root_DianHua;
        PV2.textAlignment=NSTextAlignmentCenter;
        PV2.textColor=[UIColor whiteColor];
        PV2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [self.view addSubview:PV2];
        
//        UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE,75*NOW_SIZE+30*NOW_SIZE+Size1, 150*NOW_SIZE,1*NOW_SIZE )];
//        line4.backgroundColor=[UIColor whiteColor];
//        [self.view addSubview:line4];
        
        _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(160*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1,150*NOW_SIZE,30*HEIGHT_SIZE )];
        _textField2.layer.borderWidth=1;
        _textField2.layer.cornerRadius=5;
        _textField2.textAlignment=NSTextAlignmentLeft;
        _textField2.layer.borderColor=[UIColor whiteColor].CGColor;
        _textField2.textColor = [UIColor whiteColor];
        _textField2.tintColor = [UIColor whiteColor];
        _textField2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        //_textField.delegate=self;
        [self.view addSubview:_textField2];
    }
    
    if([_type isEqualToString:@"2"]){
        UILabel *PV2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,25*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1, 300*NOW_SIZE,30*HEIGHT_SIZE )];
        PV2.text=root_WO_shuru_youxiang;
        PV2.textAlignment=NSTextAlignmentCenter;
        PV2.textColor=[UIColor whiteColor];
        PV2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [self.view addSubview:PV2];
        
//        UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE,75*NOW_SIZE+30*NOW_SIZE+Size1, 150*NOW_SIZE,1*NOW_SIZE )];
//        line4.backgroundColor=[UIColor whiteColor];
//        [self.view addSubview:line4];
        
        _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(70*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1, 180*NOW_SIZE,30*HEIGHT_SIZE )];
        _textField3.layer.borderWidth=1;
        _textField3.layer.cornerRadius=5;
        _textField3.textAlignment=NSTextAlignmentCenter;
        _textField3.layer.borderColor=[UIColor whiteColor].CGColor;
        _textField3.textColor = [UIColor whiteColor];
        _textField3.tintColor = [UIColor whiteColor];
        _textField3.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        //_textField.delegate=self;
        [self.view addSubview:_textField3];
    }
    
    if([_type isEqualToString:@"3"]){
        UILabel *PV2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,25*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1, 300*NOW_SIZE,30*HEIGHT_SIZE )];
        PV2.text=root_WO_shuru_dailishang;
        PV2.textAlignment=NSTextAlignmentCenter;
        PV2.textColor=[UIColor whiteColor];
        PV2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [self.view addSubview:PV2];
        
//        UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE,75*NOW_SIZE+30*NOW_SIZE+Size1, 150*NOW_SIZE,1*NOW_SIZE )];
//        line4.backgroundColor=[UIColor whiteColor];
//        [self.view addSubview:line4];
        
        _textField4 = [[UITextField alloc] initWithFrame:CGRectMake(70*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1, 180*NOW_SIZE,30*HEIGHT_SIZE )];
        _textField4.layer.borderWidth=1;
        _textField4.layer.cornerRadius=5;
         _textField4.textAlignment=NSTextAlignmentLeft;
        _textField4.layer.borderColor=[UIColor whiteColor].CGColor;
        _textField4.textColor = [UIColor whiteColor];
        _textField4.tintColor = [UIColor whiteColor];
        _textField4.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        //_textField.delegate=self;
        [self.view addSubview:_textField4];
    }
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,210*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
//    [goBut.layer setMasksToBounds:YES];
//    [goBut.layer setCornerRadius:25.0];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_OK forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(finishSet1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_textField resignFirstResponder];
    [_textField1 resignFirstResponder];
     [_textField2 resignFirstResponder];
     [_textField3 resignFirstResponder];
     [_textField4 resignFirstResponder];
}

-(void)finishSet1{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }

    

    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *pass=[ud objectForKey:@"userName"];
    _accountName=[NSString stringWithString:pass];
    NSMutableDictionary *dataAll=[NSMutableDictionary new];
    
    
    if (_textField) {
        if (![[_textField text]isEqualToString:[_textField1 text]])
        {
            [self showToastViewWithTitle:root_xiangTong_miMa];
            return;
        }else{
        _address=@"/newUserAPI.do?op=updateUserPassword";
        _param1Name=@"passwordOld";
            _param1=[_textField text];
            _param2Name=@"passwordNew";
            _param2=[_textField1 text];
        }
         [dataAll setObject:_accountName forKey:@"accountName"];
          [dataAll setObject:_param1 forKey:@"passwordOld"];
          [dataAll setObject:_param2 forKey:@"passwordNew"];
    }
    
    if (_textField2 || _textField3||_textField4) {
        _address=@"/newUserAPI.do?op=updateUser";
        _param1Name=@"PhoneNum";
         _param2Name=@"email";
        _param3Name=@"agentCode";
        if (_textField2) {
            _param1=[_textField2 text];
            _param2=@"";
            _param3=@"";
        }
        if (_textField3) {
            _param1=@"";
              _param3=@"";
            _param2=[_textField3 text];
        }
        if (_textField4) {
            _param1=@"";
             _param2=@"";
            _param3=[_textField4 text];
        }
        
        [dataAll setObject:_accountName forKey:@"accountName"];
        [dataAll setObject:_param1 forKey:@"PhoneNum"];
        [dataAll setObject:_param2 forKey:@"email"];
        [dataAll setObject:_param3 forKey:@"agentCode"];
        
    }
    
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:dataAll paramarsSite:_address sucessBlock:^(id content) {
        //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"UserSet: %@", content1);
        [self hideProgressView];
        
        if (content1) {
            if ([content1[@"success"] integerValue] == 0) {
                if ([content1[@"msg"] integerValue] ==501) {
                    [self showAlertViewWithTitle:nil message:root_xitong_cuoWu cancelButtonTitle:root_Yes];
                    
                }else if ([content1[@"msg"] integerValue] ==502) {
                    [self showAlertViewWithTitle:nil message:root_WO_yonghu_bucunzai cancelButtonTitle:root_Yes];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showAlertViewWithTitle:nil message:root_CNJ_canshu_chenggong cancelButtonTitle:root_Yes];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSError *error) {
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
