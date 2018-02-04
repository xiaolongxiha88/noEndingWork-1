//
//  checkTwoView.m
//  ShinePhone
//
//  Created by sky on 2018/1/27.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "checkTwoView.h"
#import "YDChart.h"
#import "YDLineChart.h"
#import "YDLineY.h"
#import "CustomProgress.h"
#import "usbToWifiControlTwo.h"
#import "usbToWifiDataControl.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "RKAlertView.h"
static float keyOneWaitTime=5.0;
static int  firstReadTime=72.0;
static int unit=72/10.0;
static int unit2=28/4;

@interface checkTwoView ()
{
    CustomProgress *custompro;
    int present;
    CGSize lable1Size2;
    float everyLalbeH;
    float Lable11x;
    float W0;
}
@property (strong, nonatomic) YDLineChart *lineChartYD ;
@property (strong, nonatomic) YDLineChart *lineChartYDOne ;

@property (strong, nonatomic) YDLineY *YlineChartYD ;
@property (strong, nonatomic) YDLineY *YlineChartYDOne ;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGFloat pointGap;
@property (assign, nonatomic) CGFloat firstPointGap;
@property (assign, nonatomic) CGFloat moveDistance;
@property (assign, nonatomic) int Type;
@property (strong, nonatomic)UILabel *lable0;
@property (strong, nonatomic)UILabel *lable01;
@property (nonatomic) BOOL isReadNow;
@property (strong, nonatomic)NSArray *vocArray;
@property (strong, nonatomic)NSArray *colorArray;
@property (strong, nonatomic)NSMutableArray *valueForLeftLableArray;

@property(nonatomic,strong)wifiToPvOne*ControlOne;

@property (nonatomic) BOOL isReadFirstLongTimeOver;
@property (nonatomic) BOOL isIVchar;
@property (nonatomic) BOOL isReadfirstDataOver;
@property (strong, nonatomic)NSArray *allSendDataArray;
@property (strong, nonatomic)NSArray *allSendDataBoolArray;

@property (strong, nonatomic)NSMutableArray *allDataArray;    //接收的全部数据
@property (strong, nonatomic)NSMutableArray *allDataForCharArray;         //转换后的全部数据
@property (assign, nonatomic) int sendDataTime;
@property (assign, nonatomic) int progressNum;
@property (assign, nonatomic) int progressNumAll;

@property (strong, nonatomic)NSTimer *timer;
@property (strong, nonatomic)NSMutableArray *selectBoolArray;
@property (strong, nonatomic)NSString*sendSNString;
@property(nonatomic,strong)usbToWifiDataControl*changeDataValue;
@property (strong, nonatomic)NSMutableArray *xNumArray;

@property (strong, nonatomic)UIScrollView *viewAll;
@property (strong, nonatomic)UIView* view0;
@property (strong, nonatomic)UIView* view2;
@end

@implementation checkTwoView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
    }
    if (!_changeDataValue) {
        _changeDataValue=[[usbToWifiDataControl alloc]init];
    }
    
    _isReadfirstDataOver=NO;
    _isIVchar=YES;
    
     _viewAll= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_Width, SCREEN_Height)];
    _viewAll.backgroundColor=[UIColor whiteColor];
    _viewAll.contentSize=CGSizeMake(0, 0);
    [self.view addSubview:_viewAll];
    
    [self initUI];
    
}




#pragma mark - 数据交互
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveData:) name: @"TcpReceiveOneKey" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFailed) name: @"TcpReceiveOneKeyFailed" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_ControlOne) {
        [_ControlOne disConnect];
    }
    if (_timer) {
        _timer.fireDate=[NSDate distantFuture];
        _timer=nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveOneKey" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveOneKeyFailed" object:nil];
    
}


