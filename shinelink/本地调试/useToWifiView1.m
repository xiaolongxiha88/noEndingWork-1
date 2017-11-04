//
//  useToWifiView1.m
//  ShinePhone
//
//  Created by sky on 2017/10/18.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "useToWifiView1.h"
#import "useToWifiCell1.h"
#import "usbModleOne.h"
#import "usbToWifiCell2.h"
#import "usbToWifiDataControl.h"
#import "usbToWifiControlOne.h"
#import "usbToWifiWarnView.h"
#import "usbToWifiFour.h"

static NSString *cellOne = @"cellOne";
static NSString *cellTwo = @"cellTwo";

@interface useToWifiView1 ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIView *firstView;
@property(nonatomic,strong)UIView *secondView;
@property(nonatomic,strong)UIView *thirdView;
@property(nonatomic,strong)UIView *fourView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic,strong)NSMutableArray *firstViewDataArray;
@property(nonatomic,strong)NSMutableArray *secondDataArray;
@property(nonatomic,strong)NSMutableArray *thirdDataArray;
@property(nonatomic,strong)NSMutableArray *fourDataArray;

@property(nonatomic,assign) float firstH;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *tableNameArray;
@property(nonatomic,strong)usbToWifiDataControl*usbControl;
@property(nonatomic,strong)NSDictionary*allDic;

@property(nonatomic,strong)NSArray *tableLableValueArray;
@property(nonatomic,assign) BOOL isWiFi;

@end

@implementation useToWifiView1{
    NSArray<usbModleOne*> *_modelList;
}


-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getData:) name: @"recieveReceiveData" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFailedNotice) name: @"recieveFailedTcpData" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeTheTcp) name: @"StopConfigerUI" object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBarTintColor:MainColor];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(tcpToGetData)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    
    _firstH=170*HEIGHT_SIZE;
    
    _usbControl=[[usbToWifiDataControl alloc]init];
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, SCREEN_Width, SCREEN_Height)];
        _scrollView.scrollEnabled=YES;
        _scrollView.contentSize=CGSizeMake(SCREEN_Width, 1500*HEIGHT_SIZE);
        [self.view addSubview:_scrollView];
    }

    
     _firstViewDataArray=[NSMutableArray new];
      _tableLableValueArray=[NSMutableArray new];
    _thirdDataArray=[NSMutableArray new];
    
    [self checkIsWifi];
    if (_isWiFi) {
      //  [self tcpToGetData];
   
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未连接WiFi模块" message:@"请跳转连接WiFi" delegate:self cancelButtonTitle:root_cancel otherButtonTitles:@"连接", nil];
        alertView.tag = 1001;
        [alertView show];
        
    }
        [self initUI];
}

-(void)viewDidAppear:(BOOL)animated{

  
}

-(void)checkIsWifi{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
      int netType = 0;
    //获得到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
               netType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            // 1，2，3，5 分别对应的网络状态是2G、3G、4G及WIFI。(需要判断当前网络类型写个switch 判断就OK)
        }
    }
    
    if (netType==5) {
        _isWiFi=YES;
    }else{
        _isWiFi=NO;
    }
    
}

-(void)tcpToGetData{
        [self checkIsWifi];
    
    if (_isWiFi) {
        self.navigationItem.rightBarButtonItem.enabled=NO;
        [self showProgressView];
 [_usbControl getDataAll:1];
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未连接WiFi模块" message:@"请跳转连接WiFi" delegate:self cancelButtonTitle:root_cancel otherButtonTitles:@"连接", nil];
        alertView.tag = 1001;
        [alertView show];
    }
   
    
}

-(void)removeTheWaitingView{
    [self hideProgressView];
    self.navigationItem.rightBarButtonItem.enabled=YES;
}

-(void)getData:(NSNotification*) notification{
    
   [self performSelector:@selector(removeTheWaitingView) withObject:nil afterDelay:2.5];
    
 _allDic=[NSDictionary dictionaryWithDictionary:[notification object]];
        _firstViewDataArray=[NSMutableArray arrayWithArray:[_allDic objectForKey:@"oneView"]];
     _tableLableValueArray=[NSMutableArray arrayWithArray:[_allDic objectForKey:@"twoView2"]];
   _thirdDataArray=[NSMutableArray arrayWithArray:[_allDic objectForKey:@"twoView3"]];
    NSString*titleString=[_allDic objectForKey:@"titleView"];
    self.title=titleString;
    
    [self initUI];
    
}

