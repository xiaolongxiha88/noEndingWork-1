//
//  ossIntegratorSearch.m
//  ShinePhone
//
//  Created by sky on 2018/5/16.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossIntegratorSearch.h"
#import "ZJBLStoreShopTypeAlert.h"

@interface ossIntegratorSearch ()

@property (nonatomic, strong) NSArray *unitNameArray;
@property (nonatomic, strong) NSArray *unitTypeArray;
@property (nonatomic, strong)NSMutableArray *textFieldMutableArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign)float HH;
@property (nonatomic, assign)float H_All;
@property (nonatomic, strong) NSMutableArray *icodeListArray;
@property (nonatomic, strong) NSMutableDictionary*icodeListDic;
@property (nonatomic, strong) NSMutableArray *oldValueArray;
@property (nonatomic, strong) NSArray *deviceNameArray;
@property (nonatomic, strong) NSDictionary *deviceNameIdDic;
@property (nonatomic, strong) NSArray *lineTypeArray;
@property (nonatomic, strong) NSDictionary *lineTypeDic;
@property (nonatomic, strong) NSArray *moreNameArray;      //更多条件
@property (nonatomic, strong) NSArray *titleNameArray;
@property (nonatomic, strong) NSArray *titleNameTypeArray;

@property (nonatomic, strong) NSMutableDictionary*deviceNetDic;

@property (nonatomic, strong)UIButton*searchButton;

@end

@implementation ossIntegratorSearch

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
       _textFieldMutableArray=[NSMutableArray new];
    
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, ScreenHeight)];
        _scrollView.scrollEnabled=YES;
        _scrollView.userInteractionEnabled=YES;
        [self.view addSubview:_scrollView];
    }
    
    _searchButton =  [UIButton buttonWithType:UIButtonTypeCustom];

//    _searchButton.layer.borderWidth=0.8*HEIGHT_SIZE;
//    _searchButton.layer.cornerRadius=40*HEIGHT_SIZE/2.0;
//    _searchButton.layer.borderColor=COLOR(222, 222, 222, 1).CGColor;
    [_searchButton setBackgroundImage:IMAGE(@"workorder_button_icon_nor.png") forState:UIControlStateNormal];
    [_searchButton setBackgroundImage:IMAGE(@"workorder_button_icon_click.png") forState:UIControlStateHighlighted];
    [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    //_searchButton.titleLabel.tintColor=COLOR(51, 51, 51, 1);
  //  [_searchButton setTitleColor:COLOR(51, 51, 51, 1) forState:UIControlStateNormal];
    _searchButton.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_searchButton addTarget:self action:@selector(goToSearch) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_searchButton];
  
    _HH=40*HEIGHT_SIZE;
    [self initSearchType];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
    }
}

-(void)initSearchType{
    if (_searchType==1) {
        [self initDeviceUI];
    }
}

