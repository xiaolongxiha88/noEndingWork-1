//
//  payInvoice.m
//  ShinePhone
//
//  Created by sky on 2017/11/9.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "payInvoice.h"

@interface payInvoice ()<UITextViewDelegate>
@property(nonatomic,strong)UIView *view2;
@property (nonatomic, strong) UITextView *contentView;
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation payInvoice

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    
    [self initUI];
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    for (int i=0; i<4; i++) {
        UITextField *lable=[_scrollView viewWithTag:3000+i];
        [lable resignFirstResponder];
    }
    [_contentView resignFirstResponder];
}

-(void)initUI{
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,SCREEN_Height*1.4);
    [self.view addSubview:_scrollView];
    
    float H0=30*HEIGHT_SIZE;
    UIView* _V1=[[UIView alloc]initWithFrame:CGRectMake(0, 0*HEIGHT_SIZE, SCREEN_Width, H0)];
    _V1.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_V1];
    
    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width-20*NOW_SIZE, H0)];
    VL1.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    VL1.textAlignment = NSTextAlignmentLeft;
    VL1.text=@"选择是否需要发票";
    VL1.textColor =COLOR(51, 51, 51, 1);
    [_V1 addSubview:VL1];
    
    float H5=50*HEIGHT_SIZE;

       BOOL payEnable=[[[NSUserDefaults standardUserDefaults] objectForKey:@"invoiceEnable"] boolValue];
    
    NSArray *lableNameArray=@[@"不开发票",@"开发票"];
    for (int i=0; i<lableNameArray.count; i++) {
        UIView* V5=[[UIView alloc]initWithFrame:CGRectMake(0, H0+H5*i, SCREEN_Width, H5)];
        V5.backgroundColor=[UIColor whiteColor];
        [_scrollView addSubview:V5];
        
        UILabel *VL5= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width-20*NOW_SIZE, H5)];
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
        if (payEnable) {
            if (i==1) {
                  button1.selected=YES;
                 [button1 setImage:[UIImage imageNamed:@"Selected_clickPay.png"] forState:UIControlStateNormal];
                [self initTwo];
            }
        }else{
            if (i==0) {
                button1.selected=YES;
                [button1 setImage:[UIImage imageNamed:@"Selected_clickPay.png"] forState:UIControlStateNormal];
            }
        }
   
        button1.imageEdgeInsets = UIEdgeInsetsMake(W1, ScreenWidth-W-W1, W1, W1);//设置边距
        [button1 addTarget:self action:@selector(selectPressed:) forControlEvents:UIControlEventTouchUpInside];
        [V5 addSubview:button1];
        
        UIView* lineView=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, H5-LineWidth, SCREEN_Width-20*NOW_SIZE, LineWidth)];
        lineView.backgroundColor=COLOR(242, 242, 242, 1);
        [V5 addSubview:lineView];
    }
    
    
    UIButton* _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(60*NOW_SIZE,460*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:@"完成" forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_goBut];
    
}

