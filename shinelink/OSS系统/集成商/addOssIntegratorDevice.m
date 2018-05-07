//
//  addOssIntegratorDevice.m
//  ShinePhone
//
//  Created by sky on 2018/5/7.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "addOssIntegratorDevice.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "AnotherSearchViewController.h"
#import "MMScanViewController.h"
#import "SNLocationManager.h"


@interface addOssIntegratorDevice ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *oneView;
@property (nonatomic, strong) UIView *twoView;
@property (nonatomic, strong) UIView *threeView;
@property (nonatomic, strong) UIButton *finishButton;

@property (nonatomic, assign)float H1;
@property (nonatomic, strong)NSMutableArray *textFieldMutableArray;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) NSArray *userListArray;
@property (nonatomic, strong) NSArray *countryListArray;

@property (nonatomic, strong) NSMutableDictionary*oneDic;
@property (nonatomic, strong) NSMutableDictionary*twoDic;
@property (nonatomic, strong) NSMutableDictionary*threeDic;

@end

@implementation addOssIntegratorDevice

- (void)viewDidLoad {
    [super viewDidLoad];
    
      _H1=40*HEIGHT_SIZE;
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, ScreenHeight)];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    
    _finishButton=  [UIButton buttonWithType:UIButtonTypeCustom];

    [_finishButton setBackgroundImage:IMAGE(@"workorder_button_icon_nor.png") forState:UIControlStateNormal];
    [_finishButton setBackgroundImage:IMAGE(@"workorder_button_icon_click.png") forState:UIControlStateHighlighted];
    [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
    _finishButton.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_finishButton addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_finishButton];
    
    if (_deviceType==1) {
        [self initUiForUser];
    }else  if (_deviceType==2) {
        [self initUiForPlant];
    }else  if (_deviceType==3) {
        [self initUiForDevice];
    }
    
}

-(void)finishSet{
    
    if (_deviceType==1) {
        [self NetForUser];
    }else  if (_deviceType==2) {
           [self NetForPlant];
    }else  if (_deviceType==3) {
         [self NetForDevice];
    }
    
}

-(void)initUiForUser{

    
    _oneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 241*HEIGHT_SIZE)];
    _oneView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_oneView];
    
            _finishButton.frame=CGRectMake(60*NOW_SIZE,_oneView.frame.origin.y+_oneView.frame.size.height+20*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    
    NSArray *name1Array=@[@"服务器地址",@"用户名",@"密码",@"重复密码",@"时区",@"手机号"];
    for (int i=0; i<name1Array.count; i++) {
        float H2=0+_H1*i;
        NSInteger type=0;
        if (i==0 || i==4) {
            type=1;
        }
        [self getUnitUI:name1Array[i] Hight:H2 type:type tagNum:2500+i firstView:_oneView];
    }
    
    
    
}


-(void)initUiForPlant{
    
    float H2=_oneView.frame.origin.y+_oneView.frame.size.height+20*HEIGHT_SIZE;

    
        UIView *jumpUserView=[[UIView alloc]initWithFrame:CGRectMake(0, H2, SCREEN_Width, _H1*2)];
        jumpUserView.backgroundColor=[UIColor clearColor];
        jumpUserView.tag=3300;
        [_scrollView addSubview:jumpUserView];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0,SCREEN_Width-20*NOW_SIZE, _H1)];
        lable1.textColor = COLOR(154, 154, 154, 1);
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.text=@"请指定电站所属的用户:";
        [jumpUserView addSubview:lable1];
        
        [self getUnitUI:@"所属用户" Hight:_H1 type:1 tagNum:3400 firstView:jumpUserView];
        
        H2=H2+_H1*2+15*HEIGHT_SIZE;

    
    _twoView=[[UIView alloc]initWithFrame:CGRectMake(0, H2, SCREEN_Width, 241*HEIGHT_SIZE)];
    _twoView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_twoView];
    
   

    
    NSArray *name1Array=@[@"电站名称",@"安装时间",@"装机容量",@"时区",@"国家",@"定位"];
    for (int i=0; i<name1Array.count; i++) {
        float H2=0+_H1*i;
        NSInteger type=0;
        if (i==1|| i==3 || i==4) {
            type=1;
        }
        if (i==5){
            type=2;
        }
        
        [self getUnitUI:name1Array[i] Hight:H2 type:type tagNum:3500+i firstView:_twoView];
    }
    
     _scrollView.contentSize=CGSizeMake(ScreenWidth, H2+400*HEIGHT_SIZE);
    
}


