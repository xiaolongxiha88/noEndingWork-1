//
//  resultDetailView.m
//  ShinePhone
//
//  Created by sky on 2017/11/21.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "resultDetailView.h"
#import "payResultView.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@interface resultDetailView ()<WXApiDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *billArray;
@property (nonatomic, strong)NSString *status;

@property(nonatomic,assign)int payType;
@property(nonatomic,strong)NSString *payID;
@property(nonatomic,strong)NSString *kind;

@end

@implementation resultDetailView

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payResultNotice" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivepayResultNotice:) name: @"payResultNotice" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

-(void)initUI{
 
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    
    [self.view addSubview:_scrollView];
    
        _status=[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"status"]];
 
    //_status=@"2";
    
    _billArray=[NSMutableArray array];
    if ([_allDic.allKeys containsObject:@"billingStatus"]) {
        NSString *billingStatus=[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"billingStatus"]];
        if ([billingStatus integerValue]==1) {
            [_billArray addObject:@"等待开票"];
        }else if ([billingStatus integerValue]==2) {
            [_billArray addObject:@"已开发票"];
            if ([_allDic.allKeys containsObject:@"expressDeliveryComany"]) {
                [_billArray addObject:[_allDic objectForKey:@"expressDeliveryComany"]];
                if ([_allDic.allKeys containsObject:@"expressDeliveryId"]) {
                     [_billArray addObject:[_allDic objectForKey:@"expressDeliveryId"]];
                }else{
                     [_billArray addObject:@""];
                }
            }
        }else{
              [_billArray addObject:@"无需发票"];
        }
        
    }
    
    
    NSArray *nameArray=@[@"订单号",@"支付结果",@"支付金额",@"支付时间",@"采集器序列号",@"暂未续费成功序列号",@"续费年限",@"续费账号",@"发票抬头",@"企业税号",@"收件人",@"联系电话",@"详细地址",@"备注"];
    NSArray*valueArray=@[@"growattOrderId",@"status",@"money",@"gmt_create",@"datalogSn",@"failureDatalog",@"year",@"username",@"invoiceName",@"invoiceNum",@"recipients",@"invoicePhone",@"invoiceAddr",@"remark"];
    
    float H0=30*HEIGHT_SIZE, W0=300*NOW_SIZE;
 
   
    
    float allH=0;
    for (int i=0; i<nameArray.count; i++) {
        NSString *name1;
        NSString *valueString=valueArray[i];
        if ([_allDic.allKeys containsObject:valueString]) {
               name1=[_allDic objectForKey:valueArray[i]];
        }else{
            name1=@"";
            }
        
   NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
        NSString*nameString;

      nameString=[NSString stringWithFormat:@"%@:%@",nameArray[i],name1];

        CGSize size = [nameString boundingRectWithSize:CGSizeMake(W0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
       float H=size.height;
        if (H<H0) {
            H=H0;
        }

        if (i==4 || i==5) {
            H=H+H0/2;
        }
        UILabel *lable0 = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_Width-W0)/2, 0*HEIGHT_SIZE+allH, W0, H)];
        lable0.textColor = COLOR(102, 102, 102, 1);
        lable0.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        lable0.textAlignment=NSTextAlignmentLeft;
        lable0.numberOfLines=0;
        lable0.text=nameString;
        if (i==1) {
            lable0.text=_statusString;
        }
        [_scrollView addSubview:lable0];
        
          UIView *View0 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_Width-W0)/2, 0*HEIGHT_SIZE+allH+H-LineWidth, W0, LineWidth)];
        View0.backgroundColor=colorGary;
          [_scrollView addSubview:View0];
        
          allH=allH+H;
    }
    
    NSArray *billNameArray=@[@"发票状态",@"快递公司",@"快递单号"];
    
    for (int i=0; i<_billArray.count; i++) {
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_Width-W0)/2, 0*HEIGHT_SIZE+allH, W0, H0)];
        lable1.textColor = COLOR(102, 102, 102, 1);
        lable1.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.text=[NSString stringWithFormat:@"%@:%@",billNameArray[i],_billArray[i]];
        [_scrollView addSubview:lable1];
        
        UIView *View0 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_Width-W0)/2, 0*HEIGHT_SIZE+allH+H0-LineWidth, W0, LineWidth)];
        View0.backgroundColor=colorGary;
        [_scrollView addSubview:View0];
        
             allH=allH+H0;
    }
    
  
    
    if ([_status isEqualToString:@"2"]) {
        
        [WXApi registerApp:@"wx074a647e87deb0bd"];  //微信注册
    
        
        float buttonH=30*HEIGHT_SIZE; float buttonW=115*NOW_SIZE;
        UIButton  * _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
        _goBut.frame=CGRectMake(30*NOW_SIZE,allH+15*HEIGHT_SIZE, buttonW, buttonH);
        [_goBut.layer setMasksToBounds:YES];
        [_goBut.layer setCornerRadius:buttonH/2];
        [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
        [_goBut setTitle:@"取消" forState:UIControlStateNormal];
        _goBut.titleLabel.font=[UIFont systemFontOfSize: 12*HEIGHT_SIZE];
        [_goBut addTarget:self action:@selector(goToCancel) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_goBut];
        
        UIButton  * _goBut2 =  [UIButton buttonWithType:UIButtonTypeCustom];
        _goBut2.frame=CGRectMake(175*NOW_SIZE,allH+15*HEIGHT_SIZE, buttonW, buttonH);
        [_goBut2 setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
        [_goBut2.layer setMasksToBounds:YES];
        [_goBut2.layer setCornerRadius:buttonH/2];
        [_goBut2 setTitle:@"继续支付" forState:UIControlStateNormal];
        _goBut2.titleLabel.font=[UIFont systemFontOfSize: 12*HEIGHT_SIZE];
        [_goBut2 addTarget:self action:@selector(goTopay) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_goBut2];
        
               allH=allH+buttonH;
    }
    
      _scrollView.contentSize = CGSizeMake(SCREEN_Width,allH+200*HEIGHT_SIZE+(_billArray.count*H0));
    
}


-(void)goToCancel{
    _kind=@"0";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否取消支付？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    alertView.tag = 1001;
    [alertView show];
    
}

-(void)goTopay{
      _kind=@"1";
      [self getNetPay];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex) {
        if( (alertView.tag == 1001)){
          
                [self getNetPay];
        }
    }
    
}

