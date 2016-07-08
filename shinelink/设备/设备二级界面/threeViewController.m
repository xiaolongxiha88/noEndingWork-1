//
//  threeViewController.m
//  shinelink
//
//  Created by sky on 16/3/11.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "threeViewController.h"
#import "Line2View.h"

#define dateHeight 30*NOW_SIZE
static const NSTimeInterval secondsPerDay = 24 * 60 * 60;

@interface threeViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) NSMutableArray *yearsArr;
@property (nonatomic, strong) NSMutableArray *monthArr;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, strong) UIView *timeDisplayView;
@property (nonatomic, strong) UIButton *dayButton;
@property (nonatomic, strong) UIButton *monthButton;
@property (nonatomic, strong) UIButton *yearButton;
@property (nonatomic, strong) UIButton *totalButton;
@property (nonatomic, strong) UIButton *datePickerButton;
@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) NSString *currentMonth;
@property (nonatomic, strong) NSString *currentYear;

@property (nonatomic, strong) NSMutableDictionary *dayDict;
@property (nonatomic, strong) NSMutableDictionary *monthDict;
@property (nonatomic, strong) NSMutableDictionary *yearDict;
@property (nonatomic, strong) NSMutableDictionary *totalDict;

@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSDateFormatter *monthFormatter;
@property (nonatomic, strong) NSDateFormatter *yearFormatter;
@property (nonatomic, strong) NSDateFormatter *onlyMonthFormatter;

@property (nonatomic, strong) UIDatePicker *dayPicker;
@property (nonatomic, strong) UIPickerView *monthPicker;
@property (nonatomic, strong) UIPickerView *yearPicker;

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) Line2View *line2View;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)UIButton *selectButton;
@end

@implementation threeViewController