-(void)initUiForDevice{
    
    float H2=_twoView.frame.origin.y+_twoView.frame.size.height+20*HEIGHT_SIZE;
  
        UIView *jumpPlantView0=[self.view viewWithTag:3300];
        [jumpPlantView0 removeFromSuperview];
        
        _twoView.frame=CGRectMake(_twoView.frame.origin.x, _twoView.frame.origin.y-(2*_H1), _twoView.frame.size.width, _twoView.frame.size.height);
        
        H2=_twoView.frame.origin.y+_twoView.frame.size.height+20*HEIGHT_SIZE;
        
        UIView *jumpUserView=[[UIView alloc]initWithFrame:CGRectMake(0, H2, SCREEN_Width, _H1*2)];
        jumpUserView.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:jumpUserView];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0,SCREEN_Width-20*NOW_SIZE, _H1)];
        lable1.textColor = COLOR(154, 154, 154, 1);
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.text=@"请指定设备所属的用户:";
        [jumpUserView addSubview:lable1];
        
        [self getUnitUI:@"所属用户" Hight:_H1 type:1 tagNum:4400 firstView:jumpUserView];
        
        H2=H2+_H1*2+15*HEIGHT_SIZE;

    
        UIView *jumpPlantView=[[UIView alloc]initWithFrame:CGRectMake(0, H2, SCREEN_Width, _H1*2)];
        jumpPlantView.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:jumpPlantView];
        
        UILabel *lable11 = [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0,SCREEN_Width-20*NOW_SIZE, _H1)];
        lable11.textColor = COLOR(154, 154, 154, 1);
        lable11.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        lable11.textAlignment=NSTextAlignmentLeft;
        lable11.text=@"请指定设备所属的电站:";
        [jumpPlantView addSubview:lable11];
        
        [self getUnitUI:@"所属电站" Hight:_H1 type:1 tagNum:4401 firstView:jumpPlantView];
        
        H2=H2+_H1*2+15*HEIGHT_SIZE;

    
    
    _threeView=[[UIView alloc]initWithFrame:CGRectMake(0, H2, SCREEN_Width, 290*HEIGHT_SIZE)];
    _threeView.backgroundColor=COLOR(242, 242, 242, 1);
    [_scrollView addSubview:_threeView];
    
   
    //    _goNextView.frame=CGRectMake(_goNextView.frame.origin.x, H2+_threeView.frame.origin.x+_threeView.frame.size.height+15*HEIGHT_SIZE, _goNextView.frame.size.width, _goNextView.frame.size.height);
    
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 140*HEIGHT_SIZE)];
    V1.backgroundColor=[UIColor whiteColor];
    [_threeView addSubview:V1];
    
    UILabel *nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 10*HEIGHT_SIZE,SCREEN_Width, _H1)];
    nameLable1.textColor = COLOR(51, 51, 51, 1);
    nameLable1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    nameLable1.textAlignment=NSTextAlignmentCenter;
    nameLable1.text=@"方式一:手动输入添加";
    [V1 addSubview:nameLable1];
    
    float H11=(20*HEIGHT_SIZE+_H1);
    float H22=(20*HEIGHT_SIZE+_H1*2);
    [self getUnitUI:@"采集器序列号" Hight:H11 type:0 tagNum:4500 firstView:V1];
    
    [self getUnitUI:@"采集器校验码" Hight:H22 type:0 tagNum:4501 firstView:V1];
    
    
    UIView *V2=[[UIView alloc]initWithFrame:CGRectMake(0, 150*HEIGHT_SIZE, SCREEN_Width, 140*HEIGHT_SIZE)];
    V2.backgroundColor=[UIColor whiteColor];
    [_threeView addSubview:V2];
    
    UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 10*HEIGHT_SIZE,SCREEN_Width, _H1)];
    nameLable2.textColor = COLOR(51, 51, 51, 1);
    nameLable2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    nameLable2.textAlignment=NSTextAlignmentCenter;
    nameLable2.text=@"方式二:扫码添加";
    [V2 addSubview:nameLable2];
    
    UIButton*goButton2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    goButton2.frame=CGRectMake(40*NOW_SIZE,20*HEIGHT_SIZE+_H1, 240*NOW_SIZE, 50*HEIGHT_SIZE);
    [goButton2 setBackgroundImage:IMAGE(@"workorder_button_icon_nor.png") forState:UIControlStateNormal];
    [goButton2 setBackgroundImage:IMAGE(@"workorder_button_icon_click.png") forState:UIControlStateHighlighted];
    [goButton2 setTitle:@"扫描条形码" forState:UIControlStateNormal];
    goButton2.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [goButton2 addTarget:self action:@selector(scanSn) forControlEvents:UIControlEventTouchUpInside];
    [V2 addSubview:goButton2];
    
}


