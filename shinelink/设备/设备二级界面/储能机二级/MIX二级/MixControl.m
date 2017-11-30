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
@property(nonatomic,strong)UILabel *textLable5;
@property(nonatomic,strong)UITextField *fieldOne;
@property(nonatomic,strong)UITextField *fieldTwo;

@property(nonatomic,strong)NSString *choiceValue1;
@property(nonatomic,strong)NSString *choiceValue2;
@property(nonatomic,strong)NSString *choiceValue3;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) NSString *currentDay2;
@property (nonatomic, assign) int dateType;
@property (nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic,strong)NSString *timeValue1;
@property(nonatomic,strong)NSString *timeValue2;
@property(nonatomic,strong)NSString *timeValue3;
@property(nonatomic,strong)NSString *timeValue4;
@property(nonatomic,strong)NSString *timeValue5;
@property(nonatomic,strong)NSString *timeValue6;

@end

@implementation MixControl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=MainColor;
    _choiceValue1=@"";
    _choiceValue2=@"";
    _choiceValue3=@"";

           [self initUI];
    
        
 
}

-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,SCREEN_Height*1.4);
    [self.view addSubview:_scrollView];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    NSArray*nameArray;
    if (_setType==0) {
          nameArray=@[root_MIX_221,root_PCS_fangdian_gonglv,root_MIX_227,[NSString stringWithFormat:@"%@1",root_MIX_222],[NSString stringWithFormat:@"%@2",root_MIX_222],[NSString stringWithFormat:@"%@3",root_MIX_222]];
        
       // @[[NSString stringWithFormat:@"%@1",root_MIX_222],[NSString stringWithFormat:@"%@2",root_MIX_222],[NSString stringWithFormat:@"%@3",root_MIX_222]]
    }else{
          nameArray=@[root_MIX_221,root_CHARGING_POWER,root_MIX_228,[NSString stringWithFormat:@"%@%@",root_5000_ac_chongdian,root_MIX_221],[NSString stringWithFormat:@"%@1",root_MIX_222],[NSString stringWithFormat:@"%@2",root_MIX_222],[NSString stringWithFormat:@"%@3",root_MIX_222]];
    }
  
    float H1=40*HEIGHT_SIZE;
    for (int i=0; i<nameArray.count; i++) {
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT_SIZE+H1*i, 100*NOW_SIZE, 30*HEIGHT_SIZE)];
        lable1.text=[NSString stringWithFormat:@"%@:",nameArray[i]];
        lable1.textAlignment=NSTextAlignmentRight;
        lable1.adjustsFontSizeToFitWidth=YES;
        lable1.textColor=[UIColor whiteColor];
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:lable1];
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
    [_scrollView addSubview:_textLable];
    
//    _textLable2=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE, 20*HEIGHT_SIZE+H1, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
//    _textLable2.text=root_MIX_223;
//    _textLable2.userInteractionEnabled=YES;
//    _textLable2.layer.borderWidth=1;
//    _textLable2.layer.cornerRadius=5;
//    _textLable2.layer.borderColor=[UIColor whiteColor].CGColor;
//    _textLable2.textColor=[UIColor whiteColor];
//       _textLable2.textAlignment=NSTextAlignmentCenter;
//    _textLable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
//    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice2)];
//    [_textLable2 addGestureRecognizer:tapGestureRecognizer2];
//    [_scrollView addSubview:_textLable2];
    
        [self initTwo];
    

          [self initThree];

 
}

