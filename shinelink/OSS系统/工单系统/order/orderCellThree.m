//
//  orderCellThree.m
//  ShinePhone
//
//  Created by sky on 2017/6/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "orderCellThree.h"
#import "Model.h"
#import "MBProgressHUD.h"
#import "GetServerViewController.h"

@implementation orderCellThree

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
  
        
    }
    return self;
}


-(void)initUI{
    
    float viewW1=34*HEIGHT_SIZE;
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width,viewW1)];
    _titleView.backgroundColor =COLOR(242, 242, 242, 1);
    _titleView.userInteractionEnabled = YES;
    UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMoreText)];
    [_titleView addGestureRecognizer:forget2];
    [self.contentView addSubview:_titleView];
    
    float ImageW1=26*HEIGHT_SIZE;  float firstW1=5*HEIGHT_SIZE;
    _titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(firstW1, (viewW1-ImageW1)/2, ImageW1, ImageW1)];

   
    [_titleView addSubview:_titleImage];
    
    float titleLabelH1=30*HEIGHT_SIZE;
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstW1*2+ImageW1, (viewW1-titleLabelH1)/2, 150*NOW_SIZE, titleLabelH1)];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_titleView addSubview:_titleLabel];
    
    float buttonViewW=50*NOW_SIZE;
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width-buttonViewW, 0, buttonViewW,viewW1)];
    buttonView.backgroundColor =[UIColor clearColor];
    buttonView.userInteractionEnabled = YES;
    [_titleView addSubview:buttonView];
    
    float buttonW=12*NOW_SIZE;    float buttonH=8*HEIGHT_SIZE;
    if (!_moreTextBtn) {
        _moreTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreTextBtn.selected=NO;
        [_moreTextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _moreTextBtn.frame = CGRectMake((buttonViewW-buttonW)/2, (viewW1-buttonH)/2, buttonW, buttonH);
        [buttonView addSubview:_moreTextBtn];
        [_moreTextBtn addTarget:self action:@selector(showMoreText) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    float View2H=4*NOW_SIZE;
    UIView *View2 = [[UIView alloc]initWithFrame:CGRectMake(0, viewW1, SCREEN_Width,View2H)];
    View2.backgroundColor =[UIColor whiteColor];
    [self.contentView addSubview:View2];
    
    float scrollFirstH=viewW1+View2H;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollFirstH, SCREEN_Width, 0)];
    _scrollView.scrollEnabled=YES;
    [self.contentView addSubview:_scrollView];
    
    _View3 = [[UIView alloc]initWithFrame:CGRectMake(firstW1+ImageW1/2, 0, 0.3*NOW_SIZE,38*HEIGHT_SIZE)];
  
    if ([_statusString isEqualToString:@"4"] || [_statusString isEqualToString:@"4"]) {
        _View3.backgroundColor =COLOR(255, 204, 0, 1);
    }else{
      _View3.backgroundColor =COLOR(102, 102, 102, 1);
    }
    [self.contentView addSubview:_View3];
    
    
    NSArray *lableNameArray=[NSArray arrayWithObjects:@"完成情况",@"完成时间", @"回访时间",@"回访人",@"基本信息是否有误",@"满意度打分", @"电话是否接通",  @"是否按约定时间到达现场",@"是否签字确认",@"客户评价",@"回访备注",  nil];
    NSString *value5=@""; NSString *value6=@"";NSString *value7=@"";NSString *value8=@"";NSString *value9=@"";
    NSInteger INT5=[[NSString stringWithFormat:@"%@",_allValueDic[@"basicInformation"]] integerValue];
        NSInteger INT6=[[NSString stringWithFormat:@"%@",_allValueDic[@"satisfaction"]] integerValue];
      NSInteger INT7=[[NSString stringWithFormat:@"%@",_allValueDic[@"phoneIswitched"]] integerValue];
     NSInteger INT8=[[NSString stringWithFormat:@"%@",_allValueDic[@"agreedTime"]] integerValue];
      NSInteger INT9=[[NSString stringWithFormat:@"%@",_allValueDic[@"signToConfirm"]] integerValue];
    if (INT5==1) {
        value5=@"是";
    }else{
         value5=@"否";
    }
    if (INT6==10) {
        value6=[NSString stringWithFormat:@"%@(%ld分)",@"非常满意",INT6];
    }else if (INT6==8) {
        value6=[NSString stringWithFormat:@"%@(%ld分)",@"满意",INT6];
    }else if (INT6==6) {
        value6=[NSString stringWithFormat:@"%@(%ld分)",@"一般",INT6];
    }else if (INT6==4) {
        value6=[NSString stringWithFormat:@"%@(%ld分)",@"不满意",INT6];
    }else if (INT6==2) {
        value6=[NSString stringWithFormat:@"%@(%ld分)",@"很不满意",INT6];
    }
    
    if (INT7==0) {
        value7=@"已接通";
    }else  if (INT7==1) {
        value7=@"无人接听";
    }else  if (INT7==2) {
        value7=@"无法接通";
    }
    
    if (INT8==1) {
        value8=@"是";
    }else{
        value8=@"否";
    }
    
    if (INT9==1) {
        value9=@"是";
    }else{
        value9=@"否";
    }
    
  NSArray *lableValueArray2=[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",_allValueDic[@"completion"]],[NSString stringWithFormat:@"%@",_allValueDic[@"completeTime"]],[NSString stringWithFormat:@"%@",_allValueDic[@"visitTime"]],[NSString stringWithFormat:@"%@",_allValueDic[@"returnVisit"]], value5,value6,value7,value8,value9,[NSString stringWithFormat:@"%@",_allValueDic[@"recommended"]],[NSString stringWithFormat:@"%@",_allValueDic[@"returnNote"]],nil];
    
    float lable1W=10*NOW_SIZE;  float lableH=30*HEIGHT_SIZE;    float numH=35*NOW_SIZE;  float firstW=25*NOW_SIZE;
    long forNum=lableNameArray.count-1;
    for (int i=0; i<lableNameArray.count; i++) {
        

        NSString*lable2Name=[NSString stringWithFormat:@"%@:",lableNameArray[i]];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size = [lable2Name boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(firstW+lable1W, 0+numH*i,size.width, lableH)];
        lable2.textColor = COLOR(154, 154, 154, 1);

        lable2.text=lable2Name;
        lable2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:lable2];
        
        float lable3W=firstW+lable1W+size.width+10*NOW_SIZE;
        if (i!=forNum) {
            UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(lable3W, 0+numH*i,SCREEN_Width-(1*firstW)-lable3W, lableH)];
            lable3.textColor = COLOR(154, 154, 154, 1);
           lable3.text=lableValueArray2[i];
            lable3.tag=2000+i;
            lable3.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
           if ([_statusString isEqualToString:@"5"]) {
                [_scrollView addSubview:lable3];
            }
           
        }
        
        
        if (i!=forNum) {
            UIView *View4 = [[UIView alloc]initWithFrame:CGRectMake(firstW, numH*(i+1)-1*HEIGHT_SIZE, SCREEN_Width-(2*firstW),1*HEIGHT_SIZE)];
            View4.backgroundColor = COLOR(222, 222, 222, 1);
            
            [_scrollView addSubview:View4];
        }
        
        float textfieldW=firstW+lable1W+size.width+5*NOW_SIZE;
        float textW1=SCREEN_Width-firstW-(SCREEN_Width-(2*firstW));
        float textW=SCREEN_Width-textfieldW-textW1;

        
        NSString *longName1=[NSString stringWithFormat:@"%@",_allValueDic[@"satisfactoryReason"]];
          NSString *longName2=[NSString stringWithFormat:@"%@",_allValueDic[@"returnNote"]];
        
        CGSize size1= [longName1 boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
          CGSize size2= [longName2 boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        float remarkLabelH;
        if (lableH>(size1.height+20*HEIGHT_SIZE)) {
            remarkLabelH=lableH;
        }else{
            remarkLabelH=size1.height+20*HEIGHT_SIZE;
        }
        
        float remarkLabelH2;
        if (lableH>(size2.height+20*HEIGHT_SIZE)) {
            remarkLabelH2=lableH;
        }else{
            remarkLabelH2=size2.height+20*HEIGHT_SIZE;
        }
        
        if (i==forNum-1) {
            _sayGoodLabel = [[UILabel alloc] initWithFrame:CGRectMake(textfieldW, 0+numH*i,textW,remarkLabelH)];
            _sayGoodLabel.textColor = COLOR(154, 154, 154, 1);
            _sayGoodLabel.text=longName1;
            _sayGoodLabel.numberOfLines=0;
            _sayGoodLabel.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [_scrollView addSubview:_sayGoodLabel];
        }
        
        if (i==forNum) {
            _remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(textfieldW, 0+numH*i+remarkLabelH,textW,remarkLabelH2)];
    _remarkLabel.textColor = COLOR(154, 154, 154, 1);
            _remarkLabel.text=longName2;
            _remarkLabel.numberOfLines=0;
            _remarkLabel.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [_scrollView addSubview:_remarkLabel];
        }
        
    }
    
    

}