-(void)initUI{
   
    
    [self initFirstUI];
    [self initThirdUI];
}


-(void)initFirstUI{
    float W1=5*NOW_SIZE;float H1=8*HEIGHT_SIZE;float H2=50*HEIGHT_SIZE;float imageH=30*HEIGHT_SIZE;
    float W2=(H2-imageH)/2;  float lableH=30*HEIGHT_SIZE;float lableW=60*NOW_SIZE;
    if (_firstView) {
        [_firstView removeFromSuperview];
        _firstView=nil;
    }
    _firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, _firstH)];
    _firstView.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_firstView];
    NSArray *picName=@[@"max_ele.png",@"max_power.png",@"max_worning.png"];
    NSArray *colorArray=@[COLOR(88, 196, 95, 1),COLOR(0, 156, 255, 1),COLOR(221, 120, 120, 1)];
    NSArray *nameArray=@[root_energy_fadianliang,root_gongLv,root_cuoWu];
    NSArray *dataNameArray=@[root_Device_head_182,root_Device_head_183,root_dangqian_gonglv,root_usbTowifi_189,root_cuoWu,root_usbTowifi_190];
 

   
    
     float W0=SCREEN_Width-2*W1;
    for (int i=0; i<picName.count; i++) {
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(W1, H1+(H1+H2)*i, W0, H2)];
        view1.backgroundColor=[UIColor whiteColor];
        [_firstView addSubview:view1];
         view1.userInteractionEnabled=YES;
        if (i==0) {
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToControlView3)];
            [view1 addGestureRecognizer:tapGestureRecognizer];
        }
        if (i==2) {
            UITapGestureRecognizer *tapGestureRecognizer33 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToControlView2)];
            [view1 addGestureRecognizer:tapGestureRecognizer33];
        }
        
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(W2,(H2-imageH)/2, imageH,imageH)];
        image2.image=IMAGE(picName[i]);
        [view1 addSubview:image2];
        
        UILabel *titleLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(2*W2+imageH, (H2-lableH)/2,lableW,lableH)];
        titleLabel3.textColor = colorArray[i];
        titleLabel3.textAlignment=NSTextAlignmentLeft;
        titleLabel3.text=nameArray[i];
        titleLabel3.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [view1 addSubview:titleLabel3];
        
         float image3W=6*NOW_SIZE;float image3W1=5*NOW_SIZE;float imageH2=10*HEIGHT_SIZE;
        if((i==0)||(i==2)){
        UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(W0-image3W-image3W1,(H2-imageH2)/2, image3W,imageH2)];
        image3.image=IMAGE(@"MAXright.png");
        [view1 addSubview:image3];
        }
      
        float  titleLabel3X=2*W2+imageH+lableW;
        float  lable4W=(W0-image3W-image3W1*2-titleLabel3X)/2;
        float lableH2=20*HEIGHT_SIZE;float lableH3=10*HEIGHT_SIZE;
        for (int K=0; K<2; K++) {
            UILabel *lable4 = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel3X+lable4W*K, 8*HEIGHT_SIZE,lable4W,lableH2)];
            lable4.textColor = colorArray[i];
            lable4.textAlignment=NSTextAlignmentCenter;
            int T=2*i+K;
            if (_firstViewDataArray.count>0) {
                 lable4.text=_firstViewDataArray[T];
            }else{
                         lable4.text=@"";
            }
           
            lable4.adjustsFontSizeToFitWidth=YES;
            lable4.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
            [view1 addSubview:lable4];
            
            UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel3X+lable4W*K, 32*HEIGHT_SIZE,lable4W,lableH3)];
            lable5.textColor =COLOR(153, 153, 153, 1);
            lable5.textAlignment=NSTextAlignmentCenter;
            lable5.text=dataNameArray[T];
            lable5.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
            [view1 addSubview:lable5];
            
        }
        
    }
    
    [self initSecondUI];
}




