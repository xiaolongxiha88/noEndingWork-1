//
//  SPF5000Control.m
//  ShinePhone
//
//  Created by sky on 2017/8/23.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "SPF5000Control.h"

@interface SPF5000Control ()
@property (nonatomic, strong) NSArray *buttonArray;
@property (nonatomic, strong)UITextField *textField1;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) UIButton *datePickerButton;
@end

@implementation SPF5000Control

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=MainColor;
    [self initUI];
    
    if (_type==0 || _type==1 || _type==4 || _type==5 || _type==6 || _type==7 || _type==8 || _type==9 || _type==10 || _type==14) {
        [self getSPF5000Button:_type];
        [self initUIOne];
    }
    if (_type==2 || _type==3 ){
        [self initUITwo];
    }
    
    if (_type==11 || _type==12) {
      [self initUIThree];
    }
    
    if (_type==13) {
        [self initUIFour];
    }
    
}

-(void)initUI{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE,10*HEIGHT_SIZE, 320*NOW_SIZE, 30*HEIGHT_SIZE)];
    PVData.text=[NSString stringWithFormat:@"%@:",_titleString];
    PVData.textAlignment=NSTextAlignmentCenter;
    PVData.textColor=[UIColor whiteColor];
    PVData.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:PVData];
    
    UIButton *finishButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame=CGRectMake(60*NOW_SIZE,300*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [finishButton.layer setMasksToBounds:YES];
    [finishButton.layer setCornerRadius:20.0*HEIGHT_SIZE];
    finishButton.backgroundColor = COLOR(98, 226, 149, 1);
    finishButton.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [finishButton setTitle:root_Yes forState:UIControlStateNormal];
    [finishButton setTitleColor: [UIColor whiteColor]forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(goFinishNet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];

}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_textField resignFirstResponder];
    [_textField1 resignFirstResponder];
}

-(void)initUIOne{

    for (int i=0; i<_buttonArray.count; i++) {
        UIButton *Button =  [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame=CGRectMake(60*NOW_SIZE,60*HEIGHT_SIZE+70*HEIGHT_SIZE*i, 200*NOW_SIZE, 40*HEIGHT_SIZE);
        [Button.layer setMasksToBounds:YES];
        [Button.layer setCornerRadius:20.0*HEIGHT_SIZE];
//        [Button setImage:[self createImageWithColor:[UIColor clearColor] rect:CGRectMake(0, 0, 200*NOW_SIZE, 40*HEIGHT_SIZE)] forState:UIControlStateNormal];
//        [Button setImage:[self createImageWithColor:COLOR(81, 188, 254, 1) rect:CGRectMake(0, 0, 200*NOW_SIZE, 40*HEIGHT_SIZE)] forState:UIControlStateSelected];
//        [Button setImage:[self createImageWithColor:COLOR(81, 188, 254, 1) rect:CGRectMake(0, 0, 200*NOW_SIZE, 40*HEIGHT_SIZE)] forState:UIControlStateHighlighted];
        if (i==0) {
            [Button setSelected:YES];
            Button.backgroundColor=COLOR(81, 188, 254, 1);
        }else{
            [Button setSelected:NO];
            Button.backgroundColor=[UIColor clearColor];
        }
        
        Button.layer.borderWidth=1*HEIGHT_SIZE;
        Button.layer.borderColor=COLOR(81, 188, 254, 1).CGColor;
        Button.tag=2000+i;
        Button.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
        [Button setTitle:_buttonArray[i] forState:UIControlStateNormal];
        [Button setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [Button addTarget:self action:@selector(changButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Button];
    }
    
}

-(void)changButton:(UIButton*)button{
    for (int i=0; i<_buttonArray.count; i++) {
        if ((i+2000)==button.tag) {
            [button setSelected:YES];
            button.backgroundColor=COLOR(81, 188, 254, 1);
        }else{
            UIButton *otherButton=[self.view viewWithTag:2000+i];
           [otherButton setSelected:NO];
             otherButton.backgroundColor=[UIColor clearColor];
        }
    }

}

-(void)initUITwo{
    float H=70*HEIGHT_SIZE;
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(80*NOW_SIZE,H, 70*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textField.layer.borderWidth=1*HEIGHT_SIZE;
    _textField.layer.cornerRadius=5*HEIGHT_SIZE;
    _textField.layer.borderColor=[UIColor whiteColor].CGColor;
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
     _textField.textAlignment=NSTextAlignmentCenter;
    _textField.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [self.view addSubview:_textField];
    
    _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(170*NOW_SIZE,H, 70*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textField1.layer.borderWidth=1*HEIGHT_SIZE;
    _textField1.layer.cornerRadius=5*HEIGHT_SIZE;
    _textField1.layer.borderColor=[UIColor whiteColor].CGColor;
    _textField1.textColor = [UIColor whiteColor];
    _textField1.tintColor = [UIColor whiteColor];
      _textField1.textAlignment=NSTextAlignmentCenter;
    _textField1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [self.view addSubview:_textField1];
    
    UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake(150*NOW_SIZE,H, 20*NOW_SIZE, 30*HEIGHT_SIZE)];
    PVData.text=@"~";
    PVData.textAlignment=NSTextAlignmentCenter;
    PVData.textColor=[UIColor whiteColor];
    PVData.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [self.view addSubview:PVData];
    
    UILabel *noticeLable=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE,H+40*HEIGHT_SIZE, 320*NOW_SIZE, 30*HEIGHT_SIZE)];
    noticeLable.text=@"（0~23）";
    noticeLable.textAlignment=NSTextAlignmentCenter;
    noticeLable.textColor=[UIColor whiteColor];
    noticeLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:noticeLable];
    
}


-(void)initUIThree{
    float H=70*HEIGHT_SIZE;
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(100*NOW_SIZE,H, 120*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textField.layer.borderWidth=1*HEIGHT_SIZE;
    _textField.layer.cornerRadius=5*HEIGHT_SIZE;
    _textField.layer.borderColor=[UIColor whiteColor].CGColor;
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
    _textField.textAlignment=NSTextAlignmentCenter;
    _textField.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [self.view addSubview:_textField];
    
 
    UILabel *noticeLable=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE,H+40*HEIGHT_SIZE, 320*NOW_SIZE, 30*HEIGHT_SIZE)];
    if (_type==11) {
          noticeLable.text=@"（10A~130A）";
    }else{
    noticeLable.text=@"（44.4A~51.4A）";
    }
    noticeLable.textAlignment=NSTextAlignmentCenter;
    noticeLable.textColor=[UIColor whiteColor];
    noticeLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:noticeLable];

    
}


