//
//  ossNewUserEdit.m
//  ShinePhone
//
//  Created by sky on 2018/5/22.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossNewUserEdit.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "LRLChannelEditController.h"
#import "DTKDropdownMenuView.h"
#import "ShinePhone-Swift.h"

@interface ossNewUserEdit ()
@property (nonatomic, strong) UIButton *finishButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *oneView;
@property (nonatomic, assign)float H1;
@property (nonatomic, strong) NSDictionary*langurageDic;
@property (nonatomic, strong) NSDictionary*passWordDic;
@property (nonatomic, strong) NSDictionary*emailDic;
@property (nonatomic, strong)NSMutableArray *textFieldMutableArray;
@property (nonatomic, strong)NSArray *name1Array;
@property (nonatomic, strong)NSArray *keyArray;
@property (nonatomic, strong) NSDictionary* allDic;


@end

@implementation ossNewUserEdit

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textFieldMutableArray=[NSMutableArray new];
    
    //    [self addRightItem];
    
    [self initUiForUser];
    
    [self getTheValue];
}



-(void)initUiForUser{
    
    _H1=40*HEIGHT_SIZE;
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, ScreenHeight)];
    _scrollView.scrollEnabled=YES;
    _scrollView.backgroundColor=COLOR(242, 242, 242, 1);
    [self.view addSubview:_scrollView];
    
    _finishButton=  [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_finishButton setBackgroundImage:IMAGE(@"workorder_button_icon_nor.png") forState:UIControlStateNormal];
    [_finishButton setBackgroundImage:IMAGE(@"workorder_button_icon_click.png") forState:UIControlStateHighlighted];
    [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
    _finishButton.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_finishButton addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_finishButton];
    
    self.title=@"修改用户信息";
    _oneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 361*HEIGHT_SIZE)];
    _oneView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_oneView];
    
    _finishButton.frame=CGRectMake(60*NOW_SIZE,_oneView.frame.origin.y+_oneView.frame.size.height+40*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    
    _name1Array=@[@"别名",@"姓名",@"电子邮箱",@"手机号",@"公司名称",@"时区",@"语言",@"是否重置密码",@"是否发送新密码到客户邮箱"];
        _keyArray=@[@"alias",@"name",@"email",@"phone",@"company",@"timezone",@"lang",@"isResetPwd",@"isSendPweToEmail"];
            _langurageDic=@{@"中文":@"zh_cn",@"English":@"en",@"Français":@"fr",@"日本語":@"ja",@"In Italiano":@"it",@"Nederland":@"ho",@"Türkçe":@"tk",@"Polish":@"pl",@"Greek":@"gk"};
    
    for (int i=0; i<_name1Array.count; i++) {
        float H2=0+_H1*i;
        NSInteger type=0;
        if (i==5 || i==6 || i==7 || i==8) {
            type=1;
        }
        [self getUnitUI:_name1Array[i] Hight:H2 type:type tagNum:2500+i firstView:_oneView];
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
//    if ((type==0) || (type==1)) {
//        [firstView addSubview:label];
//    }
//
    
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


-(void)selectChioce:(UITapGestureRecognizer*)tap{
    NSInteger Num=tap.view.tag;
    
          [self choiceTheValue:Num];
 
}


-(void)choiceTheValue:(NSInteger)Num{
    NSArray *nameArray;NSString *title;
    if (Num==2506) {
        title=@"选择语言";
          nameArray=[NSArray arrayWithObjects:@"中文",@"English",@"Français",@"日本語",@"In Italiano",@"Nederland",@"Türkçe",@"Polish",@"Greek",nil];

        
       // [NSArray arrayWithObjects:@"zh_cn",@"en",@"fr",@"ja",@"it",@"ho",@"tk",@"pl",@"gk",nil];
    }else if (Num==2505) {
        title=@"选择时区";
        nameArray=[NSArray arrayWithObjects:@"+1",@"+2",@"+3",@"+4",@"+5",@"+6",@"+7",@"+8",@"+9",@"+10",@"+11",@"+12",@"-1",@"-2",@"-3",@"-4",@"-5",@"-6",@"-7",@"-8",@"-9",@"-10",@"-11",@"-12", nil];
    }else if (Num==2507) {
        title=@"是否重置密码";
        nameArray=[NSArray arrayWithObjects:@"是",@"否",nil];
        _passWordDic=@{@"是":@"2",@"否":@"1"};
    }else if (Num==2508) {
        title=@"是否发送新密码到客户邮箱";
        nameArray=[NSArray arrayWithObjects:@"是",@"否",nil];
        _emailDic=@{@"是":@"2",@"否":@"1"};
    }
    

    [ZJBLStoreShopTypeAlert showWithTitle:title titles:nameArray selectIndex:^(NSInteger selectIndex) {

        
    }selectValue:^(NSString *selectValue){
        UILabel *lable=[self.view viewWithTag:Num+100];
        lable.text=selectValue;

    } showCloseButton:YES ];
}




-(void)finishSet{
    NSMutableDictionary *netDic=[NSMutableDictionary new];
     //   _name1Array=@[@"别名",@"姓名",@"电子邮箱",@"手机号",@"公司名称",@"时区",@"语言",@"是否重置密码",@"是否发送新密码到客户邮箱"];

    for (int i=0; i<_name1Array.count; i++) {
        
        if (i<5) {
            UILabel *lable=[self.view viewWithTag:2600+i];
            
            if ([lable.text isEqualToString:@""] || lable.text==nil || [lable.text isEqualToString:@"null"]) {
                [netDic setObject:@"" forKey:_keyArray[i]];
            }else{
                [netDic setObject:lable.text forKey:_keyArray[i]];
            }
        }else{
            UITextField *field=[self.view viewWithTag:2600+i];
            
            if ([field.text isEqualToString:@""] || field.text==nil || [field.text isEqualToString:@"null"]) {
                 [netDic setObject:@"" forKey:_keyArray[i]];
                if (i==7) {
                      [netDic setObject:@"0" forKey:_keyArray[i]];
                }else if (i==8) {
                     [netDic setObject:@"0" forKey:_keyArray[i]];
                }
            }else{
                NSString *value=field.text;
                if (i==6) {
                    value=[_langurageDic objectForKey:field.text];
                }else if (i==7) {
                    value=[_passWordDic objectForKey:field.text];
                }else if (i==8) {
                    value=[_emailDic objectForKey:field.text];
                }
                [netDic setObject:value forKey:_keyArray[i]];
            }
        }
        
    }
    
        [netDic setObject:_serverId forKey:@"serverId"];
     [netDic setObject:_userId forKey:@"uid"];
    [netDic setObject:[NSString stringWithFormat:@"%@",_allDic[@"userName"]] forKey:@"userName"];
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:netDic paramarsSite:@"/api/v3/customer/userManage/edit" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v3/customer/userManage/edit:%@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
                
                [self showToastViewWithTitle:@"修改成功"];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                int ResultValue=[firstDic[@"result"] intValue];
         
                if (ResultValue==22) {
                    [self showToastViewWithTitle:@"登录超时"];
                }else if (ResultValue==4) {
                    [self showToastViewWithTitle:@"未登录"];
                }else{
                    [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",firstDic[@"msg"]]];
                }
             
                
            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
        
    }];
    
    
    
    
}



-(void)getTheValue{
    
    [self showProgressView];
    NSDictionary *dic=@{@"serverId":_serverId,@"userId":_userId};
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:dic paramarsSite:@"/api/v3/customer/userManage/editPage" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v3/customer/userManage/editPage: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
                
                
               _allDic=firstDic[@"obj"];
                
                //   _serverID=[NSString stringWithFormat:@"%@",firstDic[@"obj"][@"serverId"]];
                
                [self freshUI];
            }else{
                int ResultValue=[firstDic[@"result"] intValue];
                
           if (ResultValue==22) {
                    [self showToastViewWithTitle:@"登录超时"];
                }else{
                    [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",firstDic[@"msg"]]];
                }
                
                
                // [self showToastViewWithTitle:firstDic[@"msg"]];
                
            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
        
    }];
    
}



-(void)freshUI{
    for (int i=0; i<_name1Array.count; i++) {
        
        UILabel *lableValue=[self.view viewWithTag:2500+100+i];
        NSString*keyString=_keyArray[i];

        NSString*valueString;
        if ([_allDic.allKeys containsObject:keyString]) {
            valueString=[NSString stringWithFormat:@"%@",_allDic[keyString]];
            
            
            if ([keyString isEqualToString:@"lang"]) {
                NSString* value1=[NSString stringWithFormat:@"%@",_allDic[keyString]];
                for (int i=0; i<_langurageDic.allKeys.count; i++) {
                    NSString*keySring2=_langurageDic.allKeys[i];
                    NSString*value2=[_langurageDic objectForKey:keySring2];
                    if ([value2 isEqualToString:value1]) {
                        valueString=keySring2;
                    }
                }
            }
            
        }else{
            valueString=@"";
        }
 
    
        
        lableValue.text=valueString;
        
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
