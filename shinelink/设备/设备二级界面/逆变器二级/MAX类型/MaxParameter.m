//
//  MaxParameter.m
//  ShinePhone
//
//  Created by sky on 2017/12/9.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "MaxParameter.h"

@interface MaxParameter ()
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
@end

@implementation MaxParameter

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self netParameter];
    [self initdata];
    
}

-(void)netParameter{
    _dateN2=[NSMutableArray array];
    _dateY2=[NSMutableArray array];
    _pv12=[NSMutableArray array];
    _pv22=[NSMutableArray array];
    _pv32=[NSMutableArray array];
    
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"maxId":_PvSn} paramarsSite:@"/newInverterAPI.do?op=getInverterParams_max" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getInverterParams_max: %@", content);
        if (content) {
            NSString *A2=[NSString stringWithFormat:@"%@",content[@"inverterType"]];
            // NSString *A2=[NSString stringWithFormat:@"%@",content[@"dataLogSn"]];
            NSString *B22=[NSString stringWithFormat:@"%@",content[@"newBean"][@"normalPower"]];
            NSString *B1=[NSString stringWithFormat:@"%@",content[@"newBean"][@"dataLogSn"]];
            NSString *B2=[NSString stringWithFormat:@"%@",content[@"newBean"][@"fwVersion"]];
            NSString *B3=[NSString stringWithFormat:@"%@",content[@"newBean"][@"innerVersion"]];
            // NSString *B4=[NSString stringWithFormat:@"%@",content[@"model"]];
            NSString *B5=[NSString stringWithFormat:@"%@",content[@"newBean"][@"modelText"]];
            
            NSString *par=[NSString stringWithFormat:@"%@/%@",B2,B3];
            
            [_dateN2 addObject:_PvSn];
            [_dateN2 addObject:A2];
            [_dateN2 addObject:par];
            // [_dateN2 addObject:A3];
            
            [_dateY2 addObject:B1];
            [_dateY2 addObject:B22];
            [_dateY2 addObject:B5];
            [self netParameter2];
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
    
    
}

-(void)netParameter2{
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"inverterId":_PvSn} paramarsSite:@"/newInverterAPI.do?op=getInverterDetailData_max" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getInverterDetailData_max: %@", content);
        if (content) {
            NSDictionary *netDic=[NSDictionary dictionaryWithDictionary:content];
            
            NSArray *value1Array=@[@"vpv1",@"vpv2",@"vpv3",@"vpv4",@"vpv5",@"vpv6",@"vpv7",@"vpv8",@"vacr",@"vacs",@"vact"];
            for (int i=0; i<value1Array.count; i++) {
                if ([netDic.allKeys containsObject:value1Array[i]]) {
                    NSString*keyString=value1Array[i];
                      [_pv12 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",netDic[keyString]] floatValue]]];
                }else{
                    [_pv12 addObject:@"0"];
                }
            }
            
            [_pv12 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"vpv1"]] floatValue]]];
            [_pv12 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"vpv2"]] floatValue]]];
            [_pv12 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"vacr"]] floatValue]]];
            [_pv12 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"vacs"]] floatValue]]];
            [_pv12 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"vact"]] floatValue]]];
            
            [_pv22 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"ipv1"]] floatValue]]];
            [_pv22 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"ipv2"]] floatValue]]];
            [_pv22 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"iacr"]] floatValue]]];
            [_pv22 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"iacs"]] floatValue]]];
            [_pv22 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"iact"]] floatValue]]];
            
            [_pv32 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"ppv1"]] floatValue]]];
            [_pv32 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"ppv2"]] floatValue]]];
            [_pv32 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"pacr"]] floatValue]]];
            [_pv32 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"pacs"]] floatValue]]];
            [_pv32 addObject:[NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",content[@"pact"]] floatValue]]];
            
 
            [self initUI];
        }
    } failure:^(NSError *error) {
        
        
        [_pv12 addObject:@"0"];
        [_pv12 addObject:@"0"];
        [_pv12 addObject:@"0"];
        [_pv12 addObject:@"0"];
        [_pv12 addObject:@"0"];
        
        [_pv22 addObject:@"0"];
        [_pv22 addObject:@"0"];
        [_pv22 addObject:@"0"];
        [_pv22 addObject:@"0"];
        [_pv22 addObject:@"0"];
        
        [_pv32 addObject:@"0"];
        [_pv32 addObject:@"0"];
        [_pv32 addObject:@"0"];
        [_pv32 addObject:@"0"];
        [_pv32 addObject:@"0"];
        
        
        [self initUI];
        
    }];
    
    
}

