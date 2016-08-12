//
//  addStationViewController.m
//  ShineLink
//
//  Created by sky on 16/8/8.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "addStationViewController.h"
#import "RootPickerView.h"


@interface addStationViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIView *writeView;
@property (nonatomic, strong) UIButton *goBut;
@property(nonatomic,strong)NSMutableArray *textFieldMutableArray;
@property(nonatomic,strong)NSMutableArray *country;
@property(nonatomic,strong)UITextField *textField1;
@property(nonatomic,strong)UITextField *textField2;
@property(nonatomic,strong)RootPickerView *pickerView;
@property(nonatomic,strong)NSMutableArray *timeZone;
@property(nonatomic,strong)NSString *counrtyName;
@property(nonatomic,strong)NSString *timeZoneNum;
@end

@implementation addStationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
   _counrtyName=(NSString*)[ud objectForKey:@"counrtyName"];
    
    NSString *timeZone0;
    timeZone0=[ud objectForKey:@"timeZoneNum"];
    _timeZoneNum=[NSString stringWithFormat:@"%@",timeZone0];
    
    
    
    self.view.backgroundColor=MainColor;
    self.navigationItem.title=root_tianjia_1;
    [self getPickerData];
    [self initUI];
    //[self writeUI];
  
}

- (void)getPickerData
{
    _country=[NSMutableArray array];
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"admin":@"admin"} paramarsSite:@"/newCountryCityAPI.do?op=getCountryCity" sucessBlock:^(id content) {
        
        NSLog(@"getCountryCity: %@", content);
        if (content) {
            NSArray *dataDic=[NSArray arrayWithArray:content];
            if (dataDic.count>0) {
                for (int i=0; i<dataDic.count; i++) {
                    NSString *DY=[NSString stringWithFormat:@"%@",content[i][@"country"]];
                    [ _country addObject:DY];
                }
                [self hideProgressView];
            }
            
            [_country sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
                NSString *str1=(NSString *)obj1;
                NSString *str2=(NSString *)obj2;
                return [str1 compare:str2];
            }];
            [self writeUI];
        }else{
            [self hideProgressView];
            [self writeUI];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self writeUI];
    }];
    
}



-(void)initUI{
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    
    NSArray *array=[[NSArray alloc]initWithObjects:root_plant_name, root_instal_date, root_country, root_WO_shiqu, nil];
    for (int i=0; i<4; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40*NOW_SIZE, (10+i*40)*HEIGHT_SIZE, 120*NOW_SIZE, 40*HEIGHT_SIZE)];
        label.text=array[i];
        label.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        label.textColor=[UIColor whiteColor];
        [self.view addSubview:label];
    }
    
    
}