#pragma mark - UI界面
-(void)initUI{
 
    float lableH=30*HEIGHT_SIZE; float lableW1=40*NOW_SIZE;
    float X0=10*NOW_SIZE;
    _view0=[[UIView alloc]initWithFrame:CGRectMake(0,5*HEIGHT_SIZE, SCREEN_Width, lableH*2)];
    _view0.backgroundColor=[UIColor whiteColor];
    [_viewAll addSubview:_view0];
    
    NSString *lable0String=@"故障序号:";
    CGSize lable0StringSize=[self getStringSize:12*HEIGHT_SIZE Wsize:CGFLOAT_MAX Hsize:lableH stringName:lable0String];
    
    UILabel* lable0 = [[UILabel alloc]initWithFrame:CGRectMake(X0, 0,lable0StringSize.width,lableH)];
    lable0.textColor =COLOR(51, 51, 51, 1);
    lable0.textAlignment=NSTextAlignmentLeft;
    lable0.text=lable0String;
    lable0.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_view0 addSubview:lable0];
    
    
    UIColor *titleColor=COLOR(153, 153, 153, 1);
     UIColor *backgroundColor=COLOR(242, 242, 242, 1);
    UIColor *layerColor=COLOR(221, 221, 221, 1);
    float buttonW=80*NOW_SIZE;   float buttonH=20*HEIGHT_SIZE;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(X0*2+lable0StringSize.width, (lableH-buttonH)/2, buttonW, buttonH);
    [button1 setTitleColor:titleColor forState:UIControlStateNormal];
    [button1 setTitleColor:COLOR(242, 242, 242, 1) forState:UIControlStateHighlighted];
    button1.layer.borderWidth=0.8*HEIGHT_SIZE;
    button1.layer.borderColor=layerColor.CGColor;
    button1.tag = 3000;
    button1.layer.cornerRadius=buttonH/2;
    button1.backgroundColor=backgroundColor;
    button1.titleLabel.font=[UIFont systemFontOfSize: 12*HEIGHT_SIZE];
    [button1 setTitle:@"点击选择" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(tapInfo:) forControlEvents:UIControlEventTouchUpInside];
    [_view0 addSubview:button1];
    
    float lable1W=SCREEN_Width-X0*4-lable0StringSize.width-buttonW-0.5*X0;
        NSString *lable1String=@"故障码:--";
    UILabel* lable1 = [[UILabel alloc]initWithFrame:CGRectMake(X0*3+lable0StringSize.width+buttonW,0,lable1W,lableH)];
    lable1.textColor =COLOR(51, 51, 51, 1);
    lable1.textAlignment=NSTextAlignmentRight;
    lable1.text=lable1String;
    lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_view0 addSubview:lable1];
    
    _lable0 = [[UILabel alloc]initWithFrame:CGRectMake(0,lableH,SCREEN_Width,lableH)];
    _lable0.textColor =MainColor;
    _lable0.textAlignment=NSTextAlignmentCenter;
    _lable0.text=@"波形触发时间:--:--:--";
    _lable0.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_view0 addSubview:_lable0];
    
    
    float lastH=40*HEIGHT_SIZE;
    _isReadNow=NO;
    custompro = [[CustomProgress alloc] initWithFrame:CGRectMake(0, ScreenHeight-lastH-NavigationbarHeight-StatusHeight, ScreenWidth, lastH)];
    custompro.maxValue = 100;
    //设置背景色
    custompro.bgimg.backgroundColor =COLOR(0, 156, 255, 1);
    custompro.leftimg.backgroundColor =COLOR(53, 177, 255, 1);
    
    custompro.presentlab.textColor = [UIColor whiteColor];
    custompro.presentlab.text = @"开始";
    [self.view addSubview:custompro];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goStopRead:)];
    [custompro addGestureRecognizer:tapGestureRecognizer];
    
    
    _lable01 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-lableW1-15*NOW_SIZE, 220*HEIGHT_SIZE+60*HEIGHT_SIZE,lableW1,15*HEIGHT_SIZE)];
    _lable01.textColor =COLOR(51, 51, 51, 1);
    _lable01.textAlignment=NSTextAlignmentRight;
    _lable01.text=@"";
    _lable01.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.view addSubview:_lable01];
    
    float view2H=SCREEN_Height-300*HEIGHT_SIZE-lastH-NavigationbarHeight-StatusHeight;
    everyLalbeH=view2H/5;
    
    _view2=[[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_Height-lastH-view2H-NavigationbarHeight-StatusHeight-10*HEIGHT_SIZE, SCREEN_Width, view2H)];
    _view2.backgroundColor=[UIColor clearColor];
    [_viewAll addSubview:_view2];
    
    NSArray *lableNameArray=@[@"ID:Number",@"显示倍数",@"波形值"];
    
     W0=SCREEN_Width/lableNameArray.count;
    CGSize lable1Size=[self getStringSize:14*HEIGHT_SIZE Wsize:CGFLOAT_MAX Hsize:everyLalbeH stringName:lableNameArray[0]];
    lable1Size2=[self getStringSize:14*HEIGHT_SIZE Wsize:CGFLOAT_MAX Hsize:everyLalbeH stringName:lableNameArray[2]];
    
    for (int i=0; i<lableNameArray.count; i++) {
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0+W0*i, 0,W0,everyLalbeH)];
        titleLable.textColor =MainColor;
        titleLable.textAlignment=NSTextAlignmentCenter;
        titleLable.text=lableNameArray[i];
        titleLable.tag=3100+i;
        titleLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_view2 addSubview:titleLable];
    }

    _colorArray=@[COLOR(208, 107, 107, 1),COLOR(217, 189, 60, 1),COLOR(85, 207, 85, 1),COLOR(85, 122, 207, 1)];
    
    float imageViewH=10*HEIGHT_SIZE; float Wk=2*NOW_SIZE;
    float imageViewx=(W0-lable1Size.width)/2-imageViewH-Wk;
    
    _xNumArray=[NSMutableArray array];
    
    for (int i=0; i<_colorArray.count; i++) {
        
        //        UIView* view21=[[UIView alloc]initWithFrame:CGRectMake(0,everyLalbeH*(i+1), SCREEN_Width/2, everyLalbeH)];
        //        view21.backgroundColor=[UIColor whiteColor];
        //        [view2 addSubview:view21];
        
        [_xNumArray addObject:@"1"];
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(0,everyLalbeH*(i+1),W0, everyLalbeH);
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setTitleColor:COLOR(242, 242, 242, 1) forState:UIControlStateHighlighted];
        button1.tag = 4000+i;
        button1.backgroundColor=[UIColor whiteColor];
        button1.selected=YES;
        button1.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
        [button1 setTitle:@"" forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(buttonForNum:) forControlEvents:UIControlEventTouchUpInside];
        [_view2 addSubview:button1];
        
        UIView* imageView=[[UIView alloc]initWithFrame:CGRectMake(imageViewx,(everyLalbeH-imageViewH)/2, imageViewH, imageViewH)];
        imageView.backgroundColor=COLOR(242, 242, 242, 1);
        imageView.tag=5000+i;
        [button1 addSubview:imageView];
        
        Lable11x=imageViewx+imageViewH+Wk*2;
        UILabel *Lable11 = [[UILabel alloc]initWithFrame:CGRectMake(Lable11x, 0,W0-Lable11x,everyLalbeH)];
        Lable11.textColor =COLOR(102, 102, 102, 1);
        Lable11.textAlignment=NSTextAlignmentLeft;
        Lable11.adjustsFontSizeToFitWidth=YES;
        Lable11.text=@"(--,--)";
        Lable11.tag=6000+i;
        Lable11.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [button1 addSubview:Lable11];
        
        ///////////    
        
        float buttonW=80*NOW_SIZE;   float buttonH=20*HEIGHT_SIZE;
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(W0+(W0-buttonW)/2, (everyLalbeH-buttonH)/2+everyLalbeH*(i+1), buttonW, buttonH);
        [button2 setTitleColor:titleColor forState:UIControlStateNormal];
        [button2 setTitleColor:backgroundColor forState:UIControlStateHighlighted];
        button2.layer.borderWidth=0.8*HEIGHT_SIZE;
        button2.layer.borderColor=layerColor.CGColor;
        button2.tag = 3500+i;
        button2.layer.cornerRadius=buttonH/2;
        button2.backgroundColor=backgroundColor;
        button2.titleLabel.font=[UIFont systemFontOfSize: 12*HEIGHT_SIZE];
        [button2 setTitle:@"倍数" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(tapXnum:) forControlEvents:UIControlEventTouchUpInside];
        [_view2 addSubview:button2];
        
        float Lable22W=20*NOW_SIZE;
        UILabel *Lable22 = [[UILabel alloc]initWithFrame:CGRectMake(W0+(W0-buttonW)/2-Lable22W-2*NOW_SIZE, +everyLalbeH*(i+1),Lable22W,everyLalbeH)];
        Lable22.textColor =COLOR(102, 102, 102, 1);
        Lable22.textAlignment=NSTextAlignmentRight;
        Lable22.adjustsFontSizeToFitWidth=YES;
        Lable22.text=@"X";
        Lable22.tag=6000+i;
        Lable22.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_view2 addSubview:Lable22];
        
        //////////////
        UIView* view22=[[UIView alloc]initWithFrame:CGRectMake(W0*2,everyLalbeH*(i+1), W0, everyLalbeH)];
        view22.backgroundColor=[UIColor whiteColor];
        [_view2 addSubview:view22];
        
        //  UILabel *Lable22 = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/2-lable1Size2.width)/2-Wk, 0,ScreenWidth/2-Lable11x,everyLalbeH)];
        UILabel *Lable33 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,W0,everyLalbeH)];
        Lable33.textColor =COLOR(102, 102, 102, 1);
        Lable33.textAlignment=NSTextAlignmentCenter;
        Lable33.adjustsFontSizeToFitWidth=YES;
        Lable33.text=@"(--,--)";
        Lable33.tag=7000+i;
        Lable33.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [view22 addSubview:Lable33];
        
        
        
        
    }
    
    [self showFirstAndFourQuardrant];
    
}

