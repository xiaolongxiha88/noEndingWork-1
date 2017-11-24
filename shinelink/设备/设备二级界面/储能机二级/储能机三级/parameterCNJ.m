//
//  parameterCNJ.m
//  shinelink
//
//  Created by sky on 16/3/31.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "parameterCNJ.h"

@interface parameterCNJ ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *dateN1;
@property (nonatomic, strong)  NSMutableArray *dateN2;
@property (nonatomic, strong) NSMutableArray *dateY1;
@property (nonatomic, strong)  NSMutableArray *dateY2;
@property (nonatomic, strong)  NSMutableArray *dateName;
@property (nonatomic, strong)  NSMutableArray *pv;
@property (nonatomic, strong)  NSMutableArray *pv11;
@property (nonatomic, strong)  NSMutableArray *pv12;
@property (nonatomic, strong)  NSMutableArray *pv21;
@property (nonatomic, strong)  NSMutableArray *pv22;
@property (nonatomic, strong)  NSMutableArray *pv31;
@property (nonatomic, strong)  NSMutableArray *pv32;
@property (nonatomic, strong)  NSArray *SPF5000Array;

@property (nonatomic, strong)  NSString *Version;
@end

@implementation parameterCNJ

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor whiteColor];
    
      [self initdata];
    
    if ([_typeNum isEqualToString:@"3"]) {
           [self netMIX];
    }else{
            [self netParameter];
    }

    
  
}




-(void)netParameter{
    _dateN2=[NSMutableArray array];
     _dateY2=[NSMutableArray array];
    _pv12=[NSMutableArray array];
    _pv22=[NSMutableArray array];
    _pv32=[NSMutableArray array];

    NSString *B1=[NSString stringWithFormat:@"%@",_params2Dict[@"dataLogSn"]];

    //NSString *B1=[NSString stringWithFormat:@"%@",_params2Dict[@"alias"]];
    
     NSString *B3=[NSString stringWithFormat:@"%@",_params2Dict[@"modelText"]];
    
_Version=[NSString stringWithFormat:@"%@/%@",_params2Dict[@"fwVersion"],_params2Dict[@"innerVersion"]];
    
    [_dateN2 addObject:_deviceSN];
    [_dateN2 addObject:_storageType];
    [_dateN2 addObject:_Version];
    
    [_dateY2 addObject:B1];
    [_dateY2 addObject:_normalPower];
    [_dateY2 addObject:B3];
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"storageId":_deviceSN} paramarsSite:@"/newStorageAPI.do?op=getStorageInfo" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getStorageInfo: %@", content);
        if (content) {
          
             [self initUI];
            
            
            if ([_typeNum isEqualToString:@"1"]) {
                [self getPCS5000data:content];
            }else{
                [self getSPdata:content];
            }
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
     
    }];


}



-(void)netMIX{
    _dateN2=[NSMutableArray array];
    _dateY2=[NSMutableArray array];
    _pv12=[NSMutableArray array];
    _pv22=[NSMutableArray array];
    _pv32=[NSMutableArray array];
    
    
    [_dateN2 addObject:_deviceSN];
    [_dateN2 addObject:[NSString stringWithFormat:@"%@",_params2Dict[@"innerVersion"]]];
    [_dateN2 addObject:[NSString stringWithFormat:@"%@",_params2Dict[@"fwVersion"]]];
    
    [_dateY2 addObject:[NSString stringWithFormat:@"%@",_params2Dict[@"dataLogSn"]]];
    [_dateY2 addObject:_normalPower];
    [_dateY2 addObject:[NSString stringWithFormat:@"%@",_params2Dict[@"modelText"]]];
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"mixId":_deviceSN} paramarsSite:@"/newMixApi.do?op=getMixInfo" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getMixInfo: %@", content);
        if (content) {
                     [self initUI];
            if ([content[@"result"] intValue]==1) {
                NSDictionary *allDataDic=content[@"obj"];
                [self getMIXdata:allDataDic];
            }
            
   
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
    
}