- (void)viewWillAppear:(BOOL)animated {

    [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
     [self initUI];
}

- (void)initData {
    self.yearsArr = [NSMutableArray array];
    for (int i = 1900; i<2100; i++) {
        [self.yearsArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    self.monthArr = [NSMutableArray array];
    for (int i = 1; i<13; i++) {
        [self.monthArr addObject:[NSString stringWithFormat:@"%02d", i]];
    }
}

- (void)initUI {
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    [self.view addSubview:_scrollView];

    self.dayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dayButton.frame = CGRectMake(0 * SCREEN_Width/4, 0, SCREEN_Width/4, 40*NOW_SIZE);
    [self.dayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(45, 182, 165, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateNormal];
    [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(64, 221, 204, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateHighlighted];
    [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(64, 221, 204, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateSelected];
    self.dayButton.tag = 1000;
    [self.dayButton setTitle:@"日" forState:UIControlStateNormal];
    self.dayButton.selected = YES;
    [self.dayButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.dayButton];

    self.monthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.monthButton.frame = CGRectMake(1 * SCREEN_Width/4, 0, SCREEN_Width/4, 40*NOW_SIZE);
    [self.monthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(45, 182, 165, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateNormal];
    [self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(64, 221, 204, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateHighlighted];
    [self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(64, 221, 204, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateSelected];
    self.monthButton.tag = 1001;
    [self.monthButton setTitle:@"月" forState:UIControlStateNormal];
    [self.monthButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.monthButton];
    
    self.yearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.yearButton.frame = CGRectMake(2 * SCREEN_Width/4, 0, SCREEN_Width/4, 40*NOW_SIZE);
    [self.yearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.yearButton setBackgroundImage:[self createImageWithColor:COLOR(45, 182, 165, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateNormal];
    [self.yearButton setBackgroundImage:[self createImageWithColor:COLOR(64, 221, 204, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateHighlighted];
    [self.yearButton setBackgroundImage:[self createImageWithColor:COLOR(64, 221, 204, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateSelected];
    self.yearButton.tag = 1002;
    [self.yearButton setTitle:@"年  " forState:UIControlStateNormal];
    [self.yearButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.yearButton];
    
    self.totalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.totalButton.frame = CGRectMake(3 * SCREEN_Width/4, 0, SCREEN_Width/4, 40*NOW_SIZE);
    [self.totalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.totalButton setBackgroundImage:[self createImageWithColor:COLOR(45, 182, 165, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateNormal];
    [self.totalButton setBackgroundImage:[self createImageWithColor:COLOR(64, 221, 204, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateHighlighted];
    [self.totalButton setBackgroundImage:[self createImageWithColor:COLOR(64, 221, 204, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, dateHeight)] forState:UIControlStateSelected];
    self.totalButton.tag = 1003;
    [self.totalButton setTitle:@"累计" forState:UIControlStateNormal];
    [self.totalButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.totalButton];

    self.timeDisplayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 40*NOW_SIZE, SCREEN_Width, 30*NOW_SIZE)];
    self.timeDisplayView.backgroundColor = COLOR(140, 220, 220, 1);
    [_scrollView addSubview:self.timeDisplayView];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_Width - 120*NOW_SIZE)/2, 4*NOW_SIZE, 120*NOW_SIZE, 30*NOW_SIZE - 8*NOW_SIZE)];
    bgImageView.image = IMAGE(@"rili.png");
    bgImageView.userInteractionEnabled = YES;
    [self.timeDisplayView addSubview:bgImageView];
    
    self.lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastButton.frame = CGRectMake(0, 0, 22*NOW_SIZE, 22*NOW_SIZE);
    [self.lastButton setImage:IMAGE(@"shang.png") forState:UIControlStateNormal];
    self.lastButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*NOW_SIZE, 7*NOW_SIZE, 7*NOW_SIZE);
    self.lastButton.tag = 1004;
    [self.lastButton addTarget:self action:@selector(lastDate:) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:self.lastButton];

    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(CGRectGetWidth(bgImageView.frame) - 22*NOW_SIZE, 0, 22*NOW_SIZE, 22*NOW_SIZE);
    [self.nextButton setImage:IMAGE(@"xia.png") forState:UIControlStateNormal];
    self.nextButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*NOW_SIZE, 7*NOW_SIZE, 7*NOW_SIZE);
    self.nextButton.tag = 1005;
    [self.nextButton addTarget:self action:@selector(nextDate:) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:self.nextButton];
    
    
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd"];
    self.monthFormatter = [[NSDateFormatter alloc] init];
    [self.monthFormatter setDateFormat:@"yyyy-MM"];
    self.yearFormatter = [[NSDateFormatter alloc] init];
    [self.yearFormatter setDateFormat:@"yyyy"];
    self.onlyMonthFormatter = [[NSDateFormatter alloc] init];
    [self.onlyMonthFormatter setDateFormat:@"MM"];
    
    self.datePickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.datePickerButton.frame = CGRectMake(22*NOW_SIZE, 0, CGRectGetWidth(bgImageView.frame) - 44*NOW_SIZE, 22*NOW_SIZE);
    self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    self.currentMonth = [_monthFormatter stringFromDate:[NSDate date]];
    self.currentYear = [_yearFormatter stringFromDate:[NSDate date]];
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [self.datePickerButton setTitleColor:COLOR(7, 64, 52, 1) forState:UIControlStateNormal];
    self.datePickerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.datePickerButton.titleLabel.font = [UIFont boldSystemFontOfSize:10*NOW_SIZE];
    [self.datePickerButton addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:self.datePickerButton];
    
    self.line2View = [[Line2View alloc] initWithFrame:CGRectMake(0, 130*NOW_SIZE, SCREEN_Width,280*NOW_SIZE )];
    self.line2View.flag=@"2";
    [self.view addSubview:self.line2View];

}

#pragma mark - 获取、保存曲线图数据
- (void)requestDayDatasWithDayString:(NSString *)datString {
    NSMutableDictionary *dict=[NSMutableDictionary new];
    [dict setObject:@"3.0" forKey:@"08:30"];
    [dict setObject:@"5.0" forKey:@"09:30"];
    [dict setObject:@"12.0" forKey:@"10:30"];
    [dict setObject:@"21.0" forKey:@"11:30"];
    [dict setObject:@"33.0" forKey:@"12:30"];
    [dict setObject:@"45.0" forKey:@"13:30"];
    [dict setObject:@"65.0" forKey:@"14:30"];
    [dict setObject:@"23.0" forKey:@"15:30"];
    [dict setObject:@"151.0" forKey:@"16:30"];
    [dict setObject:@"124.0" forKey:@"17:30"];
  
            self.dayDict = [NSMutableDictionary dictionaryWithDictionary:dict];
            [self.line2View refreshLineChartViewWithDataDict:dict];
   
}

- (void)requestMonthDatasWithMonthString:(NSString *)monthString {
    
    NSMutableDictionary *dict=[NSMutableDictionary new];
    [dict setObject:@"3.0" forKey:@"2"];
    [dict setObject:@"5.0" forKey:@"4"];
    [dict setObject:@"12.0" forKey:@"6"];
    [dict setObject:@"21.0" forKey:@"8"];
    [dict setObject:@"33.0" forKey:@"10"];
    [dict setObject:@"45.0" forKey:@"12"];
    [dict setObject:@"65.0" forKey:@"14"];
    [dict setObject:@"23.0" forKey:@"16"];
    [dict setObject:@"151.0" forKey:@"18"];
    [dict setObject:@"124.0" forKey:@"20"];
    
            [self.line2View refreshBarChartViewWithDataDict:dict chartType:2];
 

}

- (void)requestYearDatasWithYearString:(NSString *)yearString {
    NSMutableDictionary *dict=[NSMutableDictionary new];
    [dict setObject:@"3.0" forKey:@"2"];
    [dict setObject:@"5.0" forKey:@"4"];
    [dict setObject:@"12.0" forKey:@"6"];
    [dict setObject:@"21.0" forKey:@"8"];
    [dict setObject:@"33.0" forKey:@"10"];
    [dict setObject:@"45.0" forKey:@"12"];
    [dict setObject:@"65.0" forKey:@"14"];
    [dict setObject:@"23.0" forKey:@"16"];
    [dict setObject:@"151.0" forKey:@"18"];
    [dict setObject:@"124.0" forKey:@"20"];
            [self.line2View refreshBarChartViewWithDataDict:dict chartType:3];

    //    }
}

- (void)requestTotalDatas {
    NSMutableDictionary *dict=[NSMutableDictionary new];
    [dict setObject:@"3.0" forKey:@"2"];
    [dict setObject:@"5.0" forKey:@"4"];
    [dict setObject:@"12.0" forKey:@"6"];
    [dict setObject:@"21.0" forKey:@"8"];
    [dict setObject:@"33.0" forKey:@"10"];
    [dict setObject:@"45.0" forKey:@"12"];
    [dict setObject:@"65.0" forKey:@"14"];
    [dict setObject:@"23.0" forKey:@"16"];
    [dict setObject:@"151.0" forKey:@"18"];
    [dict setObject:@"124.0" forKey:@"20"];
    [self.line2View refreshBarChartViewWithDataDict:dict chartType:4];
       }
#pragma mark - 上一个时间  下一个时间  按钮事件
//上一个时间
- (void)lastDate:(UIButton *)sender {
    //日
    if (self.dayButton.selected) {
        NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
        NSDate *yesterday = [currentDayDate dateByAddingTimeInterval: -secondsPerDay];
        
        self.currentDay = [self.dayFormatter stringFromDate:yesterday];
        [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
        [self.dayDict removeAllObjects];
        [self requestDayDatasWithDayString:self.currentDay];
    }
    
    //月
    if (self.monthButton.selected) {
        NSDate *currentYearDate = [self.monthFormatter dateFromString:self.currentMonth];
        NSString *currentYearStr = [self.yearFormatter stringFromDate:currentYearDate];
        NSString *currentMonthStr = [self.onlyMonthFormatter stringFromDate:currentYearDate];
        
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                
                for (int j = 0; j<self.monthArr.count; j++) {
                    if ([_monthArr[j] integerValue] == [currentMonthStr integerValue]) {
                        if (i > 0 && j > 0) {
                            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i], _monthArr[j-1]];
                            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                            [self.monthDict removeAllObjects];
                            [self requestMonthDatasWithMonthString:self.currentMonth];
                        }
                        
                        if (i > 0 && j == 0) {
                            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i-1], _monthArr[_monthArr.count - 1]];
                            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                            [self.monthDict removeAllObjects];
                            [self requestMonthDatasWithMonthString:self.currentMonth];
                        }
                        
                        break;
                    }
                }
                
                break;
            }
        }
    }
    
    //年
    if (self.yearButton.selected) {
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                if (i > 0) {
                    self.currentYear = _yearsArr[i-1];
                    [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
                    [self.yearDict removeAllObjects];
                    [self requestYearDatasWithYearString:self.currentYear];
                }
                break;
            }
        }
    }
}

//下一个时间
- (void)nextDate:(UIButton *)sender {
    //日
    if (self.dayButton.selected) {
        NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
        NSDate *tomorrow = [currentDayDate dateByAddingTimeInterval: secondsPerDay];
        
        self.currentDay = [self.dayFormatter stringFromDate:tomorrow];
        [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
        [self.dayDict removeAllObjects];
        [self requestDayDatasWithDayString:self.currentDay];
    }
    
    //月
    if (self.monthButton.selected) {
        NSDate *currentYearDate = [self.monthFormatter dateFromString:self.currentMonth];
        NSString *currentYearStr = [self.yearFormatter stringFromDate:currentYearDate];
        NSString *currentMonthStr = [self.onlyMonthFormatter stringFromDate:currentYearDate];
        
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                
                for (int j = 0; j<self.monthArr.count; j++) {
                    if ([_monthArr[j] integerValue] == [currentMonthStr integerValue]) {
                        if (i < _yearsArr.count && j < _monthArr.count-1) {
                            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i], _monthArr[j+1]];
                            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                            [self.monthDict removeAllObjects];
                            [self requestMonthDatasWithMonthString:self.currentMonth];
                        }
                        
                        if (i < _yearsArr.count && j == _monthArr.count-1) {
                            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i+1], _monthArr[0]];
                            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                            [self.monthDict removeAllObjects];
                            [self requestMonthDatasWithMonthString:self.currentMonth];
                        }
                        
                        break;
                    }
                }
                
                break;
            }
        }
    }
    
    //年
    if (self.yearButton.selected) {
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                if (i < _yearsArr.count) {
                    self.currentYear = _yearsArr[i+1];
                    [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
                    [self.yearDict removeAllObjects];
                    [self requestYearDatasWithYearString:self.currentYear];
                }
                break;
            }
        }
    }
}


