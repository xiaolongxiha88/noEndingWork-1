//
//  MixControl.m
//  ShinePhone
//
//  Created by sky on 2017/11/17.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "MixControl.h"
#import "ZJBLStoreShopTypeAlert.h"

@interface MixControl ()
@property(nonatomic,strong)UILabel *textLable;
@property(nonatomic,strong)UILabel *textLable2;
@property(nonatomic,strong)UILabel *textLable3;
@property(nonatomic,strong)UILabel *textLable4;
@property(nonatomic,strong)NSString *choiceValue1;
@property(nonatomic,strong)NSString *choiceValue2;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) NSString *currentDay2;
@property (nonatomic, assign) int dateType;

@end

@implementation MixControl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=MainColor;
    _choiceValue1=@"";
    _choiceValue2=@"";
    if (_setType==0) {
        [self initThree];
    }else{
           [self initUI];
    }
        
 
}

-(void)initUI{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    NSArray*nameArray=@[[NSString stringWithFormat:@"%@:",root_MIX_221],[NSString stringWithFormat:@"%@:",root_MIX_222]];
    float H1=40*HEIGHT_SIZE;
    for (int i=0; i<nameArray.count; i++) {
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT_SIZE+H1*i, 100*NOW_SIZE, 30*HEIGHT_SIZE)];
        lable1.text=nameArray[i];
        lable1.textAlignment=NSTextAlignmentRight;
        lable1.textColor=[UIColor whiteColor];
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [self.view addSubview:lable1];
    }
    
    _textLable=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE, 20*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textLable.text=root_MIX_223;
    _textLable.userInteractionEnabled=YES;
    _textLable.layer.borderWidth=1;
    _textLable.layer.cornerRadius=5;
    _textLable.textAlignment=NSTextAlignmentCenter;
    _textLable.textColor=[UIColor whiteColor];
    _textLable.layer.borderColor=[UIColor whiteColor].CGColor;
    _textLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice1)];
    [_textLable addGestureRecognizer:tapGestureRecognizer1];
    [self.view addSubview:_textLable];
    
    _textLable2=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE, 20*HEIGHT_SIZE+H1, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textLable2.text=root_MIX_223;
    _textLable2.userInteractionEnabled=YES;
    _textLable2.layer.borderWidth=1;
    _textLable2.layer.cornerRadius=5;
    _textLable2.layer.borderColor=[UIColor whiteColor].CGColor;
    _textLable2.textColor=[UIColor whiteColor];
       _textLable2.textAlignment=NSTextAlignmentCenter;
    _textLable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice2)];
    [_textLable2 addGestureRecognizer:tapGestureRecognizer2];
    [self.view addSubview:_textLable2];
    
    [self initTwo];
}

-(void)initTwo{
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"HH:mm"];
   _currentDay = [_dayFormatter stringFromDate:[NSDate date]];
      _currentDay2 = [_dayFormatter stringFromDate:[NSDate date]];
    
    float H=120*HEIGHT_SIZE; float LH=30*HEIGHT_SIZE;
    _textLable3=[[UILabel alloc]initWithFrame:CGRectMake(40*NOW_SIZE, H, 80*NOW_SIZE, LH)];
    _textLable3.text=_currentDay;
    _textLable3.userInteractionEnabled=YES;
    _textLable3.layer.borderWidth=1;
    _textLable3.layer.cornerRadius=5;
    _textLable3.textAlignment=NSTextAlignmentCenter;
    _textLable3.textColor=[UIColor whiteColor];
    _textLable3.layer.borderColor=[UIColor whiteColor].CGColor;
    _textLable3.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice3)];
    [_textLable3 addGestureRecognizer:tapGestureRecognizer1];
    [self.view addSubview:_textLable3];
    
    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(150*NOW_SIZE, H, 20*NOW_SIZE, LH)];
    lable1.text=@"~";
    lable1.textAlignment=NSTextAlignmentCenter;
    lable1.textColor=[UIColor whiteColor];
    lable1.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
    [self.view addSubview:lable1];
    
    _textLable4=[[UILabel alloc]initWithFrame:CGRectMake(200*NOW_SIZE, H, 80*NOW_SIZE, LH)];
    _textLable4.text=_currentDay2;
    _textLable4.userInteractionEnabled=YES;
    _textLable4.layer.borderWidth=1;
    _textLable4.layer.cornerRadius=5;
    _textLable4.layer.borderColor=[UIColor whiteColor].CGColor;
    _textLable4.textColor=[UIColor whiteColor];
    _textLable4.textAlignment=NSTextAlignmentCenter;
    _textLable4.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice4)];
    [_textLable4 addGestureRecognizer:tapGestureRecognizer2];
    [self.view addSubview:_textLable4];
    
    UILabel *lable2=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, H+LH+10*HEIGHT_SIZE, ScreenWidth, 20*HEIGHT_SIZE)];
    lable2.text=@"(20:00 ~ 06:00)";
    lable2.textAlignment=NSTextAlignmentCenter;
    lable2.textColor=[UIColor whiteColor];
    lable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:lable2];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,H+LH+60*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_finish forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
        [goBut addTarget:self action:@selector(finishSet1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
}

-(void)initThree{
  
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT_SIZE, 100*NOW_SIZE, 30*HEIGHT_SIZE)];
        lable1.text=root_MIX_220;
        lable1.textAlignment=NSTextAlignmentRight;
        lable1.textColor=[UIColor whiteColor];
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [self.view addSubview:lable1];
    
    
    _textLable=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE, 20*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textLable.text=root_MIX_223;
    _textLable.userInteractionEnabled=YES;
    _textLable.layer.borderWidth=1;
    _textLable.layer.cornerRadius=5;
    _textLable.textAlignment=NSTextAlignmentCenter;
    _textLable.textColor=[UIColor whiteColor];
    _textLable.layer.borderColor=[UIColor whiteColor].CGColor;
    _textLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice1)];
    [_textLable addGestureRecognizer:tapGestureRecognizer1];
    [self.view addSubview:_textLable];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,80*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_finish forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut addTarget:self action:@selector(finishSet1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
}