-(void)tapXnum:(UIButton*)button{
   
    [RKAlertView showAlertPlainTextWithTitle:@"请填写曲线显示的倍数" message:nil cancelTitle:root_cancel confirmTitle:root_OK alertViewStyle:UIAlertViewStylePlainTextInput confrimBlock:^(UIAlertView *alertView) {
        NSLog(@"确认了输入：%@",[alertView textFieldAtIndex:0].text);
        NSString *alert1=[alertView textFieldAtIndex:0].text;
           NSInteger Num=button.tag-3500;
    
        [_xNumArray setObject:alert1 atIndexedSubscript:Num];
          [ button setTitle:alert1 forState:UIControlStateNormal];

        
    } cancelBlock:^{
        NSLog(@"取消了");
    }];
}




-(void)tapInfo:(UITapGestureRecognizer*)Tap{
  //  NSInteger Num=Tap.view.tag;
    NSMutableArray*NameArray=[NSMutableArray array];
    for (int i=1; i<31; i++) {
        [NameArray addObject:[NSString stringWithFormat:@"%d",i]];
    }

       NSString* title=@"选择故障序号";

   
    [ZJBLStoreShopTypeAlert showWithTitle:title titles:NameArray selectIndex:^(NSInteger selectIndex) {

    }selectValue:^(NSString *selectValue){
        _sendSNString=selectValue;
        UIButton*button=[_viewAll viewWithTag:3000];
            [button setTitle:selectValue forState:UIControlStateNormal];
    } showCloseButton:YES ];
    
}


