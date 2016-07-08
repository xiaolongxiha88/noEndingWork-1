//
//  StationEarningsViewController.m
//  ShinePhone
//
//  Created by ZML on 15/5/28.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "StationEarningsViewController.h"
#import "RootPickerView.h"

@interface StationEarningsViewController ()
@property(nonatomic,strong)NSMutableArray *textFieldMutableArray;
@property(nonatomic,strong)NSMutableArray *money;
@property (nonatomic, strong) UIView *readView;
@property (nonatomic, strong) UIView *writeView;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIButton *goBut;
@property(nonatomic,strong)RootPickerView *pickerView;
@end

@implementation StationEarningsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=root_WO_zijin;
//    UIImage *bgImage = IMAGE(@"bg4.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
     self.view.backgroundColor=MainColor;
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
        [_buttonView removeFromSuperview];
        _buttonView=nil;
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
    
    NSArray *array=[[NSArray alloc]initWithObjects:root_WO_zijin,root_WO_jieneng,root_WO_C02,root_WO_SO2, nil];
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
     NSString *string1=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"formulaMoney"]] floatValue]];
    NSString *string=[NSString stringWithFormat:@"%@ %@",string1,_dict[@"formulaMoneyUnitId"]];
    
      NSString *formulaCoal=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"formulaCoal"]] floatValue]];
   // NSString *formulaCoal=[NSString stringWithFormat:@"%@",_dict[@"formulaCoal"]];
      NSString *formulaCo2=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"formulaCo2"]] floatValue]];
  //NSString *formulaCo2=[NSString stringWithFormat:@"%@",_dict[@"formulaCo2"]];
    NSString *formulaSo2=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"formulaSo2"]] floatValue]];
     // NSString *formulaSo2=[NSString stringWithFormat:@"%@",_dict[@"formulaSo2"]];
    
    NSArray *array=[[NSArray alloc]initWithObjects:string,formulaCoal,formulaCo2,formulaSo2, nil];
    for (int i=0; i<4; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, (0+i*40)*HEIGHT_SIZE, 120*NOW_SIZE, 40*HEIGHT_SIZE)];
        label.text=array[i];
        label.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        label.textColor=[UIColor whiteColor];
        [_readView addSubview:label];
    }
}


-(void)writeUI{
    _pickerView=[[RootPickerView alloc]initWithArray:@[@"RMB",@"USD",@"EUR",@"AUD",@"JPY",@"GBP"]];
    [self.view addSubview:_pickerView];
 
    _writeView=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 10*HEIGHT_SIZE, 140*NOW_SIZE, 170*HEIGHT_SIZE)];
    [self.view addSubview:_writeView];
    _textFieldMutableArray=[NSMutableArray new];
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(110*NOW_SIZE, 5*HEIGHT_SIZE, 40*NOW_SIZE, 30*HEIGHT_SIZE)];
       NSString *formulaMoneyUnitId=[NSString stringWithFormat:@"%@",_dict[@"formulaMoneyUnitId"]];
    textField.text=formulaMoneyUnitId;
    textField.layer.borderWidth=0.5;
    textField.layer.cornerRadius=5;
    textField.layer.borderColor=[UIColor whiteColor].CGColor;
    textField.tintColor = [UIColor whiteColor];
    [textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    textField.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    textField.textColor=[UIColor whiteColor];
    textField.tag=1000;
   textField.delegate=_pickerView;
    
    [_writeView addSubview:textField];
    [_textFieldMutableArray addObject:textField];
  //  NSString *formulaMoney=[NSString stringWithFormat:@"%@",_dict[@"formulaMoney"]];
   // NSString *formulaCoal=[NSString stringWithFormat:@"%@",_dict[@"formulaCoal"]];
    //NSString *formulaCo2=[NSString stringWithFormat:@"%@",_dict[@"formulaCo2"]];
   // NSString *formulaSo2=[NSString stringWithFormat:@"%@",_dict[@"formulaSo2"]];
    
    NSString *formulaMoney=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"formulaMoney"]] floatValue]];
    //NSString *string=[NSString stringWithFormat:@"%@ %@",string1,_dict[@"formulaMoneyUnitId"]];
    
    NSString *formulaCoal=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"formulaCoal"]] floatValue]];
    // NSString *formulaCoal=[NSString stringWithFormat:@"%@",_dict[@"formulaCoal"]];
    NSString *formulaCo2=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"formulaCo2"]] floatValue]];
    //NSString *formulaCo2=[NSString stringWithFormat:@"%@",_dict[@"formulaCo2"]];
    NSString *formulaSo2=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"formulaSo2"]] floatValue]];
    // NSString *formulaSo2=[NSString stringWithFormat:@"%@",_dict[@"formulaSo2"]];

    
    
    NSArray *array=[[NSArray alloc]initWithObjects:formulaMoney,formulaCoal,formulaCo2,formulaSo2, nil];
    for (int i=0; i<4; i++) {
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(0*NOW_SIZE, (5+i*40)*HEIGHT_SIZE, 100*NOW_SIZE, 30*HEIGHT_SIZE)];
        textField.text=array[i];
        textField.layer.borderWidth=0.5;
        textField.layer.cornerRadius=5;
        textField.layer.borderColor=[UIColor whiteColor].CGColor;
        textField.tintColor = [UIColor whiteColor];
        [textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
        textField.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        textField.textColor=[UIColor whiteColor];
        textField.tag=i;
     textField.delegate=_pickerView;
        [_writeView addSubview:textField];
        
        [_textFieldMutableArray addObject:textField];
    }
    
    

    
    _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(60*NOW_SIZE,240*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
//    [_goBut.layer setMasksToBounds:YES];
//    [_goBut.layer setCornerRadius:25.0];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:root_finish forState:UIControlStateNormal];
    [_goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_goBut];
}


