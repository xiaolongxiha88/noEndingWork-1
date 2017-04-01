//
//  newEnergyStorage.m
//  ShinePhone
//
//  Created by sky on 17/3/31.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "newEnergyStorage.h"

#define ScreenProW  HEIGHT_SIZE/2.38
#define ScreenProH  NOW_SIZE/2.34

@interface newEnergyStorage ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *pcsNetPlantID;
@property (nonatomic, strong) NSString *pcsNetStorageSN;
@property (nonatomic, strong) NSDictionary *dataOneDic;
@property (nonatomic, strong) NSDictionary *dataTwoDic;
@property (nonatomic, strong) NSDictionary *dataThreeDic;
@property (nonatomic, strong) NSDictionary *dataFourDic;
@property (nonatomic, strong) NSDictionary *dataFiveDic;
@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *datePickerButton;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) UIDatePicker *dayPicker;
@property (nonatomic, strong) UIToolbar *toolBar;


@property (nonatomic, strong) UIView *uiview1;
@property (nonatomic, strong) UIView *uiview2;
@property (nonatomic, strong) UIView *uiview3;
@property (nonatomic, strong) UIView *uiview4;
@property (nonatomic, strong) UIView *uiview5;
@end


static const NSTimeInterval secondsPerDay = 24 * 60 * 60;

@implementation newEnergyStorage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pcsNetPlantID=[[NSUserDefaults standardUserDefaults] objectForKey:@"pcsNetPlantID"];
    _pcsNetStorageSN=[[NSUserDefaults standardUserDefaults] objectForKey:@"pcsNetStorageSN"];
    
    [self initUI];
    
    [self getNetOne];
   // [self getNetTwo];
  //  [self getNetThree];
    
    [self initUITwo];
}



-(void)initUI{

    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,SCREEN_Height*2);
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)COLOR(7, 149, 239, 1).CGColor, (__bridge id)COLOR(0, 219, 216, 1).CGColor];
    gradientLayer.locations = nil;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height*2);
    [_scrollView.layer addSublayer:gradientLayer];
    
  
   
}

-(void)initUIOne{
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(0, 143*ScreenProH, SCREEN_Width, ScreenProH*60)];
    V1.backgroundColor=COLOR(4, 55, 85, 0.1);
    [_scrollView addSubview:V1];
    
    UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(40*ScreenProW, 13*ScreenProH, 35*ScreenProH, ScreenProH*35)];
    [VM1 setImage:[UIImage imageNamed:@"energyinfo_icon.png"]];
    [V1 addSubview:VM1];
    
    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(90*ScreenProW, 0*ScreenProH, 300*ScreenProH, ScreenProH*60)];
    VL1.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL1.textAlignment = NSTextAlignmentLeft;
    VL1.text=@"Energy overview";
    VL1.textColor =[UIColor whiteColor];
    [V1 addSubview:VL1];
    
    UILabel *VL2= [[UILabel alloc] initWithFrame:CGRectMake(400*ScreenProW, 0*ScreenProH, 320*ScreenProH, ScreenProH*60)];
    VL2.font=[UIFont systemFontOfSize:20*ScreenProH];
    VL2.textAlignment = NSTextAlignmentRight;
    NSString *N1=@"Unit"; NSString *N2=@"Today"; NSString *N3=@"Total";
    NSString *N=[NSString stringWithFormat:@"%@:kWh  %@/%@",N1,N2,N3];
    VL2.text=N;
    VL2.textColor =COLOR(186, 216, 244, 0.8);
    [V1 addSubview:VL2];

    _uiview1=[[UIView alloc]initWithFrame:CGRectMake(0, 205*ScreenProH, SCREEN_Width, ScreenProH*310)];
    [_scrollView addSubview:_uiview1];
    
    NSArray *lableName=[NSArray arrayWithObjects:@"PV Out",@"Storage Out", nil];
    NSString *A=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"epvToday"],[_dataOneDic objectForKey:@"epvTotal"]];
    NSString *B=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"eDischargeToday"],[_dataOneDic objectForKey:@"eDischargeTotal"]];
     NSArray *lableName1=[NSArray arrayWithObjects:A,B, nil];
    
    for (int i=0; i<2; i++) {
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/2*i, 10*ScreenProH, 375*ScreenProH, ScreenProH*55)];
        VL1.font=[UIFont systemFontOfSize:26*ScreenProH];
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=lableName[i];
        VL1.textColor =COLOR(255, 255, 255, 0.7);
        [_uiview1 addSubview:VL1];
    }
    for (int i=0; i<2; i++) {
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/2*i, 45*ScreenProH, 375*ScreenProH, ScreenProH*85)];
        VL1.font=[UIFont systemFontOfSize:40*ScreenProH];
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=lableName1[i];
        VL1.textColor =COLOR(255, 255, 255, 1);
        [_uiview1 addSubview:VL1];
    }
    
    NSArray *lableName2=[NSArray arrayWithObjects:@"Grid Use",@"Home Load", nil];
    NSString *C=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"eToUserToday"],[_dataOneDic objectForKey:@"eToUserTotal"]];
    NSString *D=[NSString stringWithFormat:@"%@/%@",[_dataOneDic objectForKey:@"useEnergyToday"],[_dataOneDic objectForKey:@"useEnergyTotal"]];
    NSArray *lableName3=[NSArray arrayWithObjects:C,D, nil];
    
    for (int i=0; i<2; i++) {
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/2*i, 140*ScreenProH, 375*ScreenProH, ScreenProH*55)];
        VL1.font=[UIFont systemFontOfSize:26*ScreenProH];
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=lableName2[i];
        VL1.textColor =COLOR(255, 255, 255, 0.7);
        [_uiview1 addSubview:VL1];
    }
    for (int i=0; i<2; i++) {
        UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/2*i, 175*ScreenProH, 375*ScreenProH, ScreenProH*85)];
        VL1.font=[UIFont systemFontOfSize:40*ScreenProH];
        VL1.textAlignment = NSTextAlignmentCenter;
        VL1.text=lableName3[i];
        VL1.textColor =COLOR(255, 255, 255, 1);
        [_uiview1 addSubview:VL1];
    }

}