//左边Lable的使能按钮开关
-(void)buttonForNum:(UIButton*)button{
    button.selected = !button.selected;
    NSInteger tagNum=button.tag-4000;
    
    [_selectBoolArray setObject:[NSNumber numberWithBool:button.selected] atIndexedSubscript:tagNum];
    
    UIView* view =[self.view viewWithTag:5000+tagNum];
    UILabel* lable =[self.view viewWithTag:6000+tagNum];
    if ( button.selected) {
        view.backgroundColor=_colorArray[tagNum];
        lable.text=_valueForLeftLableArray[tagNum];
        
    }else{
        view.backgroundColor=COLOR(151, 151, 151, 1);
        lable.text=@"(--,--)";
    }
    
    [self showFirstAndFourQuardrant];
    
}

//准备读取曲线数据
-(void)goToReadCharData{
    _progressNum=0;
    _progressNumAll=0;
    if (!_allSendDataArray) {
   
        _allSendDataArray=@[@[@"1000",@"1125",@"1250",@"1375",@"1500"],@[@"1625",@"1750",@"1875",@"2000",@"2125"],@[@"2250",@"2375",@"2500",@"2625",@"2750"],@[@"2875",@"3000",@"3125",@"3250",@"3375"]];
        
    }
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    }else{
        _timer.fireDate=[NSDate distantPast];
    }
    
}

//开始或取消按钮开关
-(void)goStopRead:( UITapGestureRecognizer *)tap{
    
    if (_sendSNString==nil || [_sendSNString isEqualToString:@""]) {
        [self showToastViewWithTitle:@"请选择故障序号"];
        return;
    }
    
    _isReadNow = !_isReadNow;
    
    if (_isReadNow) {
        if (_isReadfirstDataOver) {
            present=firstReadTime;
            _isReadfirstDataOver=YES;
            [self goToReadTcpData];
        }else{
            [self goToReadFirstData];
        }
        
        custompro.presentlab.text = @"取消";
        
    }else{
        
        present=0;
        [custompro setPresent:present];
        custompro.presentlab.text = @"开始";
        _timer.fireDate=[NSDate distantFuture];
        
    }
    
}

//定时器更新
-(void)updateProgress{
    _progressNum++;
    
    present=_progressNum*unit;
    [custompro setPresent:present];
    
    if (_progressNum>=keyOneWaitTime) {
        _isReadfirstDataOver=YES;
        _timer.fireDate=[NSDate distantFuture];
        _progressNum=0;
        [self goToReadTcpData];
    }
    
}





