//
//  ControlCNJ.m
//  shinelink
//
//  Created by sky on 16/3/31.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ControlCNJ.h"
#import "ASValueTrackingSlider.h"


@interface ControlCNJ ()<UIAlertViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) ASValueTrackingSlider *slider;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property (nonatomic, strong) UIDatePicker *date1;
@property (nonatomic, strong) UIDatePicker *date2;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) UIButton *time1;
@property (nonatomic, strong) NSDateFormatter *time1Formatter;
@property (nonatomic, strong) NSString *currentTime1;
@property (nonatomic, strong) UIButton *time2;
@property (nonatomic, strong) NSString *currentTime2;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UITextField *textField1;
@property (nonatomic, strong) UIButton *datePickerButton;
@property (nonatomic, strong) UISwitch *Switch;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIAlertView *Alert1;
@property (nonatomic, strong) UIAlertView *Alert2;
@property (nonatomic, strong) NSString *param1;
@property (nonatomic, strong) NSString *param2;
@property (nonatomic, strong) NSString *param3;
@property (nonatomic, strong) NSString *param4;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) UILabel *PV3;
@property (nonatomic, strong) UILabel *PV4;
@end

@implementation ControlCNJ

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _param1=@"";
    _param2=@"";
    _param3=@"";
    _param4=@"";
    _typeName=@"";
        self.view.backgroundColor=COLOR(17, 183, 243, 1);
//    UIImage *bgImage = IMAGE(@"bg4.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
   
    [self initUI];
}

-(void)initUI{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,650*NOW_SIZE);
    [self.view addSubview:_scrollView];
    
    float buttonSize=80*HEIGHT_SIZE;
    
    if([_type isEqualToString:@"0"]){
        UILabel *buttonLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width/2-100*NOW_SIZE)/2, 60*HEIGHT_SIZE, 100*NOW_SIZE,20*HEIGHT_SIZE )];
        buttonLable.text=root_CNJ_kaiji;
        buttonLable.textAlignment=NSTextAlignmentCenter;
        buttonLable.textColor=[UIColor whiteColor];
        buttonLable.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
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

     if([_type isEqualToString:@"1"]){
    UILabel *PVLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 60*HEIGHT_SIZE+5*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    PVLable.text=root_CNJ_SOC_xia;
    PVLable.textAlignment=NSTextAlignmentLeft;
    PVLable.textColor=[UIColor whiteColor];
    PVLable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:PVLable];
    _slider=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 85*HEIGHT_SIZE+30*HEIGHT_SIZE, SCREEN_Width-40*NOW_SIZE, 40*HEIGHT_SIZE)];
    _slider.maximumValue = 10;
    _slider.minimumValue=0;
    [_scrollView addSubview:_slider];
    
    UILabel *PVLable1=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 85*HEIGHT_SIZE+10*HEIGHT_SIZE+55*HEIGHT_SIZE, 150*NOW_SIZE,20*HEIGHT_SIZE )];
    PVLable1.text=@"0";
    PVLable1.textAlignment=NSTextAlignmentLeft;
    PVLable1.textColor=[UIColor whiteColor];
    PVLable1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:PVLable1];
    UILabel *PVLable2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width-22*NOW_SIZE, 85*HEIGHT_SIZE+10*HEIGHT_SIZE+55*HEIGHT_SIZE, 150*NOW_SIZE,20*HEIGHT_SIZE )];
    PVLable2.text=@"10";
    PVLable2.textAlignment=NSTextAlignmentLeft;
    PVLable2.textColor=[UIColor whiteColor];
    PVLable2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:PVLable2];
     }
    
       if([_type isEqualToString:@"2"]){
    UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width-250*NOW_SIZE)/2, 75*HEIGHT_SIZE, 250*NOW_SIZE,20*HEIGHT_SIZE )];
    PVData.text=root_CNJ_shijian_she;
    PVData.textAlignment=NSTextAlignmentCenter;
    PVData.textColor=[UIColor whiteColor];
    PVData.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:PVData];
    
