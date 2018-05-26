//
//  ossNewPlantControl2.m
//  ShinePhone
//
//  Created by sky on 2018/5/22.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossNewPlantControl2.h"
#import "DTKDropdownMenuView.h"
#import "ShinePhone-Swift.h"
#import "ossNewPlantEdit.h"
#import "loginViewController.h"

@interface ossNewPlantControl2 ()

@property (nonatomic, strong) NSDictionary* allDic;
@property (nonatomic, strong) NSString* serverID;
@property (nonatomic, strong) NSString* accountName;
@property (nonatomic, strong) NSArray* lableNameArray;
@property (nonatomic, strong) NSArray* controlNameArray;
@property (nonatomic, strong) NSArray* controlImageArray;
@property (nonatomic, strong) NSArray* controlImageClickArray;

@property (nonatomic, strong) NSArray* lableNameKeyArray;
@property (nonatomic, strong) UIScrollView *ScrollView;
@property (nonatomic, strong) DTKDropdownMenuView *rightMenuView;

@property (nonatomic, strong) NSString *plantId;

@end

@implementation ossNewPlantControl2


- (void)viewWillAppear:(BOOL)animated{
    [self getNetForInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allDic=[NSDictionary new];
    
    [self addRightItem];
    
    [self initData];
    [self initUI];
    
    
    
}

-(void)initData{
    
    
    
    _lableNameArray=@[@"电站名称",@"别名",@"所属用户",@"安装商",@"资金收益",@"时区",@"建站日期",@"设备数量",@"设计功率",@"今日发电量",@"累计发电量",@"日发电量下限值"];
    _lableNameKeyArray=@[@"plantName",@"alias",@"accountName",@"iCode",@"formula_money",@"timezone",@"creatDate",@"deviceCount",@"nominal_power",@"etoday",@"etotal",@"lowEnergy"];
    
    
    _controlNameArray=@[@"编辑",@"查看该电站"];
    _controlImageArray=@[@"edit_nor.png",@"check_nor.png"];
    _controlImageClickArray=@[@"edit_click.png",@"check_click.png"];
    
    
}

-(void)initUI{
    
    _ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _ScrollView.backgroundColor = COLOR(222, 222, 222, 1);
    [self.view addSubview:_ScrollView];
    
    float lable_H=20*HEIGHT_SIZE;float line_W=10*HEIGHT_SIZE;
    float unit_H=lable_H*2+line_W;
    
    float WW=ScreenWidth/2.0;
    float WW_1=ScreenWidth/2.0-WW*0.28-5*NOW_SIZE;
    for (int i=0; i<_lableNameArray.count; i++) {
        
        int w_k=i%2;
        int H_k=i/2;
        
        UIView *View0 = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE+ScreenWidth/2.0*w_k,0+unit_H*H_k, SCREEN_Width/2.0,unit_H)];
        View0.backgroundColor =[UIColor whiteColor];
        [_ScrollView addSubview:View0];
        
        UILabel *lableL = [[UILabel alloc] initWithFrame:CGRectMake(WW*0.28, line_W/2.0,WW_1, lable_H)];
        lableL.textColor = MainColor;
        lableL.textAlignment=NSTextAlignmentLeft;
        lableL.text=_lableNameArray[i];
        lableL.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [View0 addSubview:lableL];
        
        UILabel *lableValue = [[UILabel alloc] initWithFrame:CGRectMake(WW*0.28, line_W/2.0+lable_H,WW_1, lable_H)];
        lableValue.textColor = COLOR(102, 102, 102, 1);
        lableValue.textAlignment=NSTextAlignmentLeft;
        lableValue.tag=2000+i;
           lableValue.adjustsFontSizeToFitWidth=YES;
        lableValue.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [View0 addSubview:lableValue];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE,unit_H-1*HEIGHT_SIZE, SCREEN_Width/2.0,1*HEIGHT_SIZE)];
        lineView.backgroundColor = COLOR(222, 222, 222, 1);
        [View0 addSubview:lineView];
    }
    
    float HH=unit_H*(_lableNameArray.count/2)+unit_H*(_lableNameArray.count%2);
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width/2.0,0, 1*HEIGHT_SIZE,HH)];
    lineView2.backgroundColor = COLOR(222, 222, 222, 1);
    [_ScrollView addSubview:lineView2];
    
    float line2_H=10*HEIGHT_SIZE;
    HH=HH+line2_H;
    
    float WW_imageView=SCREEN_Width/2.0;
    float imageViewHH=100*HEIGHT_SIZE;
    float imageH=70*HEIGHT_SIZE;
    
    
    for (int i=0; i<_controlNameArray.count; i++) {
        int w_k=i%2;
        int H_k=i/2;
        UIView *View0 = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE+ScreenWidth/2.0*w_k,imageViewHH*H_k+HH, SCREEN_Width/2.0,imageViewHH)];
        View0.backgroundColor =[UIColor whiteColor];
        [_ScrollView addSubview:View0];
        
        UIButton*goButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        goButton.frame=CGRectMake((WW_imageView-imageH)/2.0,0, imageH, imageH);
        [goButton setBackgroundImage:IMAGE(_controlImageArray[i]) forState:UIControlStateNormal];
        [goButton setBackgroundImage:IMAGE(_controlImageClickArray[i]) forState:UIControlStateHighlighted];
        goButton.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
        goButton.tag=3000+i;
        [goButton addTarget:self action:@selector(goToOtherView:) forControlEvents:UIControlEventTouchUpInside];
        [View0 addSubview:goButton];
        
        UILabel *lableL = [[UILabel alloc] initWithFrame:CGRectMake(0, imageH,WW_imageView, imageViewHH-imageH)];
        lableL.textColor = COLOR(102, 102, 102, 1);
        lableL.textAlignment=NSTextAlignmentCenter;
        lableL.text=_controlNameArray[i];
        lableL.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [View0 addSubview:lableL];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE,imageViewHH-1*HEIGHT_SIZE, SCREEN_Width/2.0,1*HEIGHT_SIZE)];
        lineView.backgroundColor = COLOR(222, 222, 222, 1);
        [View0 addSubview:lineView];
        
    }
    float H3=imageViewHH*(_controlNameArray.count/2)+imageViewHH*(_controlNameArray.count%2);
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width/2.0,HH, 1*HEIGHT_SIZE,H3)];
    lineView3.backgroundColor = COLOR(222, 222, 222, 1);
    [_ScrollView addSubview:lineView3];
    
    HH=H3+HH;
    
    _ScrollView.contentSize=CGSizeMake(ScreenWidth, HH+100*NOW_SIZE);
    
}


