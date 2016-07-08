//
//  StationSafeViewController.m
//  ShinePhone
//
//  Created by ZML on 15/5/27.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "StationSafeViewController.h"

@interface StationSafeViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray *textFieldMutableArray;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *finishView;
@property (nonatomic, strong) UIView *readView;
@property (nonatomic, strong) UIView *writeView;
@property (nonatomic, strong) UIView *buttonView;
@property(nonatomic)BOOL flag;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIButton *goBut;
@end

@implementation StationSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *bgImage = IMAGE(@"bg4.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
    self.view.backgroundColor=MainColor;
    self.navigationItem.title=root_WO_anzhuang;
    [self requestData];
}


//rightBarButtonItem上变成取消
-(void)barButtonPressed:(UIBarButtonItem *)sender{
    //4.根据是否为浏览用户(登录接口返回参数判断)，屏蔽添加电站、添加采集器、修改电站信息功能，给予提示(浏览用户禁止操作)。
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }
    if ([sender.title isEqual:root_dianzhan_bianji]) {
        [sender setTitle:root_Cancel];
        [_readView removeFromSuperview];
        _readView=nil;
        [self writeUI];
    }else{
        [sender setTitle:root_dianzhan_bianji];
        [self readUI];
        [_writeView removeFromSuperview];
        _writeView=nil;
        [_goBut removeFromSuperview];
        _goBut=nil;
    }
}

//请求数据
-(void)requestData{

    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"plantId":[UserInfo defaultUserInfo].plantID} paramarsSite:@"/newPlantAPI.do?op=getPlant" sucessBlock:^(id content) {
        NSLog(@"getPlant:%@",content);
        _dict=[NSDictionary new];
        _dict=content;
              [self initUI];
        [self readUI];
    } failure:^(NSError *error) {
        
    }];
}

-(void)initUI{
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_dianzhan_bianji style:UIBarButtonItemStylePlain target:self action:@selector(barButtonPressed:)];
    self.navigationItem.rightBarButtonItem=rightItem;

    NSArray *array=[[NSArray alloc]initWithObjects:root_plant_name, root_instal_date, root_company, root_power, nil];
    for (int i=0; i<4; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40*NOW_SIZE, (10+i*40)*HEIGHT_SIZE, 120*NOW_SIZE, 40*HEIGHT_SIZE)];
        label.text=array[i];
        label.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        label.textColor=[UIColor whiteColor];
        [self.view addSubview:label];
    }
}


-(void)readUI{
    _readView=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 10*HEIGHT_SIZE, 140*NOW_SIZE, 170*HEIGHT_SIZE)];
    [self.view addSubview:_readView];
   // NSString *normalPower=[_dict[@"normalPower"] substringWithRange:NSMakeRange(0, [_dict[@"normalPower"] length]-1) ];
    NSString *normalPower=[NSString stringWithFormat:@"%@",_dict[@"nominalPower"]];
    
    NSArray *array=[[NSArray alloc]initWithObjects:_dict[@"plantName"],_dict[@"createDateText"],_dict[@"designCompany"],normalPower, nil];
    for (int i=0; i<4; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, (i*40)*HEIGHT_SIZE, 120*NOW_SIZE, 40*HEIGHT_SIZE)];
        label.text=array[i];
        label.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        label.textColor=[UIColor whiteColor];
        [_readView addSubview:label];
    }
}


-(void)writeUI{
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    

    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_Height, SCREEN_Width, 30*HEIGHT_SIZE)];
    _toolBar.barTintColor = MainColor;
    _toolBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:root_OK style:UIBarButtonItemStyleDone target:self action:@selector(doneBarItemDidClicked)];
    UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
     [doneBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14*HEIGHT_SIZE],NSFontAttributeName, nil] forState:UIControlStateNormal];
    _toolBar.items = @[spaceBarItem,doneBarItem];
    
    _writeView=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 10*HEIGHT_SIZE, 140*NOW_SIZE, 170*HEIGHT_SIZE)];
    [self.view addSubview:_writeView];
    _textFieldMutableArray=[NSMutableArray new];
//    NSRange range=[_dict[@"normalPower"] rangeOfString:@" "];
//    NSRange newRange={0,range.location};
//    NSString *string=[_dict[@"normalPower"] substringWithRange:newRange];
      NSString *normalPower=[NSString stringWithFormat:@"%@",_dict[@"nominalPower"]];
    NSMutableArray *arrayText=[NSMutableArray array];
    [arrayText addObject:_dict[@"plantName"]];
    [arrayText addObject:_dict[@"createDateText"]];
    [arrayText addObject:_dict[@"designCompany"]];
    [arrayText addObject:normalPower];
    //NSArray *array2=[[NSArray alloc]initWithObjects:_dict[@"plantName"],_dict[@"createData"],_dict[@"designCompany"],normalPower,nil];
    
    for (int i=0; i<4; i++) {
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(0, (5+i*40)*HEIGHT_SIZE, 120*NOW_SIZE, 30*HEIGHT_SIZE)];
        textField.text=arrayText[i];
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
        if (i==3) {
            textField.keyboardType=UIKeyboardTypeDecimalPad;
        }
        [_writeView addSubview:textField];
        [_textFieldMutableArray addObject:textField];
    }
    