-(void)getMIXdata:(NSDictionary*)content{
    
    //      NSArray *nameArray=@[@"Vb/Cb",@"Vpv",@"Ic_pv",@"Ppv",@"Ac_In",@"Ac_Out",@"PL",@"Per_Load",@"Epv_d",@"Epv_a",@"Ec_day",@"Ec_all",@"Ed_day",@"Ed_all"];
    
    _SPF5000Array=@[[NSString stringWithFormat:@"%@V",content[@"vpv1"]],
                    [NSString stringWithFormat:@"%@V",content[@"vpv2"]],
                    [NSString stringWithFormat:@"%@V",content[@"vbat"]],
                    [NSString stringWithFormat:@"%@W",content[@"pCharge1"]],
                    [NSString stringWithFormat:@"%@kWh",content[@"epvTotal"]],
                    [NSString stringWithFormat:@"%@kWh",content[@"epvToday"]],
                    [NSString stringWithFormat:@"%@kWh",content[@"eBatChargeToday"]],
                    [NSString stringWithFormat:@"%@kWh",content[@"eBatChargeTotal"]],
                    [NSString stringWithFormat:@"%@kWh",content[@"eBatDisChargeToday"]],
                    [NSString stringWithFormat:@"%@kWh",content[@"eBatDisChargeTotal"]],
                    ];
    
    [self initUIThree];
}

-(void)getPCS5000data:(NSDictionary*)content{
    
//      NSArray *nameArray=@[@"Vb/Cb",@"Vpv",@"Ic_pv",@"Ppv",@"Ac_In",@"Ac_Out",@"PL",@"Per_Load",@"Epv_d",@"Epv_a",@"Ec_day",@"Ec_all",@"Ed_day",@"Ed_all"];
    
    _SPF5000Array=@[[NSString stringWithFormat:@"%@V/%@%%",content[@"vbat"],content[@"capacity"]],
                    [NSString stringWithFormat:@"%@V/%@V",content[@"vpv1"],content[@"vpv2"]],
                      [NSString stringWithFormat:@"%@A/%@A",content[@"iChargePV1"],content[@"iChargePV2"]],
                      [NSString stringWithFormat:@"%@W/%@W",content[@"pCharge1"],content[@"pCharge2"]],
                     [NSString stringWithFormat:@"%@V/%@Hz",content[@"vGrid"],content[@"freqGrid"]],
                    [NSString stringWithFormat:@"%@V/%@Hz",content[@"outPutVolt"],content[@"freqOutPut"]],
                    [NSString stringWithFormat:@"%@W",content[@"outPutPower"]],
                    [NSString stringWithFormat:@"%@%%",content[@"loadPercent"]],
                    [NSString stringWithFormat:@"%@kWh",content[@"epvToday"]],
                      [NSString stringWithFormat:@"%@kWh",content[@"epvTotal"]],
                     [NSString stringWithFormat:@"%@kWh",content[@"eBatChargeToday"]],
                       [NSString stringWithFormat:@"%@kWh",content[@"eBatChargeTotal"]],
                     [NSString stringWithFormat:@"%@kWh",content[@"eBatDisChargeToday"]],
                      [NSString stringWithFormat:@"%@kWh",content[@"eBatDisChargeTotal"]]
                    ];
    
  [self initUIThree];
}

-(void)getSPdata:(NSDictionary*)content{
    NSString *C1=[NSString stringWithFormat:@"%@",content[@"vpv"]];
    NSString *C2=[NSString stringWithFormat:@"%@",content[@"vbat"]];
    NSString *C3=[NSString stringWithFormat:@"%@",content[@"vGuid"]];
    
    NSString *D1=[NSString stringWithFormat:@"%@",content[@"ipv"]];
    NSString *D2=[NSString stringWithFormat:@"%@",content[@"ibat"]];
    NSString *D3=[NSString stringWithFormat:@"%@",content[@"iGuid"]];
    
    NSString *E1=[NSString stringWithFormat:@"%@",content[@"ppv"]];
    NSString *E2=[NSString stringWithFormat:@"%@",content[@"pbat"]];
    NSString *E3=[NSString stringWithFormat:@"%@",content[@"pGuid"]];
    
    [_pv12 addObject:C1];
    [_pv12 addObject:C2];
    [_pv12 addObject:C3];
    
    [_pv22 addObject:D1];
    [_pv22 addObject:D2];
    [_pv22 addObject:D3];
    
    [_pv32 addObject:E1];
    [_pv32 addObject:E2];
    [_pv32 addObject:E3];

           [self initUITwo];
}



