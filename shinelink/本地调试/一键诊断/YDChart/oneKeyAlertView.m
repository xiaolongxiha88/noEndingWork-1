//
//  oneKeyAlertView.m
//  ShinePhone
//
//  Created by sky on 2018/2/7.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "oneKeyAlertView.h"




@interface oneKeySelectAlertCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *selectView;

@end

@implementation oneKeySelectAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.selectView];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = COLOR(51, 51, 51, 1);
        _titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            _titleLabel.frame = CGRectMake(50*HEIGHT_SIZE, 0, self.frame.size.width-40*HEIGHT_SIZE, self.frame.size.height);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIView *)selectView {
    if (!_selectView) {
        float buttonH=20*HEIGHT_SIZE;
        _selectView = [[UIView alloc] init];
               _selectView.frame = CGRectMake(15*HEIGHT_SIZE, (self.frame.size.height-buttonH)/2, buttonH, buttonH);
        _selectView.layer.borderWidth=1*HEIGHT_SIZE;
        _selectView.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
        _selectView.layer.cornerRadius=buttonH/2;
        _selectView.backgroundColor=[UIColor clearColor];
    }
    return _selectView;
}

- (void)layoutSubviews {
    [super layoutSubviews];

}

@end


@interface oneKeyAlertView () {
    float alertHeight;//弹框整体高度，默认250
    float buttonHeight;//按钮高度，默认40
}


@property (nonatomic, assign) BOOL showCloseButton;//是否显示关闭按钮
@property (nonatomic, strong) UIView *alertView;//弹框视图
@property (nonatomic, strong) UITableView *selectTableView;//选择列表

@property (nonatomic, strong) NSMutableArray *isSelectArray;

@end

@implementation oneKeyAlertView


+ (oneKeyAlertView *)showWithTitle:(NSString *)title
                                   titles:(NSArray *)titles
                              selectIndex:(SelectIndex)selectIndex
                              selectValue:(SelectValue)selectValue
                          showCloseButton:(BOOL)showCloseButton {
    oneKeyAlertView *alert = [[oneKeyAlertView alloc] initWithTitle:title titles:titles selectIndex:selectIndex selectValue:selectValue showCloseButton:showCloseButton];
    return alert;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        _titleLabel.textColor = MainColor;
        _titleLabel.font = [UIFont boldSystemFontOfSize:14*HEIGHT_SIZE];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 8;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        [_closeButton setTitle:root_OK forState:UIControlStateNormal];
        [_closeButton setTitleColor:MainColor forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _selectTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        }
    }
    return _selectTableView;
}

- (instancetype)initWithTitle:(NSString *)title titles:(NSArray *)titles selectIndex:(SelectIndex)selectIndex selectValue:(SelectValue)selectValue showCloseButton:(BOOL)showCloseButton {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        int N = [[NSString stringWithFormat:@"%lu",(unsigned long)titles.count] intValue];
        alertHeight = 40*HEIGHT_SIZE*N+80*HEIGHT_SIZE;
        if (alertHeight>300*HEIGHT_SIZE) {
            alertHeight=300*HEIGHT_SIZE;
        }
        
        buttonHeight = 40*HEIGHT_SIZE;
        
        self.titleLabel.text = title;
        _titles = titles;
        _selectIndex = [selectIndex copy];
        _selectValue = [selectValue copy];
        _showCloseButton = showCloseButton;
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.selectTableView];
        if (_showCloseButton) {
            [self.alertView addSubview:self.closeButton];
        }
        
        _isSelectArray=[NSMutableArray arrayWithArray:@[[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES]]];
        [self initUI];
        
        [self show];
    }
    return self;
}

- (void)show {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 1;
    }];
}

- (void)initUI {

    
    self.alertView.frame = CGRectMake(50, ([UIScreen mainScreen].bounds.size.height-alertHeight)/2.0, [UIScreen mainScreen].bounds.size.width-100, alertHeight);
    self.titleLabel.frame = CGRectMake(0, 0, _alertView.frame.size.width, buttonHeight);
    float reduceHeight = buttonHeight;
    if (_showCloseButton) {
        self.closeButton.frame = CGRectMake(_alertView.frame.size.width/2, _alertView.frame.size.height-buttonHeight,_alertView.frame.size.width/2, buttonHeight);
        reduceHeight = buttonHeight*2;
    }
    self.selectTableView.frame = CGRectMake(0, buttonHeight, _alertView.frame.size.width, _alertView.frame.size.height-reduceHeight);
    
    UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allButton.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    allButton.frame = CGRectMake(0, _alertView.frame.size.height-buttonHeight, _alertView.frame.size.width/2, buttonHeight);
    allButton.selected=YES;
    [allButton setTitle:@"全选" forState:UIControlStateNormal];
    [allButton setTitleColor:MainColor forState:UIControlStateNormal];
    allButton.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [allButton addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:allButton];
    
}

- (void)choiceAction:(UIButton*)button{
    button.selected = !button.selected;
    if (button.selected) {
     _isSelectArray=[NSMutableArray arrayWithArray:@[[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES]]];
    }else{
                _isSelectArray=[NSMutableArray arrayWithArray:@[[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO]]];
    }
     [_selectTableView reloadData];
}

#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    float real = (alertHeight - buttonHeight)/(float)_titles.count;
    //    if (_showCloseButton) {
    //        real = (alertHeight - buttonHeight*2)/(float)_titles.count;
    //    }
    //    return real<=45 ? 45:real;
    
    return 40*HEIGHT_SIZE;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    oneKeySelectAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectcell"];
    if (!cell) {
        cell = [[oneKeySelectAlertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectcell"];
    }
    cell.titleLabel.text = _titles[indexPath.row];
    
        BOOL isSelect=[self.isSelectArray[indexPath.row] boolValue];
    if (isSelect) {
            cell.selectView.layer.borderColor=[UIColor whiteColor].CGColor;
             cell.selectView.backgroundColor = MainColor;
    }else{
            cell.selectView.layer.borderColor=COLOR(102, 102, 102, 1).CGColor;
             cell.selectView.backgroundColor = [UIColor clearColor];
    }
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL isSelect=[self.isSelectArray[indexPath.row] boolValue];
    isSelect = !isSelect;
    [self.isSelectArray setObject:[NSNumber numberWithBool:isSelect ] atIndexedSubscript:indexPath.row];
    
    [_selectTableView reloadData];
    
//    if (self.selectIndex) {
//        self.selectIndex(indexPath.row);
//    }

//
//    [self closeAction];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt) && !_showCloseButton) {
        [self closeAction];
    }
}

- (void)closeAction {
    
        if (self.selectValue) {
            self.selectValue(self.isSelectArray);
        }
    
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc {
    //    NSLog(@"SelectAlert被销毁了");
}


@end