- (void)addRightItem
{
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"返回首页" iconName:@"DTK_jiangbei" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ossFistVC class]])
            {
                ossFistVC *A =(ossFistVC *)controller;
                [self.navigationController popToViewController:A animated:YES];
                
            }
            
        }
        
    }];
    
    
    //    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"设备分配" iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
    //        NSLog(@"rightItem%lu",(unsigned long)index);
    //
    //    }];
    
    _rightMenuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0] icon:@"add@2x.png"];
    //  menuView.intrinsicContentSize=CGSizeMake(44.f, 44.f);
    // menuView.translatesAutoresizingMaskIntoConstraints=true;
    _rightMenuView.dropWidth =150.f;
    _rightMenuView.titleFont = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    _rightMenuView.textColor =COLOR(102, 102, 102, 1);
    _rightMenuView.cellSeparatorColor =COLOR(229, 229, 229, 1);
    _rightMenuView.textFont = [UIFont systemFontOfSize:14.f];
    _rightMenuView.animationDuration = 0.2f;
    
    // _rightMenuView.userInteractionEnabled=YES;
    
    if (deviceSystemVersion>=11.0) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self.rightMenuView action:@selector(pullTheTableView)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightMenuView];
    }
    
    
}



-(void)goToOtherView:(UIButton*)button{
    NSInteger tagNum=button.tag-3000;
    if (tagNum==0) {
        ossNewPlantEdit *deviceView=[[ossNewPlantEdit alloc]init];
        deviceView.serverId=_serverId;
        deviceView.plantId=_userId;
        deviceView.accountName=[NSString stringWithFormat:@"%@",[_allDic objectForKey:@"accountName"]];
     //   deviceView.allDic=[NSDictionary dictionaryWithDictionary:_allDic];
        [self.navigationController pushViewController:deviceView animated:YES];
        
    }else if (tagNum==1) {
      
            NSArray *serverListArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"OssServerAddress"];
            NSString *serverUrl;
            //   NSMutableArray* serverIdArray=[NSMutableArray array];
            for (NSDictionary*dic in serverListArray) {
                NSString *ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
                if([ID isEqualToString:[NSString stringWithFormat:@"%@",_serverId]]) {
                    serverUrl=[NSString stringWithFormat:@"%@",dic[@"url"]];
                }
            }
            
            loginViewController *deviceView=[[loginViewController alloc]init];
            deviceView.demoServerURL=serverUrl;
            deviceView.demoName=_userName;
            deviceView.LogTypeForOSS=1;
            deviceView.isFirstLogin=YES;
            deviceView.LogOssNum=3;
        deviceView.demoPlantID=_plantId;
            [self.navigationController pushViewController:deviceView animated:NO];
        
    }
    
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex) {
        if( (alertView.tag == 1001) || (alertView.tag == 1002) || (alertView.tag == 1003)){
      
        }
    }
    
}

