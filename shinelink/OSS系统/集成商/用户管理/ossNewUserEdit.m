//
//  ossNewUserEdit.m
//  ShinePhone
//
//  Created by sky on 2018/5/22.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossNewUserEdit.h"

@interface ossNewUserEdit ()

@end

@implementation ossNewUserEdit

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



-(void)initUiForUser{
    
    self.title=@"添加用户";
    _oneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 361*HEIGHT_SIZE)];
    _oneView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_oneView];
    
    _finishButton.frame=CGRectMake(60*NOW_SIZE,_oneView.frame.origin.y+_oneView.frame.size.height+40*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    
    NSArray *name1Array=@[@"服务器地址",@"用户名",@"密码",@"重复密码",@"时区",@"手机号",@"邮箱地址",@"公司名称",@"安装商代码"];
    for (int i=0; i<name1Array.count; i++) {
        float H2=0+_H1*i;
        NSInteger type=0;
        if (i==0 || i==4) {
            type=1;
        }
        if (i==6 || i==7) {
            type=3;
        }
        if (i==8) {
            type=2;
        }
        [self getUnitUI:name1Array[i] Hight:H2 type:type tagNum:2500+i firstView:_oneView];
    }
    
    
    
}


-(void)getUnitUI:(NSString*)name Hight:(float)Hight type:(NSInteger)type tagNum:(NSInteger)tagNum firstView:(UIView*)firstView{
    float W1=8*NOW_SIZE;
    
    UIView *V011 = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE,Hight, SCREEN_Width,_H1)];
    V011.backgroundColor =[UIColor whiteColor];
    [firstView addSubview:V011];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,2*HEIGHT_SIZE+Hight, W1, _H1)];
    label.text=@"*";
    label.textAlignment=NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
    label.textColor=COLOR(154, 154, 154, 1);
    if ((type==0) || (type==1)) {
        [firstView addSubview:label];
    }
    
    
    NSString *nameString=[NSString stringWithFormat:@"%@:",name];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
    CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, _H1) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE+W1, Hight,size.width, _H1)];
    lable1.textColor = COLOR(154, 154, 154, 1);
    lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    lable1.textAlignment=NSTextAlignmentLeft;
    lable1.text=nameString;
    [firstView addSubview:lable1];
    
    UIView *V01 = [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,_H1+Hight-1*HEIGHT_SIZE, SCREEN_Width-(2*10*NOW_SIZE),1*HEIGHT_SIZE)];
    V01.backgroundColor = COLOR(222, 222, 222, 1);
    [firstView addSubview:V01];
    
    float WK1=5*NOW_SIZE;
    float W_image1=6*HEIGHT_SIZE;
    float H_image1=12*HEIGHT_SIZE;
    float W2=SCREEN_Width-(10*NOW_SIZE+W1+size.width+WK1)-10*NOW_SIZE;
    
    if (type==1 || type==2) {
        
        UIView *V0= [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE+W1+size.width+WK1,Hight, W2,_H1)];
        V0.backgroundColor = [UIColor clearColor];
        V0.userInteractionEnabled=YES;
        V0.tag=tagNum;
        UITapGestureRecognizer *labelTap1;
        labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectChioce:)];
        [V0 addGestureRecognizer:labelTap1];
        [firstView addSubview:V0];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,W2-W_image1-WK1, _H1)];
        lable1.textColor = COLOR(51, 51, 51, 1);
        lable1.tag=tagNum+100;
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.userInteractionEnabled=YES;
        [V0 addSubview:lable1];
        
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(W2-W_image1, (_H1-H_image1)/2, W_image1,H_image1 )];
        image2.userInteractionEnabled=YES;
        image2.image=IMAGE(@"select_icon.png");
        [V0 addSubview:image2];
        
    }else{
        UITextField *text1 = [[UITextField alloc] initWithFrame:CGRectMake(10*NOW_SIZE+W1+size.width+WK1, Hight, W2, _H1)];
        text1.textColor =  COLOR(51, 51, 51, 1);
        text1.tintColor =  COLOR(51, 51, 51, 1);
        text1.tag=tagNum+100;
        text1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [firstView addSubview:text1];
        
        [_textFieldMutableArray addObject:text1];
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
