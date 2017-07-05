//
//  orderCellOne.m
//  ShinePhone
//
//  Created by sky on 2017/6/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "orderCellOne.h"
#import "Model.h"
#import "MBProgressHUD.h"

static NSString *statusNum = @"2";

@implementation orderCellOne

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
      
    }
    return self;
}


-(void)initUI{


     //   self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        float viewW1=34*HEIGHT_SIZE;    float remarkLabelH = 0.0;
        
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width,viewW1)];
        _titleView.backgroundColor =COLOR(242, 242, 242, 1);
        _titleView.userInteractionEnabled = YES;
        UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMoreText)];
        [_titleView addGestureRecognizer:forget2];
        [self.contentView addSubview:_titleView];
        
        float ImageW1=26*HEIGHT_SIZE;  float firstW1=5*HEIGHT_SIZE;
        _titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(firstW1, (viewW1-ImageW1)/2, ImageW1, ImageW1)];
        
        if ([_statusString isEqualToString:statusNum]) {
            _titleImage.image=IMAGE(@"yuan_1.png");
        }else{
            _titleImage.image=IMAGE(@"yuan_2.png");
        }
        
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
        
        _View3 = [[UIView alloc]initWithFrame:CGRectMake(firstW1+ImageW1/2, viewW1/2, 0.3*NOW_SIZE,38*HEIGHT_SIZE-viewW1/2)];
    if ([_statusString isEqualToString:statusNum]) {
    _View3.backgroundColor =COLOR(102, 102, 102, 1);
    }else{
    _View3.backgroundColor =COLOR(255, 204, 0, 1);
    }
    
        [self.contentView addSubview:_View3];
        
        self.dayFormatter = [[NSDateFormatter alloc] init];
        [self.dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dataString = [_dayFormatter stringFromDate:[NSDate date]];
        _goTimeString=dataString;
        
        NSArray *lableNameArray=[NSArray arrayWithObjects:@"所属区域:",@"申请时间:",@"要求到达时间:", @"预约上门时间:", @"详细地址:", @"备注:",@"添加备注:", nil];
        NSArray *lableNameArray2=[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",_allValueDic[@"groupName"]],[NSString stringWithFormat:@"%@",_allValueDic[@"applicationTime"]],[NSString stringWithFormat:@"%@",_allValueDic[@"doorTime"]], dataString, nil];
        
        float lable1W=10*NOW_SIZE;  float lableH=30*HEIGHT_SIZE;    float numH=35*NOW_SIZE;  float firstW=25*NOW_SIZE;
        for (int i=0; i<lableNameArray.count; i++) {
            
              if ((i==0)||(i==1)||(i==2)||(i==3)||(i==4)) {
                UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(firstW, 2*HEIGHT_SIZE+numH*i,lable1W, lableH)];
                lable1.textColor = COLOR(154, 154, 154, 1);
                if ([_statusString isEqualToString:statusNum]) {
                    if ((i==3)||(i==4)) {
                        lable1.textColor = [UIColor redColor];
                    }
                }
                
                lable1.text=@"*";
                lable1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
                [_scrollView addSubview:lable1];
            }
            
            
            NSString*lable2Name=lableNameArray[i];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
            CGSize size = [lable2Name boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(firstW+lable1W, 0+numH*i,size.width, lableH)];
            lable2.textColor = COLOR(154, 154, 154, 1);
            if ([_statusString isEqualToString:statusNum]) {
                if ((i==3)||(i==4)||(i==5)) {
                    lable2.textColor =COLOR(51, 51, 51, 1);
                }
            }
            
            lable2.text=lableNameArray[i];
            lable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
            if ([_statusString isEqualToString:statusNum]) {
                if (i!=6) {
                   [_scrollView addSubview:lable2];
                }
             
            }else{
                  if ((i==1)||(i==2)||(i==3)||(i==0)||(i==4)) {
                    [_scrollView addSubview:lable2];
                }
            }
            
            
            float ImageW2=15*HEIGHT_SIZE;
            if ((i==1)||(i==2)||(i==3)) {
                
                UIImageView *image00 = [[UIImageView alloc]initWithFrame:CGRectMake(firstW+lable1W+size.width, (lableH-ImageW2)/2+numH*i,ImageW2, ImageW2)];
                image00.image=IMAGE(@"workoader_date1.png");
                if ([_statusString isEqualToString:statusNum]) {
                    if (i==3) {
                        image00.image=IMAGE(@"workoader_date2.png");
                    }
                }
                
                [_scrollView addSubview:image00];
            }
            
            float lable3W=firstW+lable1W+size.width+ImageW2+5*NOW_SIZE;
            if ((i==0)||(i==1)||(i==2)||(i==3)) {
                UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(lable3W, 0+numH*i,SCREEN_Width-(1*firstW)-lable3W, lableH)];
                lable3.textColor = COLOR(154, 154, 154, 1);
                if ([_statusString isEqualToString:statusNum]) {
                    if (i==3) {
                        lable3.textColor =COLOR(51, 51, 51, 1);
                        lable3.userInteractionEnabled=YES;
                        UITapGestureRecognizer * forget3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickDate)];
                        [lable3 addGestureRecognizer:forget3];
                    }
                }
                
                lable3.tag=2000+i;
                lable3.text=lableNameArray2[i];
                lable3.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
                [_scrollView addSubview:lable3];
            }
            
            if ((i==0)||(i==1)||(i==2)||(i==3)||(i==4)) {
                UIView *View4 = [[UIView alloc]initWithFrame:CGRectMake(firstW, numH*(i+1)-1*HEIGHT_SIZE, SCREEN_Width-(2*firstW),1*HEIGHT_SIZE)];
                View4.backgroundColor = COLOR(222, 222, 222, 1);
                [_scrollView addSubview:View4];
            }
            
            
            
  
            
            float textfieldW=firstW+lable1W+size.width+5*NOW_SIZE;
            float textW1=SCREEN_Width-firstW-(SCREEN_Width-(2*firstW));
            float textW=SCREEN_Width-textfieldW-textW1;
            
            CGSize size1= [_remarkString boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
            if (lableH>(size1.height+10*HEIGHT_SIZE)) {
                remarkLabelH=lableH;
            }else{
                remarkLabelH=size1.height+10*HEIGHT_SIZE;
            }
            if (i==5) {
                if ([_statusString isEqualToString:statusNum]) {
                    UILabel *lableR = [[UILabel alloc] initWithFrame:CGRectMake(textfieldW, 0+numH*5+2*HEIGHT_SIZE,textW, remarkLabelH)];
                    lableR.textColor = COLOR(154, 154, 154, 1);
                    lableR.text=_remarkString;
                    lableR.numberOfLines=0;
                    lableR.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
                    [_scrollView addSubview:lableR];
                    
                    UIView* lineR = [[UIView alloc]initWithFrame:CGRectMake(firstW, numH*(5)+5*HEIGHT_SIZE-1*HEIGHT_SIZE+remarkLabelH, SCREEN_Width-(2*firstW),1*HEIGHT_SIZE)];
                    lineR.backgroundColor = COLOR(222, 222, 222, 1);
                    [_scrollView addSubview:lineR];
                }
  
            }
    
            
            if (i==6) {
                UILabel *lableR2= [[UILabel alloc]initWithFrame:CGRectMake(firstW+lable1W,5*HEIGHT_SIZE+numH*5+remarkLabelH,size.width, lableH)];
                lableR2.textColor = COLOR(51, 51, 51, 1);
                lableR2.text=lableNameArray[i];
                lableR2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
                if ([_statusString isEqualToString:statusNum]) {
                    [_scrollView addSubview:lableR2];
                }
                
                if ([_statusString isEqualToString:statusNum]) {
                    if (i==6) {
                        _textfield2 = [[UITextView alloc] initWithFrame:CGRectMake(textfieldW,5*HEIGHT_SIZE+numH*5+remarkLabelH,textW, lableH)];
                        _textfield2.textColor=COLOR(51, 51, 51, 1);
                        _textfield2.tintColor = COLOR(51, 51, 51, 1);
                        _textfield2.delegate=self;
                        _textfield2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
                        [_scrollView addSubview:_textfield2];
                    }
                    
               
                        _View5 = [[UIView alloc]initWithFrame:CGRectMake(firstW, 5*HEIGHT_SIZE+numH*5+remarkLabelH+lableH-1*HEIGHT_SIZE, SCREEN_Width-(2*firstW),1*HEIGHT_SIZE)];
                        _View5.backgroundColor = COLOR(222, 222, 222, 1);
                        [_scrollView addSubview:_View5];
                 
                }
                
        
            }
  

            
            
            if (i==4) {
                _textfield = [[UITextField alloc] initWithFrame:CGRectMake(textfieldW, 0+numH*i,textW, lableH)];

                [_textfield setValue:COLOR(154, 154, 154, 1) forKeyPath:@"_placeholderLabel.textColor"];
                [_textfield setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
                _textfield.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
                [_scrollView addSubview:_textfield];
                
                if ([_statusString isEqualToString:statusNum]) {
                    _textfield.textColor = COLOR(51, 51, 51, 1);
                    _textfield.tintColor = COLOR(51, 51, 51, 1);
                    _textfield.placeholder = @"请输入客户地址";
                }else{
                    _textfield.textColor =  COLOR(154, 154, 154, 1);
                    _textfield.tintColor = COLOR(154, 154, 154, 1);
                    _textfield.userInteractionEnabled=NO;
                }
            }
            
            
            // CGSize size1= [textfieldString boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
 
            
            
        }
        
        
        _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
        _goBut.frame=CGRectMake(60*NOW_SIZE,numH*5+95*HEIGHT_SIZE+remarkLabelH, 200*NOW_SIZE, 40*HEIGHT_SIZE);
        [_goBut setBackgroundImage:IMAGE(@"workorder_button_icon_nor.png") forState:UIControlStateNormal];
        [_goBut setBackgroundImage:IMAGE(@"workorder_button_icon_click.png") forState:UIControlStateHighlighted];
        [_goBut setTitle:@"接收" forState:UIControlStateNormal];
        _goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
        [_goBut addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
        
        if ([_statusString isEqualToString:statusNum]) {
            [_scrollView addSubview:_goBut];
        }
        
        
        
        
        
    

}


-(void)finishSet{
    
     //_picArray=[NSMutableArray arrayWithObjects:@"",@"",@"", @"", @"", @"",@"",@"",@"",@"",nil];
    
    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
  
//    NSMutableArray *picAll=[NSMutableArray arrayWithArray:_picArray];
//    [picAll removeObject:@"del"];
//    for (int i=0; i<picAll.count; i++) {
//         NSString *imageName=[NSString stringWithFormat:@"image%d",i+1];
//        if ([picAll[i] isEqualToString:@""]) {
//                  [dataImageDict setObject:@"" forKey:imageName];
//        }else{
//            NSData *imageData = UIImageJPEGRepresentation(picAll[i], 0.5);
//            [dataImageDict setObject:imageData forKey:imageName];
//        }
//    
//    }
    
    NSMutableDictionary *allDict=[NSMutableDictionary dictionary];
    [allDict setObject:_orderID forKey:@"orderId"];
    [allDict setObject:_statusString forKey:@"status"];
    [allDict setObject:_goTimeString forKey:@"appointment"];
       [allDict setObject:_textfield.text forKey:@"address"];
    
    NSString*remarkAll=[NSString stringWithFormat:@"%@%@",_remarkString,_textfield2.text];
       [allDict setObject:remarkAll forKey:@"remarks"];
    
    [self showProgressView];
   [BaseRequest uplodImageWithMethod:OSS_HEAD_URL paramars:allDict paramarsSite:@"/api/v1/workOrder/work/perfect_info" dataImageDict:dataImageDict sucessBlock:^(id content) {
        [self hideProgressView];
        
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v1/workOrder/work/perfect_info: %@", content1);
        
        if (content1) {
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
            if ([firstDic[@"result"] intValue]==1) {
                
              [self showToastViewWithTitle:@"接收成功"];
         _titleLabel.text=@"已接收";
                  _titleImage.image=IMAGE(@"yuan_2.png");
                
                [self showMoreText];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"regetNet" object:nil];
                
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
    [hud hide:YES afterDelay:3];
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
    
        float W1=_View5.frame.size.width;
        float x1=_View5.frame.origin.x;
   
        
     _textfield2.frame=CGRectMake(x,y , W, height);
    
         _View5.frame = CGRectMake(x1, y+height,W1,1*HEIGHT_SIZE);
      
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

    
    _titleLabel.text = self.model.title;
    
         NSArray *lableNameArray2=[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",_allValueDic[@"groupName"]],[NSString stringWithFormat:@"%@",_allValueDic[@"applicationTime"]],[NSString stringWithFormat:@"%@",_allValueDic[@"doorTime"]], nil];
    
    UILabel *L1=[_scrollView viewWithTag:2000];
    L1.text=lableNameArray2[0];
    
    UILabel *L2=[_scrollView viewWithTag:2001];
    L2.text=lableNameArray2[1];
    
    UILabel *L3=[_scrollView viewWithTag:2002];
    L3.text=lableNameArray2[2];
    
    UILabel *L4=[_scrollView viewWithTag:2003];
   

    if ([_statusString isEqualToString:statusNum]) {
        _titleImage.image=IMAGE(@"yuan_1.png");
       // _textfield2.text=[NSString stringWithFormat:@"%@",_allValueDic[@"remarks"]];
    }else{
        _titleImage.image=IMAGE(@"yuan_2.png");
    }
    
    if (![_statusString isEqualToString:statusNum]) {
     L4.text=[NSString stringWithFormat:@"%@",_allValueDic[@"appointment"]];
        _textfield.text=[NSString stringWithFormat:@"%@",_allValueDic[@"address"]];
    }
    
       if (self.model.isShowMoreText){ // 展开状态
        // 计算文本高度
           float y=_scrollView.frame.origin.y;
           float buttonY=_goBut.frame.origin.y;
     _scrollView.frame=CGRectMake(0, y, SCREEN_Width, buttonY+100*HEIGHT_SIZE);
           
 //           float H=SCREEN_Height-90*HEIGHT_SIZE-(38*HEIGHT_SIZE*2)-70*HEIGHT_SIZE;
           float Vx=_View3.frame.origin.x; float Vy=_View3.frame.origin.y;
                _View3.frame = CGRectMake(Vx,Vy, 0.3*NOW_SIZE,buttonY+100*HEIGHT_SIZE);
           
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
+ (CGFloat)moreHeight:(CGFloat) navigationH status:(NSString*)status remarkH:(CGFloat) remarkH{
    
    float H=SCREEN_Height-90*HEIGHT_SIZE-(38*HEIGHT_SIZE*2)-navigationH+remarkH+40*HEIGHT_SIZE;
    if (![status isEqualToString:@"2"]) {
        H=250*HEIGHT_SIZE;
    }

    
    return H;
    
}



-(void)pickDate{
    float buttonH=420*HEIGHT_SIZE;
    
    _date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, SCREEN_Height-buttonH, SCREEN_Width, 200*HEIGHT_SIZE)];
   _date.backgroundColor=COLOR(242, 242, 242, 1);
    _date.datePickerMode=UIDatePickerModeDateAndTime;
    [self.contentView addSubview:_date];
    
    if (self.toolBar) {
        [UIView animateWithDuration:0.3f animations:^{
            self.toolBar.alpha = 1;
            self.toolBar.frame = CGRectMake(0, SCREEN_Height-buttonH-40*HEIGHT_SIZE, SCREEN_Width, 40*HEIGHT_SIZE);
            [self.contentView addSubview:_toolBar];
        }];
    } else {
        self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_Height-buttonH-40*HEIGHT_SIZE, SCREEN_Width, 40*HEIGHT_SIZE)];
        self.toolBar.barStyle = UIBarStyleDefault;
        self.toolBar.barTintColor = COLOR(17, 183, 243, 1);
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
    
    UILabel *L2=[_scrollView viewWithTag:2003];
    L2.text=_goTimeString;
    
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}



@end
