//
//  orderSetView.m
//  ShinePhone
//
//  Created by sky on 2017/12/26.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "orderSetView.h"

@interface orderSetView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *lableNameArray;
@property (nonatomic, strong) NSArray *lableNameArray2;
@end

@implementation orderSetView

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self getData];
}

-(void)getData{
    _lableNameArray=@[@"项目名称",@"产品类型",@"安装或第一次开机年月",@"产品SN号",@"软件版本号",@"客户公司名称",@"联系人员",@"联系电话"];
      _lableNameArray2=@[@"故障描述",@"处理方式",@"更换配件",@"维修结论"];
    
        [self initUI];
}

-(void)initUI{
    UIColor *lableColor=COLOR(102, 102, 102, 1);
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    
        float KongW=5*NOW_SIZE;  float lableH=35*HEIGHT_SIZE;    float numH=35*NOW_SIZE;  float firstW=10*NOW_SIZE;
    
    for (int i=0; i<_lableNameArray.count; i++) {
        NSString *lableNameString1=[NSString stringWithFormat:@"%@:",_lableNameArray[i]];
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size0 = [lableNameString1 boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic1 context:nil].size;
       
        UILabel *lable02 = [[UILabel alloc]initWithFrame:CGRectMake(firstW, 0+numH*i,size0.width, lableH)];
        lable02.textColor = lableColor;
        lable02.text=lableNameString1;
        lable02.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        lable02.textAlignment=NSTextAlignmentLeft;
        [_scrollView addSubview:lable02];
        
        UIView *V01 = [[UIView alloc]initWithFrame:CGRectMake(firstW,lableH+numH*i, SCREEN_Width-(2*firstW),LineWidth)];
        V01.backgroundColor = COLOR(222, 222, 222, 1);
        [_scrollView addSubview:V01];
        
        float textfieldW=SCREEN_Width-(2*firstW)-(size0.width+KongW);
        UITextField*  lableTextfield = [[UITextField alloc] initWithFrame:CGRectMake(firstW+size0.width+KongW, 0+numH*i,textfieldW, lableH)];
        lableTextfield.textColor = lableColor;
        lableTextfield.tintColor =lableColor;
        lableTextfield.tag=2000+i;
       // lableTextfield.placeholder = @"请输入相关资料";
        [lableTextfield setValue:COLOR(154, 154, 154, 1) forKeyPath:@"_placeholderLabel.textColor"];
        [lableTextfield setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
        lableTextfield.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:lableTextfield];
    }
   
    float lableH2=35*HEIGHT_SIZE;  float H2=numH*_lableNameArray.count;
       float textValueH=60*HEIGHT_SIZE;
     float numH2=lableH2+textValueH;
    for (int i=0; i<_lableNameArray2.count; i++) {
        UILabel *lable03 = [[UILabel alloc]initWithFrame:CGRectMake(firstW, H2+numH2*i,200*NOW_SIZE, lableH2)];
        lable03.textColor = lableColor;
        lable03.text=[NSString stringWithFormat:@"%@:",_lableNameArray2[i]];
        lable03.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        lable03.textAlignment=NSTextAlignmentLeft;
        [_scrollView addSubview:lable03];
        
     
        UITextView *textValue = [[UITextView alloc] initWithFrame:CGRectMake(firstW, H2+lableH2+numH2*i, SCREEN_Width-(2*firstW),textValueH)];
        textValue.textColor=lableColor;
        textValue.tintColor = lableColor;
        textValue.layer.borderWidth=LineWidth;
        textValue.layer.borderColor= COLOR(222, 222, 222, 1).CGColor;
        textValue.tag=3000+i;
        textValue.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:textValue];
        
    }
    
    float H3=H2+numH2*_lableNameArray2.count+20*HEIGHT_SIZE;
    UIButton* _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(60*NOW_SIZE,H3, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_goBut setBackgroundImage:IMAGE(@"workorder_button_icon_nor.png") forState:UIControlStateNormal];
    [_goBut setBackgroundImage:IMAGE(@"workorder_button_icon_click.png") forState:UIControlStateHighlighted];
    [_goBut setTitle:@"完成" forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_goBut];
    
    _scrollView.contentSize=CGSizeMake(SCREEN_Width, H3+140*HEIGHT_SIZE);
    
}

-(void)finishSet{
    
    
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
