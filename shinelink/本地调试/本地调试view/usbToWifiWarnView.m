//
//  usbToWifiWarnView.m
//  ShinePhone
//
//  Created by sky on 2017/11/1.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "usbToWifiWarnView.h"
#import "wifiToPvOne.h"
#import "usbToWifiWarnList.h"

@interface usbToWifiWarnView ()

@property(nonatomic,strong)NSString *faultString;
@property(nonatomic,strong)NSString *faultStateString;
@property(nonatomic,strong)NSString *warnString;
@property(nonatomic,strong)wifiToPvOne*ControlOne;

@end

@implementation usbToWifiWarnView

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor=COLOR(242, 242, 242, 1);
    _faultString=@""; _faultStateString=@""; _warnString=@"";
    [self getData];
    
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
    }
    
    [self getTimeData];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_MAX_325 style:UIBarButtonItemStylePlain target:self action:@selector(goToHistory)];
    self.navigationItem.rightBarButtonItem=rightItem;
}

-(void)goToHistory{
    usbToWifiWarnList *testView=[[usbToWifiWarnList alloc]init];
    [self.navigationController pushViewController:testView animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFirstData2:) name: @"TcpReceiveDataTwo" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFailed) name: @"TcpReceiveDataTwoFailed" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_ControlOne) {
        [_ControlOne disConnect];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveDataTwo" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveDataTwoFailed" object:nil];
    
}

-(void)receiveFirstData2:(NSNotification*) notification{
    NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
    NSData *receiveData=[firstDic objectForKey:@"one"];
    Byte *dataArray=(Byte*)[receiveData bytes];
    int monthInt=dataArray[1];
    int dayInt=dataArray[2];
    int hourInt=dataArray[3];
      int minInt=dataArray[4];
    
    NSString*timeString=[NSString stringWithFormat:@"%d-%d %d:%d",monthInt,dayInt,hourInt,minInt];
    
    UIView *V1=[self.view viewWithTag:2000];
    float lableH1=20*HEIGHT_SIZE;
    UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(210*NOW_SIZE, 0,100*NOW_SIZE,lableH1)];
    lable5.textColor =COLOR(51, 51, 51, 1);
    lable5.textAlignment=NSTextAlignmentRight;
    lable5.text=timeString;
    lable5.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [V1 addSubview:lable5];
}

-(void)setFailed{

    [self removeTheTcp];
    
     [self performSelector:@selector(getDataAgain) withObject:nil afterDelay:2];
    
 
}

-(void)getDataAgain{
         [_ControlOne goToOneTcp:2 cmdNum:1 cmdType:@"4" regAdd:@"501" Length:@"10"];
}

-(void)removeTheTcp{
    if (_ControlOne) {
        [_ControlOne disConnect];
    }
    
}

-(void)getTimeData{
     [self removeTheTcp];
    
     [_ControlOne goToOneTcp:2 cmdNum:1 cmdType:@"4" regAdd:@"501" Length:@"10"];
}

-(void)initUI{
    float W1=5*NOW_SIZE; float W0=SCREEN_Width-2*W1;
    float H=150*HEIGHT_SIZE;
    
    NSArray *valueArray=@[_faultString,_warnString];
    NSArray *nameArray=@[[NSString stringWithFormat:@"%@:%@",root_MAX_324,_faultCode],[NSString stringWithFormat:@"%@:%@",root_MAX_326,_warnCode]];
    
    for (int i=0; i<valueArray.count; i++) {
        UIView* _secondView=[[UIView alloc]initWithFrame:CGRectMake(W1, 5*HEIGHT_SIZE+H*i, W0, H)];
        _secondView.backgroundColor=[UIColor clearColor];
        _secondView.tag=2000+i;
        [self.view addSubview:_secondView];
        
        
        UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(1*NOW_SIZE, 3*HEIGHT_SIZE, 3*NOW_SIZE, 14*HEIGHT_SIZE)];
        V1.backgroundColor=MainColor;
        [_secondView addSubview:V1];
        
        float lableH1=20*HEIGHT_SIZE;
        UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(7*NOW_SIZE, 0,200*NOW_SIZE,lableH1)];
        lable5.textColor =COLOR(51, 51, 51, 1);
        lable5.textAlignment=NSTextAlignmentLeft;
        lable5.text=nameArray[i];
        lable5.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_secondView addSubview:lable5];
        
        UIView *V2=[[UIView alloc]initWithFrame:CGRectMake(0, lableH1+5*HEIGHT_SIZE, SCREEN_Width, 115*HEIGHT_SIZE)];
        V2.backgroundColor=[UIColor whiteColor];
        [_secondView addSubview:V2];
        
        UILabel *lable6 = [[UILabel alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 5*HEIGHT_SIZE,W0-40*NOW_SIZE,100*HEIGHT_SIZE)];
        lable6.textColor =COLOR(102, 102, 102, 1);
        lable6.textAlignment=NSTextAlignmentLeft;
        lable6.text=valueArray[i];
        lable6.numberOfLines=0;
        lable6.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [V2 addSubview:lable6];
    }
 
    
}


-(void)getData{
    int faultInt=[_faultCode intValue];
     int warnInt=[_warnCode intValue];
 
    if (faultInt==101) {
          _faultString=root_MAX_327;
    }else if (faultInt==102) {
        _faultString=root_MAX_328;
    }else if (faultInt==108) {
         _faultString=root_MAX_329;
    }else if (faultInt==112) {
        _faultString=root_MAX_330;
    }else if (faultInt==113) {
        _faultString=root_MAX_331;
    }else if (faultInt==114) {
        _faultString=root_MAX_332;
    }else if (faultInt==117) {
        _faultString=root_MAX_333;
    }else if (faultInt==121) {
        _faultString=root_MAX_334;
    }else if (faultInt==122) {
        _faultString=root_MAX_335;
    }else if (faultInt==124) {
        _faultString=root_MAX_336;
    }else if (faultInt==125) {
        _faultString=root_MAX_337;
    }else if (faultInt==126) {
        _faultString=root_MAX_338;
    }else if (faultInt==127) {
        _faultString=root_MAX_339;
    }else if (faultInt==128) {
        _faultString=root_MAX_340;
    }else if (faultInt==129) {
        _faultString=root_MAX_341;
    }else if (faultInt==130) {
        _faultString=root_MAX_342;
    }else if (faultInt==99) {
        _faultString=root_MAX_351;
    }else{
         _faultString=[NSString stringWithFormat:@"Error:%d",faultInt];
    }
    
    
    if (warnInt==100) {
        _warnString=root_MAX_343;
    }else if (warnInt==104) {
        _warnString=root_MAX_344;
    }else if (warnInt==106) {
        _warnString=root_MAX_345;
    }else if (warnInt==107) {
        _warnString=root_MAX_346;
    }else if (warnInt==108) {
        _warnString=root_MAX_347;
    }else if (warnInt==109) {
        _warnString=root_MAX_348;
    }else if (warnInt==110) {
        _warnString=root_MAX_349;
    }else if (warnInt==111) {
        _warnString=root_MAX_350;
    }else if (warnInt==99) {
        _warnString=root_MAX_352;
    }else{
        _warnString=[NSString stringWithFormat:@"Warning:%d",warnInt];
    }
      
    [self initUI];
    
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