-(void)getUnitUI:(NSString*)name Hight:(float)Hight type:(NSInteger)type tagNum:(NSInteger)tagNum firstView:(UIView*)firstView{
    float W1=8*NOW_SIZE;
    
    UIView *V011 = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE,Hight, SCREEN_Width,_H1)];
    V011.backgroundColor =[UIColor whiteColor];
    [firstView addSubview:V011];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,2*HEIGHT_SIZE+Hight, W1, _H1)];
    label.text=@"*";
    label.textAlignment=NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
    label.textColor=COLOR(154, 154, 154, 1);
    if (type!=2) {
        [firstView addSubview:label];
    }
    
    
    NSString *nameString=[NSString stringWithFormat:@"%@:",name];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
    CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, _H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE+W1, Hight,size.width, _H1)];
    lable1.textColor = COLOR(154, 154, 154, 1);
    lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    lable1.textAlignment=NSTextAlignmentLeft;
    lable1.text=nameString;
    [firstView addSubview:lable1];
    
    UIView *V01 = [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,_H1+Hight-1*HEIGHT_SIZE, SCREEN_Width-(2*10*NOW_SIZE),1*HEIGHT_SIZE)];
    V01.backgroundColor = COLOR(222, 222, 222, 1);
    [firstView addSubview:V01];
    
    float WK1=5*NOW_SIZE;
    float W_image1=6*HEIGHT_SIZE;
    float H_image1=12*HEIGHT_SIZE;
    float W2=SCREEN_Width-(10*NOW_SIZE+W1+size.width+WK1)-10*NOW_SIZE;
    
    if (type==1 || type==2) {
        
        UIView *V0= [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE+W1+size.width+WK1,Hight, W2,_H1)];
        V0.backgroundColor = [UIColor clearColor];
        V0.userInteractionEnabled=YES;
        V0.tag=tagNum;
        UITapGestureRecognizer *labelTap1;
        labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectChioce:)];
        [V0 addGestureRecognizer:labelTap1];
        [firstView addSubview:V0];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,W2-W_image1-WK1, _H1)];
        lable1.textColor = COLOR(51, 51, 51, 1);
        lable1.tag=tagNum+100;
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.userInteractionEnabled=YES;
        [V0 addSubview:lable1];
        
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(W2-W_image1, (_H1-H_image1)/2, W_image1,H_image1 )];
        image2.userInteractionEnabled=YES;
        image2.image=IMAGE(@"select_icon.png");
        [V0 addSubview:image2];
        
    }else{
        UITextField *text1 = [[UITextField alloc] initWithFrame:CGRectMake(10*NOW_SIZE+W1+size.width+WK1, Hight, W2, _H1)];
        text1.textColor =  COLOR(51, 51, 51, 1);
        text1.tintColor =  COLOR(51, 51, 51, 1);
        text1.tag=tagNum+100;
        text1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [firstView addSubview:text1];
        
        [_textFieldMutableArray addObject:text1];
    }
    
}

-(void)selectChioce:(UITapGestureRecognizer*)tap{
    NSInteger Num=tap.view.tag;
    
    if (Num==3400 || Num==4400 ){
        [self choiceTheUser:Num];
    }
    
    if (Num==4401 ){
        [self choiceThePlant];
    }
    
    if (Num==3501 ){
        [self pickDate];
    }
    
    if (Num==3504 ){
        [self choiceTheCountry];
    }
    if (Num==3505 ){
        [self getTheLocation];
    }
    
    if (Num==2500 || Num==2504 || Num==3503) {
        [self choiceTheValue:Num];
    }
    
}