//读取数据成功
-(void)receiveData:(NSNotification*) notification{
    NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
    if (!_isReadfirstDataOver) {
        
        [self goToReadCharData];
    }else{
        [_allDataArray addObject:firstDic];
        if (_sendDataTime<_allSendDataArray.count-1) {
            _sendDataTime++;
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [_ControlOne goToOneTcp:10 cmdNum:1 cmdType:@"20" regAdd:_allSendDataArray[_sendDataTime] Length:@"125"];
            });
            
            
            
        }
        [self changData];
        
        //收完数据啦~~~~~~~~~~~~~~~~~~~~~~~~~~
        if (_allSendDataArray.count==_allDataArray.count) {
            _isReadfirstDataOver=NO;
            _isReadNow=NO;
        }
    }
    
}

//解析读取的数据
-(void)changData{
    _allDataForCharArray=[NSMutableArray array];
    for (int i=0; i<_allDataArray.count; i++) {
        NSDictionary *dic=[NSDictionary dictionaryWithDictionary:_allDataArray[i]];
        NSData*data= [dic objectForKey:@"one"];
        
        //   Byte *dataArray=(Byte*)[data bytes];
        NSMutableDictionary *dataDic=[NSMutableDictionary new];
        NSInteger LENG=(data.length/2-25)/2;
        for (int K=0; K<LENG;K++) {
            float V=([_changeDataValue changeOneRegister:data registerNum:2*K]/10+i*i*20);
            float I=([_changeDataValue changeOneRegister:data registerNum:2*K+1]/10+(i*200));
            float P=V*I;
            if (_isIVchar) {
                [dataDic setObject:[NSString stringWithFormat:@"%.1f",I] forKey:[NSString stringWithFormat:@"%.f",V]];
            }else{
                [dataDic setObject:[NSString stringWithFormat:@"%.1f",P] forKey:[NSString stringWithFormat:@"%.f",V]];
            }
            
        }
        
        [_allDataForCharArray addObject:dataDic];
        
        
    }
    
    [self updateUI];
    
    
}

//更新曲线图
-(void)updateUI{
    [self showFirstAndFourQuardrant];
}


//读取失败
-(void)setFailed{
    if (!_isReadfirstDataOver) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据读取失败,请重试或检查WiFi连接." message:nil delegate:self cancelButtonTitle:root_cancel otherButtonTitles:@"检查", nil];
        alertView.tag = 1002;
        [alertView show];
    }else{
        [self showAlertViewWithTitle:@"数据读取中断" message:@"请重新读取数据" cancelButtonTitle:root_OK];
        
    }
    present=0;
    [custompro setPresent:present];
    custompro.presentlab.text = @"开始";
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex) {
        if( (alertView.tag == 1001) || (alertView.tag == 1002) || (alertView.tag == 1003)){
            if (deviceSystemVersion>10) {
                NSURL *url = [NSURL URLWithString:@"App-Prefs:root=WIFI"];
                if ([[UIApplication sharedApplication]canOpenURL:url]) {
                    [[UIApplication sharedApplication]openURL:url];
                }
            }else{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
            }
            
        }
        
    }
    
}

//开始读取曲线的寄存器
-(void)goToReadTcpData{
    _allDataArray=[NSMutableArray array];
    _sendDataTime=0;
    [_ControlOne goToOneTcp:10 cmdNum:1 cmdType:@"20" regAdd:_allSendDataArray[_sendDataTime] Length:@"125"];
    
}

//读取刷新的寄存器
-(void)goToReadFirstData{
   
    _selectBoolArray=[NSMutableArray array];
    for (int i=0; i<_colorArray.count; i++) {
        [_selectBoolArray addObject:[NSNumber numberWithBool:YES]];
    }
    NSString *LENTH=[NSString stringWithFormat:@"1_2_%d",[_sendSNString intValue]];
    _isReadfirstDataOver=NO;
    [_ControlOne goToOneTcp:9 cmdNum:1 cmdType:@"16" regAdd:@"259" Length:LENTH];
}

