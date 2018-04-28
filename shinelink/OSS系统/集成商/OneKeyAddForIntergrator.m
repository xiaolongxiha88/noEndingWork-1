//
//  OneKeyAddForIntergrator.m
//  ShinePhone
//
//  Created by sky on 2018/4/27.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "OneKeyAddForIntergrator.h"
#import "ZJBLStoreShopTypeAlert.h"

@interface OneKeyAddForIntergrator ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *oneView;
@property (nonatomic, strong) NSArray *addressArray;
@property (nonatomic, strong) UIView *goNextView;
@property (nonatomic, assign)NSInteger stepNum;
@property (nonatomic, strong) NSMutableDictionary*oneDic;
@property (nonatomic, assign)BOOL keepValueEnable;

@end

@implementation OneKeyAddForIntergrator

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}

-(void)initUI{
    float H1=40*HEIGHT_SIZE;
    self.view.backgroundColor=COLOR(242, 242, 242, 1);
    
    float W1=SCREEN_Width/3.0;
    NSArray *nameArray=@[@"1.添加用户",@"2.添加电站",@"3.添加设备"];
    for (int i=0; i<3; i++) {
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0+W1*i, 0,W1, H1)];
        if (i==0) {
             lable1.textColor = MainColor;
              lable1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        }else{
            lable1.textColor = COLOR(154, 154, 154, 1);
            lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        }
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.text=nameArray[i];
        [self.view addSubview:lable1];
        
        
    }
    
    _stepNum=0;
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, H1, SCREEN_Width, ScreenHeight-H1)];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    
    [self initOneView];
}


-(void)initOneView{
    _oneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 241*HEIGHT_SIZE)];
    _oneView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_oneView];
    
    float H1=40*HEIGHT_SIZE;
    float W1=8*NOW_SIZE;
    NSArray *name1Array=@[@"服务器地址",@"用户名",@"密码",@"重复密码",@"时区",@"手机号"];
    for (int i=0; i<name1Array.count; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,2*HEIGHT_SIZE+H1*i, W1, H1)];
        label.text=@"*";
        label.textAlignment=NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
        label.textColor=COLOR(154, 154, 154, 1);
        [_oneView addSubview:label];
        
        NSString *nameString=[NSString stringWithFormat:@"%@:",name1Array[i]];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE+W1, 0+H1*i,size.width, H1)];
            lable1.textColor = COLOR(154, 154, 154, 1);
            lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.text=nameString;
        [_oneView addSubview:lable1];
        
        UIView *V01 = [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,H1+H1*i, SCREEN_Width-(2*10*NOW_SIZE),1*HEIGHT_SIZE)];
        V01.backgroundColor = COLOR(222, 222, 222, 1);
        [_oneView addSubview:V01];
        
            float WK1=5*NOW_SIZE;
        float W_image1=6*HEIGHT_SIZE;
           float H_image1=12*HEIGHT_SIZE;
        float W2=SCREEN_Width-(10*NOW_SIZE+W1+size.width+WK1)-10*NOW_SIZE;
        
        if (i==0 || i==4) {
            
            UIView *V0= [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE+W1+size.width+WK1,0+H1*i, W2,H1)];
            V0.backgroundColor = [UIColor clearColor];
            V0.userInteractionEnabled=YES;
            V0.tag=2500+i;
            UITapGestureRecognizer *labelTap1;
            labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectChioce:)];
            [V0 addGestureRecognizer:labelTap1];
            [_oneView addSubview:V0];
            
            UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,W2-W_image1-WK1, H1)];
            lable1.textColor = COLOR(51, 51, 51, 1);
              lable1.tag=2600+i;
            lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
            lable1.textAlignment=NSTextAlignmentLeft;
            lable1.userInteractionEnabled=YES;
            [V0 addSubview:lable1];
            

            
            UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(W2-W_image1, (H1-H_image1)/2, W_image1,H_image1 )];
                image2.userInteractionEnabled=YES;
            image2.image=IMAGE(@"select_icon.png");
            [V0 addSubview:image2];
            
        }else{
            UITextField *text1 = [[UITextField alloc] initWithFrame:CGRectMake(10*NOW_SIZE+W1+size.width+WK1, 0+H1*i, W2, H1)];
            text1.textColor =  COLOR(51, 51, 51, 1);
            text1.tintColor =  COLOR(51, 51, 51, 1);
             text1.tag=2600+i;
            text1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
            [_oneView addSubview:text1];
            
            
        }
        
    }
    
    _goNextView=[[UIView alloc]initWithFrame:CGRectMake(0, _oneView.frame.origin.x+_oneView.frame.size.height+20*HEIGHT_SIZE, SCREEN_Width, 100*HEIGHT_SIZE)];
    _goNextView.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_goNextView];
    
    UIButton*goButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    goButton.frame=CGRectMake(20*NOW_SIZE,0, 120*NOW_SIZE, H1);
    [goButton setBackgroundImage:IMAGE(@"workorder_button_icon_nor.png") forState:UIControlStateNormal];
    [goButton setBackgroundImage:IMAGE(@"workorder_button_icon_click.png") forState:UIControlStateHighlighted];
    [goButton setTitle:@"取消" forState:UIControlStateNormal];
    goButton.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [goButton addTarget:self action:@selector(nextGoCancel) forControlEvents:UIControlEventTouchUpInside];
    [_goNextView addSubview:goButton];
    
    UIButton*goButton1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    goButton1.frame=CGRectMake(180*NOW_SIZE,0, 120*NOW_SIZE, H1);
    [goButton1 setBackgroundImage:IMAGE(@"workorder_button_icon_nor.png") forState:UIControlStateNormal];
    [goButton1 setBackgroundImage:IMAGE(@"workorder_button_icon_click.png") forState:UIControlStateHighlighted];
    [goButton1 setTitle:@"下一步" forState:UIControlStateNormal];
    goButton1.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [goButton1 addTarget:self action:@selector(nextGoStep) forControlEvents:UIControlEventTouchUpInside];
    [_goNextView addSubview:goButton1];
    

    NSString *str =@"已有用户?  跳过";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableDictionary * dic=[NSMutableDictionary dictionary];
    dic[NSFontAttributeName]=[UIFont boldSystemFontOfSize:16*HEIGHT_SIZE];
    dic[NSForegroundColorAttributeName]=MainColor;
    [attrStr addAttributes:dic range:[str rangeOfString:@" 跳过"]];

    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, H1+10*HEIGHT_SIZE,SCREEN_Width, H1)];
    lable1.textColor = COLOR(154, 154, 154, 1);
    lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    lable1.textAlignment=NSTextAlignmentCenter;
    lable1.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextJumpStep)];
    [lable1 addGestureRecognizer:labelTap1];
    lable1.attributedText=attrStr;
    [_goNextView addSubview:lable1];
    
    
    
}



