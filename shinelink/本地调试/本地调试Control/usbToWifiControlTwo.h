//
//  usbToWifiControlTwo.h
//  ShinePhone
//
//  Created by sky on 2017/10/27.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "RootViewController.h"
#import "wifiToPvOne.h"
#import "usbToWifiDataControl.h"

@interface usbToWifiControlTwo : RootViewController
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *moreTextBtn;
@property(nonatomic,strong) NSString *titleString;
@property(nonatomic,strong) UIView *nameView;
@property(nonatomic,strong) UIView *titleView;

@property(nonatomic, copy) void(^showMoreBlock)(UITableViewCell *currentCell);
@property(nonatomic,assign) int CellTypy;
@property(nonatomic,assign) int CellNumber;



@property(nonatomic,strong)UIButton *goBut;
@property(nonatomic,strong)UITextField *textField2;
@property(nonatomic,strong)UILabel *textLable;

@property(nonatomic,strong)NSArray*lableNameArray;
@property(nonatomic,strong) NSArray* nameArray0;

@property(nonatomic,strong) NSArray* choiceArray;
@property(nonatomic,strong) NSString* setValue;
@property(nonatomic,strong) NSString* setRegister;
@property(nonatomic,strong) NSString* setRegisterLength;
@property(nonatomic,strong) NSString *readValue;
@property(nonatomic,strong) NSArray *readValueArray;

@property (nonatomic, strong) NSData *receiveCmdTwoData;

@property(nonatomic,assign) int cmdRegisterNum;

@property(nonatomic,assign) BOOL isFirstGoToView;

@property(nonatomic,strong)wifiToPvOne*ControlOne;

@property(nonatomic,strong)usbToWifiDataControl*changeDataValue;

@end
