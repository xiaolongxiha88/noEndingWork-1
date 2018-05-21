//
//  kongZhiNi0.h
//  shinelink
//
//  Created by sky on 16/4/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kongZhiNi0 : UITableViewController
@property (nonatomic, strong) NSString *PvSn;
@property (nonatomic, strong) NSString *controlType;     //OSS是2
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *invType;     // 1是MAX

@property (nonatomic, strong) NSString* serverID;

@end