#pragma mark - 日、月、年、总  按钮事件
- (void)buttonDidClicked:(UIButton *)sender {
    [self.monthPicker removeFromSuperview];
    [self.yearPicker removeFromSuperview];
    [self.dayPicker removeFromSuperview];
    [self.toolBar removeFromSuperview];
    
    if (sender.tag == 1000) {
        //日
        self.dayButton.selected = YES;
        self.monthButton.selected = NO;
        self.yearButton.selected = NO;
        self.totalButton.selected = NO;
        
        [UIView animateWithDuration:0.3f animations:^{
            self.timeDisplayView.alpha = 1;
        }];
        
        if (self.monthPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.monthPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
            } completion:^(BOOL finished) {
                [self.monthPicker removeFromSuperview];
            }];
        }
        if (self.yearPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.yearPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
            } completion:^(BOOL finished) {
                [self.yearPicker removeFromSuperview];
            }];
        }
        if (!self.currentDay) {
            self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
        }
        [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
        
        [self requestDayDatasWithDayString:self.currentDay];
    }
    
    if (sender.tag == 1001) {
        //月
        self.dayButton.selected = NO;
        self.monthButton.selected = YES;
        self.yearButton.selected = NO;
        self.totalButton.selected = NO;
     
        [UIView animateWithDuration:0.3f animations:^{
            self.timeDisplayView.alpha = 1;
        }];
        
        if (self.dayPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
            } completion:^(BOOL finished) {
                [self.dayPicker removeFromSuperview];
            }];
        }
        if (self.yearPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.yearPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
            } completion:^(BOOL finished) {
                [self.yearPicker removeFromSuperview];
            }];
        }
        
        if (!self.currentMonth) {
            self.currentMonth = [_monthFormatter stringFromDate:[NSDate date]];
        }
        [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
        
        [self requestMonthDatasWithMonthString:self.currentMonth];
    }
    
    if (sender.tag == 1002) {
        //年
        self.dayButton.selected = NO;
        self.monthButton.selected = NO;
        self.yearButton.selected = YES;
        self.totalButton.selected = NO;
     
        [UIView animateWithDuration:0.3f animations:^{
            self.timeDisplayView.alpha = 1;
        }];
        
        if (self.dayPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
            } completion:^(BOOL finished) {
                [self.dayPicker removeFromSuperview];
            }];
        }
        if (self.monthPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.monthPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
            } completion:^(BOOL finished) {
                [self.monthPicker removeFromSuperview];
            }];
        }
        
        if (!self.currentYear) {
            self.currentYear = [_yearFormatter stringFromDate:[NSDate date]];
        }
        [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
        
        [self requestYearDatasWithYearString:self.currentYear];
    }
    
    if (sender.tag == 1003) {
        //总体
        self.dayButton.selected = NO;
        self.monthButton.selected = NO;
        self.yearButton.selected = NO;
        self.totalButton.selected = YES;
       
        [UIView animateWithDuration:0.3f animations:^{
            self.timeDisplayView.alpha = 0;
        }];
        
        if (self.dayPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
                self.toolBar.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE - 44, SCREEN_Width, 44);
            } completion:^(BOOL finished) {
                [self.dayPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
        if (self.monthPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.monthPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
                self.toolBar.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE - 44, SCREEN_Width, 44);
            } completion:^(BOOL finished) {
                [self.monthPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
        if (self.yearPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.yearPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
                self.toolBar.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE - 44, SCREEN_Width, 44);
            } completion:^(BOOL finished) {
                [self.yearPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
        
        [self requestTotalDatas];
    }
}

#pragma mark - datePickerButton点击事件 选择时间
- (void)pickDate {
    self.lastButton.enabled = NO;
    self.nextButton.enabled = NO;
    
    if (self.dayButton.selected) {
        //选择日
        NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
        
        if (!self.dayPicker) {
            self.dayPicker = [[UIDatePicker alloc] init];
            self.dayPicker.backgroundColor = [UIColor whiteColor];
         
            self.dayPicker.date = currentDayDate;
            self.dayPicker.frame = CGRectMake(0, 70*NOW_SIZE + 64, SCREEN_Width, 216);
            [self.view addSubview:self.dayPicker];
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.date = currentDayDate;
                self.dayPicker.alpha = 1;
                self.dayPicker.frame = CGRectMake(0, 70*NOW_SIZE + 64, SCREEN_Width, 216);
                [self.view addSubview:self.dayPicker];
            }];
        }
    }
    
    if (self.monthButton.selected) {
        //选择月
        NSDate *currentMonthDate = [self.monthFormatter dateFromString:self.currentMonth];
        NSString *currentYearStr = [self.yearFormatter stringFromDate:currentMonthDate];
        NSString *currentMonthStr = [self.onlyMonthFormatter stringFromDate:currentMonthDate];
        
        if (!self.monthPicker) {
            self.monthPicker = [[UIPickerView alloc] init];
            self.monthPicker.backgroundColor = [UIColor whiteColor];
            self.monthPicker.delegate = self;
            self.monthPicker.dataSource = self;
            self.monthPicker.frame = CGRectMake(0, 70*NOW_SIZE + 64, SCREEN_Width, 216);
            [self.view addSubview:self.monthPicker];
            
            for (int i = 0; i<self.yearsArr.count; i++) {
                if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                    [self.monthPicker selectRow:i inComponent:0 animated:NO];
                    break;
                }
            }
            for (int i = 0; i<self.monthArr.count; i++) {
                if ([_monthArr[i] integerValue] == [currentMonthStr integerValue]) {
                    [self.monthPicker selectRow:i inComponent:1 animated:NO];
                    break;
                }
            }
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                for (int i = 0; i<self.yearsArr.count; i++) {
                    if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                        [self.monthPicker selectRow:i inComponent:0 animated:NO];
                        break;
                    }
                }
                for (int i = 0; i<self.monthArr.count; i++) {
                    if ([_monthArr[i] integerValue] == [currentMonthStr integerValue]) {
                        [self.monthPicker selectRow:i inComponent:1 animated:NO];
                        break;
                    }
                }
                self.monthPicker.alpha = 1;
                self.monthPicker.frame = CGRectMake(0, 70*NOW_SIZE + 64, SCREEN_Width, 216);
                [self.view addSubview:self.monthPicker];
            }];
        }
    }
    
    if (self.yearButton.selected) {
        //选择年
        if (!self.yearPicker) {
            self.yearPicker = [[UIPickerView alloc] init];
            self.yearPicker.backgroundColor = [UIColor whiteColor];
            self.yearPicker.delegate = self;
            self.yearPicker.dataSource = self;
            self.yearPicker.frame = CGRectMake(0, 70*NOW_SIZE + 64, SCREEN_Width, 216);
            [self.view addSubview:self.yearPicker];
            
            for (int i = 0; i<self.yearsArr.count; i++) {
                if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                    [self.yearPicker selectRow:i inComponent:0 animated:NO];
                    break;
                }
            }
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                for (int i = 0; i<self.yearsArr.count; i++) {
                    if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                        [self.yearPicker selectRow:i inComponent:0 animated:NO];
                        break;
                    }
                }
                self.yearPicker.alpha = 1;
                self.yearPicker.frame = CGRectMake(0, 70*NOW_SIZE + 64, SCREEN_Width, 216);
                [self.view addSubview:self.yearPicker];
            }];
        }
    }
    
    if (!self.totalButton.selected) {
        if (self.toolBar) {
            [UIView animateWithDuration:0.3f animations:^{
                self.toolBar.alpha = 1;
                self.toolBar.frame = CGRectMake(0, 70*NOW_SIZE + 64 + 216, SCREEN_Width, 44);
                [self.view addSubview:_toolBar];
            }];
        } else {
            self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 70*NOW_SIZE + 64 + 216, SCREEN_Width, 44)];
            self.toolBar.barStyle = UIBarStyleDefault;
            self.toolBar.barTintColor = COLOR(101, 203, 197, 1);
            [self.view addSubview:self.toolBar];
            
            UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeSelectDate:)];
            doneButton.tintColor = [UIColor whiteColor];
            self.toolBar.items = @[spaceButton, doneButton];
        }
    }
}