//    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(130*NOW_SIZE,85*NOW_SIZE+26*NOW_SIZE, 180*NOW_SIZE, 1*NOW_SIZE)];
//    line.backgroundColor=[UIColor whiteColor];
//    [_scrollView addSubview:line];
    
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    
           
    _datePickerButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2,115*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
           _datePickerButton.layer.borderWidth=0.5;
           _datePickerButton.layer.cornerRadius=5;
           _datePickerButton.layer.borderColor=[UIColor whiteColor].CGColor;
    [_datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [_datePickerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _datePickerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _datePickerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16*HEIGHT_SIZE];
    _datePickerButton.tag=1001;
    [_datePickerButton addTarget:self action:@selector(pickDate1:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_datePickerButton];
       }
    
    
   /* UILabel *FDT=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+85*NOW_SIZE+45*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    FDT.text=@"FDT设置";
    FDT.textAlignment=NSTextAlignmentLeft;
    FDT.textColor=[UIColor blueColor];
    FDT.font = [UIFont systemFontOfSize:18*NOW_SIZE];
    [_scrollView addSubview:FDT];*/
    
       if([_type isEqualToString:@"3"]){
    UILabel *Enable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*HEIGHT_SIZE, 250*NOW_SIZE,20*HEIGHT_SIZE )];
    Enable.text=root_CNJ_fangjian_shineng;
    Enable.textAlignment=NSTextAlignmentLeft;
    Enable.textColor=[UIColor whiteColor];
    Enable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:Enable];
           
           UILabel *EnableOff=[[UILabel alloc]initWithFrame:CGRectMake(80*NOW_SIZE, 85*HEIGHT_SIZE+40*HEIGHT_SIZE, 60*NOW_SIZE,20*HEIGHT_SIZE )];
           EnableOff.text=root_guan;
           EnableOff.textAlignment=NSTextAlignmentLeft;
           EnableOff.textColor=[UIColor whiteColor];
           EnableOff.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
           [_scrollView addSubview:EnableOff];
           
           UILabel *EnableOn=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width-140*NOW_SIZE), 85*HEIGHT_SIZE+40*HEIGHT_SIZE, 60*NOW_SIZE,20*HEIGHT_SIZE )];
           EnableOn.text=root_kai;
           EnableOn.textAlignment=NSTextAlignmentRight;
           EnableOn.textColor=[UIColor whiteColor];
           EnableOn.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
           [_scrollView addSubview:EnableOn];
           
           _typeName=@"storage_cmd_forced_discharge_enable";
           _param1=@"0";
    
    _Switch=[[UISwitch alloc]initWithFrame:CGRectMake(140*NOW_SIZE, 85*HEIGHT_SIZE+40*HEIGHT_SIZE, 120*NOW_SIZE,10*HEIGHT_SIZE )];
    [_Switch setOn:YES];
    [_Switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    _Switch.transform= CGAffineTransformMakeScale(1.2, 1);
       [_scrollView addSubview:_Switch];
           
       }

    if([_type isEqualToString:@"4"]){
    UILabel *dataDischarge=[[UILabel alloc]initWithFrame:CGRectMake(25*NOW_SIZE, 75*HEIGHT_SIZE+10*HEIGHT_SIZE, 250*NOW_SIZE,20*HEIGHT_SIZE )];
    dataDischarge.text=root_CNJ_fangdian_shijianduan;
    dataDischarge.textAlignment=NSTextAlignmentLeft;
    dataDischarge.textColor=[UIColor whiteColor];
    dataDischarge.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:dataDischarge];
    
    self.time1Formatter = [[NSDateFormatter alloc] init];
    [self.time1Formatter setDateFormat:@"HH:mm"];
    self.currentTime1 = [_time1Formatter stringFromDate:[NSDate date]];
    
    _time1=[[UIButton alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 85*HEIGHT_SIZE+10*HEIGHT_SIZE+25*HEIGHT_SIZE, 120*NOW_SIZE,30*HEIGHT_SIZE )];
        _time1.layer.borderWidth=1;
        _time1.layer.cornerRadius=5;
        _time1.layer.borderColor=[UIColor whiteColor].CGColor;
    [_time1 setTitle:self.currentTime1 forState:UIControlStateNormal];
    [_time1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _time1.titleLabel.textAlignment = NSTextAlignmentCenter;
    _time1.titleLabel.font = [UIFont boldSystemFontOfSize:16*HEIGHT_SIZE];
    _time1.tag=1002;
    [_time1 addTarget:self action:@selector(pickDate1:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_time1];
    
    _time2=[[UIButton alloc]initWithFrame:CGRectMake(180*NOW_SIZE, 85*HEIGHT_SIZE+10*HEIGHT_SIZE+25*HEIGHT_SIZE, 120*NOW_SIZE,30*HEIGHT_SIZE )];
        _time2.layer.borderWidth=1;
        _time2.layer.cornerRadius=5;
        _time2.layer.borderColor=[UIColor whiteColor].CGColor;
    [_time2 setTitle:self.currentTime1 forState:UIControlStateNormal];
    [_time2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _time2.titleLabel.textAlignment = NSTextAlignmentLeft;
    _time2.titleLabel.font = [UIFont boldSystemFontOfSize:16*HEIGHT_SIZE];
    _time2.tag=1003;
    [_time2 addTarget:self action:@selector(pickDate1:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_time2];
    
    UILabel *TO=[[UILabel alloc]initWithFrame:CGRectMake(140*NOW_SIZE, 85*HEIGHT_SIZE+10*HEIGHT_SIZE+25*HEIGHT_SIZE, 40*NOW_SIZE,30*HEIGHT_SIZE )];
    TO.text=root_zhi;
    TO.textAlignment=NSTextAlignmentCenter;
    TO.textColor=[UIColor whiteColor];
    TO.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:TO];
    
//    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(25*NOW_SIZE, 85*NOW_SIZE+10*NOW_SIZE+50*NOW_SIZE, 115*NOW_SIZE,1*NOW_SIZE )];
//    line1.backgroundColor=[UIColor whiteColor];
//    [_scrollView addSubview:line1];
//    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(185*NOW_SIZE, 85*NOW_SIZE+10*NOW_SIZE+50*NOW_SIZE, 115*NOW_SIZE,1*NOW_SIZE )];
//    line2.backgroundColor=[UIColor whiteColor];
//    [_scrollView addSubview:line2];
    }
    
    float Size1=40*HEIGHT_SIZE;
    
     if([_type isEqualToString:@"5"]){
    UILabel *PV=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    PV.text=root_CNJ_SP;
    PV.textAlignment=NSTextAlignmentLeft;
    PV.textColor=[UIColor whiteColor];
    PV.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:PV];
    
    UILabel *PV1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1, 180*NOW_SIZE,20*HEIGHT_SIZE )];
    PV1.text=root_CNJ_kailu_dianya;
    PV1.textAlignment=NSTextAlignmentLeft;
    PV1.textColor=[UIColor whiteColor];
    PV1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:PV1];
    
