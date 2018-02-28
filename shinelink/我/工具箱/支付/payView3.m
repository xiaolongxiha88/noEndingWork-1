//
//  payView3.m
//  ShinePhone
//
//  Created by sky on 2017/11/9.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "payView3.h"
#import "payInvoice.h"
#import "payResultView.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>


@interface payView3 ()<WXApiDelegate>
@property(nonatomic,strong)UILabel *paperLable1;
@property(nonatomic,strong)NSArray *InvoiceArray;
@property(nonatomic,assign)int payType;
@property(nonatomic,strong)NSString *payID;
@end

@implementation payView3

-(void)viewWillDisappear:(BOOL)animated{
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payResultNotice" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    _InvoiceArray=[NSArray new];
     [self initUI];
    
       [WXApi registerApp:@"wx4f0bf741c4f4443d"];  //微信注册
    
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivepayResultNotice:) name: @"payResultNotice" object:nil];

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
                
                payResultView *goView = [[payResultView alloc]init];
                goView.noticeString=noticeString;
                goView.isShowAlert=YES;
                [self.navigationController pushViewController:goView animated:YES];
               
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



-(void)viewWillAppear:(BOOL)animated{
    if (_paperLable1) {
        BOOL payB=[[[NSUserDefaults standardUserDefaults] objectForKey:@"invoiceEnable"] boolValue];
        if (payB) {
             _paperLable1.text=@"是";
            _InvoiceArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"invoiceArray"];
        }else{
            _paperLable1.text=@"否";
        }
    }
    
}

-(void)initUI{
    
    float H0=30*HEIGHT_SIZE;
   UIView* _V1=[[UIView alloc]initWithFrame:CGRectMake(0, 0*HEIGHT_SIZE, SCREEN_Width, H0)];
    _V1.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_V1];
    
    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width-20*NOW_SIZE, H0)];
    VL1.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    VL1.textAlignment = NSTextAlignmentLeft;
    VL1.text=@"支付总金额";
    VL1.textColor =COLOR(51, 51, 51, 1);
    [_V1 addSubview:VL1];
    
     UIView* _V22=[[UIView alloc]initWithFrame:CGRectMake(0, H0, SCREEN_Width,  100*HEIGHT_SIZE)];
    _V22.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_V22];
    
    
    UILabel*  _moneyLable= [[UILabel alloc] initWithFrame:CGRectMake(0*NOW_SIZE, 10*HEIGHT_SIZE, SCREEN_Width, HEIGHT_SIZE*80)];
    _moneyLable.font=[UIFont systemFontOfSize:36*HEIGHT_SIZE];
    _moneyLable.textAlignment = NSTextAlignmentCenter;
    _moneyLable.text=[NSString stringWithFormat:@"¥ %ld",_AllMoney];
    _moneyLable.textColor =[UIColor blackColor];
    [_V22 addSubview:_moneyLable];
    
     float H2=40*HEIGHT_SIZE;
    UIView* _V33=[[UIView alloc]initWithFrame:CGRectMake(0, 140*HEIGHT_SIZE, SCREEN_Width,  H2)];
    _V33.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_V33];
    _V33.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goTopaperView)];
    [_V33 addGestureRecognizer:tapGestureRecognizer];
    
    UILabel*  papleLable= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, 200*NOW_SIZE, H2)];
    papleLable.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    papleLable.textAlignment = NSTextAlignmentLeft;
    papleLable.text=@"是否开发票";
    papleLable.textColor =COLOR(102, 102, 102, 1);
    [_V33 addSubview:papleLable];
    
    
    float image3W=6*NOW_SIZE;float imageH2=10*HEIGHT_SIZE;
        UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_Width-image3W-10*NOW_SIZE,(H2-imageH2)/2, image3W,imageH2)];
        image3.image=IMAGE(@"MAXright.png");
        [_V33 addSubview:image3];
    
    if (!_paperLable1) {
        _paperLable1= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width-image3W-10*NOW_SIZE-55*NOW_SIZE, 0*HEIGHT_SIZE, 50*NOW_SIZE, H2)];
        _paperLable1.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        _paperLable1.textAlignment = NSTextAlignmentRight;
        _paperLable1.text=@"否";
        _paperLable1.textColor =COLOR(102, 102, 102, 1);
        [_V33 addSubview:_paperLable1];
    }
 
    
    
    UIView* _V4=[[UIView alloc]initWithFrame:CGRectMake(0, 180*HEIGHT_SIZE, SCREEN_Width, H0)];
    _V4.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_V4];
    
    UILabel *VL4= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width-20*NOW_SIZE, H0)];
    VL4.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    VL4.textAlignment = NSTextAlignmentLeft;
    VL4.text=@"支付方式";
    VL4.textColor =COLOR(51, 51, 51, 1);
    [_V4 addSubview:VL4];
    
      float H5=50*HEIGHT_SIZE;
    NSArray *imageNameArray=@[@"wechat.png",@"Alipay.png"];
     NSArray *lableNameArray=@[@"微信支付",@"支付宝支付"];
    for (int i=0; i<imageNameArray.count; i++) {
        UIView* V5=[[UIView alloc]initWithFrame:CGRectMake(0, 210*HEIGHT_SIZE+H5*i, SCREEN_Width, H5)];
        V5.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:V5];
        
        float imageW5=36*HEIGHT_SIZE;
        UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,(H5-imageW5)/2, imageW5,imageW5)];
        image5.image=IMAGE(imageNameArray[i]);
        [V5 addSubview:image5];
        
        UILabel *VL5= [[UILabel alloc] initWithFrame:CGRectMake(20*NOW_SIZE+imageW5, 0*HEIGHT_SIZE, SCREEN_Width-20*NOW_SIZE, H5)];
        VL5.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        VL5.textAlignment = NSTextAlignmentLeft;
        VL5.text=lableNameArray[i];
        VL5.textColor =COLOR(102, 102, 102, 1);
        [V5 addSubview:VL5];
        
        float W=20*HEIGHT_SIZE;
        float W1=(50*HEIGHT_SIZE-W)/2;
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,  H5)];
        [button1 setImage:[UIImage imageNamed:@"Selected_norPay.png"] forState:UIControlStateNormal];
        button1.tag=2000+i;
        button1.selected=NO;
        button1.imageEdgeInsets = UIEdgeInsetsMake(W1, ScreenWidth-W-W1, W1, W1);//设置边距
        [button1 addTarget:self action:@selector(selectPressed:) forControlEvents:UIControlEventTouchUpInside];
        [V5 addSubview:button1];
        
        UIView* lineView=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, H5-LineWidth, SCREEN_Width-20*NOW_SIZE, LineWidth)];
        lineView.backgroundColor=COLOR(242, 242, 242, 1);
        [V5 addSubview:lineView];
    }
   
    
   UIButton* _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(60*NOW_SIZE,360*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:@"支付" forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(getNetOne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_goBut];
    
    
    UILabel *alertLable= [[UILabel alloc] initWithFrame:CGRectMake(15*NOW_SIZE, 440*HEIGHT_SIZE, SCREEN_Width-30*NOW_SIZE, 30*HEIGHT_SIZE)];
    alertLable.font=[UIFont systemFontOfSize:10*HEIGHT_SIZE];
    alertLable.textAlignment = NSTextAlignmentCenter;
    alertLable.numberOfLines=0;
    alertLable.text=@"温馨提示:本业务为运营商代理续费业务,如运营商取消套餐,本公司将不予退款.";
    alertLable.textColor =COLOR(186, 186, 186, 1);
    [self.view addSubview:alertLable];
    
    
    
}