-(void)initDeviceUI{
    self.title=@"搜索设备";
   _deviceNameArray=@[@"逆变器",@"储能机",@"混储一体机"];
    _deviceNameIdDic=@{_deviceNameArray[0]:@"1",_deviceNameArray[1]:@"2",_deviceNameArray[2]:@"3",};
    _H_All=0;
    if (_oldValueArray.count==0) {
        _oldValueArray=[NSMutableArray arrayWithArray:@[@"逆变器",@"所有",@"",@"",@"序列号",@""]];
    }
    if ([_oldValueArray[0] isEqualToString:_deviceNameArray[0]]) {
        _moreNameArray=@[@"序列号",@"用户或电站名",@"额定功率"];
    }else{
        _moreNameArray=@[@"序列号",@"用户或电站名"];
    }
    
    _lineTypeArray=@[@"所有",@"已接入设备",@"未接入设备"];
    _lineTypeDic=@{_lineTypeArray[0]:@"3",_lineTypeArray[1]:@"2",_lineTypeArray[2]:@"1"};
    
    _titleNameArray=@[@"设备类型",@"接入类型",@"所属安装商",@"城市",@"其他条件"];
     _titleNameTypeArray=@[@"1",@"1",@"1",@"0",@"1"];

    for (int i=0; i<_titleNameArray.count; i++) {
        NSInteger tagNum=2000+i;
        
        [self getUnitUI:_titleNameArray[i] Hight:_H_All type:[_titleNameTypeArray[i] integerValue] tagNum:tagNum firstView:_scrollView];
     
              _H_All=_HH+_H_All;
    }
    
    [self getUnitUiTwo:[NSString stringWithFormat:@"%@%@",@"请输入",_oldValueArray[4]] Hight:_H_All type:1 tagNum:3000 firstView:_scrollView];
    
    _H_All= _H_All+_HH+50*HEIGHT_SIZE;
    
        _searchButton.frame=CGRectMake(60*NOW_SIZE,_H_All, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    
    _scrollView.contentSize=CGSizeMake(ScreenWidth, ScreenHeight+50*HEIGHT_SIZE);
}



-(void)getUnitUI:(NSString*)name Hight:(float)Hight type:(NSInteger)type tagNum:(NSInteger)tagNum firstView:(UIView*)firstView{
    float W1=0*NOW_SIZE;
    
    
    NSString *nameString=[NSString stringWithFormat:@"%@:",name];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
    CGSize size = [nameString boundingRectWithSize:CGSizeMake(MAXFLOAT, _HH) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(10*NOW_SIZE+W1, Hight,size.width, _HH)];
    lable1.textColor = COLOR(154, 154, 154, 1);
    lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    lable1.textAlignment=NSTextAlignmentLeft;
    lable1.text=nameString;
    [firstView addSubview:lable1];
    
    UIView *V01 = [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,_HH+Hight-1*HEIGHT_SIZE, SCREEN_Width-(2*10*NOW_SIZE),1*HEIGHT_SIZE)];
    V01.backgroundColor = COLOR(222, 222, 222, 1);
    [firstView addSubview:V01];
    
    float WK1=10*NOW_SIZE;
    float W_image1=6*HEIGHT_SIZE;
    float H_image1=12*HEIGHT_SIZE;
    float W2=SCREEN_Width-(10*NOW_SIZE+W1+size.width+WK1)-10*NOW_SIZE;
    
    if (type==1) {
        
        UIView *V0= [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE+W1+size.width+WK1,Hight, W2,_HH)];
        V0.backgroundColor = [UIColor clearColor];
        V0.userInteractionEnabled=YES;
        V0.tag=tagNum;
        UITapGestureRecognizer *labelTap1;
        labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectChioce:)];
        [V0 addGestureRecognizer:labelTap1];
        [firstView addSubview:V0];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,W2-W_image1-WK1, _HH)];
        lable1.textColor = COLOR(51, 51, 51, 1);
        lable1.tag=tagNum+100;
        if (![_oldValueArray[tagNum-2000] isEqualToString:@""]) {
            lable1.text=_oldValueArray[tagNum-2000];
        }
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        lable1.textAlignment=NSTextAlignmentLeft;
        lable1.userInteractionEnabled=YES;
        [V0 addSubview:lable1];
        
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(W2-W_image1, (_HH-H_image1)/2, W_image1,H_image1 )];
        image2.userInteractionEnabled=YES;
        image2.image=IMAGE(@"select_icon.png");
        [V0 addSubview:image2];
        
    }else{
        UITextField *text1 = [[UITextField alloc] initWithFrame:CGRectMake(10*NOW_SIZE+W1+size.width+WK1, Hight, W2, _HH)];
        text1.textColor =  COLOR(51, 51, 51, 1);
        text1.tintColor =  COLOR(51, 51, 51, 1);
        text1.tag=tagNum+100;
        if (![_oldValueArray[tagNum-2000] isEqualToString:@""]) {
            text1.text=_oldValueArray[tagNum-2000];
        }
        text1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [firstView addSubview:text1];
        
        [_textFieldMutableArray addObject:text1];
    }
    
}


