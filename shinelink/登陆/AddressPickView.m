//
//  PopupView.m
//  买布易
//
//  Created by 张建 on 15/6/26.
//  Copyright (c) 2015年 张建. All rights reserved.
//

#import "AddressPickView.h"
#import "UIViewExt.h"
#define navigationViewHeight 44.0f
#define pickViewViewHeight 300.0f
#define buttonWidth 60.0f


@interface AddressPickView ()

@property(nonatomic,strong)NSDictionary *pickerDic;
  
@property(nonatomic,strong)NSArray *selectedArray;
@property(nonatomic,strong)NSArray *cityArray;
@property(nonatomic,strong)NSArray *townArray;
@property(nonatomic,strong)UIView *bottomView;//包括导航视图和地址选择视图
@property(nonatomic,strong)UIPickerView *pickView;//地址选择视图
@property(nonatomic,strong)UIView *navigationView;//上面的导航视图

@end

@implementation AddressPickView
+ (instancetype)shareInstance
{
    static AddressPickView *shareInstance = nil;
   // static dispatch_once_t onceToken;
    //dispatch_once(&onceToken, ^{
        shareInstance = [[AddressPickView alloc] init];
  //  });
    
    [shareInstance showBottomView];
    return shareInstance;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        
        [self _addTapGestureRecognizerToSelf];
        [self _createView];
    }
    return self;
  
}
#pragma mark - get data



- (void)showProgressView {
    [MBProgressHUD hideHUDForView:self animated:YES];
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

- (void)hideProgressView {
    [MBProgressHUD hideHUDForView:self animated:YES];
}

-(void)_addTapGestureRecognizerToSelf
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tap];
}
-(void)_createView
{
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, navigationViewHeight+pickViewViewHeight)];
    [self addSubview:_bottomView];
    //导航视图
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, navigationViewHeight)];
    _navigationView.backgroundColor = [UIColor lightGrayColor];
    [_bottomView addSubview:_navigationView];
    //这里添加空手势不然点击navigationView也会隐藏,
    UITapGestureRecognizer *tapNavigationView = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
    [_navigationView addGestureRecognizer:tapNavigationView];
    NSArray *buttonTitleArray = @[root_cancel,root_OK];
    for (int i = 0; i <buttonTitleArray.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i*(kScreenWidth-buttonWidth), 0, buttonWidth, navigationViewHeight);
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [_navigationView addSubview:button];
        
        button.tag = i;
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        

    }
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, navigationViewHeight, kScreenWidth, pickViewViewHeight)];
    _pickView.backgroundColor = [UIColor whiteColor];
    _pickView.dataSource = self;
    _pickView.delegate =self;
    [_bottomView addSubview:_pickView];
    
    
}
-(void)tapButton:(UIButton*)button
{
    //点击确定回调block
    if (button.tag == 1) {
        
        NSString *province = [self.provinceArray objectAtIndex:[_pickView selectedRowInComponent:0]];
      //  NSString *city = [self.cityArray objectAtIndex:[_pickView selectedRowInComponent:1]];
       // NSString *town = [self.townArray objectAtIndex:[_pickView selectedRowInComponent:2]];
        
        _block(province);
    }
    
    [self hiddenBottomView];

    
}
-(void)showBottomView
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
       
        _bottomView.top = kScreenHeight-navigationViewHeight-pickViewViewHeight;
        self.backgroundColor = windowColor;
    } completion:^(BOOL finished) {

    }];
}
-(void)hiddenBottomView
{
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = kScreenHeight;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}


#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
        return _provinceArray.count;
    
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:20.0f];
    if (component == 0) {
        lable.text=[self.provinceArray objectAtIndex:row];
    }
    return lable;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat pickViewWidth = kScreenWidth;

    return pickViewWidth;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
  
 
}


@end