-(void)finishSet1{
    NSArray *nameArray=@[@"mix_energy_priority",@"mix_ac_charge_time_period",@"mix_ac_discharge_time_period"];
    NSString*typeName=nameArray[_setType];
    NSString *_param2=@"";  NSString *_param3=@""; NSString *_param4=@""; NSString *_param5=@"";
    if (_setType==1 || _setType==2) {
        NSDate *DATA=[_dayFormatter dateFromString:_currentDay];
          NSDate *DATA1=[_dayFormatter dateFromString:_currentDay2];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH"];
        _param2= [dateFormatter stringFromDate:DATA];
          _param3= [dateFormatter stringFromDate:DATA1];
        [dateFormatter setDateFormat:@"mm"];
        _param4 = [dateFormatter stringFromDate:DATA];
        _param5 = [dateFormatter stringFromDate:DATA1];
    }
    if ([_choiceValue1 isEqualToString:@""]) {
        [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_MIX_225,root_MIX_221]];
        return;
    }
    if ([_choiceValue2 isEqualToString:@""]) {
        [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_MIX_225,root_MIX_222]];
        return;
    }

    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"serialNum":_CnjSN,@"type":typeName,@"param1":_choiceValue2,@"param2":_param2,@"param3":_param3,@"param4":_param4,@"param5":_param5,@"param6":_choiceValue1} paramarsSite:@"/newTcpsetAPI.do?op=mixSetApi" sucessBlock:^(id content) {
        //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"mixSetApi: %@", content1);
        [self hideProgressView];
        
        if (content1) {
            if ([content1[@"success"] integerValue] == 0) {
                if ([content1[@"msg"] integerValue] ==501) {
                    [self showAlertViewWithTitle:nil message:root_xitong_cuoWu cancelButtonTitle:root_Yes];
                    
                }else if ([content1[@"msg"] integerValue] ==502) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_fuwuqi_cuowu cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==503) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_xuliehao_kong cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==504) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_buzaixian cancelButtonTitle:root_Yes];
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


-(void)showTheChoice1{
    [self showTheChoice:1];
}

-(void)showTheChoice2{
        [self showTheChoice:2];
}
-(void)showTheChoice3{
    _dateType=1;
    [self pickDate];
}
-(void)showTheChoice4{
    _dateType=2;
    [self pickDate];
}

-(void)showTheChoice:(int)Type{
    NSArray *choiceArray;
    if (Type==1) {
        choiceArray=@[root_jinzhi,root_shineng];
    }else if (Type==2){
          choiceArray=@[[NSString stringWithFormat:@"%@1",root_MIX_222],[NSString stringWithFormat:@"%@2",root_MIX_222],[NSString stringWithFormat:@"%@3",root_MIX_222]];
    }
    if (_setType==0) {
          choiceArray=@[root_MIX_208,root_MIX_209,root_MIX_210];
    }
    [ZJBLStoreShopTypeAlert showWithTitle:root_MIX_224 titles:choiceArray selectIndex:^(NSInteger SelectIndexNum){
        if (Type==1) {
      _choiceValue1=[NSString stringWithFormat:@"%ld",SelectIndexNum];
        }else if (Type==2){
             _choiceValue2=[NSString stringWithFormat:@"%ld",SelectIndexNum+1];
        }
        
    } selectValue:^(NSString* valueString){
        if (Type==1) {
              _textLable.text=valueString;
        }else if (Type==2){
          _textLable2.text=valueString;
        }
   
    } showCloseButton:YES];
    
}


-(void)pickDate{
    // float buttonSize=70*HEIGHT_SIZE;
    _date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, SCREEN_Height-300*HEIGHT_SIZE, SCREEN_Width, 300*HEIGHT_SIZE)];
    _date.backgroundColor=[UIColor whiteColor];
    _date.datePickerMode=UIDatePickerModeDateAndTime;
    [self.view addSubview:_date];
    
    if (self.toolBar) {
        [UIView animateWithDuration:0.3f animations:^{
            self.toolBar.alpha = 1;
            self.toolBar.frame = CGRectMake(0, SCREEN_Height-300*HEIGHT_SIZE-44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            [self.view addSubview:_toolBar];
        }];
    } else {
        self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_Height-300*HEIGHT_SIZE-44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE)];
        self.toolBar.barStyle = UIBarStyleDefault;
        self.toolBar.barTintColor = MainColor;
        [self.view addSubview:self.toolBar];
        
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(removeToolBar)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(completeSelectDate:)];
        
        UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
        
        spaceButton.tintColor=[UIColor whiteColor];
        doneButton.tintColor=[UIColor whiteColor];
        
        //           [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14*HEIGHT_SIZE],NSFontAttributeName, nil] forState:UIControlStateNormal];
        //
        //        doneButton.tintColor = [UIColor whiteColor];
        self.toolBar.items = @[spaceButton,flexibleitem,doneButton];
    }
    
}

-(void)removeToolBar{
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}


- (void)completeSelectDate:(UIToolbar *)toolBar {
    if (_dateType==1) {
            self.currentDay = [self.dayFormatter stringFromDate:self.date.date];
        _textLable3.text= self.currentDay;
    }
    if (_dateType==2) {
          self.currentDay2 = [self.dayFormatter stringFromDate:self.date.date];
         _textLable3.text= self.currentDay2;
    }


    
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
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