//    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(200*NOW_SIZE,75*NOW_SIZE+30*NOW_SIZE+Size1, 110*NOW_SIZE,1*NOW_SIZE )];
//    line3.backgroundColor=[UIColor whiteColor];
//    [_scrollView addSubview:line3];
    
   _textField = [[UITextField alloc] initWithFrame:CGRectMake(200*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1, 100*NOW_SIZE,30*HEIGHT_SIZE )];
         _textField.layer.borderWidth=1;
         _textField.layer.cornerRadius=5;
         _textField.layer.borderColor=[UIColor whiteColor].CGColor;
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
    _textField.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
         _textField.delegate=self;
     [_scrollView addSubview:_textField];
//         [_textField addObserver:_textField forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    UILabel *PV2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1*2, 180*NOW_SIZE,20*HEIGHT_SIZE )];
    PV2.text=root_CNJ_MPP;
    PV2.textAlignment=NSTextAlignmentLeft;
    PV2.textColor=[UIColor whiteColor];
    PV2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:PV2];
         
         _PV3=[[UILabel alloc]initWithFrame:CGRectMake(80*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1*2, 50*NOW_SIZE,20*HEIGHT_SIZE )];
        // PV3.text=@"MPP电压(";
        
         _PV3.textAlignment=NSTextAlignmentLeft;
         _PV3.textColor=[UIColor whiteColor];
         _PV3.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
         [_scrollView addSubview:_PV3];
         
         _PV4=[[UILabel alloc]initWithFrame:CGRectMake(130*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1*2, 50*NOW_SIZE,20*HEIGHT_SIZE )];
                 _PV4.textAlignment=NSTextAlignmentLeft;
         _PV4.textColor=[UIColor whiteColor];
         _PV4.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
         [_scrollView addSubview:_PV4];
         
    
    _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(200*NOW_SIZE,75*HEIGHT_SIZE+10*HEIGHT_SIZE+Size1*2, 100*NOW_SIZE,30*HEIGHT_SIZE )];
         _textField1.layer.borderWidth=1;
         _textField1.layer.cornerRadius=5;
         _textField1.layer.borderColor=[UIColor whiteColor].CGColor;
    _textField1.textColor = [UIColor whiteColor];
    _textField1.tintColor = [UIColor whiteColor];
    _textField1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:_textField1];
    