-(void)writeUI{
    
    if (_country.count==0) {
         [ _country addObject:@"Null"];
    }
    
    _timeZone=[NSMutableArray arrayWithObjects:@"+1",@"+2",@"+3",@"+4",@"+5",@"+6",@"+7",@"+8",@"+9",@"+10",@"+11",@"+12",@"-1",@"-2",@"-3",@"-4",@"-5",@"-6",@"-7",@"-8",@"-9",@"-10",@"-11",@"-12", nil];
    _pickerView=[[RootPickerView alloc]initWithTwoArray:_country arrayTwo:_timeZone];
    [self.view addSubview:_pickerView];
    
    
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
    
    for (int i=0; i<2; i++) {
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(0, (5+i*40)*HEIGHT_SIZE, 120*NOW_SIZE, 30*HEIGHT_SIZE)];
      
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
      
        [_writeView addSubview:textField];
              [_textFieldMutableArray addObject:textField];
    }
    

    _textField1=[[UITextField alloc]initWithFrame:CGRectMake(0, (5+2*40)*HEIGHT_SIZE, 120*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textField1.layer.borderWidth=0.5;
    _textField1.layer.cornerRadius=5;
    _textField1.text=_counrtyName;
    _textField1.layer.borderColor=[UIColor whiteColor].CGColor;
    _textField1.tintColor = [UIColor whiteColor];
    [_textField1 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField1 setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField1.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    _textField1.textColor=[UIColor whiteColor];
    _textField1.tag=1000;
    _textField1.delegate=_pickerView;
    [_writeView addSubview:_textField1];
    
    
    _textField2=[[UITextField alloc]initWithFrame:CGRectMake(0, (5+3*40)*HEIGHT_SIZE, 120*NOW_SIZE, 30*HEIGHT_SIZE)];
    _textField2.layer.borderWidth=0.5;
    _textField2.layer.cornerRadius=5;
      _textField2.text=_timeZoneNum;
    _textField2.layer.borderColor=[UIColor whiteColor].CGColor;
    _textField2.tintColor = [UIColor whiteColor];
    [_textField2 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField2 setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _textField2.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    _textField2.textColor=[UIColor whiteColor];
    _textField2.tag=5000;
    _textField2.delegate=_pickerView;
    [_writeView addSubview:_textField2];
    
    
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


-(void)addButtonPressed{
     if (!([_pickerView.textValue1 isEqual:@""]||_pickerView.textValue1==nil||_pickerView.textValue1==NULL)) {
    _textField1.text=_pickerView.textValue1;
       _textField2.text=_pickerView.textValue2;
     }
    
    NSArray *array=[[NSArray alloc]initWithObjects:root_plant_name, root_instal_date, root_country, root_WO_shiqu, nil];
    NSString *KK=root_WO_buneng_weikong;
    
    for (int i=0; i<2; i++) {
        if ([[_textFieldMutableArray[i] text] isEqual:@""]) {
            [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@!",array[i],KK]];
            return;
        }
    }
    
    if ([[_textField1 text] isEqual:@""]) {
        [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@!",array[2],KK]];
        return;
    }
    if ([[_textField2 text] isEqual:@""]) {
        [self showToastViewWithTitle:[NSString stringWithFormat:@"%@%@!",array[3],KK]];
        return;
    }
    
    NSMutableDictionary *dicArray=[NSMutableDictionary new];
    [dicArray setObject:[_textFieldMutableArray[0] text] forKey:@"plantName"];
    [dicArray setObject:[_textFieldMutableArray[1] text] forKey:@"plantDate"];
    [dicArray setObject:[_textField1 text] forKey:@"plantCountry"];
    [dicArray setObject:[_textField2 text] forKey:@"plantTimezone"];
    [dicArray setObject:@"0" forKey:@"plantFirm"];
  [dicArray setObject:@"0" forKey:@"plantPower"];
     [dicArray setObject:@"0" forKey:@"plantCity"];
     [dicArray setObject:@"0" forKey:@"plantLng"];
    [dicArray setObject:@"0" forKey:@"plantLat"];
     [dicArray setObject:@"1.2" forKey:@"plantIncome"];
    [dicArray setObject:@"rmb" forKey:@"plantMoney"];
    [dicArray setObject:@"0.4" forKey:@"plantCoal"];
       [dicArray setObject:@"0.997" forKey:@"plantCo2"];
    [dicArray setObject:@"0.03" forKey:@"plantSo2"];
    
    
    [self showProgressView];
    [BaseRequest uplodImageWithMethod:HEAD_URL paramars:dicArray paramarsSite:@"/newPlantAPI.do?op=addPlant" dataImageDict:nil sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"testtest: %@", content);
        id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if ([jsonObj[@"success"] integerValue]==1) {
            [self showAlertViewWithTitle:nil message:root_tianjia_dianzhan_chenggong cancelButtonTitle:root_Yes];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            if ([jsonObj[@"msg"] integerValue]==502) {
                [self showAlertViewWithTitle:nil message:root_tianjia_dianzhan_chongfu cancelButtonTitle:root_Yes];
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([jsonObj[@"msg"] integerValue]==503) {
                [self showAlertViewWithTitle:nil message:root_tianjia_dianzhan_chaochu cancelButtonTitle:root_Yes];
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([jsonObj[@"msg"] integerValue]==504) {
                [self showAlertViewWithTitle:nil message:root_tianjia_dianzhan_guojia cancelButtonTitle:root_Yes];
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([jsonObj[@"msg"] integerValue]==501) {
                [self showAlertViewWithTitle:nil message:root_tianjia_dianzhan_xinxi cancelButtonTitle:root_Yes];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
                [self.navigationController popViewControllerAnimated:YES];
            
            
            
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
}




- (void)chooseDate:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
  NSString *dateString = [formatter stringFromDate:selectedDate];
    UITextField *textField=_textFieldMutableArray[1];
    textField.text = dateString;
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


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag != 1) {
        if (self.datePicker.superview) {
            [self.datePicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
        }
       
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
     
    }

    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.datePicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.datePicker.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 216*HEIGHT_SIZE);
          
        } completion:^(BOOL finished) {
            [self.datePicker removeFromSuperview];
          
        }];
    }
 
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
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
