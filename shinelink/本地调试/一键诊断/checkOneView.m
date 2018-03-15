//
//  checkOneView.m
//  ShinePhone
//
//  Created by sky on 2018/1/27.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "checkOneView.h"
#import "YDChart.h"
#import "YDLineChart.h"
#import "YDLineY.h"
#import "CustomProgress.h"
#import "usbToWifiControlTwo.h"
#import "usbToWifiDataControl.h"


static float keyOneWaitTime=35.0;     //add 5second

static int  firstReadTime=72.0;
 static int unit=72/35.0;
 static int unit2=28/7;

#define   useToWifiCheckOneRemember @"useToWifiCheckOneRemember"
#define   useToWifiCheckOneRememberTime @"useToWifiCheckOneRememberTime"

#define k_MainBoundsWidth [UIScreen mainScreen].bounds.size.width
#define k_MainBoundsHeight [UIScreen mainScreen].bounds.size.height

@interface checkOneView ()
{
       CustomProgress *custompro;
        float present;
    CGSize lable1Size2;
    float everyLalbeH;
    float Lable11x;
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
@property (strong, nonatomic)UILabel *lableSetTime;
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
@property (strong, nonatomic)NSMutableArray *allDataArray;    //接收的全部数据
@property (strong, nonatomic)NSMutableArray *allDataForCharArray;         //转换后的全部数据
@property (assign, nonatomic) int sendDataTime;
@property (assign, nonatomic) int progressNum;
@property (strong, nonatomic)NSTimer *timer;
@property (strong, nonatomic)NSMutableArray *selectBoolArray;

@property(nonatomic,strong)usbToWifiDataControl*changeDataValue;

@end





@implementation checkOneView

- (void)viewDidLoad {
    [super viewDidLoad];
 
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
    }
    if (!_changeDataValue) {
        _changeDataValue=[[usbToWifiDataControl alloc]init];
    }
   
    _isReadfirstDataOver=NO;
    _isIVchar=YES;
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
    if (_oneCharType==1) {
        [self removeTheNotification];
    }

}

-(void)removeTheNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveOneKey" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TcpReceiveOneKeyFailed" object:nil];
    
    if (_oneCharType==2) {
        if (_ControlOne) {
            [_ControlOne disConnect];
            _ControlOne=nil;
        }
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"OneKeyOneViewGoToStartRead" object:nil];
    }
}

-(void)addNotification{
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goToStartRead) name: @"OneKeyOneViewGoToStartRead" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveData:) name: @"TcpReceiveOneKey" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFailed) name: @"TcpReceiveOneKeyFailed" object:nil];
}

-(void)goToStartRead{
    if (!_ControlOne) {
        _ControlOne=[[wifiToPvOne alloc]init];
    }
    _isReadNow=NO;
    [self goStopRead:nil];
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
            if (_oneCharType==1) {
                     [[NSUserDefaults standardUserDefaults] setObject:_allDataArray forKey:useToWifiCheckOneRemember];
            
                NSDateFormatter *dayFormatter=[[NSDateFormatter alloc] init];
           [dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
              NSString *readTime = [dayFormatter stringFromDate:[NSDate date]];
                  [[NSUserDefaults standardUserDefaults] setObject:readTime forKey:useToWifiCheckOneRememberTime];
                  _lableSetTime.text=[NSString stringWithFormat:@"%@:%@",root_MAX_267,readTime];
            }
    
            if (_oneCharType==2) {
                        [self removeTheNotification];
                self.oneViewOverBlock(_allDataArray);
            }
            
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
        NSInteger LENG=(data.length/2-25)/2+1;
        for (int K=0; K<LENG;K++) {
            float V0=[_changeDataValue changeOneRegister:data registerNum:2*K];
            float I0=[_changeDataValue changeOneRegister:data registerNum:2*K+1];
            
            float V=(V0)/10;  //+i*i*20
            float I=(I0)/10;  //+(i*200)
            float P=V*I;
            if (_isIVchar) {
                  [dataDic setObject:[NSString stringWithFormat:@"%.1f",I] forKey:[NSString stringWithFormat:@"%.f",V]];
            }else{
                    [dataDic setObject:[NSString stringWithFormat:@"%.f",P] forKey:[NSString stringWithFormat:@"%.f",V]];
            }
          
        }
        
        [_allDataForCharArray addObject:dataDic];
        
        
    }
    
      [self updateUI];
 
    
}