#pragma mark 完成选择时间
- (void)completeSelectDate:(UIToolbar *)toolBar {
    self.lastButton.enabled = YES;
    self.nextButton.enabled = YES;
    
    if (self.dayButton.selected) {
        if (self.dayPicker) {
            self.currentDay = [self.dayFormatter stringFromDate:self.dayPicker.date];
            [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
            
            [self.dayDict removeAllObjects];
            [self requestDayDatasWithDayString:self.currentDay];
            
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.alpha = 0;
                self.toolBar.alpha = 0;
                self.dayPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
                self.toolBar.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE - 44, SCREEN_Width, 44);
            } completion:^(BOOL finished) {
                [self.dayPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
            
        }
    }
    
    if (self.monthButton.selected) {
        if (self.monthPicker) {
            NSInteger rowYear = [_monthPicker selectedRowInComponent:0];
            NSInteger rowMonth = [_monthPicker selectedRowInComponent:1];
            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[rowYear], _monthArr[rowMonth]];
            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
            
            [self.monthDict removeAllObjects];
            [self requestMonthDatasWithMonthString:self.currentMonth];
            
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.alpha = 0;
                self.toolBar.alpha = 0;
                self.monthPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
                self.toolBar.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE - 44, SCREEN_Width, 44);
            } completion:^(BOOL finished) {
                [self.monthPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
    }
    
    if (self.yearButton.selected) {
        if (self.yearPicker) {
            NSInteger rowYear = [_yearPicker selectedRowInComponent:0];
            self.currentYear = [NSString stringWithFormat:@"%@", _yearsArr[rowYear]];
            [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
            
            [self.yearDict removeAllObjects];
            [self requestYearDatasWithYearString:self.currentYear];
            
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.alpha = 0;
                self.toolBar.alpha = 0;
                self.yearPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
                self.toolBar.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE - 44, SCREEN_Width, 44);
            } completion:^(BOOL finished) {
                [self.yearPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
    }
}

#pragma mark - 取消选择时间
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.dayPicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.dayPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.dayPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
            self.toolBar.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE - 44, SCREEN_Width, 44);
        } completion:^(BOOL finished) {
            [self.dayPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
            self.lastButton.enabled = YES;
            self.nextButton.enabled = YES;
        }];
    }
    
    if (self.monthPicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.monthPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.monthPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
            self.toolBar.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE - 44, SCREEN_Width, 44);
        } completion:^(BOOL finished) {
            [self.monthPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
            self.lastButton.enabled = YES;
            self.nextButton.enabled = YES;
        }];
    }
    
    if (self.yearPicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.yearPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.yearPicker.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE, SCREEN_Width, 216);
            self.toolBar.frame = CGRectMake(0, -216 - 64 - 70*NOW_SIZE - 44, SCREEN_Width, 44);
        } completion:^(BOOL finished) {
            [self.yearPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
            self.lastButton.enabled = YES;
            self.nextButton.enabled = YES;
        }];
    }
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == _monthPicker) {
        return 2;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == _monthPicker) {
        if (component == 0) {
            return _yearsArr.count;
        }
        return _monthArr.count;
    }
    return _yearsArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == _monthPicker) {
        if (component == 0) {
            return [NSString stringWithFormat:@"%@年", _yearsArr[row]];
        }
        return [NSString stringWithFormat:@"%@月", _monthArr[row]];
    }
    return [NSString stringWithFormat:@"%@年", _yearsArr[row]];
}






#pragma mark - EditCellectViewDelegate
- (void)menuDidSelectAtRow:(NSInteger)row {
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