-(void)getTheLocation{
    [[SNLocationManager shareLocationManager] startUpdatingLocationWithSuccess:^(CLLocation *location, CLPlacemark *placemark) {
        NSString* _longitude=[NSString stringWithFormat:@"%.2f", location.coordinate.longitude];
        NSString* _latitude=[NSString stringWithFormat:@"%.2f", location.coordinate.latitude];
        NSString* _city=placemark.locality;
        //   NSString* _countryGet=placemark.country;
        
        NSString *lableText=[NSString stringWithFormat:@"%@(%@,%@)",_city,_longitude,_latitude];
        UILabel *lable=[self.view viewWithTag:3505+100];
        lable.text=lableText;
        
    } andFailure:^(CLRegion *region, NSError *error) {
        
    }];
}

-(void)choiceThePlant{
    _userListArray=@[@"中国",@"美国",@"英国",@"朝国",@"钱国"];
    if(_userListArray.count>0){
        
        AnotherSearchViewController *another = [AnotherSearchViewController new];
        //返回选中搜索的结果
        [another didSelectedItem:^(NSString *item) {
            UILabel *lable=[self.view viewWithTag:4401+100];
            lable.text=item;
        }];
        another.title =@"选择所属电站";
        another.isNeedRightItem=YES;
        another.rightItemBlock = ^{
            [self gotoAddUser];
        };
        another.dataSource=_userListArray;
        [self.navigationController pushViewController:another animated:YES];
    }else{
        [self showToastViewWithTitle:@"点击获取电站列表"];
        return;
    }
}


-(void)choiceTheUser:(NSInteger)Num{
    
    _userListArray=@[@"中国",@"美国",@"英国",@"朝国",@"钱国"];
    if(_userListArray.count>0){
        
        AnotherSearchViewController *another = [AnotherSearchViewController new];
        //返回选中搜索的结果
        [another didSelectedItem:^(NSString *item) {
            
            UILabel *lable=[self.view viewWithTag:Num+100];
            lable.text=item;
        }];
        another.title =@"选择所属用户";
        another.isNeedRightItem=YES;
        another.rightItemBlock = ^{
            [self gotoAddUser];
        };
        another.dataSource=_userListArray;
        [self.navigationController pushViewController:another animated:YES];
    }else{
        [self showToastViewWithTitle:@"点击获取用户列表"];
        return;
    }
    
}

-(void)gotoAddUser{
    
}


-(void)choiceTheCountry{
    _countryListArray=@[@"中国",@"美国",@"英国",@"朝国",@"钱国"];
    if(_countryListArray.count>0){
        
        AnotherSearchViewController *another = [AnotherSearchViewController new];
        //返回选中搜索的结果
        [another didSelectedItem:^(NSString *item) {
            UILabel *lable=[self.view viewWithTag:3504+100];
            lable.text=item;
        }];
        another.title =@"选择用户";
        another.isNeedRightItem=YES;
        another.rightItemBlock = ^{
            [self gotoAddUser];
        };
        another.dataSource=_countryListArray;
        [self.navigationController pushViewController:another animated:YES];
    }else{
        [self showToastViewWithTitle:@"点击获取国家列表"];
        return;
    }
    
    
}

-(void)choiceTheValue:(NSInteger)Num{
    NSArray *nameArray;NSString *title;
    if (Num==2500) {
        title=@"选择服务器地址";
        NSArray *serverListArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"OssServerAddress"];
        NSMutableArray *array1=[NSMutableArray array];
        for (NSDictionary*dic in serverListArray) {
            [array1 addObject:dic[@"url"]];
        }
        nameArray=[NSArray arrayWithArray:array1];
    }else if (Num==2504 || Num==3503) {
        title=@"选择时区";
        nameArray=[NSArray arrayWithObjects:@"+1",@"+2",@"+3",@"+4",@"+5",@"+6",@"+7",@"+8",@"+9",@"+10",@"+11",@"+12",@"-1",@"-2",@"-3",@"-4",@"-5",@"-6",@"-7",@"-8",@"-9",@"-10",@"-11",@"-12", nil];
    }
    
    
    
    [ZJBLStoreShopTypeAlert showWithTitle:title titles:nameArray selectIndex:^(NSInteger selectIndex) {
        
        
    }selectValue:^(NSString *selectValue){
        UILabel *lable=[self.view viewWithTag:Num+100];
        lable.text=selectValue;
        
    } showCloseButton:YES ];
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
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd"];
    self.currentDay = [self.dayFormatter stringFromDate:self.date.date];
    UILabel *lable=[self.view viewWithTag:3501+100];
    lable.text=_currentDay;
    
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}