//更新曲线图
-(void)updateUI{
    [self showFirstQuardrant];
}


//读取失败
-(void)setFailed{
    
    if (_oneCharType==2) {
        [self removeTheNotification];
        [self showAlertViewWithTitle:@"数据读取失败" message:@"请重试或检查WiFi连接." cancelButtonTitle:root_OK];
        return;
    }
    
    if (!_isReadfirstDataOver) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:root_MAX_292 message:nil delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_MAX_293, nil];
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

    _isReadfirstDataOver=NO;
     [_ControlOne goToOneTcp:9 cmdNum:1 cmdType:@"16" regAdd:@"250" Length:@"1_2_1"];
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
                        CGFloat yValue=[self getYvalue:xValue X1:A Y1:y1 X2:B Y2:y2];
                        if (_isIVchar) {
                               [value2Array addObject:[NSString stringWithFormat:@"%.1f",yValue]];
                        }else{
                             [value2Array addObject:[NSString stringWithFormat:@"%.f",yValue]];
                        }
                     
                        
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
           float maxX= [[dic.allKeys valueForKeyPath:@"@max.floatValue"] floatValue];
 

        
        UILabel *lable=[self.view viewWithTag:6000+i];
        
        if (_isIVchar) {
             lable.text=[NSString stringWithFormat:@"(%.f,%.1f)",maxX,maxY];
                    [_valueForLeftLableArray addObject:[NSString stringWithFormat:@"(%.f,%.1f)",maxX,maxY]];
        }else{
            __block  NSString *maxKey;
            [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSString*obj1=obj;
                float maxyy=[obj1 floatValue];
                if (maxyy==maxY) {
                    maxKey=key;
                }
                
            }];
            maxX=[maxKey floatValue];
             lable.text=[NSString stringWithFormat:@"(%.f,%.f)",maxX,maxY];
               [_valueForLeftLableArray addObject:[NSString stringWithFormat:@"(%.f,%.f)",maxX,maxY]];
        }

        
        UIView *view=[self.view viewWithTag:5000+i];
        view.backgroundColor=_colorArray[i];
        
    }
    
}


-(CGFloat)getYvalue:(CGFloat)xValue X1:(CGFloat)x1 Y1:(CGFloat)y1 X2:(CGFloat)x2 Y2:(CGFloat)y2{
    CGFloat yValue;
    CGFloat k=[self calculateKWithX1:x1 Y1:y1 X2:x2 Y2:y2];
    CGFloat b=[self calculateBWithX1:x1 Y1:y1 X2:x2 Y2:y2];
    yValue=k*xValue+b;
    return yValue;
}

-(CGFloat)calculateKWithX1:(CGFloat)x1 Y1:(CGFloat)y1 X2:(CGFloat)x2 Y2:(CGFloat)y2
{
    return (y2 - y1) / (x2 - x1);
}

- (CGFloat)calculateBWithX1:(CGFloat)x1 Y1:(CGFloat)y1 X2:(CGFloat)x2 Y2:(CGFloat)y2
{
    return (y1*(x2 - x1) - x1*(y2 - y1)) / (x2 - x1);
}