-(void)delButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)addButtonPressed{
    
    //3.添加/修改电站：设计功率只能为数字、时区为-12到+12、发电收益为可填可不填
    
//    NSArray *array=[[NSArray alloc]initWithObjects:@"资金收益",@"节省标准煤",@"CO2减排",@"SO2减排", nil];
//    for (int i=0; i<4; i++) {
//        if ([[_textFieldMutableArray[i] text] isEqual:@""]) {
//            [self showToastViewWithTitle:[NSString stringWithFormat:@"%@不能为空!",array[i]]];
//            return;
//        }
//    }
    NSMutableDictionary *dicArray=[NSMutableDictionary new];
    [dicArray setObject:[UserInfo defaultUserInfo].plantID forKey:@"plantID"];
    [dicArray setObject:_dict[@"plantName"] forKey:@"plantName"];
    [dicArray setObject:_dict[@"createDateText"] forKey:@"plantDate"];
    [dicArray setObject:_dict[@"designCompany"] forKey:@"plantFirm"];
    [dicArray setObject:_dict[@"nominalPower"] forKey:@"plantPower"];
    [dicArray setObject:_dict[@"country"] forKey:@"plantCountry"];
    [dicArray setObject:_dict[@"city"] forKey:@"plantCity"];
    [dicArray setObject:_dict[@"timezone"] forKey:@"plantTimezone"];
    [dicArray setObject:_dict[@"plant_lat"] forKey:@"plantLat"];
    [dicArray setObject:_dict[@"plant_lng"] forKey:@"plantLng"];
    
    [dicArray setObject:[_textFieldMutableArray[1] text] forKey:@"plantIncome"];
    [dicArray setObject:[_textFieldMutableArray[0] text] forKey:@"plantMoney"];
    [dicArray setObject:[_textFieldMutableArray[2] text] forKey:@"plantCoal"];
    [dicArray setObject:[_textFieldMutableArray[3] text] forKey:@"plantCo2"];
    [dicArray setObject:[_textFieldMutableArray[4] text] forKey:@"plantSo2"];
    

    [self showProgressView];
    [BaseRequest uplodImageWithMethod:HEAD_URL paramars:dicArray paramarsSite:@"/newPlantAPI.do?op=updatePlant" dataImageDict:nil sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"testtest: %@", content);
        id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if ([jsonObj[@"success"]  integerValue]==1) {
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  
    for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
    }
}

@end