-(void)getNetOne{
    NSString *userName= [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
      NSArray *payA=[[NSUserDefaults standardUserDefaults] objectForKey:@"invoiceArray"];
    
    BOOL payB=[[[NSUserDefaults standardUserDefaults] objectForKey:@"invoiceEnable"] boolValue];
    NSString*haveInvoice; NSString*InvoiceName=@"";NSString*invoiceNum=@"";NSString*invoicePhone=@"";NSString*invoiceAddr=@"";NSString*remark=@"";
    if (payB) {
        haveInvoice=@"1";InvoiceName=payA[0];invoiceNum=payA[1];invoicePhone=payA[2];invoiceAddr=payA[3];remark=payA[4];
    }else{
 haveInvoice=@"0";
    }
     NSString*moneyType=@"";
    
        UIButton *button=[self.view viewWithTag:2000];
        UIButton *button1=[self.view viewWithTag:2001];
    if (button.selected) {
        moneyType=@"1";       //微信
    }
    if (button1.selected) {
        moneyType=@"0";    //支付宝
    }
    if ([moneyType isEqualToString:@""]) {
        [self showToastViewWithTitle:@"请选择支付方式"];
        return;
    }
    _payType=[moneyType intValue];
    
    NSString *serverUrl0= [[NSUserDefaults standardUserDefaults] objectForKey:@"server"];
    
  //  serverUrl0=@"http://server.growatt.com"; //DEMO
    
    //_moneyString=@"0.01";//DEMO
    

    NSMutableString *snString=[NSMutableString new];
    for (NSString*sn in _snArray) {
        [snString appendString:sn];
        [snString appendString:@"_"];
    }
    if (_snArray.count>1) {
        NSRange deleteRange = {[snString length]-1, 1};
        [snString deleteCharactersInRange:deleteRange];
    }


    //_moneyString=@"0.01";
    
    NSString * serverUrl = [serverUrl0 substringFromIndex:7];
  NSDictionary *netDic=@{
                         @"username":userName,
                         @"datalog":snString,
                           @"type":moneyType,
                     @"serverUrl":serverUrl,
                            @"year":_yearString,
                                @"money":_moneyString,
                             @"haveInvoice":haveInvoice,
                         @"invoiceName":InvoiceName,
                         @"invoiceNum":invoiceNum,
                         @"invoicePhone":invoicePhone,
                         @"invoiceAddr":invoiceAddr,
                           @"remark":remark,
                         };
    
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL_Demo_2 paramars:netDic paramarsSite:@"/api/v2/renew/getPayRequest" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"api/v2/renew/getPayRequest: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            if ([firstDic[@"result"] intValue]==1) {
                _payID=firstDic[@"msg"];
                if (_payType==0) {
                    NSString *payString=firstDic[@"obj"];
                    [self goPayAlipay:payString];
                }
                if (_payType==1) {
                   NSDictionary *DIC=firstDic[@"obj"];
                    [self goPayWeChar:DIC];
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






- (void)selectPressed:(UIButton *)sender{
    sender.selected=!sender.selected;
    
    for (int i=0; i<2; i++) {
        UIButton *button=[self.view viewWithTag:2000+i];
        if (button.tag==sender.tag) {
            if (button.selected) {
                  [button setImage:[UIImage imageNamed:@"Selected_clickPay.png"] forState:UIControlStateNormal];
            }else{
                     [button setImage:[UIImage imageNamed:@"Selected_norPay.png"] forState:UIControlStateNormal];
            }
        }else{
            button.selected=NO;
                  [button setImage:[UIImage imageNamed:@"Selected_norPay.png"] forState:UIControlStateNormal];
        }
        
    }
    
}



-(void)goTopaperView{
    
    payInvoice *testView=[[payInvoice alloc]init];
    [self.navigationController pushViewController:testView animated:YES];
    
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