#pragma mark - UI界面
-(void)initUI{


    
  //  float lableH=30*HEIGHT_SIZE;
    float lableW1=40*NOW_SIZE;
      float lableH2=20*HEIGHT_SIZE;
    
    if (_oneCharType==1) {
        float _lable00H=15*HEIGHT_SIZE;
        _lableSetTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 0*HEIGHT_SIZE,SCREEN_Width,_lable00H)];
        _lableSetTime.textColor =MainColor;
        _lableSetTime.textAlignment=NSTextAlignmentCenter;
        _lableSetTime.text=[NSString stringWithFormat:@"%@:%@",root_MAX_267,@"2018-3-12 6:30:12"];
        _lableSetTime.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        [self.view addSubview:_lableSetTime];
    }

    
    UIView* view0=[[UIView alloc]initWithFrame:CGRectMake(0,20*HEIGHT_SIZE, SCREEN_Width, lableH2)];
    view0.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view0];
    
      float _lable01H=20*HEIGHT_SIZE;
    _lable0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT_SIZE,lableW1,_lable01H)];
    _lable0.textColor =COLOR(51, 51, 51, 1);
    _lable0.textAlignment=NSTextAlignmentRight;
    _lable0.text=@"(A)";
    _lable0.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.view addSubview:_lable0];
    
    float buttonW=60*NOW_SIZE;   float buttonH=20*HEIGHT_SIZE;
   UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(160*NOW_SIZE, (lableH2-buttonH)/2, buttonW, buttonH);
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setTitleColor:COLOR(242, 242, 242, 1) forState:UIControlStateHighlighted];
    button1.layer.borderWidth=0.8*HEIGHT_SIZE;
    button1.layer.borderColor=MainColor.CGColor;
   button1.tag = 3000;
    button1.layer.cornerRadius=buttonH/2;
    button1.backgroundColor=MainColor;
    button1.selected=YES;
    button1.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [button1 setTitle:@"I-V" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view0 addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(160*NOW_SIZE+buttonW+10*NOW_SIZE, (lableH2-buttonH)/2, buttonW, buttonH);
    [button2 setTitleColor:MainColor forState:UIControlStateNormal];
    [button2 setTitleColor:COLOR(242, 242, 242, 1) forState:UIControlStateHighlighted];
    button2.layer.borderWidth=0.8*HEIGHT_SIZE;
       button2.layer.cornerRadius=buttonH/2;
    button2.layer.borderColor=MainColor.CGColor;
    button2.tag = 3001;
    button2.backgroundColor=[UIColor clearColor];
    button2.selected=NO;
    button2.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [button2 setTitle:@"P-V" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view0 addSubview:button2];
    
    float lastH=40*HEIGHT_SIZE;
     _isReadNow=NO;
    custompro = [[CustomProgress alloc] initWithFrame:CGRectMake(0, ScreenHeight-lastH-NavigationbarHeight-StatusHeight, ScreenWidth, lastH)];
    custompro.maxValue = 100;
    //设置背景色
    custompro.bgimg.backgroundColor =COLOR(0, 156, 255, 1);
    custompro.leftimg.backgroundColor =COLOR(53, 177, 255, 1);

    custompro.presentlab.textColor = [UIColor whiteColor];
    custompro.presentlab.text = @"开始";
    if (_oneCharType != 2) {
            [self.view addSubview:custompro];
    }

    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goStopRead:)];
    [custompro addGestureRecognizer:tapGestureRecognizer];
    
  
    _lable01 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-lableW1-15*NOW_SIZE, 240*HEIGHT_SIZE,lableW1,_lable01H)];
    _lable01.textColor =COLOR(51, 51, 51, 1);
    _lable01.textAlignment=NSTextAlignmentRight;
    _lable01.text=@"(V)";
    _lable01.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [self.view addSubview:_lable01];
    
    
        _colorArray=@[COLOR(208, 107, 107, 1),COLOR(217, 189, 60, 1),COLOR(85, 207, 85, 1),COLOR(85, 122, 207, 1),COLOR(79, 208, 206, 1),COLOR(146, 91, 202, 1),COLOR(161, 177, 55, 1),COLOR(215, 98, 208, 1)];
    
    float view2H=SCREEN_Height-265*HEIGHT_SIZE-lastH-NavigationbarHeight-StatusHeight;
     everyLalbeH=view2H/(_colorArray.count+1);
    UIView* view2=[[UIView alloc]initWithFrame:CGRectMake(0,255*HEIGHT_SIZE, SCREEN_Width, view2H)];
    view2.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view2];
    
    NSArray *lableNameArray=@[@"MPPT(Voc,Isc)",@"(Vpv,Ipv)"];
    
    CGSize lable1Size=[self getStringSize:14*HEIGHT_SIZE Wsize:(ScreenWidth/2) Hsize:everyLalbeH stringName:lableNameArray[0]];
      lable1Size2=[self getStringSize:14*HEIGHT_SIZE Wsize:(ScreenWidth/2) Hsize:everyLalbeH stringName:lableNameArray[1]];
    
    for (int i=0; i<lableNameArray.count; i++) {
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0+(ScreenWidth/2)*i, 0,ScreenWidth/2,everyLalbeH)];
        titleLable.textColor =MainColor;
        titleLable.textAlignment=NSTextAlignmentCenter;
        titleLable.text=lableNameArray[i];
        titleLable.tag=3100+i;
        titleLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [view2 addSubview:titleLable];
    }


    
    float imageViewH=10*HEIGHT_SIZE; float Wk=5*NOW_SIZE;
    float imageViewx=(ScreenWidth/2-lable1Size.width)/2-imageViewH-Wk;
    for (int i=0; i<_colorArray.count; i++) {
        
//        UIView* view21=[[UIView alloc]initWithFrame:CGRectMake(0,everyLalbeH*(i+1), SCREEN_Width/2, everyLalbeH)];
//        view21.backgroundColor=[UIColor whiteColor];
//        [view2 addSubview:view21];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(0,everyLalbeH*(i+1), SCREEN_Width/2, everyLalbeH);
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setTitleColor:COLOR(242, 242, 242, 1) forState:UIControlStateHighlighted];
        button1.tag = 4000+i;
        button1.backgroundColor=[UIColor whiteColor];
        button1.selected=YES;
        button1.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
        [button1 setTitle:@"" forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(buttonForNum:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:button1];
        
        UIView* imageView=[[UIView alloc]initWithFrame:CGRectMake(imageViewx,(everyLalbeH-imageViewH)/2, imageViewH, imageViewH)];
        imageView.backgroundColor=COLOR(242, 242, 242, 1);
        imageView.tag=5000+i;
        [button1 addSubview:imageView];
        
         Lable11x=imageViewx+imageViewH+Wk*2;
        UILabel *Lable11 = [[UILabel alloc]initWithFrame:CGRectMake(Lable11x, 0,ScreenWidth/2-Lable11x,everyLalbeH)];
        Lable11.textColor =COLOR(102, 102, 102, 1);
        Lable11.textAlignment=NSTextAlignmentLeft;
        Lable11.adjustsFontSizeToFitWidth=YES;
        Lable11.text=@"(--,--)";
        Lable11.tag=6000+i;
        Lable11.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [button1 addSubview:Lable11];
        
        UIView* view22=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width/2,everyLalbeH*(i+1), SCREEN_Width/2, everyLalbeH)];
        view22.backgroundColor=[UIColor whiteColor];
         [view2 addSubview:view22];
        
      //  UILabel *Lable22 = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/2-lable1Size2.width)/2-Wk, 0,ScreenWidth/2-Lable11x,everyLalbeH)];
          UILabel *Lable22 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth/2,everyLalbeH)];
        Lable22.textColor =COLOR(102, 102, 102, 1);
        Lable22.textAlignment=NSTextAlignmentCenter;
                Lable22.adjustsFontSizeToFitWidth=YES;
        Lable22.text=@"(--,--)";
            Lable22.tag=7000+i;
        Lable22.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [view22 addSubview:Lable22];
        
    }
    
    NSArray *allDataArrayOld=[NSArray array];
    if (_oneCharType==1) {
           allDataArrayOld=[NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:useToWifiCheckOneRemember]];
        NSString *timeLableString=[[NSUserDefaults standardUserDefaults] objectForKey:useToWifiCheckOneRememberTime];
        if (([timeLableString isEqualToString:@""]) || (timeLableString==nil)) {
            _lableSetTime.text=[NSString stringWithFormat:@"%@:%@",root_MAX_267,@"--:--:--"];
        }else{
             _lableSetTime.text=[NSString stringWithFormat:@"%@:%@",root_MAX_267,timeLableString];
        }
    }
    if (_oneCharType==2) {
        NSDictionary *dic=[NSDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"useToWifiCheckThreeRemember"]];
        if ([dic.allKeys containsObject:@"one"]) {
              allDataArrayOld=[NSArray arrayWithArray:[dic objectForKey:@"one"]];
        }
    }
    
    if (allDataArrayOld.count>0) {
        _allDataArray=[NSMutableArray arrayWithArray:allDataArrayOld];
        _selectBoolArray=[NSMutableArray array];
        for (int i=0; i<_colorArray.count; i++) {
            [_selectBoolArray addObject:[NSNumber numberWithBool:YES]];
        }
           [self changData];
    }else{
           [self showFirstQuardrant];
    }
  
    
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

    [self showFirstQuardrant];
    
}