-(void)scanSn{
    
    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeAll onFinish:^(NSString *result, NSError *error) {
        if (error) {
            NSLog(@"error: %@",error);
        } else {
            [self ScanGoToNet:result];
            NSLog(@"扫描结果：%@",result);
        }
    }];
    scanVc.titleString=root_saomiao_sn;
    scanVc.scanBarType=0;
    [self.navigationController pushViewController:scanVc animated:YES];
    
}



- (void)ScanGoToNet:(NSString *)result {
    NSString *validCodeString=[self getValidCode:result];
    
    UILabel *lable=[self.view viewWithTag:4500+100];
    lable.text=result;
    
    UILabel *lable1=[self.view viewWithTag:4501+100];
    lable1.text=validCodeString;
}







-(void)NetForUser{
    
        _oneDic=[NSMutableDictionary new];
    
        NSArray *alertArray=@[@"请选择服务器地址",@"请填写用户名",@"请填写密码",@"请填写密码",@"请选择时区",@"请填写手机号"];
        NSArray*keyArray=@[@"serverId",@"userName",@"password",@"passwordtwo",@"timezone",@"phone"];
        NSString *pass1String;    NSString *pass2String;
        
        for (int i=0; i<alertArray.count; i++) {
            
            
            if (i==0 || i==4) {
                UILabel *lable=[self.view viewWithTag:2600+i];
                
                if ([lable.text isEqualToString:@""] || lable.text==nil) {
                    [self showToastViewWithTitle:alertArray[i]];
                    return;
                }else{
                    [_oneDic setObject:lable.text forKey:keyArray[i]];
                }
            }else{
                UITextField *field=[self.view viewWithTag:2600+i];
                
                if ([field.text isEqualToString:@""] || field.text==nil) {
                    [self showToastViewWithTitle:alertArray[i]];
                    return;
                }else{
                    [_oneDic setObject:field.text forKey:keyArray[i]];
                }
                
                if (i==1) {
                    if ([field.text length]<3) {
                        [self showToastViewWithTitle:root_daYu_san];
                        return;
                    }
                }
                if (i==2) {
                    if ([field.text length]<6) {
                        [self showToastViewWithTitle:root_daYu_liu];
                        return;
                    }
                }
                
                if (i==2) {
                    pass1String=field.text;
                }
                if (i==3) {
                    pass2String=field.text;
                }
            }
            
        }
        
        if (![pass1String isEqualToString:pass2String]) {
            [self showToastViewWithTitle:@"请输入相同的密码"];
            return;
        }
        
  
 
    
}


-(void)NetForPlant{
    
 
        NSArray *alertArray=@[@"请填写电站名称",@"请选择安装时间",@"请填写装机容量",@"请选择时区",@"请选择国家"];
        NSArray*keyArray=@[@"serverId",@"userName",@"password",@"passwordtwo",@"timezone",@"phone"];
        
        

            UILabel *lable=[self.view viewWithTag:3400+100];
            if ([lable.text isEqualToString:@""] || lable.text==nil) {
                [self showToastViewWithTitle:@"请选择电站所属用户"];
                return;
            }

        
        for (int i=0; i<alertArray.count; i++) {
            if (i==0 || i==4) {
                UILabel *lable=[self.view viewWithTag:3600+i];
                if ([lable.text isEqualToString:@""] || lable.text==nil) {
                    [self showToastViewWithTitle:alertArray[i]];
                    return;
                }else{
                    [_twoDic setObject:lable.text forKey:keyArray[i]];
                }
            }else{
                UITextField *field=[self.view viewWithTag:3600+i];
                if ([field.text isEqualToString:@""] || field.text==nil) {
                    [self showToastViewWithTitle:alertArray[i]];
                    return;
                }else{
                    [_twoDic setObject:field.text forKey:keyArray[i]];
                }
                
            }
            
        }
        
   
    
}

-(void)NetForDevice{
    
    
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
