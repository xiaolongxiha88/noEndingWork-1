//
//  registerViewController.m
//  shinelink
//
//  Created by sky on 16/2/23.
//  Copyright © 2016年 sky. All rights reserved.
//
#define moveHeight 35*HEIGHT_SIZE
#import "registerViewController.h"
#import "loginViewController.h"
#import "countryViewController.h"
#import "AddCellectViewController.h"
#import "protocol.h"

@interface registerViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong)NSMutableArray *textFieldMutableArray;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property(nonatomic,strong)UIScrollView *backScroll;
@property(nonatomic,strong)NSString *customerCodeEnable;
@property(nonatomic,strong)NSString *userEnable;
@end

@implementation registerViewController

- (instancetype)initWithDataDict:(NSMutableDictionary *)dataDict {
    if (self = [super init]) {
        self.dataDic = [NSMutableDictionary dictionaryWithDictionary:dataDict];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=root_register;
    
 [self netServer];
    
    [self initUI];
    //获取本地语言
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *regLanguage = [languages objectAtIndex:0];
    
    if ([regLanguage isEqualToString:@"en-CN"]) {
            [_dataDic setObject:@"en" forKey:@"regLanguage"];
    }else if ([regLanguage isEqualToString:@"zh-Hans-CN"]){
          [_dataDic setObject:@"zh_cn" forKey:@"regLanguage"];
    }else if ([regLanguage isEqualToString:@"fr-CN"]){
        [_dataDic setObject:@"fr" forKey:@"regLanguage"];
    }
    else if ([regLanguage isEqualToString:@"ja-CN"]){
        [_dataDic setObject:@"ja" forKey:@"regLanguage"];
    }
    else if ([regLanguage isEqualToString:@"it-CN"]){
        [_dataDic setObject:@"it" forKey:@"regLanguage"];
    }
    else if ([regLanguage isEqualToString:@"nl-CN"]){
        [_dataDic setObject:@"ho" forKey:@"regLanguage"];
    }
    else if ([regLanguage isEqualToString:@"tr-CN"]){
        [_dataDic setObject:@"tk" forKey:@"regLanguage"];
    }
    else if ([regLanguage isEqualToString:@"pl-CN"]){
        [_dataDic setObject:@"pl" forKey:@"regLanguage"];
    }
    else if ([regLanguage isEqualToString:@"el-CN"]){
        [_dataDic setObject:@"gk" forKey:@"regLanguage"];
    }
    else if ([regLanguage isEqualToString:@"de-CN"]){
        [_dataDic setObject:@"gm" forKey:@"regLanguage"];
    }else{
         [_dataDic setObject:@"en" forKey:@"regLanguage"];
    }
    
 
     //获取时区
    NSTimeZone *regTimeZone1 = [NSTimeZone systemTimeZone];
    NSInteger regTimeZone = [regTimeZone1 secondsFromGMT]/3600;
   
 
    [_dataDic setObject:[NSNumber numberWithInteger:regTimeZone] forKey:@"regTimeZone"];
    //[NSNumber numberWithInt:i
   
}

- (void)netServer
{
   
    //[self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"country":[_dataDic objectForKey:@"regCountry"]} paramarsSite:@"/newLoginAPI.do?op=getServerUrl" sucessBlock:^(id content) {
        
        NSLog(@"getServerUrl: %@", content);
        if (content) {
            if ([content[@"success"]intValue]==1) {
            NSString *server1=content[@"server"];
                 NSString *server2=@"http://";
                NSString *server=[NSString stringWithFormat:@"%@%@",server2,server1];
            [[UserInfo defaultUserInfo] setServer:server];
            }
            if ([content[@"customerCode"] intValue]==1) {
                _customerCodeEnable=@"1";
            }else{
                _customerCodeEnable=@"0";
            }
            
           // _customerCodeEnable=@"1";
            
            if ([_customerCodeEnable isEqualToString:@"0"]) {
                [_textFieldMutableArray[5] removeFromSuperview];
                  UIImageView *image3=[_backScroll viewWithTag:5];
                 UILabel *button3=[_backScroll viewWithTag:15];
                UIView *view3=[_backScroll viewWithTag:25];
                  [image3 removeFromSuperview];
                [button3 removeFromSuperview];
                [view3 removeFromSuperview];
            }
            
        }else{
        _customerCodeEnable=@"0";
            if ([_customerCodeEnable isEqualToString:@"0"]) {
                [_textFieldMutableArray[5] removeFromSuperview];
                UIImageView *image3=[_backScroll viewWithTag:5];
                UILabel *button3=[_backScroll viewWithTag:15];
                UIView *view3=[_backScroll viewWithTag:25];
                [image3 removeFromSuperview];
                [button3 removeFromSuperview];
                [view3 removeFromSuperview];

            }
        }
        
    } failure:^(NSError *error) {
        _customerCodeEnable=@"0";
        if ([_customerCodeEnable isEqualToString:@"0"]) {
            [_textFieldMutableArray[5] removeFromSuperview];
            UIImageView *image3=[_backScroll viewWithTag:5];
            UILabel *button3=[_backScroll viewWithTag:15];
            UIView *view3=[_backScroll viewWithTag:25];
            [image3 removeFromSuperview];
            [button3 removeFromSuperview];
            [view3 removeFromSuperview];

        }
        
    }];
    
   
    
}

