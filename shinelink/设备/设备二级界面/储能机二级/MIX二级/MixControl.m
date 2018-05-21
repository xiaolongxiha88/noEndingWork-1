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
 @property(nonatomic,strong) NSDictionary *netDic;

@property(nonatomic,strong)NSString *timeEnable1;
@property(nonatomic,strong)NSString *timeEnable2;
@property(nonatomic,strong)NSString *timeEnable3;

@property(nonatomic,strong)NSArray *oldValueArray;
@property (nonatomic, strong)UITextField *textField3;
@property (nonatomic, strong)UITextField *textField4;

@end

@implementation MixControl

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.dayFormatter = [[NSDateFormatter alloc] init];
    self.view.backgroundColor=MainColor;
    self.title=_titleString;
    
    _choiceValue1=@"";
    _choiceValue2=@"";
    _choiceValue3=@"";

        _timeValue1=@"";_timeValue2=@"";_timeValue3=@"";_timeValue4=@"";_timeValue5=@"";_timeValue6=@"";
 
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,SCREEN_Height*1.4);
    [self.view addSubview:_scrollView];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self setOldValueForUI];
    
    if (_setType==0 || _setType==1) {
          [self initUI];
    }else if (_setType==14){
        [self initHighSet];
    }else{
    
        [self initUiZero];
    }
    
    
        
 
}


-(void)initUiZero{
    
    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 20*HEIGHT_SIZE, 300*NOW_SIZE, 30*HEIGHT_SIZE)];
    lable1.text=[NSString stringWithFormat:@"%@:",_titleString];
    lable1.textAlignment=NSTextAlignmentLeft;
    lable1.adjustsFontSizeToFitWidth=YES;
    lable1.textColor=[UIColor whiteColor];
    lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:lable1];
    
    if (_setType==2 || _setType==3 || _setType==5 || _setType==7 || _setType==10 || _setType==11 || _setType==12 || _setType==13) {
        _textLable=[[UILabel alloc]initWithFrame:CGRectMake(70*NOW_SIZE, 60*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    
        _textLable.text=root_MIX_223;
       
        if (![_oldValueArray[0] isEqualToString:@""]) {
            _textLable.text=_oldValueArray[0];
        }
        if (_setType==5) {
            _textLable.frame=CGRectMake(70*NOW_SIZE, 100*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE);
            if (![_oldValueArray[1] isEqualToString:@""]) {
                _textLable.text=_oldValueArray[1];
            }else{
                _textLable.text=root_device_256;
                _choiceValue1=@"over";
            }
        }
        _textLable.userInteractionEnabled=YES;
        _textLable.layer.borderWidth=1;
        _textLable.layer.cornerRadius=5;
        _textLable.textAlignment=NSTextAlignmentCenter;
        _textLable.textColor=[UIColor whiteColor];
        _textLable.layer.borderColor=[UIColor whiteColor].CGColor;
        _textLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        if (_setType==7) {
            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickDate)];
            [_textLable addGestureRecognizer:tapGestureRecognizer1];
        
        }else{
            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice00)];
            [_textLable addGestureRecognizer:tapGestureRecognizer1];
        }
    
        [_scrollView addSubview:_textLable];
        
    }
 
    if (_setType==4 || _setType==5 || _setType==6  || _setType==8 || _setType==9) {
        _fieldOne = [[UITextField alloc] initWithFrame:CGRectMake(70*NOW_SIZE, 60*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        _fieldOne.textColor = [UIColor whiteColor];
        _fieldOne.tintColor = [UIColor whiteColor];
        _fieldOne.layer.borderWidth=1;
        _fieldOne.layer.cornerRadius=5;
        _fieldOne.layer.borderColor=[UIColor whiteColor].CGColor;
        _fieldOne.textAlignment=NSTextAlignmentCenter;
        if (![_oldValueArray[0] isEqualToString:@""]) {
            _fieldOne.text=_oldValueArray[0];
        }
        [_fieldOne setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_fieldOne setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
        _fieldOne.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:_fieldOne];
    }
    
    if (_setType==5 || _setType==4) {
        UILabel *lable22=[[UILabel alloc]initWithFrame:CGRectMake(255*NOW_SIZE, 60*HEIGHT_SIZE, 30*NOW_SIZE, 30*HEIGHT_SIZE)];
        lable22.text=@"%";
        lable22.textAlignment=NSTextAlignmentLeft;
        lable22.adjustsFontSizeToFitWidth=YES;
        lable22.textColor=[UIColor whiteColor];
        lable22.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:lable22];
    }
 
    if (_setType==6) {
        UILabel *lable22=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 92*HEIGHT_SIZE, 300*NOW_SIZE, 20*HEIGHT_SIZE)];
        lable22.text=@"(-0.8 ~ -1)/(0.8 ~ 1)";
        lable22.textAlignment=NSTextAlignmentCenter;
        lable22.adjustsFontSizeToFitWidth=YES;
        lable22.textColor=[UIColor whiteColor];
        lable22.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:lable22];
    }
    
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,140*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    if (_setType==5) {
        goBut.frame=CGRectMake(60*NOW_SIZE,170*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    }
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_finish forState:UIControlStateNormal];
    goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut addTarget:self action:@selector(finishSet1) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:goBut];
}