//    _buttonView=[[UIView alloc]initWithFrame:CGRectMake(60*NOW_SIZE, 280*NOW_SIZE, 200*NOW_SIZE, 40*NOW_SIZE)];
//    [self.view addSubview:_buttonView];
    

    
    _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(60*NOW_SIZE,240*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    //[_goBut.layer setMasksToBounds:YES];
  //  [_goBut.layer setCornerRadius:25.0];
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:root_OK forState:UIControlStateNormal];
     _goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_goBut];
    
}


-(void)delButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)addButtonPressed{
    NSArray *array=[[NSArray alloc]initWithObjects:root_plant_name,root_instal_date,root_company,root_power, nil];
    NSString *KK=root_WO_buneng_weikong;
    for (int i=0; i<4; i++) {
        if ([[_textFieldMutableArray[i] text] isEqual:@""]) {
            [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@!",array[i],KK]];
            return;
        }
    }
//    NSRange range=[_dict[@"timeZone"] rangeOfString:@"T"];
//    NSRange newRange={range.location+1,[_dict[@"timeZone"] length]-range.location-1};
//    NSString *timeString=[_dict[@"timeZone"] substringWithRange:newRange];
    NSMutableDictionary *dicArray=[NSMutableDictionary new];
    [dicArray setObject:[UserInfo defaultUserInfo].plantID forKey:@"plantID"];
     [dicArray setObject:[_textFieldMutableArray[0] text] forKey:@"plantName"];
     [dicArray setObject:[_textFieldMutableArray[1] text] forKey:@"plantDate"];
     [dicArray setObject:[_textFieldMutableArray[2] text] forKey:@"plantFirm"];
     [dicArray setObject:[_textFieldMutableArray[3] text] forKey:@"plantPower"];
     [dicArray setObject:_dict[@"country"] forKey:@"plantCountry"];
      [dicArray setObject:_dict[@"city"] forKey:@"plantCity"];
     [dicArray setObject:_dict[@"timezone"] forKey:@"plantTimezone"];
     [dicArray setObject:_dict[@"plant_lat"] forKey:@"plantLat"];
     [dicArray setObject:_dict[@"plant_lng"] forKey:@"plantLng"];
       [dicArray setObject:_dict[@"formulaMoney"] forKey:@"plantIncome"];
       [dicArray setObject:_dict[@"formulaMoneyUnitId"] forKey:@"plantMoney"];
       [dicArray setObject:_dict[@"formulaCoal"] forKey:@"plantCoal"];
       [dicArray setObject:_dict[@"formulaCo2"] forKey:@"plantCo2"];
     [dicArray setObject:_dict[@"formulaSo2"] forKey:@"plantSo2"];
    
    [self showProgressView];
    [BaseRequest uplodImageWithMethod:HEAD_URL paramars:dicArray paramarsSite:@"/newPlantAPI.do?op=updatePlant" dataImageDict:nil sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"testtest: %@", content);
        id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if ([jsonObj[@"success"] integerValue]==1) {
            [self showAlertViewWithTitle:nil message:NSLocalizedString(@"Successfully modified", @"Successfully modified") cancelButtonTitle:root_Yes];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showAlertViewWithTitle:nil message:NSLocalizedString(@"Modification fails", @"Modification fails") cancelButtonTitle:root_Yes];
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.datePicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.datePicker.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 216*HEIGHT_SIZE);
            self.finishView.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 30*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.datePicker removeFromSuperview];
            [self.finishView removeFromSuperview];
        }];
    }
    for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
    }
}


- (void)chooseDate:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:selectedDate];
    UITextField *textField=_textFieldMutableArray[1];
    textField.text = dateString;
    _textFieldMutableArray[1]=textField;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag != 1) {
        if (self.datePicker.superview) {
            [self.datePicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
        }
        _flag=NO;
        return YES;
    }
    if (self.datePicker.superview == nil) {
        self.datePicker.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 216*HEIGHT_SIZE);
        [self.view addSubview:self.datePicker];
        self.toolBar.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 30*HEIGHT_SIZE);
        [self.view addSubview:self.toolBar];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.datePicker.frame = CGRectMake(0, SCREEN_Height - 216*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
        self.toolBar.frame = CGRectMake(0, SCREEN_Height - 246*HEIGHT_SIZE, SCREEN_Width, 30*HEIGHT_SIZE);
        [UIView commitAnimations];
        if (_flag) {
            [self resignMethod];
        }
    }
    _flag=NO;
    return NO;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _flag=YES;
    });
    
}


-(void)resignMethod{
    for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
    }
}

- (void)doneBarItemDidClicked {
    [self chooseDate:_datePicker];
    
    if (self.datePicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.datePicker.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 216*HEIGHT_SIZE);
            self.toolBar.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 30*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.datePicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
        }];
    }
    [self resignFirstResponder];
}

@end