-(void)initUI{
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
     _textFieldMutableArray=[NSMutableArray new];
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    _backScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height+60*NOW_SIZE)];
    _backScroll.scrollEnabled=YES;
       _backScroll.contentSize = CGSizeMake(SCREEN_Width,850*HEIGHT_SIZE);
    [self.view addSubview:_backScroll];
    
    NSArray *imageArray=[NSArray arrayWithObjects:@"icon---Name.png", @"icon---Password.png", @"icon---Password.png", @"icon---Email.png", @"iconfont-shouji.png",@"bianhao.png",nil];
    NSArray *labelArray=[NSArray arrayWithObjects:root_yongHuMing, root_Mima, root_chongFu_miMa,root_dianzZiYouJian, root_DianHua, root_daiLiShangBianHao,nil];
    NSArray *textFieldArray=[NSArray arrayWithObjects:root_Enter_your_username,root_Enter_your_pwd, root_chongFu_shuRu_miMa, root_Enter_email, root_Enter_phone_number,root_shuRu_daiLiShangBianHao, nil];
   
    for (int i=0; i<labelArray.count; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,16*HEIGHT_SIZE+i*60*HEIGHT_SIZE+moveHeight,17*NOW_SIZE, 17*HEIGHT_SIZE)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds=YES;
        imageView.image=[UIImage imageNamed:imageArray[i]];
        imageView.tag=i;
        [_backScroll addSubview:imageView];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50*NOW_SIZE,10*HEIGHT_SIZE+i*60*HEIGHT_SIZE+moveHeight, 100*NOW_SIZE, 30*HEIGHT_SIZE)];
        label.text=labelArray[i];
        label.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        label.textColor=[UIColor whiteColor];
        label.tag=10+i;
        [_backScroll addSubview:label];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,40*HEIGHT_SIZE+i*60*HEIGHT_SIZE+moveHeight, 260*NOW_SIZE, 0.5*HEIGHT_SIZE)];
        line.backgroundColor=[UIColor whiteColor];
        line.tag=20+i;
        [_backScroll addSubview:line];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(155*NOW_SIZE,10*HEIGHT_SIZE+i*60*HEIGHT_SIZE+moveHeight, 135*NOW_SIZE, 30*HEIGHT_SIZE)];
        textField.placeholder =textFieldArray[i];
        textField.textColor = [UIColor whiteColor];
        textField.tintColor = [UIColor whiteColor];
        [textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont systemFontOfSize:11*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
        textField.font = [UIFont systemFontOfSize:11*HEIGHT_SIZE];
        textField.tag = i;
        textField.delegate = self;
        [_backScroll addSubview:textField];
         [_textFieldMutableArray addObject:textField];
        if (i == 1|| i == 2) {
            textField.keyboardType = UIKeyboardTypeEmailAddress;
            textField.secureTextEntry = YES;
        }
        if (i == 3) {
            textField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        if (i == 4) {
            textField.keyboardType = UIKeyboardTypeEmailAddress;
        }
    }
    
    
    UIButton *selectButton= [UIButton buttonWithType:UIButtonTypeCustom];
    
      selectButton.frame=CGRectMake(40*NOW_SIZE,362*HEIGHT_SIZE+moveHeight, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE);
    
     [selectButton setBackgroundImage:IMAGE(@"未打勾.png") forState:UIControlStateNormal];
    [selectButton setBackgroundImage:IMAGE(@"打勾.png") forState:UIControlStateSelected];
    [selectButton addTarget:self action:@selector(selectGo:) forControlEvents:UIControlEventTouchUpInside];
     [_backScroll addSubview:selectButton];
    
    UILabel *userOk= [[UILabel alloc] initWithFrame:CGRectMake(80*NOW_SIZE,360*HEIGHT_SIZE+moveHeight, 200*HEIGHT_SIZE, 20*HEIGHT_SIZE)];
    userOk.text=root_yonghu_xieyi;
   userOk.textColor=[UIColor whiteColor];
    userOk.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    userOk.textAlignment = NSTextAlignmentCenter;
    userOk.userInteractionEnabled=YES;
    UITapGestureRecognizer * demo1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GoUsert)];
    [userOk addGestureRecognizer:demo1];
    [_backScroll addSubview:userOk];
    
    UIView *userView= [[UIView alloc] initWithFrame:CGRectMake(80*NOW_SIZE,360*HEIGHT_SIZE+moveHeight+20*HEIGHT_SIZE, 200*HEIGHT_SIZE, 1*HEIGHT_SIZE)];
    userView.backgroundColor=[UIColor whiteColor];
    [_backScroll addSubview:userView];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,400*HEIGHT_SIZE+moveHeight, 200*NOW_SIZE, 40*HEIGHT_SIZE);