-(void)initSecondUI{
    float W1=5*NOW_SIZE; float W0=SCREEN_Width-2*W1;
    float H=110*HEIGHT_SIZE;
    float view1H= CGRectGetMaxY(_firstView.frame);
    
    if (_secondView) {
        [_secondView removeFromSuperview];
        _secondView=nil;
    }
    _secondView=[[UIView alloc]initWithFrame:CGRectMake(W1, view1H+10*HEIGHT_SIZE, W0, H)];
    _secondView.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_secondView];
    
    
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(1*NOW_SIZE, 3*HEIGHT_SIZE, 3*NOW_SIZE, 14*HEIGHT_SIZE)];
    V1.backgroundColor=MainColor;
    [_secondView addSubview:V1];
    
    float lableH1=20*HEIGHT_SIZE;
    UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(7*NOW_SIZE, 0,200*NOW_SIZE,lableH1)];
    lable5.textColor =COLOR(51, 51, 51, 1);
    lable5.textAlignment=NSTextAlignmentLeft;
    lable5.text=@"设备控制";
    lable5.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_secondView addSubview:lable5];
    
    float H2=80*HEIGHT_SIZE;
    UIView *V2=[[UIView alloc]initWithFrame:CGRectMake(0, 25*HEIGHT_SIZE, W0, H2)];
    V2.backgroundColor=[UIColor whiteColor];
    [_secondView addSubview:V2];
    
       NSArray *picName=@[@"max_set.png",@"max_parameter.png"];
     NSArray *nameArray=@[@"设置配置",@"参数设置"];
    
    float imageH=30*HEIGHT_SIZE;float V2H1=15*HEIGHT_SIZE;
    float WW=ScreenWidth/picName.count;
    for (int i=0; i<picName.count; i++) {
        UIView *VV=[[UIView alloc]initWithFrame:CGRectMake(0+WW*i, 0, WW, H2)];
        VV.backgroundColor=[UIColor clearColor];
        VV.userInteractionEnabled=YES;
        if (i==0) {
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToControlView)];
            [VV addGestureRecognizer:tapGestureRecognizer];
        }else{
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToControlView1)];
            [VV addGestureRecognizer:tapGestureRecognizer];
        }
      
        [V2 addSubview:VV];
        
        UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake((WW-imageH)/2,V2H1, imageH,imageH)];
        image3.userInteractionEnabled=YES;
        image3.image=IMAGE(picName[i]);
        [VV addSubview:image3];
        
        UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(0, V2H1+imageH+5*HEIGHT_SIZE,WW,lableH1)];
        lable5.textColor =COLOR(102, 102, 102, 1);
        lable5.textAlignment=NSTextAlignmentCenter;
        lable5.text=nameArray[i];
        lable5.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [VV addSubview:lable5];
    }
    
    
}

-(void)goToControlView{
    usbToWifiControlOne *testView=[[usbToWifiControlOne alloc]init];
    testView.controlType=1;
    [self.navigationController pushViewController:testView animated:YES];
}
-(void)goToControlView1{
    usbToWifiControlOne *testView=[[usbToWifiControlOne alloc]init];
        testView.controlType=2;
    [self.navigationController pushViewController:testView animated:YES];
}

-(void)goToControlView2{
    if (_firstViewDataArray.count>0) {
        usbToWifiWarnView *testView=[[usbToWifiWarnView alloc]init];
        testView.faultCode=_firstViewDataArray[4];
        testView.warnCode=_firstViewDataArray[5];
        NSString*faultStateString=[_allDic objectForKey:@"faultStateView"];
        testView.faultStatueCode=faultStateString;
        
        [self.navigationController pushViewController:testView animated:YES];
    }else{
        [self showToastViewWithTitle:@"请先读取故障信息"];
    }
    
}

-(void)goToControlView3{
    usbToWifiFour *testView=[[usbToWifiFour alloc]init];
    [self.navigationController pushViewController:testView animated:YES];
}