-(void)initdata{

    
    _dateN1=[[NSMutableArray alloc]initWithObjects:root_xuleihao, root_xinghao, root_gujian_banben,nil];
  
    if ([_typeNum isEqualToString:@"1"]) {
    _dateY1=[[NSMutableArray alloc]initWithObjects:root_duankou, root_Device_head_187, root_moshi,nil];
    }else{
        _dateY1=[[NSMutableArray alloc]initWithObjects:root_duankou, root_CNJ_eDing_gonglv, root_moshi,nil];
    }

    
    _dateName=[[NSMutableArray alloc]initWithObjects:@"Volt(V)", @"Current(A)", @"Watt(W)",nil];
    _pv=[[NSMutableArray alloc]initWithObjects:@"PV", @"Bat", @"Grid",nil];
  
}

-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,650*NOW_SIZE);
    [self.view addSubview:_scrollView];
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 210*HEIGHT_SIZE)];
    //UIImage *bgImage = IMAGE(@"bg4.png");
    headView.backgroundColor=MainColor;
    //headView.layer.contents = (id)bgImage.CGImage;
     [_scrollView addSubview:headView];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width/2,10*HEIGHT_SIZE, 1*NOW_SIZE, 210*HEIGHT_SIZE)];
    line1.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:line1];
    
    float SIZE1=70*HEIGHT_SIZE;
    for(int i=0;i<_dateN1.count;i++){
    UILabel *PVLable=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 15*HEIGHT_SIZE+SIZE1*i, 160*NOW_SIZE,20*HEIGHT_SIZE )];
    PVLable.text=_dateN1[i];
    PVLable.textAlignment=NSTextAlignmentCenter;
    PVLable.textColor=[UIColor whiteColor];
           PVLable.adjustsFontSizeToFitWidth=YES;
    PVLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:PVLable];
        
    UILabel *Lable1=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 40*HEIGHT_SIZE+SIZE1*i, 160*NOW_SIZE,20*HEIGHT_SIZE )];
    Lable1.text=_dateN2[i];
    Lable1.textAlignment=NSTextAlignmentCenter;
    Lable1.textColor=[UIColor whiteColor];
           Lable1.adjustsFontSizeToFitWidth=YES;
    Lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:Lable1];
    
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 15*HEIGHT_SIZE+SIZE1*i, 160*NOW_SIZE,20*HEIGHT_SIZE )];
    PV2Lable.text=_dateY1[i];
    PV2Lable.textAlignment=NSTextAlignmentCenter;
    PV2Lable.textColor=[UIColor whiteColor];
           PV2Lable.adjustsFontSizeToFitWidth=YES;
    PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:PV2Lable];
    UILabel *Lable2=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 40*HEIGHT_SIZE+SIZE1*i, 160*NOW_SIZE,20*HEIGHT_SIZE )];
    Lable2.text=_dateY2[i];
        if ([_typeNum isEqualToString:@"1"]) {
            if (i==1) {
                Lable2.text=_actAndapparentString;
            }
        }
    Lable2.textAlignment=NSTextAlignmentCenter;
    Lable2.textColor=[UIColor whiteColor];
           Lable2.adjustsFontSizeToFitWidth=YES;
    Lable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:Lable2];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,70*HEIGHT_SIZE+SIZE1*i, 300*NOW_SIZE, LineWidth)];
        line.backgroundColor=[UIColor whiteColor];
        [_scrollView addSubview:line];
    }

   
}