//长按后右边的Lable显示值
-(void)updataTheLableValue:(int)xValue{
    NSString* xValueString=[NSString stringWithFormat:@"%d",xValue];
    NSMutableArray *value1Array=[NSMutableArray array];
    NSMutableArray *value2Array=[NSMutableArray array];
    for (int i=0; i<_allDataForCharArray.count; i++) {
        NSDictionary *dic=[NSDictionary dictionaryWithDictionary:_allDataForCharArray[i]];
        [value1Array addObject:xValueString];
        
        if ([dic.allKeys containsObject:xValueString]) {
            [value2Array addObject:[dic objectForKey:xValueString]];
        }else{
            NSArray *allKeyArray0=dic.allKeys;
            NSSortDescriptor *sortDescripttor1 = [NSSortDescriptor sortDescriptorWithKey:@"intValue" ascending:YES];
            NSArray *allKeyArray = [allKeyArray0 sortedArrayUsingDescriptors:@[sortDescripttor1]];
            
            float maxX= [[allKeyArray valueForKeyPath:@"@max.floatValue"] integerValue];
            float minX= [[allKeyArray valueForKeyPath:@"@min.floatValue"] integerValue];
            if ((xValue>maxX) || (xValue<minX)) {
                [value2Array addObject:[NSString stringWithFormat:@"%.f",0.0]];
            }else{
                for (int i=0; i<allKeyArray.count-1; i++) {
                    int A=[[NSString stringWithFormat:@"%@",allKeyArray[i]] intValue];
                    int B=[[NSString stringWithFormat:@"%@",allKeyArray[i+1]] intValue];
                    if ((A<xValue) && ( B>xValue)) {
                        
                        CGFloat y1=[[dic objectForKey:[NSString stringWithFormat:@"%d",A]] floatValue];
                        CGFloat y2=[[dic objectForKey:[NSString stringWithFormat:@"%d",B]] floatValue];
                        CGFloat yValue;
                        [value2Array addObject:[NSString stringWithFormat:@"%.f",yValue]];
                        
                    }
                }
            }
            
        }
        
    }
    float Wk=5*NOW_SIZE;
    for (int i=0; i<value1Array.count; i++) {
        BOOL isSelect=[_selectBoolArray[i] boolValue];
        if (isSelect) {
            UILabel *lable=[self.view viewWithTag:7000+i];
            lable.text=[NSString stringWithFormat:@"(%@,%@)",value1Array[i],value2Array[i]];
            lable.frame=CGRectMake((ScreenWidth/2-lable1Size2.width)/2-Wk, 0,ScreenWidth/2-Lable11x,everyLalbeH);
            lable.textAlignment=NSTextAlignmentLeft;
        }
        
        
    }
    
}



//更新左边Lable的值
-(void)updataLeftMaxValue2{
    _valueForLeftLableArray=[NSMutableArray array];
    for (int i=0; i<_allDataForCharArray.count; i++) {
        NSDictionary *dic=[NSDictionary dictionaryWithDictionary:_allDataForCharArray[i]];
        float maxY= [[dic.allValues valueForKeyPath:@"@max.floatValue"] floatValue];
        __block  NSString *maxKey;
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString*obj1=obj;
            float maxyy=[obj1 floatValue];
            if (maxyy==maxY) {
                maxKey=key;
            }
            
        }];
        
        UILabel *lable=[self.view viewWithTag:6000+i];
        lable.text=[NSString stringWithFormat:@"(%.f,%.1f)",[maxKey floatValue],maxY];
        
        [_valueForLeftLableArray addObject:[NSString stringWithFormat:@"(%.f,%.1f)",[maxKey floatValue],maxY]];
        
        UIView *view=[self.view viewWithTag:5000+i];
        view.backgroundColor=_colorArray[i];
        
    }
    
}