-(void)initThirdUI{
    _tableNameArray=@[@"PV电压/电流/电量",@"PV串电压/电流",@"AC电压/电流",@"PID电压/电流"];
    float view1H= CGRectGetMaxY(_secondView.frame);
    
    float lableH1=20*HEIGHT_SIZE;
    
    if (!_thirdView) {
        _thirdView=[[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, view1H+10*HEIGHT_SIZE, SCREEN_Width, lableH1)];
        _thirdView.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:_thirdView];
        
        UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(6*NOW_SIZE, 3*HEIGHT_SIZE, 3*NOW_SIZE, 14*HEIGHT_SIZE)];
        V1.backgroundColor=MainColor;
        [_thirdView addSubview:V1];
        
        UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(12*NOW_SIZE, 0*HEIGHT_SIZE,200*NOW_SIZE,lableH1)];
        lable5.textColor =COLOR(51, 51, 51, 1);
        lable5.textAlignment=NSTextAlignmentLeft;
        lable5.text=@"设备信息";
        lable5.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_thirdView addSubview:lable5];
        
        UILabel *lable6 = [[UILabel alloc]initWithFrame:CGRectMake(210*NOW_SIZE, 2*HEIGHT_SIZE,100*NOW_SIZE,lableH1)];
        lable6.textColor =MainColor;
        lable6.textAlignment=NSTextAlignmentRight;
        lable6.text=@"单位:V/A/kWh";
        lable6.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        [_thirdView addSubview:lable6];
    }
 
    
       NSMutableArray<usbModleOne *> *arrM = [NSMutableArray arrayWithCapacity:_tableNameArray.count];
    for (int i=0; i<_tableNameArray.count; i++) {
        usbModleOne *model = [[usbModleOne alloc] initWithDict]; 
        [arrM addObject:model];
    }
    _modelList = arrM.copy;
    
    if (_tableView) {
        [_tableView removeFromSuperview];
        _tableView=nil;
    }
    
  
    
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, view1H+10*HEIGHT_SIZE+28*HEIGHT_SIZE, SCREEN_Width,SCREEN_Height+600*HEIGHT_SIZE)];
        _tableView.contentSize=CGSizeMake(SCREEN_Width, 2500*HEIGHT_SIZE);
        _tableView.delegate = self;
        _tableView.dataSource = self;
 
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self.tableView registerClass:[useToWifiCell1 class] forCellReuseIdentifier:cellOne];
             [self.tableView registerClass:[usbToWifiCell2 class] forCellReuseIdentifier:cellTwo];

        [_scrollView addSubview:_tableView];
        
    }
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int K=(int)indexPath.row;
    
    if (K!=4) {
        useToWifiCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellOne forIndexPath:indexPath];
        if (!cell) {
            cell=[[useToWifiCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellOne];
        }
        
        if (_tableLableValueArray.count>0) {
            NSArray *dataAllArray=[NSArray arrayWithArray:_tableLableValueArray[indexPath.row]];
            cell.lable1Array=[NSArray arrayWithArray:dataAllArray[0]];
            cell.lable2Array=[NSArray arrayWithArray:dataAllArray[1]];
            if (K==0) {
                cell.lable3Array=[NSArray arrayWithArray:dataAllArray[2]];
                cell.lable4Array=[NSArray arrayWithArray:dataAllArray[3]];
            }
        }
  
        cell.cellTypy=K;
        usbModleOne *model = _modelList[K];
        cell.model = model;
        cell.titleString=_tableNameArray[K];
        [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
            NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
            [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        return cell;
    }else{
        usbToWifiCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellTwo forIndexPath:indexPath];
        cell.lable1Array=_thirdDataArray;
        if (!cell) {
            cell=[[usbToWifiCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTwo];
        }
    
        return cell;
  
    }
 
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


// MARK: - 返回cell高度的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row!=4) {
        usbModleOne *model = _modelList[indexPath.row];
        
        if (model.isShowMoreText){
            
            return [useToWifiCell1 moreHeight:(int)indexPath.row];
            
        }else{
            
            return [useToWifiCell1 defaultHeight];
        }
        
    }else{
        
          return [usbToWifiCell2 moreHeight:(int)indexPath.row];
    }


}


-(void)receiveFailedNotice{
    [self hideProgressView];
      self.navigationItem.rightBarButtonItem.enabled=YES;

    [self removeTheTcp];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"WiFi模块通信失败,请检查WiFi连接." message:nil delegate:self cancelButtonTitle:root_cancel otherButtonTitles:@"检查", nil];
    alertView.tag = 1002;
    [alertView show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex) {
        if( (alertView.tag == 1001) || (alertView.tag == 1002)){
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


-(void)removeTheTcp{
    if (_usbControl) {
        [_usbControl removeTheTcp];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_usbControl) {
        [_usbControl removeTheTcp];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"recieveReceiveData" object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:@"recieveFailedTcpData" object:nil];
   //   [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StopConfigerUI" object:nil];
    
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
