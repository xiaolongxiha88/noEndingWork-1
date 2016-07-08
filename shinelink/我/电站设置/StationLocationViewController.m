//
//  StationLocationViewController.m
//  ShinePhone
//
//  Created by ZML on 15/5/27.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "StationLocationViewController.h"
#import "SNLocationManager.h"
#import "RootPickerView.h"

@interface StationLocationViewController ()
@property(nonatomic,strong)NSMutableArray *textFieldMutableArray;
@property(nonatomic,strong)NSMutableArray *timeZone;
@property(nonatomic,strong)NSMutableArray *country;
@property(nonatomic,strong)NSString *lat;
@property(nonatomic,strong)NSString *lng;
@property (nonatomic, strong) UIView *readView;
@property (nonatomic, strong) UIView *writeView;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIButton *goBut;
@property(nonatomic,strong)RootPickerView *pickerView;
@end

@implementation StationLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *bgImage = IMAGE(@"bg4.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
     self.view.backgroundColor=MainColor;
    self.navigationItem.title=root_WO_dili;
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
        [self getPickerData];
    }else{
        [sender setTitle:root_dianzhan_bianji];
        [self readUI];
        [_writeView removeFromSuperview];
        _writeView=nil;
        [_buttonView removeFromSuperview];
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

    NSArray *array=[[NSArray alloc]initWithObjects:root_country,root_WO_chengshi,root_WO_shiqu,root_WO_jingdu,root_WO_weidu, nil];
    
    for (int i=0; i<5; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40*NOW_SIZE, (10+i*40)*HEIGHT_SIZE, 120*NOW_SIZE, 40*HEIGHT_SIZE)];
        label.text=array[i];
        label.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        label.textColor=[UIColor whiteColor];
        [self.view addSubview:label];
    }
}


-(void)readUI{
    _readView=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 10*HEIGHT_SIZE, 140*NOW_SIZE, 210*HEIGHT_SIZE)];
    [self.view addSubview:_readView];
    NSString *timezone=[NSString stringWithFormat:@"%@",_dict[@"timezone"]];
    NSString *plant_lat=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"plant_lat"]] floatValue]];
    NSString *plant_lng=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"plant_lng"]] floatValue]];
    
//    NSString *plant_lat=[NSString stringWithFormat:@"%@",_dict[@"plant_lat"]];
//      NSString *plant_lng=[NSString stringWithFormat:@"%@",_dict[@"plant_lng"]];
    NSArray *array=[[NSArray alloc]initWithObjects:_dict[@"country"],_dict[@"city"],timezone,plant_lng,plant_lat,nil];
    for (int i=0; i<5; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, (0+i*40)*HEIGHT_SIZE, 120*NOW_SIZE, 40*HEIGHT_SIZE)];
        label.text=array[i];
        label.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        label.textColor=[UIColor whiteColor];
        [_readView addSubview:label];
    }
    
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



-(void)writeUI{
    _timeZone=[NSMutableArray arrayWithObjects:@"+1",@"+2",@"+3",@"+4",@"+5",@"+6",@"+7",@"+8",@"+9",@"+10",@"+11",@"+12",@"-1",@"-2",@"-3",@"-4",@"-5",@"-6",@"-7",@"-8",@"-9",@"-10",@"-11",@"-12", nil];
    _pickerView=[[RootPickerView alloc]initWithTwoArray:_country arrayTwo:_timeZone];
    [self.view addSubview:_pickerView];
    _writeView=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 10*HEIGHT_SIZE, 140*NOW_SIZE, 210*HEIGHT_SIZE)];
    [self.view addSubview:_writeView];
    _textFieldMutableArray=[NSMutableArray new];
//    NSRange timerange=[_dict[@"timeZone"] rangeOfString:@"T"];
//    NSRange timeNewRange={timerange.location+1,[_dict[@"timeZone"] length]-timerange.location-1};
//    NSString *timeString=[_dict[@"timeZone"] substringWithRange:timeNewRange];
    NSString *timezone=[NSString stringWithFormat:@"%@",_dict[@"timezone"]];
    //NSString *plant_lat=[NSString stringWithFormat:@"%@",_dict[@"plant_lat"]];
      NSString *plant_lat=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"plant_lat"]] floatValue]];
    NSString *plant_lng=[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_dict[@"plant_lng"]] floatValue]];
   // NSString *plant_lng=[NSString stringWithFormat:@"%@",_dict[@"plant_lng"]];
    NSArray *array=[[NSArray alloc]initWithObjects:_dict[@"country"],_dict[@"city"],timezone,plant_lng,plant_lat, nil];
    for (int i=0; i<5; i++) {
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
        if (i==0) {
            textField.tag=1000;
        }else if(i==2){
            textField.tag=5000;
        }else{
            textField.tag=i;
        }
        textField.delegate=_pickerView;
        [_writeView addSubview:textField];
        [_textFieldMutableArray addObject:textField];
    }
    