-(void)receivepayResultNotice:(NSNotification*) notification{
    NSString *goString; NSString *resultString;
    if (_payType==0) {
        NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
        resultString=[NSString stringWithFormat:@"%@",[firstDic objectForKey:@"resultStatus"]];
        if ([resultString intValue]==9000) {
            goString=@"支付成功，将于月底统一续费。";
        }else{
            goString=[NSString stringWithFormat:@"%@(%d)",@"支付失败",[resultString intValue]];
        }
        
    }
    if (_payType==1) {
        NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
        
        resultString=[NSString stringWithFormat:@"%@",[firstDic objectForKey:@"code"]];
        if ([resultString isEqualToString:@"0"]) {
            goString=@"支付成功，将于月底统一续费。";
        }else if ([resultString isEqualToString:@"-1"]){
            goString=@"支付错误";
        }else if ([resultString isEqualToString:@"-2"]){
            goString=@"取消支付";
        }else{
            goString=[NSString stringWithFormat:@"支付失败(%@)",[firstDic objectForKey:@"code"]];
        }
    }
    
    [self getNetResult:resultString noticeString:goString];
}


-(void)getNetResult:(NSString*)codeString noticeString:(NSString*)noticeString{
    
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL_Demo_2 paramars:@{@"growattOrderId":_payID,@"status":codeString} paramarsSite:@"/api/v2/renew/submitPayResult" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v2/renew/submitPayResult: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            if ([firstDic[@"result"] intValue]==1) {
                
                [self showAlertViewWithTitle:@"支付结果" message:noticeString cancelButtonTitle:root_OK];
                [self.navigationController popViewControllerAnimated:YES];
        
                
            }else{
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",firstDic[@"msg"]]];
                [self showAlertViewWithTitle:@"支付结果" message:noticeString cancelButtonTitle:root_OK];
            }
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
        [self showAlertViewWithTitle:@"支付结果" message:noticeString cancelButtonTitle:root_OK];
        
        
    }];
    
}


-(void)getNetPay{
  
    NSString*growattOrderId=[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"growattOrderId"]];
    
_payType=[[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"pay_type"]] intValue];
    
//    NSString*orderId=[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"trade_no"]];

    NSDictionary *netDic=@{
                           @"growattOrderId":growattOrderId,
                           @"kind":_kind,
                           };
    
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL_Demo_2 paramars:netDic paramarsSite:@"/api/v2/renew/updateStatus" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v2/renew/updateStatus: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            if ([firstDic[@"result"] intValue]==1) {
                if ([_kind isEqualToString:@"0"]) {
                    [self showToastViewWithTitle:@"取消成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                if ([_kind isEqualToString:@"1"]) {
                    _payID=firstDic[@"msg"];
                    if (_payType==0) {
                        NSString *payString=firstDic[@"obj"];
                        [self goPayAlipay:payString];
                    }
                    if (_payType==1) {
                        NSDictionary *DIC=firstDic[@"obj"];
                        [self goPayWeChar:DIC];
                    }
                }
             
                
            }else{
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",firstDic[@"msg"]]];
            }
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
        
    }];
    
}


-(void)goPayWeChar:(NSDictionary*)dict{
    //NSDictionary *dict=[NSDictionary new];
    NSMutableString *stamp  = [dict objectForKey:@"timestrap"];
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [dict objectForKey:@"partnerid"];
    req.prepayId            = [dict objectForKey:@"prepayid"];
    req.nonceStr            = [dict objectForKey:@"noncestr"];
    req.timeStamp           = stamp.intValue;
    req.package             = @"Sign=WXPay";
    req.sign                = [dict objectForKey:@"sign"];
    [WXApi sendReq:req];
    //日志输出
    //    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    
}


-(void)goPayAlipay:(NSString*)payString{
    //    NSArray *resultArr = [payString componentsSeparatedByString:@"&"];
    
    NSString *appScheme = @"ShinePhoneAlipay";
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:payString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSLog(@"reslut1212 = %@",resultDic);
    }];
    
}




-(NSString*)changeResult:(NSString*)result{
    NSString *ResultString;
    int resultInt=[result intValue];
    if (resultInt==9000) {
        ResultString=@"成功";
    }else if (resultInt==8000 || resultInt==6004) {
        ResultString=@"正在处理,支付结果未知,请联系客服。";
    }else if (resultInt==4000) {
        ResultString=@"支付失败";
    }else if (resultInt==5000) {
        ResultString=@"重复请求";
    }else if (resultInt==6001) {
        ResultString=@"用户中途取消";
    }else if (resultInt==6002) {
        ResultString=@"网络连接出错";
    }else if (resultInt==0) {
        ResultString=@"成功";
    }else if (resultInt==-1) {
        ResultString=@"错误";
    }else if (resultInt==-2) {
        ResultString=@"用户取消";
    }else{
        ResultString=@"其他支付错误";
    }
    
    return ResultString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
    
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
