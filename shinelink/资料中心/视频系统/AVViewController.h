//
//  AVViewController.h
//  ShinePhone
//
//  Created by sky on 16/9/1.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "RootViewController.h"

@interface AVViewController : RootViewController

@property (nonatomic, strong) NSString *AvUrl;
@property (nonatomic, strong) NSString *AvPicUrl;
@property (nonatomic, strong) NSString *contentLabelTextValue;
@property (nonatomic, strong) NSMutableArray *tableCellName;
@property (nonatomic, strong) NSMutableArray *tableCellPic;

@end