-(void)initTwo{
    
     NSArray *payValue=[[NSUserDefaults standardUserDefaults] objectForKey:@"invoiceArray"];
    
    _view2=[[UIView alloc]initWithFrame:CGRectMake(0, 130*HEIGHT_SIZE, SCREEN_Width, 330*HEIGHT_SIZE)];
    _view2.backgroundColor=[UIColor clearColor];
    _view2.userInteractionEnabled=YES;
    [_scrollView addSubview:_view2];
    
    float H0=30*HEIGHT_SIZE;

    UILabel *VL1= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width-20*NOW_SIZE, H0)];
    VL1.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
    VL1.textAlignment = NSTextAlignmentLeft;
    VL1.text=@"填写发票信息";
    VL1.textColor =COLOR(51, 51, 51, 1);
    [_view2 addSubview:VL1];
    
    float H1=40*HEIGHT_SIZE;
    NSArray *lableNameArray=@[@"发票抬头",@"企业税号",@"收件人",@"联系电话",@"详细地址"];
    for (int i=0; i<lableNameArray.count; i++) {
        UIView *V0=[[UIView alloc]initWithFrame:CGRectMake(0, 30*HEIGHT_SIZE+H1*i, SCREEN_Width,H1)];
           V0.userInteractionEnabled=YES;
        V0.backgroundColor=[UIColor whiteColor];
        [_view2 addSubview:V0];
        
        float LW=100*NOW_SIZE;
        UILabel *VL5= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE, LW, H1)];
        VL5.font=[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        VL5.textAlignment = NSTextAlignmentRight;
        VL5.text=[NSString stringWithFormat:@"%@:",lableNameArray[i]];
        VL5.textColor =COLOR(102, 102, 102, 1);
        [V0 addSubview:VL5];
        
      UITextField*  _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(LW+15*NOW_SIZE, 0*HEIGHT_SIZE, 310*NOW_SIZE-LW-15*NOW_SIZE, H1)];
        _textField2.textColor = COLOR(102, 102, 102, 1);
        _textField2.tintColor = COLOR(102, 102, 102, 1);
        _textField2.textAlignment=NSTextAlignmentLeft;
        if (payValue.count>i) {
            _textField2.text=payValue[i];
        }
        _textField2.tag=3000+i;
        [_textField2 setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_textField2 setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
          _textField2.placeholder = @"请填写相关信息";
        _textField2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [V0 addSubview:_textField2];
        
        UIView* lineView=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, H1-LineWidth, SCREEN_Width-20*NOW_SIZE, LineWidth)];
        lineView.backgroundColor=COLOR(242, 242, 242, 1);
        [V0 addSubview:lineView];
        
    }
    
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(0, 230*HEIGHT_SIZE, SCREEN_Width,60*HEIGHT_SIZE)];
    V1.userInteractionEnabled=YES;
    V1.backgroundColor=[UIColor whiteColor];
      [_view2 addSubview:V1];
    
    self.contentView = [[UITextView alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 0, 300*NOW_SIZE,60*HEIGHT_SIZE )];
    _contentView.text=root_pay_191;
    if (payValue.count>5) {
        _contentView.text=payValue[5];
    }
    
    self.contentView.textColor = COLOR(153, 153, 153, 1);
    self.contentView.tintColor = COLOR(153, 153, 153, 1);
    _contentView.textAlignment=NSTextAlignmentLeft;
    _contentView.delegate=self;
    self.contentView.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [V1 addSubview:_contentView];
    
    
    NSString* alertString1;
    if ([_infoDic.allKeys containsObject:@"defaultCourier"]) {
        alertString1=[_infoDic objectForKey:@"defaultCourier"];
    }
    UILabel *alertV= [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 290*HEIGHT_SIZE, 300*NOW_SIZE, 30*HEIGHT_SIZE)];
    alertV.font=[UIFont systemFontOfSize:10*HEIGHT_SIZE];
    alertV.textAlignment = NSTextAlignmentCenter;
    alertV.text=[NSString stringWithFormat:@"快递信息:%@(运费到付)",alertString1];
    alertV.numberOfLines=0;
    alertV.textColor =MainColor;
    [_view2 addSubview:alertV];

    
}

-(void)finishSet{
  
        UIButton *button0=[_scrollView viewWithTag:2000];
    if (button0.selected) {
         [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"invoiceEnable"];
    }else{
          [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"invoiceEnable"];
        
        NSMutableArray *textArray=[NSMutableArray new];
         for (int i=0; i<5; i++) {
            UITextField *textF=[_scrollView viewWithTag:3000+i];
             if ([textF.text isEqualToString:@""]) {
                 [self showToastViewWithTitle:@"请填写发票相关信息"];
                 return;
             }else{
                   [textArray addObject:textF.text];
             }
           
        }
        if ([_contentView.text isEqualToString:root_pay_191]) {
            [textArray addObject:@""];
        }else{
             [textArray addObject:_contentView.text];
        }
        
         [[NSUserDefaults standardUserDefaults] setObject:textArray forKey:@"invoiceArray"];
    }

 //   NSArray *payA=[[NSUserDefaults standardUserDefaults] objectForKey:@"invoiceArray"];
 //   BOOL payB=[[[NSUserDefaults standardUserDefaults] objectForKey:@"invoiceEnable"] boolValue];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([_contentView.text isEqualToString:root_pay_191]) {
        
        _contentView.text = @"";
        self.contentView.textColor = COLOR(51, 51, 51, 1);
        self.contentView.tintColor = COLOR(51, 51, 51, 1);
        
    }
    
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (_contentView.text.length<1) {
        _contentView.text = root_pay_191;
        self.contentView.textColor = COLOR(153, 153, 153, 1);
        self.contentView.tintColor = COLOR(153, 153, 153, 1);
    }
    
}

- (void)selectPressed:(UIButton *)sender{
    if (!sender.selected) {
            sender.selected=!sender.selected;
    }

    
    for (int i=0; i<2; i++) {
        UIButton *button=[_scrollView viewWithTag:2000+i];
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
    
    if ((sender.tag==2001) && (sender.selected==YES)) {
        if (!_view2) {
              [self initTwo];
        }
    }else{
        [_view2 removeFromSuperview];
        _view2=nil;
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