-(void)initTwo{
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"HH:mm"];
   _currentDay = [_dayFormatter stringFromDate:[NSDate date]];
      _currentDay2 = [_dayFormatter stringFromDate:[NSDate date]];
    
    float H=120*HEIGHT_SIZE; float LH=30*HEIGHT_SIZE;
    if (_setType==0) {
        H=140*HEIGHT_SIZE;
    }
    if (_setType==1) {
        H=180*HEIGHT_SIZE;
    }
    
    float H1=40*HEIGHT_SIZE;
    

    for (int i=0; i<3; i++) {
        UILabel *timeLable1=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE, H+H1*i, 80*NOW_SIZE, LH)];
        timeLable1.text=_currentDay;
        timeLable1.userInteractionEnabled=YES;
        timeLable1.layer.borderWidth=1;
        timeLable1.layer.cornerRadius=5;
        timeLable1.tag=3000+i;
        timeLable1.textAlignment=NSTextAlignmentCenter;
        timeLable1.textColor=[UIColor whiteColor];
        timeLable1.layer.borderColor=[UIColor whiteColor].CGColor;
        timeLable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice3:)];
        [timeLable1 addGestureRecognizer:tapGestureRecognizer1];
        [_scrollView addSubview:timeLable1];
        
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(200*NOW_SIZE, H+H1*i, 20*NOW_SIZE, LH)];
        lable1.text=@"~";
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.textColor=[UIColor whiteColor];
        lable1.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
        [_scrollView addSubview:lable1];
        
         UILabel *timeLable2=[[UILabel alloc]initWithFrame:CGRectMake(220*NOW_SIZE, H+H1*i, 80*NOW_SIZE, LH)];
        timeLable2.text=_currentDay2;
        timeLable2.userInteractionEnabled=YES;
        timeLable2.layer.borderWidth=1;
        timeLable2.layer.cornerRadius=5;
         timeLable2.tag=4000+i;
        timeLable2.layer.borderColor=[UIColor whiteColor].CGColor;
        timeLable2.textColor=[UIColor whiteColor];
        timeLable2.textAlignment=NSTextAlignmentCenter;
        timeLable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice3:)];
        [timeLable2 addGestureRecognizer:tapGestureRecognizer2];
        [_scrollView addSubview:timeLable2];
    }
    
    
 
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,H+LH+100*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_finish forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
        [goBut addTarget:self action:@selector(finishSet1) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:goBut];
    
}