#pragma mark - 曲线图
- (void)showFirstAndFourQuardrant{
    float Wx=30*NOW_SIZE;   float Yy=60*HEIGHT_SIZE; float allH=220*HEIGHT_SIZE;
    float Wx2=5*NOW_SIZE;
    float sizeFont=7*HEIGHT_SIZE;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(Wx, Yy, SCREEN_Width-Wx-Wx2, allH)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    NSArray *XLineDataArr=@[@"",@"二月份",@"三月份",@"四月份",@"五月份",@"六月份",@"七月份",@"八月份"];
    NSArray *YLineDataArr=@[@[@"5",@"-220",@"170",@"(-4)",@25,@5,@6,@9],@[@"1",@"-121",@"1",@6,@4,@(-8),@6,@7],@[@"5",@"-14",@"63",@6,@4,@(-8),@12,@17],@[@"13",@"-17",@"8",@63,@4,@(-183),@18,@8]];
    
    
    _lineChartYD = [[YDLineChart alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) andLineChartType:JHChartLineValueNotForEveryXYD];
    _lineChartYD.xLineDataArr = XLineDataArr;
    _lineChartYD.lineChartQuadrantType = JHLineChartQuadrantTypeFirstAndFouthQuardrantYD;
    _lineChartYD.valueArr = YLineDataArr;
    _lineChartYD.yDescTextFontSize = _lineChartYD.xDescTextFontSize = 9.0;
    _lineChartYD.valueFontSize = 9.0;
    /* 值折线的折线颜色 默认暗黑色*/
    _lineChartYD.valueLineColorArr =@[ [UIColor redColor], [UIColor greenColor], [UIColor greenColor], [UIColor greenColor]];
    _lineChartYD.showPointDescription = NO;
    /* 值点的颜色 默认橘黄色*/
    _lineChartYD.pointColorArr = @[[UIColor orangeColor],[UIColor yellowColor],[UIColor yellowColor],[UIColor yellowColor]];
    _lineChartYD.showXDescVertical = YES;
    _lineChartYD.xDescMaxWidth = 15.0;
    /*        是否展示Y轴分层线条 默认否        */
    _lineChartYD.showYLevelLine = NO;
    _lineChartYD.showValueLeadingLine = NO;
    _lineChartYD.showYLevelLine = YES;
    _lineChartYD.showYLine = NO;
    //从下标为1的点开始绘制 默认从下标为0的点开始绘制
    _lineChartYD.drawPathFromXIndex = 0;
    _lineChartYD.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    /* X和Y轴的颜色 默认暗黑色 */
    _lineChartYD.xAndYLineColor = [UIColor darkGrayColor];
    _lineChartYD.backgroundColor = [UIColor whiteColor];
    /* XY轴的刻度颜色 m */
    _lineChartYD.xAndYNumberColor = [UIColor darkGrayColor];
    _lineChartYD.animationDuration=0.01;
    _lineChartYD.contentFill = NO;
    
    _lineChartYD.pathCurve = YES;
    
    
    //    lineChart.contentFillColorArr = @[[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.386],[UIColor colorWithRed:0.000 green:1 blue:0 alpha:0.472]];
    
    [self.view addSubview:_lineChartYD];
    [_lineChartYD showAnimation];
    
    self.pointGap= (_lineChartYD.frame.size.width)/(_lineChartYD.xLineDataArr.count-1);
    _lineChartYD.pointGap= (_lineChartYD.frame.size.width)/(_lineChartYD.xLineDataArr.count-1);
    _firstPointGap=(_lineChartYD.frame.size.width)/(_lineChartYD.xLineDataArr.count-1);
    
    [_scrollView addSubview:_lineChartYD];
    
    _scrollView.contentSize = _lineChartYD.frame.size;
    
    __weak typeof(self) weakSelf = self;
    _lineChartYD.xBlock=^(int xValue){
        [weakSelf updataTheLableValue:xValue];
    };
    
    
    
    _YlineChartYD = [[YDLineY alloc] initWithFrame:CGRectMake(0, Yy, Wx, allH) andLineChartType:JHChartLineValueNotForEveryXYDY];
    _YlineChartYD.xLineDataArr = XLineDataArr;
    _YlineChartYD.contentInsets = UIEdgeInsetsMake(0, 35, 0, 10);
    /* X和Y轴的颜色 默认暗黑色 */
    _YlineChartYD.xAndYLineColor = [UIColor darkGrayColor];
    _YlineChartYD.backgroundColor = [UIColor whiteColor];
    /* XY轴的刻度颜色 m */
    _YlineChartYD.xAndYNumberColor = [UIColor darkGrayColor];
    _YlineChartYD.lineChartQuadrantType = JHLineChartQuadrantTypeFirstAndFouthQuardrantYD;
    _YlineChartYD.valueArr = YLineDataArr;
    _YlineChartYD.yDescTextFontSize = _lineChartYD.xDescTextFontSize = 9.0;
    [self.view addSubview:_YlineChartYD];
    [_YlineChartYD showAnimation];
    
    
    // 2. 捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [_lineChartYD addGestureRecognizer:pinch];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressAction:)];
    [_lineChartYD addGestureRecognizer:longPress];
    
}