-(void)initUITwo{
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(0, 480*ScreenProH, SCREEN_Width, ScreenProH*60)];
    V1.backgroundColor=COLOR(4, 55, 85, 0.1);
    [_scrollView addSubview:V1];
    
    UIImageView *VM1= [[UIImageView alloc] initWithFrame:CGRectMake(40*ScreenProW, 13*ScreenProH, 35*ScreenProH, ScreenProH*35)];
    [VM1 setImage:[UIImage imageNamed:@"energyinfo_icon.png"]];
    [V1 addSubview:VM1];
    
    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(90*ScreenProW, 0*ScreenProH, 300*ScreenProH, ScreenProH*60)];
    VL1.font=[UIFont systemFontOfSize:28*ScreenProH];
    VL1.textAlignment = NSTextAlignmentLeft;
    VL1.text=@"Energy Consum";
    VL1.textColor =[UIColor whiteColor];
    [V1 addSubview:VL1];
    
    UIView *V2=[[UIView alloc]initWithFrame:CGRectMake(225*ScreenProW, 550*ScreenProH, 300*ScreenProW, ScreenProH*60)];
    V2.layer.borderWidth=1;
    V2.layer.cornerRadius=ScreenProH*60/2.5;
    V2.layer.borderColor=COLOR(255, 255, 255, 0.7).CGColor;
    V2.userInteractionEnabled = YES;
    [_scrollView addSubview:V2];
    
    self.lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastButton.frame = CGRectMake(20*ScreenProW, 12.5*ScreenProH, 25*ScreenProH, 35*ScreenProH);
    [self.lastButton setImage:IMAGE(@"date_left_icon.png") forState:UIControlStateNormal];
    //self.lastButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
    self.lastButton.tag = 1004;
    [self.lastButton addTarget:self action:@selector(lastDate:) forControlEvents:UIControlEventTouchUpInside];
    [V2 addSubview:self.lastButton];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(CGRectGetWidth(V2.frame) - 20*ScreenProW-25*ScreenProH, 12.5*ScreenProH, 25*ScreenProH, 35*ScreenProH);
    [self.nextButton setImage:IMAGE(@"date_right_icon.png") forState:UIControlStateNormal];
    //self.nextButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
    self.nextButton.tag = 1005;
    [self.nextButton addTarget:self action:@selector(nextDate:) forControlEvents:UIControlEventTouchUpInside];
    [V2 addSubview:self.nextButton];
    
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd"];
    
    self.datePickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.datePickerButton.frame = CGRectMake(20*ScreenProW+25*ScreenProH, 0, CGRectGetWidth(V2.frame) -( 20*ScreenProW+25*ScreenProH)*2, 60*ScreenProH);
    self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [self.datePickerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.datePickerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.datePickerButton.titleLabel.font = [UIFont boldSystemFontOfSize:28*ScreenProH];
    [self.datePickerButton addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventTouchUpInside];
    [V2 addSubview:self.datePickerButton];
}






-(void)getNetOne{

    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":_pcsNetPlantID,@"storageSn":_pcsNetStorageSN} paramarsSite:@"/newStorageAPI.do?op=getEnergyOverviewData" sucessBlock:^(id content) {
        [self hideProgressView];
        _dataOneDic=[NSDictionary new];
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            //    id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"getEnergyOverviewData==%@", jsonObj);
            
            if ([jsonObj[@"result"] integerValue]==1) {
                
                if (jsonObj[@"obj"]==nil || jsonObj[@"obj"]==NULL||([jsonObj[@"obj"] isEqual:@""] )) {
                }else{
                    _dataOneDic=[NSDictionary dictionaryWithDictionary:jsonObj[@"obj"]];
                      [self initUIOne];
                }
               
            }
            
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];

}