-(void)getUnitUiTwo:(NSString*)name Hight:(float)Hight type:(NSInteger)type tagNum:(NSInteger)tagNum firstView:(UIView*)firstView{
    float W=10*NOW_SIZE;
    UITextField *text1 = [[UITextField alloc] initWithFrame:CGRectMake(W, Hight, ScreenWidth-W*2,_HH )];
    text1.textColor =  COLOR(51, 51, 51, 1);
    text1.tintColor =  COLOR(51, 51, 51, 1);
    text1.tag=tagNum;
    text1.adjustsFontSizeToFitWidth=YES;
    text1.textAlignment=NSTextAlignmentLeft;
    text1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    text1.placeholder = name;
    [text1 setValue:COLOR(222, 222, 222, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [text1 setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    
    [firstView addSubview:text1];
    
    [_textFieldMutableArray addObject:text1];
    
    UIView *V01 = [[UIView alloc]initWithFrame:CGRectMake(W,Hight+_HH-1*HEIGHT_SIZE,ScreenWidth-W*2,1*HEIGHT_SIZE)];
    V01.backgroundColor = COLOR(222, 222, 222, 1);
    [firstView addSubview:V01];
}



-(void)goToSearch{
    _deviceNetDic=[NSMutableDictionary new];
    NSArray* keyArray=@[@"deviceType",@"lineType",@"iCode",@"city"];
    for (int i=0; i<keyArray.count; i++) {
        if ([_titleNameTypeArray[i] integerValue]==1) {
            UILabel *lable=[self.view viewWithTag:2000+i+100];
            
            if (lable.text==nil || [lable.text isEqualToString:@""]) {
                [_deviceNetDic setObject:@"" forKey:keyArray[i]];
            }else{
          
                    if (i==0) {
                        [_deviceNetDic setObject:[_deviceNameIdDic objectForKey:lable.text] forKey:keyArray[i]];
                    }else if (i==1) {
                        [_deviceNetDic setObject:[_lineTypeDic objectForKey:lable.text] forKey:keyArray[i]];
                    }else if (i==2) {
                        [_deviceNetDic setObject:[_icodeListDic objectForKey:lable.text] forKey:keyArray[i]];
                    }else{
                          [_deviceNetDic setObject:lable.text forKey:keyArray[i]];
                    }
                
                
                
            }
        }else{
            UITextField *textField=[self.view viewWithTag:2000+i+100];
            if (textField.text==nil || [textField.text isEqualToString:@""]) {
            
            }
        }
    }
    
         UILabel *lable=[self.view viewWithTag:2004+100];
      UITextField *textField=[self.view viewWithTag:3000];
    
    NSArray *moreKeyArray=@[@"deviceSn",@"userName",@"ratedPower"];
    for (int i=0; i<_moreNameArray.count; i++) {
        if ([_moreNameArray[i] isEqualToString:lable.text]) {
            if (textField.text==nil || [textField.text isEqualToString:@""]) {
                [_deviceNetDic setObject:@"" forKey:moreKeyArray[i]];
            }else{
                [_deviceNetDic setObject:textField.text forKey:moreKeyArray[i]];
            }
        }else{
               [_deviceNetDic setObject:@"" forKey:moreKeyArray[i]];
        }
   
    }
    
      [_deviceNetDic setObject:@"1" forKey:@"page"];
         [_deviceNetDic setObject:@"" forKey:@"deviceStatus"];
            [_deviceNetDic setObject:@"1" forKey:@"order"];
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:_deviceNetDic paramarsSite:@"/api/v3/device/deviceManage/list" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v3/customer/userManage_overview_creatUserPage: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
                NSInteger totalNum=0;
                NSArray *allArray=firstDic[@"obj"][@"pagers"];
                for (int i=0; i<allArray.count; i++) {
                    NSDictionary *unitDic=allArray[i];
                    totalNum=[[NSString stringWithFormat:@"%@",unitDic[@"nums"][@"totalNum"]] integerValue]+totalNum;
                }
                if (totalNum>0) {
                    [self.navigationController popViewControllerAnimated:YES];
                    self.searchResultBlock(allArray);
                }else{
                        [self showToastViewWithTitle:@"没有设备"];
                }
                
            }else{
                int ResultValue=[firstDic[@"result"] intValue];
                
                if ((ResultValue>1) && (ResultValue<5)) {
                    NSArray *resultArray=@[@"参数错误",@"服务器地址为空",@"您不是集成商账户"];
                    if (ResultValue<(resultArray.count+2)) {
                        [self showToastViewWithTitle:resultArray[ResultValue-2]];
                    }
                }
                if (ResultValue==0) {
                         [self showToastViewWithTitle:@"返回异常"];
                }
                if (ResultValue==22) {
                    [self showToastViewWithTitle:@"未登录"];
                }
                // [self showToastViewWithTitle:firstDic[@"msg"]];
                
            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
        
    }];
    
}



-(void)selectChioce:(UITapGestureRecognizer*)tap{
    NSInteger Num=tap.view.tag;
    NSArray *nameArray;NSString *titleString;
    if (_searchType==1) {
        if (Num==2000 || Num==2001 || Num==2004) {
            if (Num==2000) {
                titleString=@"选择设备类型";
                nameArray=_deviceNameArray;
            }else if (Num==2001) {
                 titleString=@"选择接入类型";
                nameArray=_lineTypeArray;
                _lineTypeDic=@{nameArray[0]:@"3",nameArray[1]:@"2",nameArray[2]:@"1"};
            }else if (Num==2004) {
                 titleString=@"选择搜索条件";
                UILabel *lable=[self.view viewWithTag:Num+100];
                if ([lable.text isEqualToString:_deviceNameArray[0]]) {
                      _moreNameArray=@[@"序列号",@"用户或电站名",@"额定功率"];
                }else{
                       _moreNameArray=@[@"序列号",@"用户或电站名"];
                }
                nameArray=_moreNameArray;
              
            }
            [self chiceItem:titleString nameArray:nameArray Num:Num];
        }
   
        if (Num==2002){
            [self getTheIcode];
        }
    }
    
}

-(void)getTheIcode{
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:@{@"kind":@"0"} paramarsSite:@"/api/v3/customer/group/installer" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v3/customer /group/installer: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
                _icodeListArray=[NSMutableArray array];
                _icodeListDic=[NSMutableDictionary new];
                NSArray *icodeArray=firstDic[@"obj"];
                for (int i=0; i<icodeArray.count; i++) {
                    NSDictionary*dic=icodeArray[i];
                    NSString*name=[NSString stringWithFormat:@"%@(%@)",dic[@"iCode"],dic[@"company"]];
                    [_icodeListArray addObject:name];
                    [_icodeListDic setObject:dic[@"iCode"] forKey:name];
                }
               [self chiceItem:@"选择安装商" nameArray:_icodeListArray Num:2002];
                
            }else{
                int ResultValue=[firstDic[@"result"] intValue];
                NSArray *resultArray=@[@"非集成商用户",@"未找到指定的服务器地址"];
                
                if (ResultValue<(resultArray.count+2)) {
                    [self showToastViewWithTitle:resultArray[ResultValue-2]];
                }
                if (ResultValue==22) {
                    [self showToastViewWithTitle:@"登录超时"];
                }
                // [self showToastViewWithTitle:firstDic[@"msg"]];
                
            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
    }];

}

-(void)chiceItem:(NSString*)titleString nameArray:(NSArray*)nameArray Num:(NSInteger)Num{
    [ZJBLStoreShopTypeAlert showWithTitle:titleString titles:nameArray selectIndex:^(NSInteger selectIndex) {
      
    }selectValue:^(NSString *selectValue){
        UILabel *lable=[self.view viewWithTag:Num+100];
        lable.text=selectValue;
        if (Num==2004) {
           UITextField *textField=[self.view viewWithTag:3000];
                textField.placeholder = [NSString stringWithFormat:@"%@%@",@"请输入",selectValue];
        }
        
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