// 捏合手势监听方法
- (void)pinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    UIView *recognizerView = recognizer.view;
    if (recognizer.state == 3) {
        
        if (recognizerView.frame.size.width <= self.scrollView.frame.size.width) { //当缩小到小于屏幕宽时，松开回复屏幕宽度
            
            CGFloat scale = self.scrollView.frame.size.width / (recognizerView.frame.size.width);
            
            self.pointGap *= scale;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                CGRect frame = recognizerView.frame;
                frame.size.width = self.scrollView.frame.size.width;
                recognizerView.frame = frame;
            }];
            
            ((YDLineChart*)recognizerView).perXLen=_firstPointGap;
        }
        
        ((YDLineChart*)recognizerView).pointGap = self.pointGap;
        
    }else{
        
        CGFloat currentIndex,leftMagin;
        if( recognizer.numberOfTouches == 2 ) {
            //2.获取捏合中心点 -> 捏合中心点距离scrollviewcontent左侧的距离
            CGPoint p1 = [recognizer locationOfTouch:0 inView:recognizerView];
            CGPoint p2 = [recognizer locationOfTouch:1 inView:recognizerView];
            CGFloat centerX = (p1.x+p2.x)/2;
            leftMagin = centerX - self.scrollView.contentOffset.x;
            //            NSLog(@"centerX = %f",centerX);
            //            NSLog(@"self.scrollView.contentOffset.x = %f",self.scrollView.contentOffset.x);
            //            NSLog(@"leftMagin = %f",leftMagin);
            
            
            currentIndex = centerX / self.pointGap;
            //            NSLog(@"currentIndex = %f",currentIndex);
            
            
            
            self.pointGap *= recognizer.scale;
            //            self.pointGap = self.pointGap > _defaultSpace ? _defaultSpace : self.pointGap;
            //            if (self.pointGap == _defaultSpace) {
            //
            //                [SVProgressHUD showErrorWithStatus:@"已经放至最大"];
            //            }
            
            ((YDLineChart*)recognizerView).pointGap = self.pointGap;
            
            
            ((YDLineChart*)recognizerView).perXLen=((YDLineChart*)recognizerView).perXLen* recognizer.scale;
            
            if (_Type==1) {
                recognizerView.frame = CGRectMake(((YDLineChart*)recognizerView).frame.origin.x, ((YDLineChart*)recognizerView).frame.origin.y, (((YDLineChart*)recognizerView).MaxX-1)* ((YDLineChart*)recognizerView).perXLen, ((YDLineChart*)recognizerView).frame.size.height);
            }else{
                recognizerView.frame = CGRectMake(((YDLineChart*)recognizerView).frame.origin.x, ((YDLineChart*)recognizerView).frame.origin.y, (((YDLineChart*)recognizerView).xLineDataArr.count-1)* ((YDLineChart*)recognizerView).perXLen, ((YDLineChart*)recognizerView).frame.size.height);
            }
            
            
            self.scrollView.contentOffset = CGPointMake(currentIndex*self.pointGap-leftMagin, 0);
            //            NSLog(@"contentOffset = %f",self.scrollView.contentOffset.x);
            
            recognizer.scale = 1.0;
        }
        
        
        
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake(((YDLineChart*)recognizerView).frame.size.width, 0);
    
    
}


//长按手势
- (void)event_longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    UIView *recognizerView = longPress.view;
    
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state) {
        
        CGPoint location = [longPress locationInView:recognizerView];
        
        //相对于屏幕的位置
        CGPoint screenLoc = CGPointMake(location.x - self.scrollView.contentOffset.x, location.y);
        [((YDLineChart*)recognizerView) setScreenLoc:screenLoc];
        
        //ABS  绝对值
        if (ABS(location.x - _moveDistance) > self.pointGap) {
            [((YDLineChart*)recognizerView) setIsLongPress:YES];
            ((YDLineChart*)recognizerView).currentLoc = location;
            _moveDistance = location.x;
        }//不能长按移动一点点就重新绘图  要让定位的点改变了再重新绘图
        
        
   
        
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        
        [self performSelector:@selector(removeLongPress:) withObject:recognizerView afterDelay:3.0];
        
    }
}




-(void)removeLongPress:(UIView*)view{
    _moveDistance = 0;
    //恢复scrollView的滑动
    [((YDLineChart*)view) setIsLongPress:NO];
    
    for (int i=0; i<_colorArray.count; i++) {
        
        UILabel *lable=[self.view viewWithTag:7000+i];
        lable.text=@"(--,--)";
        lable.frame=CGRectMake(0, 0,ScreenWidth/2,everyLalbeH);
        lable.textAlignment=NSTextAlignmentCenter;
        
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