-(void)initUIFour{
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    

    
    _datePickerButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 85*HEIGHT_SIZE+30*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
    _datePickerButton.layer.borderWidth=1;
    _datePickerButton.layer.cornerRadius=5*HEIGHT_SIZE;
    _datePickerButton.layer.borderColor=[UIColor whiteColor].CGColor;
    [_datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [_datePickerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _datePickerButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    _datePickerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16*HEIGHT_SIZE];
    [_datePickerButton addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_datePickerButton];
}

-(void)goFinishNet{

}

-(void)goFinishNetOSS{
    
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
    self.currentDay = [self.dayFormatter stringFromDate:self.date.date];
    
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
 
    if ([_controlType isEqualToString:@"2"]) {
               [self goFinishNetOSS];
    }else{
         [self goFinishNet];
    }
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}

-(void)getSPF5000Button:(int)Num{
   
    if (Num==0) {
        _buttonArray=[NSArray arrayWithObjects:root_5000Control_147,root_5000Control_144,root_5000Control_148, nil];
    }else if (Num==1) {
        _buttonArray=[NSArray arrayWithObjects:root_5000Control_144,root_5000Control_145,root_5000Control_146, nil];
    }else if (Num==4) {
        _buttonArray=[NSArray arrayWithObjects:root_5000Control_149,root_5000Control_150, nil];
    }else if (Num==5) {
      _buttonArray=[NSArray arrayWithObjects:@"90~280VAC",@"170~280VAC", nil];
    }else if (Num==6) {
        _buttonArray=[NSArray arrayWithObjects:@"230VAC",@"208VAC", @"240VAC", nil];
    }else if (Num==7) {
        _buttonArray=[NSArray arrayWithObjects:@"50HZ",@"60HZ", nil];
    }else if (Num==8) {
        _buttonArray=[NSArray arrayWithObjects:root_5000Control_151,root_5000Control_152, root_5000Control_153,nil];
    }else if (Num==9) {
        _buttonArray=[NSArray arrayWithObjects:root_5000Control_151,root_5000Control_152,nil];
    }else if (Num==10) {
        _buttonArray=[NSArray arrayWithObjects:root_kai,root_guan,nil];
    }else if (Num==14) {
        _buttonArray=[NSArray arrayWithObjects:root_5000Control_154,root_5000Control_155,root_5000Control_156,nil];
    }
    
   
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
