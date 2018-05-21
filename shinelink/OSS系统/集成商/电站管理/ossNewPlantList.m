//
//  ossNewPlantList.m
//  ShinePhone
//
//  Created by sky on 2018/5/21.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossNewPlantList.h"
#import "ossNewDeviceCell.h"
#import "ossNewDeviceTwoCell.h"
#import "ShinePhone-Swift.h"
#import "LRLChannelEditController.h"
#import "ossIntegratorSearch.h"
#import "ossNewDeviceControl.h"

@interface ossNewPlantList ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *oneScrollView;
@property (nonatomic, strong) UIScrollView *twoScrollView;
@property (nonatomic, strong) UIScrollView *threeScrollView;
@property (nonatomic, strong) NSArray *oneParaArray;
@property (nonatomic, strong) NSArray *oneParaArrayNum;
@property (nonatomic, strong) NSMutableArray *cellNameArray;
@property (nonatomic, strong) NSArray *cellNameArray2;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign)float tableW;
@property (nonatomic, assign)float oldTableW;
@property (nonatomic, assign)BOOL isChangTableView;
@property (nonatomic, strong) NSMutableArray *selectRowNumArray;
@property (nonatomic, strong) DTKDropdownMenuView *rightMenuView;

@property (nonatomic, strong) NSMutableArray<LRLChannelUnitModel *> *topChannelArr;
@property (nonatomic, strong) NSMutableArray<LRLChannelUnitModel *> *bottomChannelArr;
@property (nonatomic, assign) NSInteger chooseIndex;
@property (nonatomic, assign) NSInteger pageNumForNet;
@property (nonatomic, assign) NSInteger pageTotalNum;

@property (nonatomic, strong) NSDictionary *forChoiceParameterDic;
@property (nonatomic, strong) NSArray *NetForParameterArray;
@property (nonatomic, strong) NSArray *NetForParameterNewArray;
@property (nonatomic, strong) NSArray *NetForParameterNew22Array;
@property (nonatomic, strong) NSArray *oldForParameterArray;
@property (nonatomic, strong) NSMutableArray *topArray;
@property (nonatomic, strong) NSMutableArray *battomArray;
@property (nonatomic, strong) NSArray *parameterNumArray;
@property (nonatomic, strong) NSDictionary *numForNetKeyDic;

@property (nonatomic, strong) NSArray *upOrDownNetValueArray;
@property (nonatomic, strong) NSArray *searchNameArray;
@property (nonatomic, strong) NSArray *netResultArray;
@property (nonatomic, strong) UILabel *numLable;
@property (nonatomic, strong) UILabel *numNameLable;
@property (nonatomic, strong) NSMutableDictionary*deviceNetDic;
@property (nonatomic, strong) UIView *View2;

@property (nonatomic, strong) NSMutableArray *allTableViewDataArray;
@property (nonatomic, strong) NSMutableArray *allTableViewData22Array;

@property (nonatomic, strong)NSString* numNameLableString;
@property (nonatomic, strong) NSMutableDictionary *deviceStatueNumDic;

@end

@implementation ossNewPlantList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