-(void)initUI{

    NSArray*nameArray;
    if (_setType==0) {
          nameArray=@[root_PCS_fangdian_gonglv,root_MIX_227,[NSString stringWithFormat:@"%@1",root_MIX_222],[NSString stringWithFormat:@"%@2",root_MIX_222],[NSString stringWithFormat:@"%@3",root_MIX_222]];
        
       // @[[NSString stringWithFormat:@"%@1",root_MIX_222],[NSString stringWithFormat:@"%@2",root_MIX_222],[NSString stringWithFormat:@"%@3",root_MIX_222]]
    }else{
          nameArray=@[root_CHARGING_POWER,root_MIX_228,[NSString stringWithFormat:@"%@%@",root_5000_ac_chongdian,root_MIX_221],[NSString stringWithFormat:@"%@1",root_MIX_222],[NSString stringWithFormat:@"%@2",root_MIX_222],[NSString stringWithFormat:@"%@3",root_MIX_222]];
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
    
//    _textLable=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE, 20*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
//    _textLable.text=root_MIX_223;
//    _textLable.userInteractionEnabled=YES;
//    _textLable.layer.borderWidth=1;
//    _textLable.layer.cornerRadius=5;
//    _textLable.textAlignment=NSTextAlignmentCenter;
//    _textLable.textColor=[UIColor whiteColor];
//    _textLable.layer.borderColor=[UIColor whiteColor].CGColor;
//    _textLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
//    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice1)];
//    [_textLable addGestureRecognizer:tapGestureRecognizer1];
//    [_scrollView addSubview:_textLable];
    
    _timeEnable1=@"1";
    _timeEnable2=@"1";
    _timeEnable3=@"1";
    
        [self initTwo];
    

          [self initThree];

 
}

-(void)initTwo{
   
    [self.dayFormatter setDateFormat:@"HH:mm"];
   _currentDay = [_dayFormatter stringFromDate:[NSDate date]];
      _currentDay2 = [_dayFormatter stringFromDate:[NSDate date]];
    
    float H=120*HEIGHT_SIZE; float LH=30*HEIGHT_SIZE;
    if (_setType==0) {
        H=100*HEIGHT_SIZE;
    }
    if (_setType==1) {
        H=140*HEIGHT_SIZE;
    }
    
    float H1=40*HEIGHT_SIZE;
    
    float W=60*HEIGHT_SIZE;
    for (int i=0; i<3; i++) {
        UILabel *timeLable1=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE, H+H1*i, W, LH)];
        timeLable1.text=root_MIX_223;
        timeLable1.adjustsFontSizeToFitWidth=YES;
        timeLable1.userInteractionEnabled=YES;
        timeLable1.layer.borderWidth=1;
        timeLable1.layer.cornerRadius=5;
        timeLable1.tag=3000+i;
        if (_setType==0) {
            if (![_oldValueArray[2+i] isEqualToString:@""]) {
                timeLable1.text=_oldValueArray[2+i];
            }
        }
        if (_setType==1) {
            if (![_oldValueArray[3+i] isEqualToString:@""]) {
                timeLable1.text=_oldValueArray[3+i];
            }
        }
        timeLable1.textAlignment=NSTextAlignmentCenter;
        timeLable1.textColor=[UIColor whiteColor];
        timeLable1.layer.borderColor=[UIColor whiteColor].CGColor;
        timeLable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice3:)];
        [timeLable1 addGestureRecognizer:tapGestureRecognizer1];
        [_scrollView addSubview:timeLable1];
        
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE+W, H+H1*i, 20*NOW_SIZE, LH)];
        lable1.text=@"~";
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.textColor=[UIColor whiteColor];
        lable1.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
        [_scrollView addSubview:lable1];
        
         UILabel *timeLable2=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE+W+20*NOW_SIZE, H+H1*i, W, LH)];
        timeLable2.text=root_MIX_223;
        if (_setType==0) {
            if (![_oldValueArray[5+i] isEqualToString:@""]) {
                timeLable2.text=_oldValueArray[5+i];
            }
        }
        if (_setType==1) {
            if (![_oldValueArray[6+i] isEqualToString:@""]) {
                timeLable2.text=_oldValueArray[6+i];
            }
        }
          timeLable2.adjustsFontSizeToFitWidth=YES;
        timeLable2.userInteractionEnabled=YES;
        timeLable2.layer.borderWidth=1;
        timeLable2.layer.cornerRadius=5;
         timeLable2.tag=4000+i;
        timeLable2.layer.borderColor=[UIColor whiteColor].CGColor;
        timeLable2.textColor=[UIColor whiteColor];
        timeLable2.textAlignment=NSTextAlignmentCenter;
        timeLable2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChoice3:)];
        [timeLable2 addGestureRecognizer:tapGestureRecognizer2];
        [_scrollView addSubview:timeLable2];
        
        UILabel *enableLable2=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE+W*2+20*NOW_SIZE+5*NOW_SIZE, H+H1*i, 45*NOW_SIZE, LH)];
        enableLable2.text=root_shineng;
        enableLable2.adjustsFontSizeToFitWidth=YES;
        enableLable2.userInteractionEnabled=YES;
        enableLable2.layer.borderWidth=1;
        enableLable2.layer.cornerRadius=5;
        enableLable2.tag=5000+i;
        enableLable2.layer.borderColor=[UIColor whiteColor].CGColor;
        enableLable2.textColor=[UIColor whiteColor];
        enableLable2.textAlignment=NSTextAlignmentCenter;
        enableLable2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        UITapGestureRecognizer *tapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showEnable:)];
        [enableLable2 addGestureRecognizer:tapGestureRecognizer3];
        [_scrollView addSubview:enableLable2];
        
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
    
    _fieldOne = [[UITextField alloc] initWithFrame:CGRectMake(120*NOW_SIZE, 20*HEIGHT_SIZE+H1*0, 165*NOW_SIZE, 30*HEIGHT_SIZE)];
    _fieldOne.textColor = [UIColor whiteColor];
    _fieldOne.tintColor = [UIColor whiteColor];
    _fieldOne.layer.borderWidth=1;
    _fieldOne.layer.cornerRadius=5;
    _fieldOne.layer.borderColor=[UIColor whiteColor].CGColor;
    _fieldOne.textAlignment=NSTextAlignmentCenter;
    if (![_oldValueArray[0] isEqualToString:@""]) {
        _fieldOne.text=_oldValueArray[0];
    }
    [_fieldOne setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_fieldOne setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _fieldOne.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:_fieldOne];
    
    UILabel *lable23=[[UILabel alloc]initWithFrame:CGRectMake(290*NOW_SIZE, 20*HEIGHT_SIZE+H1*0, 30*NOW_SIZE, 30*HEIGHT_SIZE)];
    lable23.text=@"%";
    lable23.textAlignment=NSTextAlignmentLeft;
    lable23.adjustsFontSizeToFitWidth=YES;
    lable23.textColor=[UIColor whiteColor];
    lable23.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:lable23];
    
    _fieldTwo = [[UITextField alloc] initWithFrame:CGRectMake(120*NOW_SIZE, 20*HEIGHT_SIZE+H1*1, 165*NOW_SIZE, 30*HEIGHT_SIZE)];
    _fieldTwo.textColor = [UIColor whiteColor];
    _fieldTwo.tintColor = [UIColor whiteColor];
    _fieldTwo.layer.borderWidth=1;
    _fieldTwo.layer.cornerRadius=5;
    _fieldTwo.layer.borderColor=[UIColor whiteColor].CGColor;
    _fieldTwo.textAlignment=NSTextAlignmentCenter;
    if (![_oldValueArray[1] isEqualToString:@""]) {
        _fieldTwo.text=_oldValueArray[1];
    }
    [_fieldTwo setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_fieldTwo setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _fieldTwo.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:_fieldTwo];
    
    UILabel *lable24=[[UILabel alloc]initWithFrame:CGRectMake(290*NOW_SIZE, 20*HEIGHT_SIZE+H1*1, 30*NOW_SIZE, 30*HEIGHT_SIZE)];
    lable24.text=@"%";
    lable24.textAlignment=NSTextAlignmentLeft;
    lable24.adjustsFontSizeToFitWidth=YES;
    lable24.textColor=[UIColor whiteColor];
    lable24.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:lable24];
    
    _textLable5=[[UILabel alloc]initWithFrame:CGRectMake(120*NOW_SIZE, 20*HEIGHT_SIZE+H1*2, 190*NOW_SIZE, 30*HEIGHT_SIZE)];
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
        if (![_oldValueArray[2] isEqualToString:@""]) {
            _textLable5.text=_oldValueArray[2];
        }
          [_scrollView addSubview:_textLable5];
    }
  
    
}


