//
//  ossNewDeviceControl.m
//  ShinePhone
//
//  Created by sky on 2018/5/21.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossNewDeviceControl.h"

@interface ossNewDeviceControl ()
@property (nonatomic, strong) NSDictionary* allDic;
@property (nonatomic, strong) NSString* serverID;
@end

@implementation ossNewDeviceControl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allDic=[NSDictionary new];
    
    
    [self getNetForInfo];
    
}

-(void)initData{
      lableNameArray=["序列号","别名","所属采集器","连接状态","额定功率(W)","当前功率(W)","今日发电(kWh)","累计发电量(kWh)","逆变器型号","最后更新时间"]
    
       lableNameArray=["序列号","别名","所属采集器","连接状态","充电功率(W)","放电功率(W)","储能机状态","固件版本","储能机型号","最后更新时间"]
    
    
}

-(void)initUI{
    
}

-(void)getNetForInfo{
    
    [self showProgressView];
    NSDictionary *dic=@{@"deviceSn":_deviceSn,@"deviceType":[NSString stringWithFormat:@"%ld",_deviceType]};
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:dic paramarsSite:@"/api/v3/device/device_info" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v3/device/device_info: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
                if (_deviceType==1) {
                      _allDic=firstDic[@"obj"][@"invList"];
                }else  if (_deviceType==2) {
                      _allDic=firstDic[@"obj"][@"storageList"];
                }else  if (_deviceType==3) {
                    _allDic=firstDic[@"obj"][@"mixList"];
                }else  if (_deviceType==4) {
                    _allDic=firstDic[@"obj"][@"maxList"];
                }
                _serverID=[NSString stringWithFormat:@"%@",firstDic[@"obj"][@"serverId"]];
                
            }else{
                int ResultValue=[firstDic[@"result"] intValue];
                
                if ((ResultValue>1) && (ResultValue<5)) {
                    NSArray *resultArray=@[@"获取不到数据",@"设备类型为空",@"服务器地址为空"];
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