//    UIButton *latButton=[[UIButton alloc]initWithFrame:CGRectMake(105*NOW_SIZE, 130*NOW_SIZE, 50*NOW_SIZE, 20*NOW_SIZE)];
//    [latButton setBackgroundImage:IMAGE(@"圆角矩形.png") forState:UIControlStateNormal];
//    [latButton setTitle:@"" forState:UIControlStateNormal];
//    latButton.titleLabel.font=[UIFont systemFontOfSize:11*NOW_SIZE];
//    [latButton setTitleColor:COLOR(82, 201, 194, 1) forState:0];
//    latButton.tag=1;
//    [latButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [_writeView addSubview:latButton];
    UIButton *lngButton0=[[UIButton alloc]initWithFrame:CGRectMake(105*NOW_SIZE, 48*HEIGHT_SIZE, 50*NOW_SIZE, 20*HEIGHT_SIZE)];
    [lngButton0 setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [lngButton0 setTitle:root_WO_dianji_huoqu forState:UIControlStateNormal];
    lngButton0.titleLabel.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
    [lngButton0 setTitleColor:COLOR(82, 201, 194, 1) forState:0];
    lngButton0.tag=2001;
    [lngButton0 addTarget:self action:@selector(fetchLocation:) forControlEvents:UIControlEventTouchUpInside];
    [_writeView addSubview:lngButton0];
    
    UIButton *lngButton=[[UIButton alloc]initWithFrame:CGRectMake(105*NOW_SIZE, 150*HEIGHT_SIZE, 50*NOW_SIZE, 20*HEIGHT_SIZE)];
    [lngButton setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [lngButton setTitle:root_WO_dianji_huoqu forState:UIControlStateNormal];
    lngButton.titleLabel.font=[UIFont systemFontOfSize:11*HEIGHT_SIZE];
    [lngButton setTitleColor:COLOR(82, 201, 194, 1) forState:0];
    lngButton.tag=2002;
    [lngButton addTarget:self action:@selector(fetchLocation:) forControlEvents:UIControlEventTouchUpInside];
    [_writeView addSubview:lngButton];
    

    
    _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(60*NOW_SIZE,300*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
//    [_goBut.layer setMasksToBounds:YES];
//    [_goBut.layer setCornerRadius:25.0];
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [_goBut setTitle:root_finish forState:UIControlStateNormal];
    [_goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_goBut];
}



-(void)buttonPressed:(UIButton *)sender{
    if (sender.tag==1) {
        UIView *view=[self.view viewWithTag:3];
        UITextField *textField=(UITextField *)view;
        textField.text=_lat;
    }
    if (sender.tag==2) {
        UIView *view=[self.view viewWithTag:4];
        UITextField *textField=(UITextField *)view;
        textField.text=_lng;
    }
}

-(void)fetchLocation:(UIButton *)sender{
    
    
    [[SNLocationManager shareLocationManager] startUpdatingLocationWithSuccess:^(CLLocation *location, CLPlacemark *placemark) {
        
       
            UIView *view=[self.view viewWithTag:1];
            UITextField *textField=(UITextField *)view;
            textField.text=placemark.locality;
    
        
        
        NSString *longitude=[NSString stringWithFormat:@"%.2f", location.coordinate.longitude];
        NSString *latitude=[NSString stringWithFormat:@"%.2f", location.coordinate.latitude];
        
            UIView *view2=[self.view viewWithTag:3];
            UITextField *textField2=(UITextField *)view2;
            textField2.text=latitude;
        
            UIView *view1=[self.view viewWithTag:4];
            UITextField *textField1=(UITextField *)view1;
            textField1.text=longitude;
        

        
       
        //_city=placemark.locality;
        
        //NSString *lableText=[NSString stringWithFormat:@"%@(%@,%@)",_city,_longitude,_latitude];
        //_label2.text =lableText;
        
    } andFailure:^(CLRegion *region, NSError *error) {
        
    }];
    
}

-(void)delButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)addButtonPressed{
    NSArray *array=[[NSArray alloc]initWithObjects:NSLocalizedString(@"Country can not be empty", @"Country can not be empty"),
                    NSLocalizedString(@"City can not be empty", @"City can not be empty"),
                    NSLocalizedString(@"Time Zone can not be empty", @"Time Zone can not be empty"),
                    NSLocalizedString(@"longitude can not be empty", @"longitude can not be empty"),
                    NSLocalizedString(@"latitude can not be empty", @"latitude can not be empty"),nil];
    for (int i=0; i<5; i++) {
        if ([[_textFieldMutableArray[i] text] isEqual:@""]) {
            [self showToastViewWithTitle:array[i]];
            return;
        }
    }
    
    NSMutableDictionary *dicArray=[NSMutableDictionary new];
    [dicArray setObject:[UserInfo defaultUserInfo].plantID forKey:@"plantID"];
    [dicArray setObject:_dict[@"plantName"] forKey:@"plantName"];
    [dicArray setObject:_dict[@"createDateText"] forKey:@"plantDate"];
    [dicArray setObject:_dict[@"designCompany"] forKey:@"plantFirm"];
    [dicArray setObject:_dict[@"nominalPower"] forKey:@"plantPower"];
    [dicArray setObject:[_textFieldMutableArray[0] text] forKey:@"plantCountry"];
    [dicArray setObject:[_textFieldMutableArray[1] text] forKey:@"plantCity"];
    [dicArray setObject:[_textFieldMutableArray[2] text] forKey:@"plantTimezone"];
    [dicArray setObject:[_textFieldMutableArray[3] text] forKey:@"plantLat"];
    [dicArray setObject:[_textFieldMutableArray[4] text] forKey:@"plantLng"];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  
    for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
    }
}

@end