-(void)initHighSet{
    
    if(_setType==14){
        NSArray *ossLableName=[NSArray arrayWithObjects:@"寄存器:",@"值:", nil];
        for (int i=0; i<ossLableName.count; i++) {
            UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE,  40*HEIGHT_SIZE+50*HEIGHT_SIZE*i, 100*NOW_SIZE,30*HEIGHT_SIZE )];
            PVData.text=ossLableName[i];
            PVData.textAlignment=NSTextAlignmentRight;
            PVData.textColor=[UIColor whiteColor];
            PVData.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
            PVData.adjustsFontSizeToFitWidth=YES;
            [_scrollView addSubview:PVData];
        }
        
        _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(112*NOW_SIZE, 40*HEIGHT_SIZE, 150*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textField3.layer.borderWidth=1;
        _textField3.layer.cornerRadius=5;
        _textField3.layer.borderColor=[UIColor whiteColor].CGColor;
        _textField3.textColor = [UIColor whiteColor];
        _textField3.tintColor = [UIColor whiteColor];
        _textField3.textAlignment=NSTextAlignmentCenter;
        _textField3.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [_scrollView addSubview:_textField3];
        
        _textField4 = [[UITextField alloc] initWithFrame:CGRectMake(112*NOW_SIZE, 90*HEIGHT_SIZE, 150*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textField4.layer.borderWidth=1;
        _textField4.layer.cornerRadius=5;
        _textField4.layer.borderColor=[UIColor whiteColor].CGColor;
        _textField4.textColor = [UIColor whiteColor];
        _textField4.tintColor = [UIColor whiteColor];
        _textField4.textAlignment=NSTextAlignmentCenter;
        _textField4.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [_scrollView addSubview:_textField4];
        
        UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
        goBut.frame=CGRectMake(60*NOW_SIZE,170*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
       
        [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
        [goBut setTitle:root_finish forState:UIControlStateNormal];
        goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
        [goBut addTarget:self action:@selector(finishSet1) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:goBut];
        
    }
    

}

-(void)showEnable:(UITapGestureRecognizer*)tag{
    int Tag=(int)tag.view.tag-5000;
 
   NSArray* choiceArray=@[root_shineng,root_jinzhi];
    [ZJBLStoreShopTypeAlert showWithTitle:root_MIX_224 titles:choiceArray selectIndex:^(NSInteger SelectIndexNum){
        if (SelectIndexNum==0) {
            if (Tag==0) {
                _timeEnable1=@"1";
            }else if (Tag==1) {
                _timeEnable2=@"1";
            }else if (Tag==2) {
                _timeEnable3=@"1";
            }
        }
        
        if (SelectIndexNum==1) {
            if (Tag==0) {
                _timeEnable1=@"0";
            }else if (Tag==1) {
                   _timeEnable2=@"0";
            }else if (Tag==2) {
                   _timeEnable3=@"0";
            }
        }
     
    } selectValue:^(NSString* valueString){
        _textLable.text=valueString;
    } showCloseButton:YES];
    
}

-(void)finishSet1{
    if ([_controlType isEqualToString:@"2"]) {
        [self finishSet2];
    }else{
          [self finishSet0];
    }
}

-(void)finishSet0{
    
    NSArray *nameArray=@[@"mix_ac_discharge_time_period",@"mix_ac_charge_time_period",@"pv_on_off",@"pv_pf_cmd_memory_state",@"pv_active_p_rate",@"pv_reactive_p_rate",@"pv_power_factor",@"pf_sys_year",@"pv_grid_voltage_high",@"pv_grid_voltage_low",@"mix_off_grid_enable",@"mix_ac_discharge_frequency",@"mix_ac_discharge_voltage",@"backflow_setting"];
    NSString*typeName=nameArray[_setType];
    
     if (_setType==2 || _setType==3 || _setType==7 || _setType==10 || _setType==11 || _setType==12 || _setType==13) {
         if ([_choiceValue1 isEqualToString:@""] || _choiceValue1==nil) {
             [self showToastViewWithTitle:root_device_257];
             return;
         }
         _netDic=@{@"serialNum":_CnjSN,@"type":typeName,@"param1":_choiceValue1};
     }
    
    if (_setType==4 || _setType==6  || _setType==8 || _setType==9) {
        _choiceValue1=_fieldOne.text;
        if ([_choiceValue1 isEqualToString:@""] || _choiceValue1==nil) {
            [self showToastViewWithTitle:root_device_257];
            return;
        }
        _netDic=@{@"serialNum":_CnjSN,@"type":typeName,@"param1":_choiceValue1};
    }
    
    if (_setType==5) {
        NSString *value2=_fieldOne.text;
        if ([value2 isEqualToString:@""] || value2==nil) {
            [self showToastViewWithTitle:root_device_257];
            return;
        }
           _netDic=@{@"serialNum":_CnjSN,@"type":typeName,@"param1":value2,@"param2":_choiceValue1};
    }
    
    NSArray *timeValueArray=@[_timeValue1,_timeValue2,_timeValue3,_timeValue4,_timeValue5,_timeValue6];

    NSMutableArray *timeValueArrayTwo=[NSMutableArray new];
    
    
    if (_setType==1 || _setType==0) {
        for (int i=0; i<3; i++) {
            NSString *valueOne=timeValueArray[2*i];
             NSString *valueTwo=timeValueArray[2*i+1];
            if ((![valueOne isEqualToString:@""]) && (![valueTwo isEqualToString:@""])) {
                NSDate *DATA=[_dayFormatter dateFromString:valueOne];
                NSDate *DATA1=[_dayFormatter dateFromString:valueTwo];
                NSDateFormatter *dateFormatterH = [[NSDateFormatter alloc] init];
                   NSDateFormatter *dateFormatterM = [[NSDateFormatter alloc] init];
                [dateFormatterH setDateFormat:@"HH"];
                [dateFormatterM setDateFormat:@"mm"];
                [timeValueArrayTwo addObject:[dateFormatterH stringFromDate:DATA]];
                    [timeValueArrayTwo addObject:[dateFormatterM stringFromDate:DATA]];
                [timeValueArrayTwo addObject:[dateFormatterH stringFromDate:DATA1]];
                [timeValueArrayTwo addObject:[dateFormatterM stringFromDate:DATA1]];
                
            }else{
                if (([valueOne isEqualToString:@""]) && ([valueTwo isEqualToString:@""])) {
                    [timeValueArrayTwo addObject:@""];
                    [timeValueArrayTwo addObject:@""];
                      [timeValueArrayTwo addObject:@""];
                      [timeValueArrayTwo addObject:@""];
                }else{
                    [self showToastViewWithTitle:root_device_258];
                    return;
                }
                
            }
        
        }

        if (_setType==1) {
            if ([_choiceValue3 isEqualToString:@""]) {
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@%@",root_MIX_225,root_5000_ac_chongdian,root_MIX_221]];
                return;
            }
        }
        
    }


  
    
    NSString *param1String,*param2String;
    if (_setType==0 || _setType==1){
        if ([_fieldOne.text isEqualToString:@""] || _fieldOne.text==nil) {
            if (_setType==0) {
                 [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_device_255,root_PCS_fangdian_gonglv]];
            }else{
                          [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_device_255,root_CHARGING_POWER]];
            }
           
            return;
        }else{
            param1String=_fieldOne.text;
        }
        if ([_fieldTwo.text isEqualToString:@""] || _fieldTwo.text==nil) {
            if (_setType==0) {
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_device_255,root_MIX_227]];
            }else{
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_device_255,root_MIX_228]];
            }
          return;
        }else{
            param2String=_fieldTwo.text;
        }
        
    }

    if (_setType==0) { _netDic=@{@"serialNum":_CnjSN,@"type":typeName,@"param1":param1String,@"param2":param2String,@"param3":timeValueArrayTwo[0],@"param4":timeValueArrayTwo[1],@"param5":timeValueArrayTwo[2],@"param6":timeValueArrayTwo[3],@"param7":_timeEnable1,@"param8":timeValueArrayTwo[4],@"param9":timeValueArrayTwo[5],@"param10":timeValueArrayTwo[6],@"param11":timeValueArrayTwo[7],@"param12":_timeEnable2,@"param13":timeValueArrayTwo[8],@"param14":timeValueArrayTwo[9],@"param15":timeValueArrayTwo[10],@"param16":timeValueArrayTwo[11],@"param17":_timeEnable3};
    }
    
    if (_setType==1) { _netDic=@{@"serialNum":_CnjSN,@"type":typeName,@"param1":param1String,@"param2":param2String,@"param3":_choiceValue3,@"param4":timeValueArrayTwo[0],@"param5":timeValueArrayTwo[1],@"param6":timeValueArrayTwo[2],@"param7":timeValueArrayTwo[3],@"param8":_timeEnable1,@"param9":timeValueArrayTwo[4],@"param10":timeValueArrayTwo[5],@"param11":timeValueArrayTwo[6],@"param12":timeValueArrayTwo[7],@"param13":_timeEnable2,@"param14":timeValueArrayTwo[8],@"param15":timeValueArrayTwo[9],@"param16":timeValueArrayTwo[10],@"param17":timeValueArrayTwo[11],@"param18":_timeEnable3};
    }
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:_netDic paramarsSite:@"/newTcpsetAPI.do?op=mixSetApiNew" sucessBlock:^(id content) {

        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"mixSetApiNew: %@", content1);
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
                }else if ([content1[@"msg"] integerValue] ==510) {
                    [self showAlertViewWithTitle:nil message:root_device_246 cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==511) {
                    [self showAlertViewWithTitle:nil message:root_device_247 cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==512) {
                    [self showAlertViewWithTitle:nil message:root_device_248 cancelButtonTitle:root_Yes];
                }else if ([content1[@"msg"] integerValue] ==701) {
                    [self showAlertViewWithTitle:nil message:root_meiyou_quanxian cancelButtonTitle:root_Yes];
                }else{
                     [self showAlertViewWithTitle:nil message:[NSString stringWithFormat:@"%@(%@)",root_xitong_cuoWu,content1[@"msg"]] cancelButtonTitle:root_Yes];
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



-(void)finishSet2{
    
    NSArray *nameArray=@[@"mix_ac_discharge_time_period",@"mix_ac_charge_time_period",@"pv_on_off",@"pv_pf_cmd_memory_state",@"pv_active_p_rate",@"pv_reactive_p_rate",@"pv_power_factor",@"pf_sys_year",@"pv_grid_voltage_high",@"pv_grid_voltage_low",@"mix_off_grid_enable",@"mix_ac_discharge_frequency",@"mix_ac_discharge_voltage",@"backflow_setting",@"set_any_reg"];
    NSString*typeName=nameArray[_setType];
    
    if (_setType==2 || _setType==3 || _setType==7 || _setType==10 || _setType==11 || _setType==12 || _setType==13) {
        if ([_choiceValue1 isEqualToString:@""] || _choiceValue1==nil) {
            [self showToastViewWithTitle:root_device_257];
            return;
        }
        _netDic=@{@"serverId":_serverId,@"deviceSn":_CnjSN,@"type":typeName,@"param1":_choiceValue1};
    }
    
    if (_setType==4 || _setType==6  || _setType==8 || _setType==9) {
        _choiceValue1=_fieldOne.text;
        if ([_choiceValue1 isEqualToString:@""] || _choiceValue1==nil) {
            [self showToastViewWithTitle:root_device_257];
            return;
        }
        _netDic=@{@"serverId":_serverId,@"deviceSn":_CnjSN,@"type":typeName,@"param1":_choiceValue1};
    }
    
    if (_setType==5) {
        NSString *value2=_fieldOne.text;
        if ([value2 isEqualToString:@""] || value2==nil) {
            [self showToastViewWithTitle:root_device_257];
            return;
        }
        _netDic=@{@"serverId":_serverId,@"deviceSn":_CnjSN,@"type":typeName,@"param1":value2,@"param2":_choiceValue1};
    }
    
    NSArray *timeValueArray=@[_timeValue1,_timeValue2,_timeValue3,_timeValue4,_timeValue5,_timeValue6];
    
    NSMutableArray *timeValueArrayTwo=[NSMutableArray new];
    
    
    if (_setType==1 || _setType==0) {
        for (int i=0; i<3; i++) {
            NSString *valueOne=timeValueArray[2*i];
            NSString *valueTwo=timeValueArray[2*i+1];
            if ((![valueOne isEqualToString:@""]) && (![valueTwo isEqualToString:@""])) {
                NSDate *DATA=[_dayFormatter dateFromString:valueOne];
                NSDate *DATA1=[_dayFormatter dateFromString:valueTwo];
                NSDateFormatter *dateFormatterH = [[NSDateFormatter alloc] init];
                NSDateFormatter *dateFormatterM = [[NSDateFormatter alloc] init];
                [dateFormatterH setDateFormat:@"HH"];
                [dateFormatterM setDateFormat:@"mm"];
                [timeValueArrayTwo addObject:[dateFormatterH stringFromDate:DATA]];
                [timeValueArrayTwo addObject:[dateFormatterM stringFromDate:DATA]];
                [timeValueArrayTwo addObject:[dateFormatterH stringFromDate:DATA1]];
                [timeValueArrayTwo addObject:[dateFormatterM stringFromDate:DATA1]];
                
            }else{
                if (([valueOne isEqualToString:@""]) && ([valueTwo isEqualToString:@""])) {
                    [timeValueArrayTwo addObject:@""];
                    [timeValueArrayTwo addObject:@""];
                    [timeValueArrayTwo addObject:@""];
                    [timeValueArrayTwo addObject:@""];
                }else{
                    [self showToastViewWithTitle:root_device_258];
                    return;
                }
                
            }
            
        }
        
        if (_setType==1) {
            if ([_choiceValue3 isEqualToString:@""]) {
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@%@",root_MIX_225,root_5000_ac_chongdian,root_MIX_221]];
                return;
            }
        }
        
    }
    
    
    if (_setType==14) {
        NSString *textValue;
        NSString *textValue1;
        if (_textField3.text==nil || [_textField3.text isEqualToString:@""]) {
            [self showToastViewWithTitle:@"请输入寄存器"];
            return;
        }else{
                textValue= [NSString stringWithFormat:@"%d",[[_textField3 text] intValue]];
        }
        if (_textField4.text==nil || [_textField4.text isEqualToString:@""]) {
            [self showToastViewWithTitle:@"请输入设置值"];
            return;
        }else{
               textValue1= [NSString stringWithFormat:@"%d",[[_textField4 text] intValue]];
        }

           _netDic=@{@"serverId":_serverId,@"deviceSn":_CnjSN,@"type":typeName,@"param1":textValue,@"param2":textValue1};

     
    }
    
    
    NSString *param1String,*param2String;
    if (_setType==0 || _setType==1){
        if ([_fieldOne.text isEqualToString:@""] || _fieldOne.text==nil) {
            if (_setType==0) {
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_device_255,root_PCS_fangdian_gonglv]];
            }else{
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_device_255,root_CHARGING_POWER]];
            }
            
            return;
        }else{
            param1String=_fieldOne.text;
        }
        if ([_fieldTwo.text isEqualToString:@""] || _fieldTwo.text==nil) {
            if (_setType==0) {
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_device_255,root_MIX_227]];
            }else{
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@",root_device_255,root_MIX_228]];
            }
            return;
        }else{
            param2String=_fieldTwo.text;
        }
        
    }
    
    if (_setType==0) { _netDic=@{@"serverId":_serverId,@"deviceSn":_CnjSN,@"type":typeName,@"param1":param1String,@"param2":param2String,@"param3":timeValueArrayTwo[0],@"param4":timeValueArrayTwo[1],@"param5":timeValueArrayTwo[2],@"param6":timeValueArrayTwo[3],@"param7":_timeEnable1,@"param8":timeValueArrayTwo[4],@"param9":timeValueArrayTwo[5],@"param10":timeValueArrayTwo[6],@"param11":timeValueArrayTwo[7],@"param12":_timeEnable2,@"param13":timeValueArrayTwo[8],@"param14":timeValueArrayTwo[9],@"param15":timeValueArrayTwo[10],@"param16":timeValueArrayTwo[11],@"param17":_timeEnable3};
    }
    
    if (_setType==1) { _netDic=@{@"serverId":_serverId,@"deviceSn":_CnjSN,@"type":typeName,@"param1":param1String,@"param2":param2String,@"param3":_choiceValue3,@"param4":timeValueArrayTwo[0],@"param5":timeValueArrayTwo[1],@"param6":timeValueArrayTwo[2],@"param7":timeValueArrayTwo[3],@"param8":_timeEnable1,@"param9":timeValueArrayTwo[4],@"param10":timeValueArrayTwo[5],@"param11":timeValueArrayTwo[6],@"param12":timeValueArrayTwo[7],@"param13":_timeEnable2,@"param14":timeValueArrayTwo[8],@"param15":timeValueArrayTwo[9],@"param16":timeValueArrayTwo[10],@"param17":timeValueArrayTwo[11],@"param18":_timeEnable3};
    }
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:_netDic paramarsSite:@"/api/v3/device/mixManage/set" sucessBlock:^(id content) {
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v3/device/mixManage/set: %@", content1);
        [self hideProgressView];
        
        if (content1) {
            if ([content1[@"result"] integerValue] != 1) {
                if ([content1[@"result"] integerValue] == 2) {
                    [self showToastViewWithTitle:@"参数为空"];
                }else if ([content1[@"result"] integerValue] == 3) {
                      [self showToastViewWithTitle:@"操作失败"];
                }else if ([content1[@"result"] integerValue] ==4) {
                         [self showToastViewWithTitle:@"网络超时"];
                }else{
                        [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",content1[@"msg"]]];
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



-(void)showTheChoice00{
     NSArray *choiceArray;
    if (_setType==2 || _setType==3 || _setType==5 || _setType==10 || _setType==11 || _setType==12 || _setType==13) {}
    
        if (_setType==2) {
            choiceArray=@[root_CNJ_guanji,root_CNJ_kaiji];
        }
    if (_setType==3) {
        choiceArray=@[root_guan,root_kai];
    }
    if (_setType==5) {
        choiceArray=@[root_device_256,root_device_259];
    }
    if (_setType==10) {
        choiceArray=@[root_jinzhi,root_shineng];
    }
    if (_setType==11) {
        choiceArray=@[@"50Hz",@"60Hz"];
    }
    if (_setType==12) {
        choiceArray=@[@"230Hz",@"208Hz",@"240Hz"];
    }
    if (_setType==13) {
        choiceArray=@[root_guan,root_kai];
    }
    
    [ZJBLStoreShopTypeAlert showWithTitle:root_MIX_224 titles:choiceArray selectIndex:^(NSInteger SelectIndexNum){
        
 _choiceValue1=[NSString stringWithFormat:@"%ld",SelectIndexNum];
        if (_setType==2) {
            if (SelectIndexNum==0) {
                _choiceValue1=@"0000";
            }else{
                _choiceValue1=@"0101";
            }
        }
        if (_setType==5) {
            if (SelectIndexNum==0) {
                _choiceValue1=@"over";
            }else{
                _choiceValue1=@"under";
            }
        }
    } selectValue:^(NSString* valueString){
  _textLable.text=valueString;
    } showCloseButton:YES];
    
}


-(void)setOldValueForUI{
    _oldValueArray=@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    if (_getOldDic.allKeys.count>0) {
        if (_setType==0) {
            _timeValue1=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedDischargeTimeStart1"]];
                _timeValue3=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedDischargeTimeStart2"]];
                _timeValue5=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedDischargeTimeStart3"]];
            _timeValue2=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedDischargeTimeStop1"]];
            _timeValue4=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedDischargeTimeStop2"]];
            _timeValue6=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedDischargeTimeStop3"]];
            _oldValueArray=@[[NSString stringWithFormat:@"%@",_getOldDic[@"disChargePowerCommand"]],[NSString stringWithFormat:@"%@",_getOldDic[@"wdisChargeSOCLowLimit2"]],_timeValue1,_timeValue3,_timeValue5,_timeValue2,_timeValue4,_timeValue6];
        }
        if (_setType==1) {
            _timeValue1=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedChargeTimeStart1"]];
            _timeValue3=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedChargeTimeStart2"]];
            _timeValue5=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedChargeTimeStart3"]];
            _timeValue2=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedChargeTimeStop1"]];
            _timeValue4=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedChargeTimeStop2"]];
            _timeValue6=[NSString stringWithFormat:@"%@",_getOldDic[@"forcedChargeTimeStop3"]];
            NSString *valueString=[NSString stringWithFormat:@"%@",_getOldDic[@"acChargeEnable"]];
            _choiceValue3=valueString;
            if ([valueString isEqualToString:@"0"]) {
                valueString=root_jinzhi;
            }
            if ([valueString isEqualToString:@"1"]) {
                  valueString=root_shineng;
            }
            
            _oldValueArray=@[[NSString stringWithFormat:@"%@",_getOldDic[@"chargePowerCommand"]],[NSString stringWithFormat:@"%@",_getOldDic[@"wchargeSOCLowLimit2"]],
                             valueString,_timeValue1,_timeValue3,_timeValue5,_timeValue2,_timeValue4,_timeValue6];
        }
        
        if (_setType==2) {
            NSString *valueString=[NSString stringWithFormat:@"%@",_getOldDic[@"pv_on_off"]];
                           _choiceValue1=valueString;
            if ([valueString isEqualToString:@"0101"]) {
                      _oldValueArray=@[root_CNJ_kaiji];
            }
            if ([valueString isEqualToString:@"0000"]) {
                _oldValueArray=@[root_CNJ_guanji];
            }
        }
        if (_setType==3 || _setType==13) {
            NSString *valueString;
            if (_setType==3) {
                    valueString=[NSString stringWithFormat:@"%@",_getOldDic[@"pv_pf_cmd_memory_state"]];
            }
            if (_setType==13) {
                   valueString=[NSString stringWithFormat:@"%@",_getOldDic[@"backflow_setting"]];
            }
              _choiceValue1=valueString;
            if ([valueString isEqualToString:@"0"]) {
                _oldValueArray=@[root_guan];
            }
            if ([valueString isEqualToString:@"1"]) {
                _oldValueArray=@[root_kai];
            }
        }
        
        if (_setType==4) {
              _oldValueArray=@[[NSString stringWithFormat:@"%@",_getOldDic[@"pv_active_p_rate"]]];
        }
        if (_setType==5) {
            NSString *valueString=[NSString stringWithFormat:@"%@",_getOldDic[@"pv_reactive_p_rate_two"]];
              _choiceValue1=valueString;
            if ([valueString isEqualToString:@"over"]) {
                  _oldValueArray=@[[NSString stringWithFormat:@"%@",_getOldDic[@"pv_reactive_p_rate"]],root_device_256];
            }
            if ([valueString isEqualToString:@"under"]) {
             _oldValueArray=@[[NSString stringWithFormat:@"%@",_getOldDic[@"pv_reactive_p_rate"]],root_device_259];
            }
        }
        if (_setType==6) {
            _oldValueArray=@[[NSString stringWithFormat:@"%@",_getOldDic[@"pv_power_factor"]]];
        }
        if (_setType==7) {
            _oldValueArray=@[[NSString stringWithFormat:@"%@",_getOldDic[@"pf_sys_year"]]];
        }
        if (_setType==8) {
            _oldValueArray=@[[NSString stringWithFormat:@"%@",_getOldDic[@"pv_grid_voltage_high"]]];
        }
        if (_setType==9) {
            _oldValueArray=@[[NSString stringWithFormat:@"%@",_getOldDic[@"pv_grid_voltage_low"]]];
        }
        if (_setType==10) {
            NSString *valueString=[NSString stringWithFormat:@"%@",_getOldDic[@"mix_off_grid_enable"]];
                _choiceValue1=valueString;
            if ([valueString isEqualToString:@"0"]) {
                _oldValueArray=@[root_jinzhi];
            }
            if ([valueString isEqualToString:@"1"]) {
                _oldValueArray=@[root_shineng];
            }
        }
        if (_setType==11) {
            NSString *valueString=[NSString stringWithFormat:@"%@",_getOldDic[@"mix_ac_discharge_frequency"]];
                _choiceValue1=valueString;
            if ([valueString isEqualToString:@"0"]) {
                _oldValueArray=@[@"50HZ"];
            }
            if ([valueString isEqualToString:@"1"]) {
                _oldValueArray=@[@"60HZ"];
            }
        }
        if (_setType==12) {
            NSString *valueString=[NSString stringWithFormat:@"%@",_getOldDic[@"mix_ac_discharge_voltage"]];
                _choiceValue1=valueString;
            if ([valueString isEqualToString:@"0"]) {
                _oldValueArray=@[@"230V"];
            }
            if ([valueString isEqualToString:@"1"]) {
                _oldValueArray=@[@"208V"];
            }
            if ([valueString isEqualToString:@"2"]) {
                _oldValueArray=@[@"240V"];
            }
        }
        
    }
}

-(void)showTheChoice1{
    [self showTheChoice:1];
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

    
    if (_setType==7) {
         [self.dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _choiceValue1=[self.dayFormatter stringFromDate:self.date.date];
        _textLable.text=_choiceValue1;
    }else{
        UILabel *timeL=[_scrollView viewWithTag:_dateType];
        timeL.text= [self.dayFormatter stringFromDate:self.date.date];
        if (_dateType==3000) {
            _timeValue1=[self.dayFormatter stringFromDate:self.date.date];
        }
        if (_dateType==3001) {
            _timeValue3=[self.dayFormatter stringFromDate:self.date.date];
        }
        if (_dateType==3002) {
            _timeValue5=[self.dayFormatter stringFromDate:self.date.date];
        }
        if (_dateType==4000) {
            _timeValue2=[self.dayFormatter stringFromDate:self.date.date];
        }
        if (_dateType==4001) {
            _timeValue4=[self.dayFormatter stringFromDate:self.date.date];
        }
        if (_dateType==4002) {
            _timeValue6=[self.dayFormatter stringFromDate:self.date.date];
        }
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