-(void)freshUI{
    for (int i=0; i<_lableNameKeyArray.count; i++) {
        
        UILabel *lableValue=[self.view viewWithTag:2000+i];
        NSString*keyString=_lableNameKeyArray[i];
        NSString*nameString=_lableNameArray[i];
        NSString*valueString;
        if ([_allDic.allKeys containsObject:keyString]) {
            valueString=[NSString stringWithFormat:@"%@",_allDic[keyString]];
        }else{
            valueString=@"";
        }
        if ([nameString isEqualToString:root_oss_509_lianJieZhuangTai]) {
            int statueNum=[[NSString stringWithFormat:@"%@",_allDic[keyString]] intValue];
            if (statueNum==1) {
                valueString=@"离线";
            }else{
                valueString=@"在线";
            }
        }
        if ([nameString isEqualToString:root_oss_507_chengShi]) {
            if ([[NSString stringWithFormat:@"%@",_allDic[keyString]] isEqualToString:@"-1"]) {
                valueString=@"---";
            }else{
                valueString=[NSString stringWithFormat:@"%@",_allDic[keyString]];
            }
            
        }

        
        if ([nameString isEqualToString:root_oss_510_yunXingZhuangTai]) {
            NSString* statueString=[NSString stringWithFormat:@"%@",_allDic[keyString]];
            valueString=[self changeTheDeviceStatue:statueString];
            lableValue.textColor=[self changeTheDeviceStatueColor:statueString];
        }
        if (valueString==nil || [valueString isEqualToString:@""]) {
            valueString=@"---";
        }
        
        lableValue.text=valueString;
        
    }
}






-(void)getNetForInfo{
    
    [self showProgressView];
    NSDictionary *dic=@{@"serverId":_serverId,@"plantId":_userId};
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:dic paramarsSite:@"/api/v3/device/getAPPDisPlants" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v3/device/getAPPDisPlants: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
                
                
                NSArray *netArray=firstDic[@"obj"][@"datas"];
                
                _allDic=netArray[0];
                
                _plantId=_allDic[@"pId"];
                _userName=_allDic[@"accountName"];
                //   _serverID=[NSString stringWithFormat:@"%@",firstDic[@"obj"][@"serverId"]];
                
                [self freshUI];
            }else{
                int ResultValue=[firstDic[@"result"] intValue];
                
                if ((ResultValue>1) && (ResultValue<5)) {
                    NSArray *resultArray=@[@"您不是集成商账户",@"服务器地址为空",@"网络超时"];
                    if (ResultValue<(resultArray.count+2)) {
                        [self showToastViewWithTitle:resultArray[ResultValue-2]];
                    }
                }else if (ResultValue==22) {
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






-(NSString*)changeTheDeviceStatue:(NSString*)numString{
    NSString*valueString=@"";
    
    NSDictionary *statueDic;
    if (_deviceType==1 || _deviceType==4) {
        statueDic=@{@"3":@"故障",@"-1":@"离线",@"0":@"等待",@"1":@"在线"};
    }else if (_deviceType==2) {
        statueDic=@{@"3":@"故障",@"-1":@"离线",@"1":@"充电",@"2":@"放电",@"-2":@"在线"};
    }else if (_deviceType==3) {
        statueDic=@{@"3":@"故障",@"-1":@"离线",@"0":@"等待",@"1":@"自检",@"5":@"在线"};
    }
    if ([statueDic.allKeys containsObject:numString]) {
        valueString=[statueDic objectForKey:numString];
    }else{
        valueString=numString;
    }
    
    return valueString;
}


-(UIColor*)changeTheDeviceStatueColor:(NSString*)numString{
    UIColor*valueColor= COLOR(102, 102, 102, 1);
    
    NSDictionary *statueDic;
    if (_deviceType==1 || _deviceType==4) {
        statueDic=@{@"3":COLOR(210, 53, 53, 1),@"-1":COLOR(170, 170, 170, 1),@"0":COLOR(213, 180, 0, 1),@"1":COLOR(44, 189, 10, 1)};
    }else if (_deviceType==2) {
        statueDic=@{@"3":COLOR(210, 53, 53, 1),@"-1":COLOR(170, 170, 170, 1),@"1":COLOR(44, 189, 10, 1),@"2":COLOR(213, 180, 0, 1),@"-2":COLOR(61, 190, 4, 1)};
    }else if (_deviceType==3) {
        statueDic=@{@"3":COLOR(210, 53, 53, 1),@"-1":COLOR(170, 170, 170, 1),@"0":COLOR(213, 180, 0, 1),@"1":COLOR(209, 148, 0, 1),@"5":COLOR(44, 189, 10, 1)};
    }
    if ([statueDic.allKeys containsObject:numString]) {
        valueColor=[statueDic objectForKey:numString];
    }
    
    return valueColor;
}



//转数组转JSON
-(NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint dataArray:(NSDictionary*)Dic{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Dic
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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