-(void)getNetTwo:(NSString*)time{
    
   // NSString *time=@"2017-03-28";
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":_pcsNetPlantID,@"storageSn":_pcsNetStorageSN,@"date":time,@"type":@"1"} paramarsSite:@"/newStorageAPI.do?op=getEnergyProdAndConsData" sucessBlock:^(id content) {
        [self hideProgressView];
        _dataTwoDic=[NSDictionary new];
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            //    id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"getEnergyProdAndConsData==%@", jsonObj);
            
            if ([jsonObj[@"result"] integerValue]==1) {
                
                if (jsonObj[@"obj"]==nil || jsonObj[@"obj"]==NULL||([jsonObj[@"obj"] isEqual:@""] )) {
                }else{
                    _dataTwoDic=[NSDictionary dictionaryWithDictionary:jsonObj[@"obj"][@"chartData"]];
                }
                
            }
            
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}

-(void)getNetThree{
    NSString *time=@"2017-03-28";
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":_pcsNetPlantID,@"storageSn":_pcsNetStorageSN,@"date":time} paramarsSite:@"/newStorageAPI.do?op=getStorageEnergyData" sucessBlock:^(id content) {
        [self hideProgressView];
        _dataFourDic=[NSDictionary new];
          _dataFiveDic=[NSDictionary new];
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            //    id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"getStorageEnergyData==%@", jsonObj);
            
            if ([jsonObj[@"result"] integerValue]==1) {
                
                if (jsonObj[@"obj"]==nil || jsonObj[@"obj"]==NULL||([jsonObj[@"obj"] isEqual:@""] )) {
                }else{
                    _dataFourDic=[NSDictionary dictionaryWithDictionary:jsonObj[@"obj"][@"cdsData"]];
                    _dataFiveDic=[NSDictionary dictionaryWithDictionary:jsonObj[@"obj"][@"socData"]];
                }
                
            }
            
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *isNew=[ud objectForKey:@"isNewEnergy"];
    if ([isNew isEqualToString:@"N"]) {
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController popViewControllerAnimated:NO];
        
    }else{
        [self.navigationController setNavigationBarHidden:YES];
    }
    
}

- (BOOL)prefersStatusBarHidden
{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *isNew=[ud objectForKey:@"isNewEnergy"];
    if ([isNew isEqualToString:@"N"]) {
        return NO;//隐藏为YES，显示为NO
    }else{
        return  YES;
    }
    
}

- (void)pickDate {
    self.lastButton.enabled = NO;
    self.nextButton.enabled = NO;
    
    
    //选择日
    NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
    
    if (!self.dayPicker) {
        self.dayPicker = [[UIDatePicker alloc] init];
        self.dayPicker.backgroundColor = [UIColor whiteColor];
        self.dayPicker.datePickerMode = UIDatePickerModeDate;
        self.dayPicker.date = currentDayDate;
        self.dayPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE+190*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
        [self.view addSubview:self.dayPicker];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            self.dayPicker.date = currentDayDate;
            self.dayPicker.alpha = 1;
            self.dayPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE+190*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            [self.view addSubview:self.dayPicker];
        }];
    }
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE + 216*HEIGHT_SIZE+190*HEIGHT_SIZE, SCREEN_Width, 30*HEIGHT_SIZE)];
    self.toolBar.barStyle = UIBarStyleDefault;
    self.toolBar.barTintColor = MainColor;
    [self.view addSubview:self.toolBar];
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:root_finish style:UIBarButtonItemStyleDone target:self action:@selector(completeSelectDate:)];
    [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14*HEIGHT_SIZE],NSFontAttributeName, nil] forState:UIControlStateNormal];
    doneButton.tintColor = [UIColor whiteColor];
    self.toolBar.items = @[spaceButton, doneButton];
    
}


- (void)completeSelectDate:(UIToolbar *)toolBar {
    self.lastButton.enabled = YES;
    self.nextButton.enabled = YES;
    
    if (self.dayPicker) {
        self.currentDay = [self.dayFormatter stringFromDate:self.dayPicker.date];
        [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
        [self getNetTwo:_currentDay];
        [UIView animateWithDuration:0.3f animations:^{
            self.dayPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.dayPicker.frame = CGRectMake(0, (-216 - 64 - 70-190)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            self.toolBar.frame = CGRectMake(0,( -216 - 64 - 70-190)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.dayPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
        }];
        
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.dayPicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.dayPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.dayPicker.frame = CGRectMake(0, (-216 - 64 - 70-190)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70-190)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.dayPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
            self.lastButton.enabled = YES;
            self.nextButton.enabled = YES;
        }];
    }
}


- (void)lastDate:(UIButton *)sender {
    
    NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
    NSDate *yesterday = [currentDayDate dateByAddingTimeInterval: -secondsPerDay];
    self.currentDay = [self.dayFormatter stringFromDate:yesterday];
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [self getNetTwo:_currentDay];
}

- (void)nextDate:(UIButton *)sender {
    
    NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
    NSDate *tomorrow = [currentDayDate dateByAddingTimeInterval: secondsPerDay];
    self.currentDay = [self.dayFormatter stringFromDate:tomorrow];
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    
    [self getNetTwo:_currentDay];
}




-(void)viewDidDisappear:(BOOL)animated{

   // [ _scrollView removeFromSuperview];
  //  self.view=nil;
    
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
