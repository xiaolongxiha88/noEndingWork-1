//
//  phoneRegister2ViewController.m
//  ShinePhone
//
//  Created by sky on 17/2/28.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "phoneRegister2ViewController.h"

@interface phoneRegister2ViewController ()
@property (nonatomic, strong)  UITextField *textField;
@property (nonatomic, strong)  UITextField *textField2;
@end


@implementation phoneRegister2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    
    [self initUI];
}

-(void)initUI{
    
    float H1=20*HEIGHT_SIZE;
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE,70*HEIGHT_SIZE-H1,220*NOW_SIZE, 25*HEIGHT_SIZE)];
    _textField.placeholder =root_Alet_user_pwd;
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
    _textField.textAlignment = NSTextAlignmentCenter;
    [_textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_textField];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(50*NOW_SIZE,98*HEIGHT_SIZE-H1,220*NOW_SIZE, 1*HEIGHT_SIZE)];
    line.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE,128*HEIGHT_SIZE-H1,220*NOW_SIZE, 25*HEIGHT_SIZE)];
    _textField2.placeholder =root_chongFu_shuRu_miMa;
    _textField2.textColor = [UIColor whiteColor];
    _textField2.tintColor = [UIColor whiteColor];
    _textField2.textAlignment = NSTextAlignmentCenter;
    [_textField2 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField2 setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_textField2];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(50*NOW_SIZE,156*HEIGHT_SIZE-H1,220*NOW_SIZE, 1*HEIGHT_SIZE)];
    line1.backgroundColor=COLOR(255, 255, 255, 0.5);
    [self.view addSubview:line1];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,205*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:20.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_finish forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(registerFrist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
}


-(void)PresentGo{

    if (([_textField text] ==nil)||([_textField text] ==NULL)||([[_textField text]  isEqual:@""])) {
           [self showToastViewWithTitle:root_Alet_user_pwd];
        return;
    }
    
    if (!([[_textField text]  isEqual:[_textField2 text]])) {
        [self showToastViewWithTitle:root_xiangTong_miMa];
        return;
    }
    
    NSMutableDictionary *dic0=[NSMutableDictionary new];
    [dic0 setObject:_PhoneNum forKey:@"phoneNum"];
      [dic0 setObject:_PhoneCheck forKey:@"validate"];
     [dic0 setObject:[_textField text] forKey:@"password"];
  
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:dic0 paramarsSite:@"/newForgetAPI.do?op=restartUserPassword" sucessBlock:^(id content) {
        [self hideProgressView];
        id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"smsVerification: %@", jsonObj);
        if (jsonObj) {
            if ([jsonObj[@"result"] intValue]==1) {
           
                 [self showAlertViewWithTitle:root_xiugai_mima_chenggong message:nil cancelButtonTitle:root_Yes];
            }else{
                
                if ((jsonObj[@"msg"]==nil)||(jsonObj[@"msg"]==NULL)||([jsonObj[@"msg"] isEqual:@""])) {
                    
                }else{
                    
                    if ([jsonObj[@"msg"] intValue]==502) {
                        [self showAlertViewWithTitle:root_xiugai_mima_shibai message:root_mima_buneng_weikong cancelButtonTitle:root_Yes];
                    }else if ([jsonObj[@"msg"] intValue]==503) {
                        [self showAlertViewWithTitle:root_xiugai_mima_shibai message:root_gaishoujihao_meiyou_zhuce_yonghu cancelButtonTitle:root_Yes];
                    }else if ([jsonObj[@"msg"] intValue]==504) {
                        [self showAlertViewWithTitle:root_xiugai_mima_shibai message:root_xiugai_mima_shibai cancelButtonTitle:root_Yes];
                    }else if ([jsonObj[@"msg"] intValue]==505) {
                        [self showAlertViewWithTitle:root_xiugai_mima_shibai message:root_gaishoujihao_heyanzhengma_bupipei cancelButtonTitle:root_Yes];
                    }
                    
                }
            }
        }
        
    } failure:^(NSError *error) {
           [self hideProgressView];
    }
     ];


}


-(void)registerFrist{
    [self showProgressView];

    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"userName":_PhoneNum} paramarsSite:@"/newLoginAPI.do?op=getUserServerUrl" sucessBlock:^(id content) {
        
        NSLog(@"getUserServerUrl: %@", content);
        if (content) {
            if ([content[@"success"]intValue]==1) {
                NSString *server1=content[@"msg"];
                NSString *server2=@"http://";
                NSString *server=[NSString stringWithFormat:@"%@%@",server2,server1];
                [[UserInfo defaultUserInfo] setServer:server];
                 [self PresentGo];
            }else{
                [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
                  [self PresentGo];
            }
        }else{
            [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
               [self PresentGo];
        }
        
    } failure:^(NSError *error) {
        [[UserInfo defaultUserInfo] setServer:HEAD_URL_Demo];
   [self PresentGo];
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