//准备读取曲线数据
-(void)goToReadCharData{
    _progressNum=0;
    if (!_allSendDataArray) {
        _allSendDataArray=@[@"0",@"125",@"250",@"375",@"500",@"625",@"750",@"875"];
    }
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    }else{
        _timer.fireDate=[NSDate distantPast];
    }
    
}

//开始或取消按钮开关
-(void)goStopRead:( UITapGestureRecognizer *)tap{
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
    if (present>100) {
        present=100;
    }
    
      [custompro setPresent:present];
    
    int waitingTime=0;
    
    //////等待时间
    if (_oneCharType==1) {
        waitingTime=keyOneWaitTime;
    }
    if (_oneCharType==2) {
        waitingTime=_waitingTimeFor3;
    }
    if (_progressNum>=waitingTime) {
             _isReadfirstDataOver=YES;
          _timer.fireDate=[NSDate distantFuture];
        _progressNum=0;
        [self goToReadTcpData];
    }
    
}



//I-V和P-V切换
-(void)buttonDidClicked:(UIButton*)button{
    NSInteger tagNum=button.tag;

    UILabel* lable =[self.view viewWithTag:3100];
    UILabel* lable1 =[self.view viewWithTag:3101];
    NSArray *lableNameArray;
    if (tagNum==3000) {
        _isIVchar=YES;
            lableNameArray=@[@"MPPT(Voc,Isc)",@"(Vpv,Ipv)"];
        _lable0.text=@"(A)";
    }else{
        _isIVchar=NO;
        _lable0.text=@"(W)";
            lableNameArray=@[@"MPPT(Vmpp,Pmpp)",@"(Vpv,Ppv)"];
    }
    lable.text=lableNameArray[0];
    lable1.text=lableNameArray[1];
        button.selected=YES;
    button.backgroundColor=MainColor;
    [button setTitleColor:COLOR(242, 242, 242, 1) forState:UIControlStateNormal];
    
        for (int i=3000; i<3002; i++) {
            if (i!=tagNum) {
                UIButton *buttonOther=[self.view viewWithTag:i];
                buttonOther.selected=NO;
                    buttonOther.backgroundColor=[UIColor clearColor];
                    [buttonOther setTitleColor:MainColor forState:UIControlStateNormal];
            }
        }
  
    [self changData];
    [self updataLeftMaxValue2];
}