-(void)initUITwo{
    float Size2=60*NOW_SIZE,Size3=(SCREEN_Width-60*NOW_SIZE)/3;
    for (int j=0; j<_dateName.count; j++) {
        UILabel *Name1=[[UILabel alloc]initWithFrame:CGRectMake(Size2+j*Size3, 225*HEIGHT_SIZE, Size3,20*HEIGHT_SIZE )];
        Name1.text=_dateName[j];
        Name1.textAlignment=NSTextAlignmentCenter;
        Name1.textColor=COLOR(104, 113, 201, 1);
        Name1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:Name1];
    }
    float size3=50*HEIGHT_SIZE;
    for (int K=0; K<_pv.count; K++) {
        UILabel *pv=[[UILabel alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 250*HEIGHT_SIZE+size3*K, 60*NOW_SIZE,20*HEIGHT_SIZE )];
        pv.text=_pv[K];
        pv.textAlignment=NSTextAlignmentLeft;
        pv.textColor=[UIColor blackColor];
        pv.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [_scrollView addSubview:pv];
        
        
        UILabel *pv11=[[UILabel alloc]initWithFrame:CGRectMake(Size2+0*Size3, 250*HEIGHT_SIZE+size3*K, Size3,20*HEIGHT_SIZE )];
        pv11.text=_pv12[K];
        pv11.textAlignment=NSTextAlignmentCenter;
        pv11.textColor=[UIColor grayColor];
        pv11.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:pv11];
        
        
        UILabel *pv21=[[UILabel alloc]initWithFrame:CGRectMake(Size2+1*Size3, 250*HEIGHT_SIZE+size3*K, Size3,20*HEIGHT_SIZE )];
        pv21.text=_pv22[K];
        pv21.textAlignment=NSTextAlignmentCenter;
        pv21.textColor=[UIColor grayColor];
        pv21.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:pv21];
        
        
        UILabel *pv31=[[UILabel alloc]initWithFrame:CGRectMake(Size2+2*Size3, 250*HEIGHT_SIZE+size3*K, Size3,20*HEIGHT_SIZE )];
        pv31.text=_pv32[K];
        pv31.textAlignment=NSTextAlignmentCenter;
        pv31.textColor=[UIColor grayColor];
        pv31.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:pv31];
        
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 285*HEIGHT_SIZE+size3*K, 300*NOW_SIZE,LineWidth )];
        line2.backgroundColor=COLOR(212, 212, 212, 1);
        [_scrollView addSubview:line2];
        
    }


}


-(void)initUIThree{
 _scrollView.contentSize = CGSizeMake(SCREEN_Width,750*NOW_SIZE);
    
    NSArray *nameArray=@[@"Vb/Cb",@"Vpv",@"Ic_pv",@"Ppv",@"Ac_In",@"Ac_Out",@"PL",@"Per_Load",@"Epv_d",@"Epv_a",@"Ec_day",@"Ec_all",@"Ed_day",@"Ed_all"];
    
    if ([_typeNum isEqualToString:@"3"]) {
        nameArray=@[root_5000Chart_159,root_5000Chart_160,root_5000xianqing_dianchi_dianya,root_MIX_229,root_MIX_230,root_MIX_231,root_MIX_232,root_MIX_233,root_MIX_234,root_MIX_235];
    }
    
    float size3=50*HEIGHT_SIZE; float H1=10*HEIGHT_SIZE;
    for (int i=0; i<nameArray.count; i++) {
        int K=i/2; int W=i%2;
        UILabel *nameLable=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE+SCREEN_Width/2*W, 250*HEIGHT_SIZE+size3*K-H1, SCREEN_Width/2,20*HEIGHT_SIZE )];
        nameLable.text=nameArray[i];
        nameLable.textAlignment=NSTextAlignmentCenter;
        nameLable.textColor=MainColor;
        nameLable.adjustsFontSizeToFitWidth=YES;
        nameLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:nameLable];
        
        UILabel *valueLable=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE+SCREEN_Width/2*W, 270*HEIGHT_SIZE+size3*K-H1, SCREEN_Width/2,20*HEIGHT_SIZE )];
        valueLable.text=_SPF5000Array[i];
        valueLable.textAlignment=NSTextAlignmentCenter;
        valueLable.adjustsFontSizeToFitWidth=YES;
        valueLable.textColor=COLOR(102, 102, 102, 1);
        valueLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:valueLable];
        
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 294.5*HEIGHT_SIZE-size3-H1, 300*NOW_SIZE,LineWidth )];
        line1.backgroundColor=COLOR(212, 212, 212, 1);
        [_scrollView addSubview:line1];
        
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 294.5*HEIGHT_SIZE+size3*K-H1, 300*NOW_SIZE,LineWidth)];
        line2.backgroundColor=COLOR(212, 212, 212, 1);
        [_scrollView addSubview:line2];
        
        UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width/2, 294.5*HEIGHT_SIZE-size3-H1, 1*NOW_SIZE,size3*(K+1) )];
        line3.backgroundColor=COLOR(212, 212, 212, 1);
        [_scrollView addSubview:line3];

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
