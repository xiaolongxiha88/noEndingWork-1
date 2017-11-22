//
//  resultDetailView.m
//  ShinePhone
//
//  Created by sky on 2017/11/21.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "resultDetailView.h"
#import "payResultView.h"


@interface resultDetailView ()

@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation resultDetailView

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

-(void)initUI{
 
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    
    [self.view addSubview:_scrollView];
    
    
    NSArray *nameArray=@[@"订单号",@"支付结果",@"支付金额",@"支付时间",@"采集器序列号",@"续费年限",@"续费账号",@"发票抬头",@"企业税号",@"联系电话",@"详细地址",@"备注"];
    NSArray*valueArray=@[@"growattOrderId",@"app_trade_status",@"money",@"gmt_create",@"datalogSn",@"year",@"username",@"invoiceName",@"invoiceNum",@"invoicePhone",@"invoiceAddr",@"remark"];
    
    float H0=30*HEIGHT_SIZE, W0=300*NOW_SIZE;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
   
    
    float allH=0;
    for (int i=0; i<nameArray.count; i++) {
        NSString *name1=[_allDic objectForKey:valueArray[i]];
        if (i==1) {
            name1=[self changeResult:name1];
        }
        NSString*nameString=[NSString stringWithFormat:@"%@:%@",nameArray[i],name1];
        CGSize size = [nameString boundingRectWithSize:CGSizeMake(W0, H0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        float H=H0;
        if (size.height>H0 && size.height<2*H0) {
            H=2*H0;
        }else  if (size.height>2*H0 && size.height<3*H0) {
            H=3*H0;
        }
        UILabel *lable0 = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_Width-W0)/2, 0*HEIGHT_SIZE+allH, W0, H)];
        lable0.textColor = COLOR(102, 102, 102, 1);
        lable0.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        lable0.textAlignment=NSTextAlignmentLeft;
        lable0.text=nameString;
        [_scrollView addSubview:lable0];
        
          UIView *View0 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_Width-W0)/2, 0*HEIGHT_SIZE+allH+H-LineWidth, W0, LineWidth)];
        View0.backgroundColor=colorGary;
          [_scrollView addSubview:View0];
        
          allH=allH+H;
    }
    
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,allH+100*HEIGHT_SIZE);
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