#pragma mark - 曲线图
- (void)showFirstQuardrant{
    
    float Wx=30*NOW_SIZE;   float Yy=40*HEIGHT_SIZE; float allH=200*HEIGHT_SIZE;
    float Wx2=5*NOW_SIZE;
    float sizeFont=7*HEIGHT_SIZE;
    if (_allDataForCharArray.count>0) {
        
        if (present<100) {
            present=present+unit2;
            if (_allDataForCharArray.count !=_colorArray.count) {
                [custompro setPresent:present];
            }else{
                present=100;
                [custompro setPresent:present];
                custompro.presentlab.text = @"开始";
            }
            
               [self updataLeftMaxValue2];
        }

    }
    if ((_allDataForCharArray.count ==_colorArray.count) && (present<50)) {
        present=0;
        [custompro setPresent:present];
        custompro.presentlab.text = @"开始";
    }

    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(Wx, Yy, k_MainBoundsWidth-Wx-Wx2, allH)];
        _scrollView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:_scrollView];
    }

    

    NSMutableArray* allDataArray=[NSMutableArray array];
    NSMutableArray *charColorArray=[NSMutableArray array];
 
    
    for (int i=0; i<_allDataForCharArray.count; i++) {
        BOOL isSelect=[_selectBoolArray[i] boolValue];
        if (isSelect) {
            [allDataArray addObject:_allDataForCharArray[i]];
                [charColorArray addObject:_colorArray[i]];
        }
    }
    
    NSArray *allDicArray=[NSArray arrayWithArray:allDataArray];
    
    NSMutableArray *XLineDataArr0=[NSMutableArray array];
    for (int i=0; i<allDicArray.count; i++) {
        NSDictionary *dic=[NSDictionary dictionaryWithDictionary:allDicArray[i]];
        for (int i=0; i<dic.allKeys.count; i++) {
            if (![XLineDataArr0 containsObject:dic.allKeys[i]]) {
                [XLineDataArr0 addObject:dic.allKeys[i]];
            }
        }
    }
    
    
    NSSortDescriptor *sortDescripttor1 = [NSSortDescriptor sortDescriptorWithKey:@"intValue" ascending:YES];
    NSArray *XLineDataArr = [XLineDataArr0 sortedArrayUsingDescriptors:@[sortDescripttor1]];
    
    
    
    NSMutableArray *YLineDataArray0=[NSMutableArray array];
    for (int i=0; i<allDataArray.count; i++) {
        NSDictionary *dic=allDataArray[i];
        [YLineDataArray0 addObject:dic.allValues];
    }
    NSArray *YLineDataArr=[NSArray arrayWithArray:YLineDataArray0];
    
    /*     Create object        */
    if (_lineChartYDOne) {
        [_lineChartYDOne removeFromSuperview];
        _lineChartYDOne=nil;
    }
   
     _lineChartYDOne = [[YDLineChart alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) andLineChartType:JHChartLineValueNotForEveryXYD];
    _Type=1;
    _lineChartYDOne.MaxX=[[XLineDataArr valueForKeyPath:@"@max.floatValue"] integerValue];
    _lineChartYDOne.xLineDataArr = XLineDataArr;
    _lineChartYDOne.contentInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    /* The different types of the broken line chart, according to the quadrant division, different quadrant correspond to different X axis scale data source and different value data source. */
    
    _lineChartYDOne.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrantYD;
    _lineChartYDOne.allDicArray=[NSArray arrayWithArray:allDicArray];
    _lineChartYDOne.valueArr = YLineDataArr;
    _lineChartYDOne.showYLevelLine = YES;
    _lineChartYDOne.showYLine = YES;
    // _lineChartYDOne.yLineDataArr = @[@[@5,@10,@15,@20,@25,@30],@[@1,@2,@3,@4,@5,@6]];
    //    lineChart.yLineDataArr = @[@5,@10,@15,@20,@25,@30];
    //    lineChart.drawPathFromXIndex = 1;
    _lineChartYDOne.animationDuration = 2.0;
    _lineChartYDOne.showDoubleYLevelLine = NO;
    _lineChartYDOne.showValueLeadingLine = NO;
    _lineChartYDOne.yDescTextFontSize = sizeFont;
    _lineChartYDOne.xDescTextFontSize= sizeFont;
    _lineChartYDOne.valueFontSize = sizeFont;
    _lineChartYDOne.backgroundColor = [UIColor whiteColor];
    _lineChartYDOne.showPointDescription = NO;
    _lineChartYDOne.showXDescVertical = YES;
    _lineChartYDOne.xDescMaxWidth = 40;
    

    /* Line Chart colors _colorArray*/
    _lineChartYDOne.valueLineColorArr =[NSArray arrayWithArray:charColorArray];
    /* Colors for every line chart*/
    _lineChartYDOne.pointColorArr = [NSArray arrayWithArray:charColorArray];
    /* color for XY axis */
    _lineChartYDOne.xAndYLineColor = [UIColor darkGrayColor];
    /* XY axis scale color */
    _lineChartYDOne.xAndYNumberColor = [UIColor darkGrayColor];
    /* Dotted line color of the coordinate point */
    _lineChartYDOne.positionLineColorArr = [NSArray arrayWithArray:charColorArray];
    /*        Set whether to fill the content, the default is False         */
    _lineChartYDOne.contentFill = NO;
    /*        Set whether the curve path         */
    _lineChartYDOne.pathCurve = NO;

    /*        Set fill color array         */
    _lineChartYDOne.animationDuration=0.001;
    _lineChartYD.xDescMaxWidth = 15.0;
    
    _lineChartYDOne.contentFillColorArr = [NSArray arrayWithArray:charColorArray];
    [_scrollView addSubview:_lineChartYDOne];
    /*       Start animation        */
    [_lineChartYDOne showAnimation];
    