- (void)showProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)initdata{
    // _dateN1=[[NSMutableArray alloc]initWithObjects:root_xuleihao, root_duankou, root_CNJ_eDing_gonglv,nil];
    _dateN1=[[NSMutableArray alloc]initWithObjects:root_xuleihao, root_xinghao, root_gujian_banben,nil];
    
    _dateY1=[[NSMutableArray alloc]initWithObjects:root_duankou, root_CNJ_eDing_gonglv, root_moshi,nil];
    
    _dateName=[[NSMutableArray alloc]initWithObjects:@"Volt(V)", @"Current(A)", @"Watt(W)",nil];
    _pv=[[NSMutableArray alloc]initWithObjects:@"PV1", @"PV2",@"AC1",@"AC2",@"AC3",nil];
    // _pv11=[[NSMutableArray alloc]initWithObjects:@"VPV1(V)", @"VPV2(V)",nil];
    
    //  _pv21=[[NSMutableArray alloc]initWithObjects:@"IPV1(A)", @"IPV2(A)",nil];
    
    //   _pv31=[[NSMutableArray alloc]initWithObjects:@"WPV1(W)", @"WPV2(W)",nil];
    
}

-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0*NOW_SIZE, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,650*NOW_SIZE);
    [self.view addSubview:_scrollView];
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 210*HEIGHT_SIZE)];
    //    UIImage *bgImage = IMAGE(@"bg4.png");
    //    headView.layer.contents = (id)bgImage.CGImage;
    headView.backgroundColor=MainColor;
    [_scrollView addSubview:headView];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width/2,10*HEIGHT_SIZE, 1*NOW_SIZE, 200*HEIGHT_SIZE)];
    line1.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:line1];
    
    float SIZE1=70*HEIGHT_SIZE;
    for(int i=0;i<_dateN1.count;i++){
        UILabel *PVLable=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 15*HEIGHT_SIZE+SIZE1*i, 160*NOW_SIZE,20*HEIGHT_SIZE )];
        PVLable.text=_dateN1[i];
        PVLable.textAlignment=NSTextAlignmentCenter;
        PVLable.adjustsFontSizeToFitWidth=YES;
        PVLable.textColor=[UIColor whiteColor];
        PVLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:PVLable];
        UILabel *Lable1=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 40*HEIGHT_SIZE+SIZE1*i, 160*NOW_SIZE,20*HEIGHT_SIZE )];
        Lable1.text=_dateN2[i];
        Lable1.adjustsFontSizeToFitWidth=YES;
        Lable1.textAlignment=NSTextAlignmentCenter;
        Lable1.textColor=[UIColor whiteColor];
        Lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:Lable1];
        
        UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 15*HEIGHT_SIZE+SIZE1*i, 160*NOW_SIZE,20*HEIGHT_SIZE )];
        PV2Lable.text=_dateY1[i];
        PV2Lable.textAlignment=NSTextAlignmentCenter;
        PV2Lable.textColor=[UIColor whiteColor];
        PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        PV2Lable.adjustsFontSizeToFitWidth=YES;
        [_scrollView addSubview:PV2Lable];
        UILabel *Lable2=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 40*HEIGHT_SIZE+SIZE1*i, 160*NOW_SIZE,20*HEIGHT_SIZE )];
        Lable2.text=_dateY2[i];
        Lable2.textAlignment=NSTextAlignmentCenter;
        Lable2.textColor=[UIColor whiteColor];
        Lable2.adjustsFontSizeToFitWidth=YES;
        Lable2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:Lable2];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,70*HEIGHT_SIZE+SIZE1*i, 300*NOW_SIZE, 1*HEIGHT_SIZE)];
        line.backgroundColor=[UIColor whiteColor];
        [_scrollView addSubview:line];
    }
    
    float Size2=60*NOW_SIZE,Size3=(SCREEN_Width-60*NOW_SIZE)/3;
    for (int j=0; j<_dateName.count; j++) {
        UILabel *Name1=[[UILabel alloc]initWithFrame:CGRectMake(Size2+j*Size3, 300*HEIGHT_SIZE-70*HEIGHT_SIZE, Size3,20*HEIGHT_SIZE )];
        Name1.text=_dateName[j];
        Name1.textAlignment=NSTextAlignmentCenter;
        Name1.textColor=COLOR(104, 113, 201, 1);
        Name1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:Name1];
    }
    
    float size3=40*HEIGHT_SIZE;
    for (int K=0; K<_pv.count; K++) {
        UILabel *pv=[[UILabel alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 330*HEIGHT_SIZE+size3*K-70*HEIGHT_SIZE, 60*NOW_SIZE,15*HEIGHT_SIZE )];
        pv.text=_pv[K];
        pv.textAlignment=NSTextAlignmentLeft;
        pv.textColor=[UIColor blackColor];
        pv.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [_scrollView addSubview:pv];
        
        //        UILabel *pv1=[[UILabel alloc]initWithFrame:CGRectMake(Size2+0*Size3, 330*NOW_SIZE+size3*K-70*NOW_SIZE, Size3,15*NOW_SIZE )];
        //        pv1.text=_pv11[K];
        //        pv1.textAlignment=NSTextAlignmentCenter;
        //        pv1.textColor=[UIColor grayColor];
        //        pv1.font = [UIFont systemFontOfSize:12*NOW_SIZE];
        //        [_scrollView addSubview:pv1];
        
        UILabel *pv11=[[UILabel alloc]initWithFrame:CGRectMake(Size2+0*Size3, 330*HEIGHT_SIZE+size3*K-70*HEIGHT_SIZE, Size3,15*HEIGHT_SIZE )];
        pv11.text=_pv12[K];
        pv11.textAlignment=NSTextAlignmentCenter;
        pv11.textColor=[UIColor grayColor];
        pv11.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:pv11];
        
        //        UILabel *pv2=[[UILabel alloc]initWithFrame:CGRectMake(Size2+1*Size3, 330*NOW_SIZE+size3*K-70*NOW_SIZE, Size3,15*NOW_SIZE )];
        //        pv2.text=_pv21[K];
        //        pv2.textAlignment=NSTextAlignmentCenter;
        //        pv2.textColor=[UIColor grayColor];
        //        pv2.font = [UIFont systemFontOfSize:12*NOW_SIZE];
        //        [_scrollView addSubview:pv2];
        
        UILabel *pv21=[[UILabel alloc]initWithFrame:CGRectMake(Size2+1*Size3, 330*HEIGHT_SIZE+size3*K-70*HEIGHT_SIZE, Size3,15*HEIGHT_SIZE )];
        pv21.text=_pv22[K];
        pv21.textAlignment=NSTextAlignmentCenter;
        pv21.textColor=[UIColor grayColor];
        pv21.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:pv21];
        
        //        UILabel *pv3=[[UILabel alloc]initWithFrame:CGRectMake(Size2+2*Size3, 330*NOW_SIZE+size3*K-70*NOW_SIZE, Size3,15*NOW_SIZE )];
        //        pv3.text=_pv31[K];
        //        pv3.textAlignment=NSTextAlignmentCenter;
        //        pv3.textColor=[UIColor grayColor];
        //        pv3.font = [UIFont systemFontOfSize:12*NOW_SIZE];
        //        [_scrollView addSubview:pv3];
        
        UILabel *pv31=[[UILabel alloc]initWithFrame:CGRectMake(Size2+2*Size3,330*HEIGHT_SIZE+size3*K-70*HEIGHT_SIZE, Size3,15*HEIGHT_SIZE )];
        pv31.text=_pv32[K];
        pv31.textAlignment=NSTextAlignmentCenter;
        pv31.textColor=[UIColor grayColor];
        pv31.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:pv31];
        
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 355*HEIGHT_SIZE+size3*K-70*HEIGHT_SIZE, 300*NOW_SIZE,1*HEIGHT_SIZE )];
        line2.backgroundColor=COLOR(212, 212, 212, 1);
        [_scrollView addSubview:line2];
        
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