//    UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(200*NOW_SIZE,75*NOW_SIZE+30*NOW_SIZE+Size1*2, 110*NOW_SIZE,1*NOW_SIZE )];
//    line4.backgroundColor=[UIColor whiteColor];
//    [_scrollView addSubview:line4];
     }
         
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,210*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
//    [goBut.layer setMasksToBounds:YES];
//    [goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_finish forState:UIControlStateNormal];
     goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut addTarget:self action:@selector(finishSet1) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:goBut];

}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
 return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_textField) {
        int V1=[[_textField text]intValue]*0.55;
         _PV3.text=[NSString stringWithFormat:@"(%d~",V1];
        int V2=[[_textField text]intValue]*0.9;
           _PV4.text=[NSString stringWithFormat:@"%dV):",V2];
    }
    
}
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    
//    int V1=[[change objectForKey:@"new"]intValue]*0.55;
//    _PV3.text=[NSString stringWithFormat:@"(%d~",V1];
//  int V2=[[change objectForKey:@"new"]intValue]*0.9;
//    _PV4.text=[NSString stringWithFormat:@"%dV)",V2];
//
//}

-(void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{

}
-(void)finishSet1{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
      
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }

    
    if(_slider){
        NSString *S1=[NSString stringWithFormat:@"%.0f",_slider.value];
        _param1=[NSString stringWithString:S1];
        _typeName=@"storage_lithium_battery";
    }
    
    if (_textField) {
        _param1=[NSString stringWithFormat:@"%d",[[_textField text] intValue]];
        
        _param2=[NSString stringWithFormat:@"%d",[[_textField1 text] intValue]];
        
         _typeName=@"storage_fdt_open_voltage";
    }
 
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"serialNum":_CnjSN,@"type":_typeName,@"param1":_param1,@"param2":_param2,@"param3":_param3,@"param4":_param4} paramarsSite:@"/newTcpsetAPI.do?op=storageSet" sucessBlock:^(id content) {
        //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"inverterSet: %@", content1);
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

-(void)control{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }
    _Alert1 = [[UIAlertView alloc] initWithTitle:root_ALET message:root_CNJ_shifou_kaiqi_CNJ delegate:self cancelButtonTitle:root_cancel  otherButtonTitles:root_OK, nil];
    
    [_Alert1 show];
    
}

-(void)controlOff{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }
    _Alert2 = [[UIAlertView alloc] initWithTitle:root_ALET message:root_CNJ_shifou_guanbi_CNJ delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_OK, nil];
    [_Alert2 show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }else if (buttonIndex==1){
        if (_Alert1) {
          _typeName=@"storage_cmd_on_off";
         _param1=@"0101";
        }else if (_Alert2){
                  _typeName=@"storage_cmd_on_off";
              _param1=@"0000";
        }
        [self finishSet1];
    }
    
}


#pragma mark - customSwitch delegate
-(void)switchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        _param1=@"0";
    }else {
      _param1=@"1";
    }
}