__weak typeof(self) weakSelf = self;
    _lineChartYDOne.xBlock=^(int xValue){
        [weakSelf updataTheLableValue:xValue];
    };
        
        
    
    
    self.pointGap= (_lineChartYDOne.frame.size.width)/(_lineChartYDOne.MaxX-1);
    _lineChartYDOne.pointGap= (_lineChartYDOne.frame.size.width)/(_lineChartYDOne.MaxX-1);
    _firstPointGap=(_lineChartYDOne.frame.size.width)/(_lineChartYDOne.MaxX-1);
    
    [_scrollView addSubview:_lineChartYDOne];
    
    _scrollView.contentSize =CGSizeMake(_lineChartYDOne.frame.size.width+10, 0);
    
    if (_YlineChartYDOne) {
        [_YlineChartYDOne removeFromSuperview];
        _YlineChartYDOne=nil;
    }
    _YlineChartYDOne = [[YDLineY alloc] initWithFrame:CGRectMake(0, Yy, Wx, allH) andLineChartType:JHChartLineValueNotForEveryXYDY];
    _YlineChartYDOne.xLineDataArr = XLineDataArr;
    _YlineChartYDOne.contentInsets = UIEdgeInsetsMake(10, Wx, 0, 10);
    _YlineChartYDOne.showXDescVertical = NO;
    /* X和Y轴的颜色 默认暗黑色 */
    _YlineChartYDOne.xAndYLineColor = [UIColor darkGrayColor];
    _YlineChartYDOne.backgroundColor = [UIColor whiteColor];
     _YlineChartYDOne.xDescMaxWidth = Wx;
    _YlineChartYDOne.yDescTextFontSize = sizeFont;
    _YlineChartYDOne.xDescTextFontSize=sizeFont;
    /* XY轴的刻度颜色 m */
    _YlineChartYDOne.xAndYNumberColor = [UIColor darkGrayColor];
    _YlineChartYDOne.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrantYD;
    _YlineChartYDOne.valueArr = YLineDataArr;
    [self.view addSubview:_YlineChartYDOne];
    [_YlineChartYDOne showAnimation];
 
    
    // 2. 捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [_lineChartYDOne addGestureRecognizer:pinch];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressAction:)];
    [_lineChartYDOne addGestureRecognizer:longPress];
    
    
    
}