//    [goBut.layer setMasksToBounds:YES];
//    [goBut.layer setCornerRadius:25.0];
     [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
      goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_next_go forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(PresentGo) forControlEvents:UIControlEventTouchUpInside];
  //  goBut.highlighted=[UIColor grayColor];
    [_backScroll addSubview:goBut];
    

}


-(void)GoUsert{

    protocol *go=[[protocol alloc]init];
    [self.navigationController pushViewController:go animated:YES];

}

-(void)selectGo:(UIButton*)sender{
    
    if (sender.selected) {
        [sender setSelected:NO];
        _userEnable=@"no";
        
        [sender setImage:[UIImage imageNamed:@"打勾.png"] forState:UIControlStateHighlighted];
        [sender setImage:[UIImage imageNamed:@"没打勾.png"] forState:UIControlStateNormal];
    }else{
        [sender setSelected:YES];
        
        _userEnable=@"ok";
        [sender setImage:[UIImage imageNamed:@"没打勾.png"] forState:UIControlStateHighlighted];
        [sender setImage:[UIImage imageNamed:@"打勾.png"] forState:UIControlStateNormal];
    
    }
    

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
    }
    
    return YES;
}


- (void)showToastViewWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.labelText = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}


//判断是否是正确的email
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



//判断手机号码
//- (BOOL)isValidateTel:(NSString *)tel {
//    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    return [pred evaluateWithObject:tel];
//}


-(void)PresentGo{
    NSArray *array=[[NSArray alloc]initWithObjects:root_Enter_your_username,root_Enter_your_pwd,root_chongFu_shuRu_miMa,root_Enter_email,root_Enter_phone_number,root_shuRu_daiLiShangBianHao,nil];
    for (int i=0; i<array.count-1; i++) {
        if ([[_textFieldMutableArray[i] text] isEqual:@""]) {
            [self showToastViewWithTitle:array[i]];
            return;
        }
    }
    
    if (![_userEnable isEqualToString:@"ok"]) {
        [self showToastViewWithTitle:root_xuanze_yonghu_xieyi];
        return;
    }
    
    if (![[_textFieldMutableArray[1] text] isEqual:[_textFieldMutableArray[2] text] ]) {
        [self showToastViewWithTitle:root_xiangTong_miMa];
        return;
    }
    
    if ([[_textFieldMutableArray[0] text] length]<3) {
        [self showToastViewWithTitle:root_daYu_san];
        return;
    }
    
    if ([[_textFieldMutableArray[1] text] length]<6) {
        [self showToastViewWithTitle:root_daYu_liu];
        return;
    }
    
    if (![self isValidateEmail:[_textFieldMutableArray[3] text]]) {
        [self showToastViewWithTitle:@"请输入正确邮箱格式"];
        return;
    }
//    if (![self isValidateTel:[_textFieldMutableArray[4] text]]) {
//        [self showToastViewWithTitle:@"请输入正确电话"];
//        return;
//    }
    
//    if (!([[_textFieldMutableArray[4] text] length]==11)) {
//        [self showToastViewWithTitle:@"请输入正确电话"];
//        return;
//    }
    
     [_dataDic setObject:[_textFieldMutableArray[0] text] forKey:@"regUserName"];
     [_dataDic setObject:[_textFieldMutableArray[1] text] forKey:@"regPassword"];
     [_dataDic setObject:[_textFieldMutableArray[3] text] forKey:@"regEmail"];
     [_dataDic setObject:[_textFieldMutableArray[4] text] forKey:@"regPhoneNumber"];
      [_dataDic setObject:[_textFieldMutableArray[5] text] forKey:@"agentCode"];
    
    AddCellectViewController *reg=[[AddCellectViewController alloc]initWithDataDict:_dataDic];
    //[self presentViewController:reg animated:YES completion:nil];
   [self. navigationController pushViewController:reg animated:YES];
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
