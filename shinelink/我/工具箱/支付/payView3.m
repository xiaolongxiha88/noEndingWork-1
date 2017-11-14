//
//  payView3.m
//  ShinePhone
//
//  Created by sky on 2017/11/9.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "payView3.h"
#import "payInvoice.h"

@interface payView3 ()
@property(nonatomic,strong)UILabel *paperLable1;
@property(nonatomic,strong)NSArray *InvoiceArray;
@end

@implementation payView3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    _InvoiceArray=[NSArray new];
     [self initUI];
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
        moneyType=@"1";
    }
    if (button1.selected) {
        moneyType=@"0";
    }
    if ([moneyType isEqualToString:@""]) {
        [self showToastViewWithTitle:@"请选择支付方式"];
        return;
    }
  NSDictionary *netDic=@{
                         @"username":userName,
                         @"datalogSn":_snArray,
                           @"type":moneyType,
                            @"year":_yearString,
                                @"money":_moneyString,
                             @"haveInvoice":haveInvoice,
                         @"InvoiceName":InvoiceName,
                         @"invoiceNum":invoiceNum,
                         @"invoicePhone":invoicePhone,
                         @"invoiceAddr":invoiceAddr,
                           @"remark":remark,
                         };
    
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:netDic paramarsSite:@"/api/v2/renew/getPayRequest" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"api/v2/renew/getPayRequest: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            if ([firstDic[@"result"] intValue]==1) {
                
            }else{
                [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",firstDic[@"msg"]]];
            }
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
   
        
    }];
    
}


-(void)goPay{
    
    //    NSString *orderString =@"alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2017110409716742&biz_content=%7B%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22out_trade_no%22%3A%22growatt_order_20171107003%22%2C%22product_code%22%3A%22GPRS%E7%BB%AD%E8%B4%B95%E5%B9%B4%22%2C%22subject%22%3A%22App%E6%94%AF%E4%BB%98%E6%B5%8B%E8%AF%95Java%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%220.01%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2F47.91.176.158%2Fcommon%2Fnotify&sign=Vjx95nXWBbIIZnhmdSC49Dyi69D1Rlft4OTKCeFSvjWFsv9je%2FeiH5XuWE5OgJ%2BgP8pumODBDoFeUgFwTI8rfF1xogzAUVYSi2xCVj5e%2Bdv0tXnew5SHjhjrGgOKZhpGfLsrEbmjdqYucEMfo4CHqhW4pCaVQa%2F8vTECqC44ifbMQszSFT0naBKQnQ%2Bx08Jjk6V%2FnwfNpH%2B%2F3INJ5xfQTWEtW4EnhqnzkKTqsSJHCdlj07iWSM2SuzyzEOoAYiVfHTf0m%2FXFyMUX9zGT5zUcBYLAoRNYMq7aTpG5t58hQF97%2FpGx5BsHczvBn1cABV34vvKvKXGspGUTpRmt6Eh2kw%3D%3D&sign_type=RSA2&timestamp=2017-11-07+16%3A08%3A32&version=1.0";
    //
    //    NSString *appScheme = @"ShinePhoneAlipay";
    //
    //    // NOTE: 调用支付结果开始支付
    //    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
    //
    //        NSLog(@"reslut1212 = %@",resultDic);
    //    }];
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