// 捏合手势监听方法
- (void)pinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    
    float W=_firstPointGap*13;
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
//        if (  ((YDLineChart*)recognizerView).perXLen<W) {
//                 ((YDLineChart*)recognizerView).pointGap = self.pointGap;
//        }
   
        
    }else{
        
        CGFloat currentIndex,leftMagin;
        if( recognizer.numberOfTouches == 2 ) {
         
            //            NSLog(@"centerX = %f",centerX);
            //            NSLog(@"self.scrollView.contentOffset.x = %f",self.scrollView.contentOffset.x);
            //            NSLog(@"leftMagin = %f",leftMagin);
            //            NSLog(@"currentIndex = %f",currentIndex);
            float oldPerXlen=((YDLineChart*)recognizerView).perXLen;
            
                             ((YDLineChart*)recognizerView).perXLen=((YDLineChart*)recognizerView).perXLen* recognizer.scale;

            if (  ((YDLineChart*)recognizerView).perXLen<W) {
                //2.获取捏合中心点 -> 捏合中心点距离scrollviewcontent左侧的距离
                CGPoint p1 = [recognizer locationOfTouch:0 inView:recognizerView];
                CGPoint p2 = [recognizer locationOfTouch:1 inView:recognizerView];
                CGFloat centerX = (p1.x+p2.x)/2;
                leftMagin = centerX - self.scrollView.contentOffset.x;
                
                            currentIndex = centerX / self.pointGap;
                          ((YDLineChart*)recognizerView).pointGap = self.pointGap;
                        self.pointGap *= recognizer.scale;
                
                if (_Type==1) {
                    recognizerView.frame = CGRectMake(((YDLineChart*)recognizerView).frame.origin.x, ((YDLineChart*)recognizerView).frame.origin.y, (((YDLineChart*)recognizerView).MaxX-1)* ((YDLineChart*)recognizerView).perXLen, ((YDLineChart*)recognizerView).frame.size.height);
                }else{
                    recognizerView.frame = CGRectMake(((YDLineChart*)recognizerView).frame.origin.x, ((YDLineChart*)recognizerView).frame.origin.y, (((YDLineChart*)recognizerView).xLineDataArr.count-1)* ((YDLineChart*)recognizerView).perXLen, ((YDLineChart*)recognizerView).frame.size.height);
                }
                
                
                self.scrollView.contentOffset = CGPointMake(currentIndex*self.pointGap-leftMagin, 0);
                //            NSLog(@"contentOffset = %f",self.scrollView.contentOffset.x);
                
                recognizer.scale = 1.0;
                
                    self.scrollView.contentSize = CGSizeMake(((YDLineChart*)recognizerView).frame.size.width, 0);
                
            }else{
      ((YDLineChart*)recognizerView).perXLen=oldPerXlen;
                [self showToastViewWithTitle:@"已经是最大显示"];
            }
            
       
        }
        
        
    }
    

    
    
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