-(void)initThree{
     float H1=40*HEIGHT_SIZE;
    
    _fieldOne = [[UITextField alloc] initWithFrame:CGRectMake(120*NOW_SIZE, 20*HEIGHT_SIZE+H1*1, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    _fieldOne.textColor = [UIColor whiteColor];
    _fieldOne.tintColor = [UIColor whiteColor];
    _fieldOne.layer.borderWidth=1;
    _fieldOne.layer.cornerRadius=5;
    _fieldOne.layer.borderColor=[UIColor whiteColor].CGColor;
    _fieldOne.textAlignment=NSTextAlignmentCenter;
    [_fieldOne setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_fieldOne setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _fieldOne.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:_fieldOne];
    
    _fieldTwo = [[UITextField alloc] initWithFrame:CGRectMake(120*NOW_SIZE, 20*HEIGHT_SIZE+H1*2, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    _fieldTwo.textColor = [UIColor whiteColor];
    _fieldTwo.tintColor = [UIColor whiteColor];
    _fieldTwo.layer.borderWidth=1;
    _fieldTwo.layer.cornerRadius=5;
    _fieldTwo.layer.borderColor=[UIColor whiteColor].CGColor;
    _fieldTwo.textAlignment=NSTextAlignmentCenter;
    [_fieldTwo setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_fieldTwo setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _fieldTwo.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:_fieldTwo];
    
    _textLable5=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE, 20*HEIGHT_SIZE+H1*3, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textLable5.text=root_MIX_223;
    _textLable5.userInteractionEnabled=YES;
    _textLable5.layer.borderWidth=1;
    _textLable5.layer.cornerRadius=5;
    _textLable5.layer.borderColor=[UIColor whiteColor].CGColor;
    _textLable5.textColor=[UIColor whiteColor];
    _textLable5.textAlignment=NSTextAlignmentCenter;
    _textLable5.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice5)];
    [_textLable5 addGestureRecognizer:tapGestureRecognizer2];
    if (_setType==1) {
          [_scrollView addSubview:_textLable5];
    }
  
    
}

-(void)initFour{
    
}






-(void)finishSet1{
    NSArray *nameArray=@[@"mix_ac_charge_time_period",@"mix_ac_discharge_time_period"];
    NSString*typeName=nameArray[_setType];
    NSString *_param2=@"";  NSString *_param3=@""; NSString *_param4=@""; NSString *_param5=@"";
    if (_setType==1 || _setType==0) {
        NSDate *DATA=[_dayFormatter dateFromString:_currentDay];
          NSDate *DATA1=[_dayFormatter dateFromString:_currentDay2];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH"];
        _param2= [dateFormatter stringFromDate:DATA];
          _param4= [dateFormatter stringFromDate:DATA1];
        [dateFormatter setDateFormat:@"mm"];
        _param3 = [dateFormatter stringFromDate:DATA];
        _param5 = [dateFormatter stringFromDate:DATA1];
    }
    if ([_choiceValue1 isEqualToString:@""]) {
        [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_MIX_225,root_MIX_221]];
        return;
    }
    if (_setType==1) {
        if ([_choiceValue3 isEqualToString:@""]) {
            [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@%@",root_MIX_225,root_5000_ac_chongdian,root_MIX_221]];
            return;
        }
    }
  
    if ([_choiceValue2 isEqualToString:@""]) {
        [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_MIX_225,root_MIX_222]];
        return;
    }
    NSString *param1String,*param2String;
    if ([_fieldOne.text isEqualToString:@""] || _fieldOne.text==nil) {
        param1String=@"";
    }else{
        param1String=_fieldOne.text;
    }
    if ([_fieldTwo.text isEqualToString:@""] || _fieldTwo.text==nil) {
        param2String=@"";
    }else{
        param2String=_fieldTwo.text;
    }

    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"serialNum":_CnjSN,@"type":typeName,@"param1":param1String,@"param2":param2String,@"param3":_choiceValue2,@"param4":_param2,@"param5":_param3,@"param6":_param4,@"param7":_param5,@"param8":_choiceValue1,@"param9":_choiceValue3} paramarsSite:@"/newTcpsetAPI.do?op=mixSetApi" sucessBlock:^(id content) {
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
-(void)showTheChoice5{
    [self showTheChoice:3];
}
-(void)showTheChoice3:(UITapGestureRecognizer*)tag{
    int Tag=(int)tag.view.tag;
    _dateType=Tag;
    [self pickDate];
}


-(void)showTheChoice:(int)Type{
    NSArray *choiceArray;
    if (Type==1 || Type==3) {
        choiceArray=@[root_jinzhi,root_shineng];
    }else if (Type==2){
          choiceArray=@[[NSString stringWithFormat:@"%@1",root_MIX_222],[NSString stringWithFormat:@"%@2",root_MIX_222],[NSString stringWithFormat:@"%@3",root_MIX_222]];
    }
    
//    if (_setType==0) {
//          choiceArray=@[root_MIX_208,root_MIX_209,root_MIX_210];
//    }
    
    [ZJBLStoreShopTypeAlert showWithTitle:root_MIX_224 titles:choiceArray selectIndex:^(NSInteger SelectIndexNum){
        if (Type==1) {
      _choiceValue1=[NSString stringWithFormat:@"%ld",SelectIndexNum];
        }else if (Type==2){
             _choiceValue2=[NSString stringWithFormat:@"%ld",SelectIndexNum+1];
        }else if (Type==3){
            _choiceValue3=[NSString stringWithFormat:@"%ld",SelectIndexNum];
        }
        
    } selectValue:^(NSString* valueString){
        if (Type==1) {
              _textLable.text=valueString;
        }else if (Type==2){
          _textLable2.text=valueString;
        }else if (Type==3){
            _textLable5.text=valueString;
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
    UILabel *timeL=[_scrollView viewWithTag:_dateType];
    timeL.text= [self.dayFormatter stringFromDate:self.date.date];
    
    if (_dateType==3001) {
        _timeValue1=[self.dayFormatter stringFromDate:self.date.date];
    }
    if (_dateType==3002) {
           _timeValue3=[self.dayFormatter stringFromDate:self.date.date];
    }
    if (_dateType==3003) {
        _timeValue5=[self.dayFormatter stringFromDate:self.date.date];
    }
    if (_dateType==4001) {
        _timeValue2=[self.dayFormatter stringFromDate:self.date.date];
    }
    if (_dateType==4002) {
        _timeValue4=[self.dayFormatter stringFromDate:self.date.date];
    }
    if (_dateType==4003) {
        _timeValue6=[self.dayFormatter stringFromDate:self.date.date];
    }
    
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_fieldOne resignFirstResponder];
    [_fieldTwo resignFirstResponder];
 
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