-(void)nextGoStep{
    _keepValueEnable=YES;
    if (_stepNum==0) {
        [self checkOneValue];
    }
}

-(void)nextGoCancel{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)nextJumpStep{
        _keepValueEnable=NO;
    if (_stepNum==0) {
        [self checkOneValue];
    }
    
}


-(void)checkOneValue{
        _oneDic=[NSMutableDictionary new];
    
    if (_keepValueEnable) {
        NSArray *alertArray=@[@"请选择服务器地址",@"请填写用户名",@"请填写密码",@"请填写密码",@"请选择时区",@"请填写手机号"];
        NSArray*keyArray=@[@"serverId",@"userName",@"password",@"passwordtwo",@"timezone",@"phone"];
        NSString *pass1String;    NSString *pass2String;
        
        for (int i=0; i<alertArray.count; i++) {
            if (i==0 || i==4) {
                UILabel *lable=[self.view viewWithTag:2600+i];
                if ([lable.text isEqualToString:@""] || lable.text==nil) {
                    [self showToastViewWithTitle:alertArray[i]];
                    return;
                }else{
                    [_oneDic setObject:lable.text forKey:keyArray[i]];
                }
            }else{
                UITextField *field=[self.view viewWithTag:2600+i];
                if ([field.text isEqualToString:@""] || field.text==nil) {
                    [self showToastViewWithTitle:alertArray[i]];
                    return;
                }else{
                    [_oneDic setObject:field.text forKey:keyArray[i]];
                }
                if (i==2) {
                    pass1String=field.text;
                }
                if (i==3) {
                    pass2String=field.text;
                }
            }
            
        }
        
        if (![pass1String isEqualToString:pass2String]) {
            [self showToastViewWithTitle:@"请输入相同的密码"];
            return;
        }
    }

    
    _stepNum=1;
    
}


-(void)selectChioce:(UITapGestureRecognizer*)tap{
    NSInteger Num=tap.view.tag;
    NSArray *nameArray;NSString *title;
  
    
    if (Num==2500) {
        title=@"选择服务器地址";
              NSArray *serverListArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"OssServerAddress"];
        NSMutableArray *array1=[NSMutableArray array];
        for (NSDictionary*dic in serverListArray) {
            [array1 addObject:dic[@"url"]];
        }
        nameArray=[NSArray arrayWithArray:array1];
    }else if (Num==2504) {
        title=@"选择时区";
            nameArray=[NSArray arrayWithObjects:@"+1",@"+2",@"+3",@"+4",@"+5",@"+6",@"+7",@"+8",@"+9",@"+10",@"+11",@"+12",@"-1",@"-2",@"-3",@"-4",@"-5",@"-6",@"-7",@"-8",@"-9",@"-10",@"-11",@"-12", nil];
    }
    

    
    [ZJBLStoreShopTypeAlert showWithTitle:title titles:nameArray selectIndex:^(NSInteger selectIndex) {

        
    }selectValue:^(NSString *selectValue){
        UILabel *lable=[self.view viewWithTag:Num+100];
        lable.text=selectValue;
        
    } showCloseButton:YES ];
    
    
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