#pragma mark - pickDate
-(void)pickDate1:(id)sender{
    float buttonSize=70*HEIGHT_SIZE;
    UIButton *switchButton = (UIButton*)sender;
    if (switchButton.tag==1001) {
        _date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 85*HEIGHT_SIZE+buttonSize+5*HEIGHT_SIZE+55*HEIGHT_SIZE+85*HEIGHT_SIZE*2, SCREEN_Width, 216*HEIGHT_SIZE)];
        _date.backgroundColor=[UIColor whiteColor];
        _date.datePickerMode=UIDatePickerModeDateAndTime;
        [self.view addSubview:_date];
    }else if(switchButton.tag==1002){
        _date1=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 85*HEIGHT_SIZE+buttonSize+5*HEIGHT_SIZE+55*HEIGHT_SIZE+85*HEIGHT_SIZE*2, SCREEN_Width, 216*HEIGHT_SIZE)];
        _date1.backgroundColor=[UIColor whiteColor];
        _date1.datePickerMode=UIDatePickerModeTime;
        [self.view addSubview:_date1];
    }else if(switchButton.tag==1003){
        _date2=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 85*HEIGHT_SIZE+buttonSize+5*HEIGHT_SIZE+55*HEIGHT_SIZE+85*HEIGHT_SIZE*2, SCREEN_Width, 216*HEIGHT_SIZE)];
        _date2.backgroundColor=[UIColor whiteColor];
        _date2.datePickerMode=UIDatePickerModeTime;
        [self.view addSubview:_date2];
    }
    
    
   
    
    if (self.toolBar) {
        [UIView animateWithDuration:0.3f animations:^{
            self.toolBar.alpha = 1;
            self.toolBar.frame = CGRectMake(0, 85*HEIGHT_SIZE+buttonSize+5*HEIGHT_SIZE+55*HEIGHT_SIZE+85*HEIGHT_SIZE*2-44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            [self.view addSubview:_toolBar];
        }];
    } else {
        self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 85*HEIGHT_SIZE+buttonSize+5*HEIGHT_SIZE+55*HEIGHT_SIZE+85*HEIGHT_SIZE*2-44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE)];
        self.toolBar.barStyle = UIBarStyleDefault;
        self.toolBar.barTintColor = COLOR(17, 183, 243, 1);
        [self.view addSubview:self.toolBar];
        
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:root_finish style:UIBarButtonItemStyleDone target:self action:@selector(completeSelectDate:)];
        doneButton.tintColor = [UIColor whiteColor];
        self.toolBar.items = @[spaceButton, doneButton];
    }
}

- (void)completeSelectDate:(UIToolbar *)toolBar {
    if (self.date) {
        self.currentDay = [self.dayFormatter stringFromDate:self.date.date];
        [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
        _typeName=@"storage_cmd_sys_year";
        _param1=self.currentDay;
    }
    if (self.date1) {
        self.currentTime1 = [self.time1Formatter stringFromDate:self.date1.date];
        [self.time1 setTitle:self.currentTime1 forState:UIControlStateNormal];
        _typeName=@"storage_cmd_forced_discharge_time1";
        NSRange rang = NSMakeRange(0, 2);
        NSRange rang1 = NSMakeRange(3, 2);
        _param1=[self.currentTime1 substringWithRange:rang];
         _param2=[self.currentTime1 substringWithRange:rang1];
    }
    if (self.date2) {
        self.currentTime2 = [self.time1Formatter stringFromDate:self.date2.date];
        [self.time2 setTitle:self.currentTime2 forState:UIControlStateNormal];
        NSRange rang = NSMakeRange(0, 2);
        NSRange rang1 = NSMakeRange(3, 2);
        _param3=[self.currentTime2 substringWithRange:rang];
        _param4=[self.currentTime2 substringWithRange:rang1];
    }
   
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    [self.date1 removeFromSuperview];
     [self.date2 removeFromSuperview];
    if (self.date) {
         [self finishSet1];
    }
    if (self.date1 && self.date2) {
         [self finishSet1];
    }
   
}

-(void)controlOpen{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:root_ALET message:root_CNJ_shifou_guanbi_CNJ delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_OK, nil];
    [alertView show];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_textField resignFirstResponder];
    [_textField1 resignFirstResponder];
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