-(void)GetPhoto:(UITapGestureRecognizer*)Tap{
        UIViewController *Controller = (UIViewController *)[self findViewController:self.contentView];
    
    GetServerViewController *get=[[GetServerViewController alloc]init];
    
    int T=(int)Tap.view.tag;
    if (T==2200) {
         get.picArray=[NSMutableArray arrayWithArray:_picArray];
    }else{
       get.picArray=[NSMutableArray arrayWithArray:_picArray1];
    }

   
    get.TypeNum=@"2";
    
    [Controller.navigationController pushViewController:get animated:NO];
    
}


- (UIViewController *)findViewController:(UIView *)sourceView

{
    
    id target=sourceView;
    
    while (target) {
        
        target = ((UIResponder *)target).nextResponder;
        
        if ([target isKindOfClass:[UIViewController class]]) {
            
            break;
            
        }
        
    }
    
    return target;
    
}

-(void)finishSet{
    
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:@{@"orderId":_orderID,@"status":_statusString} paramarsSite:@"/api/v2/order/detail" sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v2/ order/detail: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
                
                
            }else{
                [self showToastViewWithTitle:firstDic[@"msg"]];
                
            }
        }
    } failure:^(NSError *error) {
            [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
    
    }];
    
}

- (void)showToastViewWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.labelText = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}

- (void)showProgressView {
    [MBProgressHUD hideHUDForView:self.contentView animated:YES];
    [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
}

- (void)hideProgressView {
    [MBProgressHUD hideHUDForView:self.contentView animated:YES];
}

- (void)textViewDidChange:(UITextView *)textView {
    [self updateHeight:textView isInput:YES];
}


- (void)updateHeight:(UITextView *)textView isInput:(BOOL)isInput {
    
    CGFloat height =  textView.contentSize.height;
    
    
    
    if (height >=80*HEIGHT_SIZE) {
        height =80*HEIGHT_SIZE;
        
    }
    [UIView animateWithDuration:0.25f animations:^{
        
        float W=_textfield2.frame.size.width;
        float x=_textfield2.frame.origin.x;
        float y=_textfield2.frame.origin.y;
        
        
        _textfield2.frame=CGRectMake(x,y , W, height);
        
        
    }];
}



- (void)showMoreText{
    
    self.model.isShowMoreText = !self.model.isShowMoreText;
    
    
    if (self.showMoreBlock){
        self.showMoreBlock(self);
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _remarkString=_allValueDic[@"remarks"];
    
    if (!_scrollView) {
        [self initUI];
    }

    if ([_statusString isEqualToString:@"4"] || [_statusString isEqualToString:@"5"]) {
        _titleImage.image=IMAGE(@"yuan_2.png");
    }else{
        _titleImage.image=IMAGE(@"yuan_1.png");
    }
    

    
    _titleLabel.text = self.model.title;
    
    if (self.model.isShowMoreText){ // 展开状态
        // 计算文本高度
        float y=_scrollView.frame.origin.y;
        _scrollView.frame=CGRectMake(0, y, SCREEN_Width, SCREEN_Height);
        
        float H=SCREEN_Height-(38*HEIGHT_SIZE*2)-20*HEIGHT_SIZE;
        float Vx=_View3.frame.origin.x; float Vy=_View3.frame.origin.y;
        _View3.frame = CGRectMake(Vx,Vy, 0.3*NOW_SIZE,H);
        
        [_moreTextBtn setImage:IMAGE(@"oss_more_up.png") forState:UIControlStateNormal];
    }else{ // 收缩状态
        float y=_scrollView.frame.origin.y;
        _scrollView.frame=CGRectMake(0, y, SCREEN_Width, 0);
        
        [_moreTextBtn setImage:IMAGE(@"oss_more_down.png") forState:UIControlStateNormal];
    }
}

// MARK: - 获取默认高度
+ (CGFloat)defaultHeight{
    
    return 38*HEIGHT_SIZE;
}

// MARK: - 获取展开后的高度
+ (CGFloat)moreHeight:(CGFloat) navigationH{
    
    
    float H=10*35*HEIGHT_SIZE+navigationH+80*HEIGHT_SIZE;
    
    return H;
    
}



-(void)pickDate{
    // float buttonSize=70*HEIGHT_SIZE;
    _date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, SCREEN_Height-360*HEIGHT_SIZE, SCREEN_Width, 250*HEIGHT_SIZE)];
    _date.backgroundColor=COLOR(242, 242, 242, 1);
    _date.datePickerMode=UIDatePickerModeDateAndTime;
    [self.contentView addSubview:_date];
    
    if (self.toolBar) {
        [UIView animateWithDuration:0.3f animations:^{
            self.toolBar.alpha = 1;
            self.toolBar.frame = CGRectMake(0, SCREEN_Height-400*HEIGHT_SIZE-40*HEIGHT_SIZE, SCREEN_Width, 40*HEIGHT_SIZE);
            [self.contentView addSubview:_toolBar];
        }];
    } else {
        self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_Height-360*HEIGHT_SIZE-40*HEIGHT_SIZE, SCREEN_Width, 40*HEIGHT_SIZE)];
        self.toolBar.barStyle = UIBarStyleDefault;
        self.toolBar.barTintColor = MainColor;
        [self.contentView addSubview:self.toolBar];
        
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(removeToolBar)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(completeSelectDate:)];
        
        UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
        
        spaceButton.tintColor=[UIColor whiteColor];
        doneButton.tintColor=[UIColor whiteColor];
        
        
        self.toolBar.items = @[spaceButton,flexibleitem,doneButton];
    }
}


-(void)removeToolBar{
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}


- (void)completeSelectDate:(UIToolbar *)toolBar {
    _goTimeString = [self.dayFormatter stringFromDate:self.date.date];
    
    
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}






@end
