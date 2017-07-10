//
//  orderCellTwo.m
//  ShinePhone
//
//  Created by sky on 2017/6/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "orderCellTwo.h"
#import "Model.h"
#import "MBProgressHUD.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "SNLocationManager.h"

static NSString *statusNum = @"3";

@implementation orderCellTwo

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return self;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_textfield resignFirstResponder];
    [_textfield2 resignFirstResponder];
}

-(void)initUI{
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.contentView addGestureRecognizer:tapGestureRecognizer];
    
    //   self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    float viewW1=34*HEIGHT_SIZE;
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width,viewW1)];
    _titleView.backgroundColor =COLOR(242, 242, 242, 1);
    _titleView.userInteractionEnabled = YES;
    UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMoreText)];
    [_titleView addGestureRecognizer:forget2];
    [self.contentView addSubview:_titleView];
    
    float ImageW1=26*HEIGHT_SIZE;  float firstW1=5*HEIGHT_SIZE;
    _titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(firstW1, (viewW1-ImageW1)/2, ImageW1, ImageW1)];
    
    if ([_statusString isEqualToString:statusNum] || [_statusString isEqualToString:@"2"]) {
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
    
    _View3 = [[UIView alloc]initWithFrame:CGRectMake(firstW1+ImageW1/2, 0, 0.3*NOW_SIZE,38*HEIGHT_SIZE)];

    if ([_statusString isEqualToString:@"4"]) {
         _View3.backgroundColor =COLOR(255, 204, 0, 1);
    }else{
      _View3.backgroundColor =COLOR(102, 102, 102, 1);
    }
    
    [self.contentView addSubview:_View3];
    
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dataString = [_dayFormatter stringFromDate:[NSDate date]];
    _goTimeString=dataString;
    
    NSArray *lableNameArray=[NSArray arrayWithObjects:@"定位:",@"工单完成时间:",@"完成状态:",@"设备类型:", @"设备序列号:", @"上传照片:",@"报告单", nil];
    NSArray *lableNameArray2=[NSArray arrayWithObjects:@"",@"",@"", @"", @"", nil];
    
    float lable1W=10*NOW_SIZE;  float lableH=30*HEIGHT_SIZE;    float numH=35*NOW_SIZE;  float firstW=25*NOW_SIZE;
    for (int i=0; i<lableNameArray.count; i++) {
        
     
            UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(firstW, 2*HEIGHT_SIZE+numH*i,lable1W, lableH)];
            lable1.textColor = COLOR(154, 154, 154, 1);
        lable1.text=@"*";
        lable1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
            if ([_statusString isEqualToString:statusNum]) {
                if ((i==0)||(i==1)||(i==2)||(i==6)) {
                    lable1.textColor = [UIColor redColor];
                              [_scrollView addSubview:lable1];
                }
            }

        float lineW=SCREEN_Width-(2*firstW);  float image2W=6*NOW_SIZE;
        
        if ((i==3)||(i==1)||(i==2)) {
            UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(firstW+lineW-image2W, 8*HEIGHT_SIZE+numH*i, image2W,14*HEIGHT_SIZE )];
            if ([_statusString isEqualToString:statusNum]) {
                 image2.userInteractionEnabled=YES;
            }
       
            image2.image=IMAGE(@"select_icon.png");
            UITapGestureRecognizer *labelTap1;
            image2.tag=4000+i;
            if (i==1) {
                     labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickDate)];
            }else if (i==2){
             labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInfo:)];
            }else if (i==3){
                 labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInfo:)];
            }
       
            [image2 addGestureRecognizer:labelTap1];
            [_scrollView addSubview:image2];
        }
        

  
        
        
        NSString*lable2Name=lableNameArray[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size = [lable2Name boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(firstW+lable1W, 0+numH*i,size.width, lableH)];
       
        if ([_statusString isEqualToString:statusNum]) {
                lable2.textColor =COLOR(51, 51, 51, 1);
        }else{
         lable2.textColor = COLOR(154, 154, 154, 1);
        }
      
        lable2.text=lableNameArray[i];
        lable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        if (i==6) {
               lable2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        }
        if ([_statusString isEqualToString:statusNum]) {
            [_scrollView addSubview:lable2];
        }else{
            if ((i==0)||(i==1)||(i==2)||(i==3)||(i==4)) {
                [_scrollView addSubview:lable2];
            }
       
        }
        
        

        
        float lable3W=firstW+lable1W+size.width+5*NOW_SIZE;
        
        if (i==0) {
    
            UILabel *lable4 = [[UILabel alloc]initWithFrame:CGRectMake(lable3W, 0+numH*i,SCREEN_Width-(1*firstW)-lable3W, lableH)];
            lable4.textColor =COLOR(51, 51, 51, 1);
            lable4.textAlignment=NSTextAlignmentRight;
            lable4.tag=2010;
            if ([_statusString isEqualToString:statusNum]) {
                UITapGestureRecognizer * forget3;
                lable4.userInteractionEnabled=YES;
                forget3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fetchLocation)];
                [lable4 addGestureRecognizer:forget3];

            }
            NSString *lable4Name=@"点击获取";
             CGSize size1 = [lable4Name boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            lable4.frame=CGRectMake(SCREEN_Width-firstW-size1.width, 0+numH*i, size1.width, lableH);
            lable4.text=lable4Name;
            lable4.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
            if ([_statusString isEqualToString:statusNum]) {
               [_scrollView addSubview:lable4];
            }
         
            
        }
        
        if ((i==0)||(i==1)||(i==2)||(i==3)) {
            UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(lable3W, 0+numH*i,SCREEN_Width-(1*firstW)-lable3W, lableH)];
         
            if ([_statusString isEqualToString:statusNum]) {
                    lable3.textColor =COLOR(51, 51, 51, 1);
                if ((i==1)||(i==2)||(i==3)) {
                    UITapGestureRecognizer * forget3;
                     lable3.userInteractionEnabled=YES;
                    if (i==1) {
                        forget3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickDate)];
                    }else if (i==2){
                        forget3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInfo:)];
                    }else if (i==3){
                        forget3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInfo:)];
                    }
                    [lable3 addGestureRecognizer:forget3];
  
                }
            }else{
             lable3.textColor = COLOR(154, 154, 154, 1);
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
        if (i==4) {
            _textfield = [[UITextField alloc] initWithFrame:CGRectMake(textfieldW, 0+numH*i,textW, lableH)];
            
            [_textfield setValue:COLOR(154, 154, 154, 1) forKeyPath:@"_placeholderLabel.textColor"];
            [_textfield setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
            _textfield.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
            [_scrollView addSubview:_textfield];
            
            if ([_statusString isEqualToString:statusNum]) {
                _textfield.textColor = COLOR(51, 51, 51, 1);
                _textfield.tintColor = COLOR(51, 51, 51, 1);
                _textfield.placeholder = @"请输入设备序列号";
            }else{
                _textfield.textColor =  COLOR(154, 154, 154, 1);
                _textfield.tintColor = COLOR(154, 154, 154, 1);
                _textfield.userInteractionEnabled=NO;
            }
        }
        
        
    }
    
    float allH=40*HEIGHT_SIZE;
    UIView *VI = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width-firstW-allH, numH*6-5*HEIGHT_SIZE, allH,allH )];
    VI.backgroundColor =[UIColor clearColor];
    VI.userInteractionEnabled = YES;
    VI.tag=5000;
    UITapGestureRecognizer * forget1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(controlPhoto:)];
    [VI addGestureRecognizer:forget1];
    if ([_statusString isEqualToString:statusNum]) {
        [_scrollView addSubview:VI];
    }

    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 20*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    image4.userInteractionEnabled = YES;
    image4.image = IMAGE(@"pic_icon.png");
    [VI addSubview:image4];
    
    

    
    float imageH=40*HEIGHT_SIZE; float imageH2=40*HEIGHT_SIZE;
     float ViewH=imageH+10*HEIGHT_SIZE;
    if (!_imageViewAll) {
        _imageViewAll = [[UIView alloc]initWithFrame:CGRectMake(firstW, numH*7+40*HEIGHT_SIZE-imageH2, SCREEN_Width-(2*firstW)+10*NOW_SIZE,ViewH)];
        _imageViewAll.backgroundColor =COLOR(242, 242, 242, 1);
        _imageViewAll.userInteractionEnabled = YES;
        if ([_statusString isEqualToString:statusNum]) {
          [_scrollView addSubview:_imageViewAll];
        }
      
    }
    
    
    UILabel *lable6= [[UILabel alloc]initWithFrame:CGRectMake(firstW+lable1W, numH*7+60*HEIGHT_SIZE,100*NOW_SIZE, lableH)];
    if ([_statusString isEqualToString:statusNum]) {
        lable6.textColor =COLOR(51, 51, 51, 1);
    }else{
        lable6.textColor = COLOR(154, 154, 154, 1);
    }
    lable6.text=@"现场图片";
    lable6.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    if ([_statusString isEqualToString:statusNum]) {
        [_scrollView addSubview:lable6];
    }
    
    
    UIView *V2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width-firstW-allH, numH*7+60*HEIGHT_SIZE-5*HEIGHT_SIZE, allH,allH )];
    V2.backgroundColor =[UIColor clearColor];
    V2.userInteractionEnabled = YES;
    V2.tag=5001;
    UITapGestureRecognizer * forget3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(controlPhoto:)];
    [V2 addGestureRecognizer:forget3];
    if ([_statusString isEqualToString:statusNum]) {
       [_scrollView addSubview:V2];
    }
 
    
    UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 20*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    image5.userInteractionEnabled = YES;
    image5.image = IMAGE(@"pic_icon.png");
    [V2 addSubview:image5];
    
    if (!_imageViewAll2) {
        _imageViewAll2 = [[UIView alloc]initWithFrame:CGRectMake(firstW, numH*8+100*HEIGHT_SIZE-imageH2, SCREEN_Width-(2*firstW)+10*NOW_SIZE,ViewH)];
        _imageViewAll2.backgroundColor =COLOR(242, 242, 242, 1);
        _imageViewAll2.userInteractionEnabled = YES;
        if ([_statusString isEqualToString:statusNum]) {
          [_scrollView addSubview:_imageViewAll2];
        }
      
    }
    
    NSString *lable7Name=@"备注:";
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
  CGSize size3 = [lable7Name boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    UILabel *lable7= [[UILabel alloc]initWithFrame:CGRectMake(firstW+lable1W, numH*8+120*HEIGHT_SIZE,size3.width, lableH)];
        lable7.textColor =COLOR(51, 51, 51, 1);
    lable7.text=lable7Name;
    lable7.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    if ([_statusString isEqualToString:statusNum]) {
        [_scrollView addSubview:lable7];
    }
    
    CGSize size2= [_remarkString boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW)-size3.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    float remarkLabelH = 0.0;
    if (lableH>(size2.height+10*HEIGHT_SIZE)) {
        remarkLabelH=lableH;
    }else{
        remarkLabelH=size2.height+10*HEIGHT_SIZE;
    }

    if ([_statusString isEqualToString:statusNum]) {
        UILabel *lableR = [[UILabel alloc] initWithFrame:CGRectMake(firstW+lable1W+size3.width, numH*8+120*HEIGHT_SIZE+2*HEIGHT_SIZE, SCREEN_Width-(2*firstW)-lable1W-size3.width,remarkLabelH)];
        lableR.textColor = COLOR(154, 154, 154, 1);
        lableR.text=_remarkString;
        lableR.numberOfLines=0;
        lableR.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:lableR];
        
        UIView* lineR = [[UIView alloc]initWithFrame:CGRectMake(firstW,  numH*8+120*HEIGHT_SIZE+5*HEIGHT_SIZE-1*HEIGHT_SIZE+remarkLabelH, SCREEN_Width-(2*firstW),1*HEIGHT_SIZE)];
        lineR.backgroundColor = COLOR(222, 222, 222, 1);
        [_scrollView addSubview:lineR];
    }
    
    


   
    
    if ([_statusString isEqualToString:statusNum]) {
     
        NSString *lable8Name=@"添加备注:";
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
        CGSize size3 = [lable8Name boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        UILabel *lable8= [[UILabel alloc]initWithFrame:CGRectMake(firstW+lable1W, numH*8+125*HEIGHT_SIZE+remarkLabelH,size3.width, lableH)];
        lable8.textColor =COLOR(51, 51, 51, 1);
        lable8.text=lable8Name;
        lable8.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        if ([_statusString isEqualToString:statusNum]) {
            [_scrollView addSubview:lable8];
        }
        
            _textfield2 = [[UITextView alloc] initWithFrame:CGRectMake(firstW+lable1W+size3.width, numH*8+125*HEIGHT_SIZE+remarkLabelH, SCREEN_Width-(2*firstW)-lable1W-size3.width,lableH)];
            _textfield2.textColor=COLOR(51, 51, 51, 1);
            _textfield2.tintColor = COLOR(51, 51, 51, 1);
            _textfield2.delegate=self;
            _textfield2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
            [_scrollView addSubview:_textfield2];
        
        _View5 = [[UIView alloc]initWithFrame:CGRectMake(firstW, numH*8+125*HEIGHT_SIZE+lableH+remarkLabelH, SCREEN_Width-(2*firstW),1*HEIGHT_SIZE)];
        _View5.backgroundColor = COLOR(222, 222, 222, 1);
        if ([_statusString isEqualToString:statusNum]) {
            [_scrollView addSubview:_View5];
        }
        
            }
    
    
   _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(60*NOW_SIZE,_textfield2.frame.origin.y+100*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [_goBut setBackgroundImage:IMAGE(@"workorder_button_icon_nor.png") forState:UIControlStateNormal];
    [_goBut setBackgroundImage:IMAGE(@"workorder_button_icon_click.png") forState:UIControlStateHighlighted];
    [_goBut setTitle:@"完成" forState:UIControlStateNormal];
    _goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    [_goBut addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
    
    if ([_statusString isEqualToString:statusNum]) {
        [_scrollView addSubview:_goBut];
    }
    
     _picArray=[NSMutableArray new];
        _picArray2=[NSMutableArray new];
    
}


-(void)controlPhoto:(UITapGestureRecognizer*)Tap{
    if (Tap.view.tag==5000) {
        _picGetType=@"1";
        if (_image1 &&_image2 &&_image3&&_image4&&_image5) {
            [self showToastViewWithTitle:@"最多上传5张图片"];
            return;
        }
    }
    if (Tap.view.tag==5001) {
        _picGetType=@"2";
        if (_image6 &&_image7 &&_image8&&_image9&&_image10) {
            [self showToastViewWithTitle:@"最多上传5张图片"];
            return;
        }
    }

        
     
        
      UIViewController *Controller = (UIViewController *)[self findViewController:self.contentView];
        
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                                  message: nil
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        //添加Button
        [alertController addAction: [UIAlertAction actionWithTitle: root_paiZhao style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //处理点击拍照
            self.cameraImagePicker = [[UIImagePickerController alloc] init];
            self.cameraImagePicker.allowsEditing = YES;
            self.cameraImagePicker.delegate = self;
            self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
      [Controller presentViewController:_cameraImagePicker animated:YES completion:nil];
            
        }]];
        [alertController addAction: [UIAlertAction actionWithTitle: root_xiangkuang_xuanQu style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            //处理点击从相册选取
            self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
            self.photoLibraryImagePicker.allowsEditing = YES;
            self.photoLibraryImagePicker.delegate = self;
            self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     [Controller presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
            
            
        }]];
        [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
        

        [Controller presentViewController:alertController animated:YES completion:nil];
        
  
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
    float size5=60*NOW_SIZE;
    
    float imageH=40*HEIGHT_SIZE; float imageX=0*NOW_SIZE; float ButtonImage=16*HEIGHT_SIZE;
 
    if ([_picGetType isEqualToString:@"1"]) {
        if(!_image1){
            [_picArray insertObject:image atIndex:0];
            _image1=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*0, 10*HEIGHT_SIZE, imageH,imageH )];
            _image1.userInteractionEnabled = YES;
            _image1.image = image;
            _image1.tag=0+3000;
            [_imageViewAll addSubview:_image1];
            
            _button1= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*0+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
            [_button1 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
            _button1.tag=2000+0;
            [_button1 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
            [_imageViewAll addSubview:_button1];
            
        }else if(_image1 && !_image2){
            [_picArray insertObject:image atIndex:1];
            _image2=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*1, 10*HEIGHT_SIZE, imageH,imageH )];
            _image2.userInteractionEnabled = YES;
            _image2.image = image;
            _image2.tag=1+3000;
            [_imageViewAll addSubview:_image2];
            
            _button2= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*1+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
            [_button2 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
            _button2.tag=2000+1;
            // _button2.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
            [_button2 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
            [_imageViewAll addSubview:_button2];
            
        }else if(_image1 && _image2 && !_image3){
            [_picArray insertObject:image atIndex:2];
            _image3=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*2, 10*HEIGHT_SIZE, imageH,imageH )];
            _image3.userInteractionEnabled = YES;
            _image3.image = image;
            _image3.tag=2+3000;
            [_imageViewAll addSubview:_image3];
            
            _button3= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*2+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
            [_button3 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
            _button3.tag=2000+2;
            //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
            [_button3 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
            [_imageViewAll addSubview:_button3];
        }else if(_image1 && _image2 && _image3&& !_image4){
            [_picArray insertObject:image atIndex:3];
            _image4=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*3, 10*HEIGHT_SIZE, imageH,imageH )];
            _image4.userInteractionEnabled = YES;
            _image4.image = image;
            _image4.tag=3+3000;
            [_imageViewAll addSubview:_image4];
            
            _button4= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*3+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
            [_button4 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
            _button4.tag=2000+3;
            //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
            [_button4 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
            [_imageViewAll addSubview:_button4];
        }else if(_image1 && _image2 && _image3&& _image4&& !_image5){
            [_picArray insertObject:image atIndex:4];
            _image5=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*4, 10*HEIGHT_SIZE, imageH,imageH )];
            _image5.userInteractionEnabled = YES;
            _image5.image = image;
            _image5.tag=4+3000;
            [_imageViewAll addSubview:_image5];
            
            _button5= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*4+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
            [_button5 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
            _button5.tag=2000+4;
            //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
            [_button5 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
            [_imageViewAll addSubview:_button5];
        }
        
    }
    
    if ([_picGetType isEqualToString:@"2"]) {
        if(!_image6){
            [_picArray2 insertObject:image atIndex:0];
            _image6=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*0, 10*HEIGHT_SIZE, imageH,imageH )];
            _image6.userInteractionEnabled = YES;
            _image6.image = image;
            _image6.tag=0+7000;
            [_imageViewAll2 addSubview:_image6];
            
            _button6= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*0+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
            [_button6 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
            _button6.tag=8000+0;
            [_button6 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
            [_imageViewAll2 addSubview:_button6];
            
        }else if(_image6 && !_image7){
            [_picArray2 insertObject:image atIndex:1];
            _image7=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*1, 10*HEIGHT_SIZE, imageH,imageH )];
            _image7.userInteractionEnabled = YES;
            _image7.image = image;
            _image7.tag=1+7000;
            [_imageViewAll2 addSubview:_image7];
            
            _button7= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*1+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
            [_button7 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
            _button7.tag=8000+1;
            // _button2.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
            [_button7 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
            [_imageViewAll2 addSubview:_button7];
            
        }else if(_image6 && _image7 && !_image8){
            [_picArray2 insertObject:image atIndex:2];
            _image8=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*2, 10*HEIGHT_SIZE, imageH,imageH )];
            _image8.userInteractionEnabled = YES;
            _image8.image = image;
            _image8.tag=2+7000;
            [_imageViewAll2 addSubview:_image8];
            
            _button8= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*2+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
            [_button8 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
            _button8.tag=8000+2;
            //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
            [_button8 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
            [_imageViewAll2 addSubview:_button8];
        }else if(_image6 && _image7 && _image8&& !_image9){
            [_picArray2 insertObject:image atIndex:3];
            _image9=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*3, 10*HEIGHT_SIZE, imageH,imageH )];
            _image9.userInteractionEnabled = YES;
            _image9.image = image;
            _image9.tag=3+7000;
            [_imageViewAll2 addSubview:_image9];
            
            _button9= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*3+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
            [_button9 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
            _button9.tag=8000+3;
            //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
            [_button9 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
            [_imageViewAll2 addSubview:_button9];
        }else if(_image6 && _image7 && _image8&& _image9&& !_image10){
            [_picArray2 insertObject:image atIndex:4];
            _image10=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*4, 10*HEIGHT_SIZE, imageH,imageH )];
            _image10.userInteractionEnabled = YES;
            _image10.image = image;
            _image10.tag=4+7000;
            [_imageViewAll2 addSubview:_image10];
            
            _button10= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*4+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
            [_button10 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
            _button10.tag=8000+4;
            //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
            [_button10 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
            [_imageViewAll2 addSubview:_button10];
        }
        
    }
  
    
}



-(void)delPicture:(UIButton*)del{
    UIButton  *a=del;
    NSString *replaceName=@"del";
    

    
    int K = 0;
    if ([_picGetType isEqualToString:@"1"]) {
            [_picArray replaceObjectAtIndex:a.tag-2000 withObject:replaceName];
         K=(int)(a.tag-2000);
    }
    if ([_picGetType isEqualToString:@"2"]) {
               [_picArray2 replaceObjectAtIndex:a.tag-7000 withObject:replaceName];
        K=(int)(a.tag-8000);
    }
        [self removePic:K];

  
}

-(void)removePic:(int)Num{
    
    NSArray *picArray;  NSArray *buttonArray;
    if ([_picGetType isEqualToString:@"1"]) {
        picArray=[NSArray arrayWithObjects: _image1,_image2,_image3,_image4,_image5,nil];
         buttonArray=[NSArray arrayWithObjects:  _button1,_button2,_button3,_button4,_button5,nil];
    }
    if ([_picGetType isEqualToString:@"2"]) {
        picArray=[NSArray arrayWithObjects: _image6,_image7,_image8,_image9,_image10,nil];
        buttonArray=[NSArray arrayWithObjects:  _button6,_button7,_button8,_button9,_button10,nil];
    }

    UIImageView *image=picArray[Num];
    UIButton *button=buttonArray[Num];
    [image removeFromSuperview];
    [button removeFromSuperview];
    
    if ([_picGetType isEqualToString:@"1"]) {
        if (Num==0) {
            _image1=nil;
            _button1=nil;
        }else if (Num==1) {
            _image2=nil;
            _button2=nil;
        }else if (Num==2) {
            _image3=nil;
            _button3=nil;
        }else if (Num==3) {
            _image4=nil;
            _button4=nil;
        }else if (Num==4) {
            _image5=nil;
            _button5=nil;
        }
    }
    if ([_picGetType isEqualToString:@"2"]) {
        if (Num==0) {
            _image6=nil;
            _button6=nil;
        }else if (Num==1) {
            _image7=nil;
            _button7=nil;
        }else if (Num==2) {
            _image8=nil;
            _button8=nil;
        }else if (Num==3) {
            _image9=nil;
            _button9=nil;
        }else if (Num==4) {
            _image10=nil;
            _button10=nil;
        }
    }
    
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

-(void)fetchLocation{
    [[SNLocationManager shareLocationManager] startUpdatingLocationWithSuccess:^(CLLocation *location, CLPlacemark *placemark) {
        _longitude=[NSString stringWithFormat:@"%.2f", location.coordinate.longitude];
        _latitude=[NSString stringWithFormat:@"%.2f", location.coordinate.latitude];
        _city=placemark.locality;
        _countryGet=placemark.country;
        
        NSString *lableText=[NSString stringWithFormat:@"%@(%@,%@)",_city,_longitude,_latitude];

        UILabel *lable2=[_scrollView viewWithTag:2010];
        float X= lable2.frame.origin.x;

        UILabel *lable=[_scrollView viewWithTag:2000];
        lable.text=lableText;
        lable.adjustsFontSizeToFitWidth=YES;
            float X1= lable.frame.origin.x; float Y1= lable.frame.origin.y;float H= lable.frame.size.height;
        float w=X-X1;
        lable.frame=CGRectMake(X1, Y1, w, H);
        
    } andFailure:^(CLRegion *region, NSError *error) {
        
    }];
    
}


-(void)tapInfo:(UITapGestureRecognizer*)Tap{
    NSInteger Num=Tap.view.tag;
    NSArray *NameArray; NSString *title; NSString *type;
    if ((Num==4002)||(Num==2002)) {
       NameArray=[NSArray arrayWithObjects:@"待观察",@"已完成", nil];
      title=@"选择完成状态";
        type=@"1";
    }
    if ((Num==4003)||(Num==2003)) {
        NameArray=[NSArray arrayWithObjects:@"逆变器",@"储能机",@"采集器",  nil];
        title=@"选择设备类型";
        type=@"2";
    }
    [ZJBLStoreShopTypeAlert showWithTitle:title titles:NameArray selectIndex:^(NSInteger selectIndex) {
        if ([type isEqualToString:@"1"]) {
            _orderType=[NSString stringWithFormat:@"%ld",selectIndex+1];
        }
        if ([type isEqualToString:@"2"]) {
            _deviceType=[NSString stringWithFormat:@"%ld",selectIndex+1];
        }
        
    }selectValue:^(NSString *selectValue){
        if ([type isEqualToString:@"1"]) {
            UILabel *lable=[_scrollView viewWithTag:2002];
            lable.text=selectValue;
        }
        if ([type isEqualToString:@"2"]) {
            UILabel *lable=[_scrollView viewWithTag:2003];
            lable.text=selectValue;
        }
        
    } showCloseButton:YES ];
    
}



-(void)finishSet{
    
    NSString *locationString=((UILabel*)[_scrollView viewWithTag:2000]).text;
    NSString *timeString=((UILabel*)[_scrollView viewWithTag:2001]).text;
    
     NSString *deviceSnString=[_textfield text];
    

    
    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
    
    NSMutableArray *picAll=[NSMutableArray arrayWithArray:_picArray];
    [picAll removeObject:@"del"];
    
    for (int i=0; i<picAll.count; i++) {
        NSString *imageName=[NSString stringWithFormat:@"image%d",i+1];
        NSData *imageData = UIImageJPEGRepresentation(picAll[i], 0.5);
        [dataImageDict setObject:imageData forKey:imageName];
    }
    

    
    NSMutableArray *picAll2=[NSMutableArray arrayWithArray:_picArray2];
    [picAll2 removeObject:@"del"];
    
    for (int i=0; i<picAll2.count; i++) {
        NSString *imageName=[NSString stringWithFormat:@"image%d",i+6];
        NSData *imageData = UIImageJPEGRepresentation(picAll2[i], 0.5);
        [dataImageDict setObject:imageData forKey:imageName];
    }
    
    if (_picArray.count==0) {
        [self showToastViewWithTitle:@"请上传报告单图片"];
        return;
    }
    
    if ([locationString isEqual:@""]) {
        [self showToastViewWithTitle:@"请点击获取位置信息"];
        return;
    }
    if ([timeString isEqual:@""]) {
        [self showToastViewWithTitle:@"请选择工单完成时间"];
        return;
    }
    if ([_orderType isEqual:@""] || (!_orderType)) {
        [self showToastViewWithTitle:@"请选择工单完成状态"];
        return;
    }
    
    if (!_goTimeString) {
        [self showToastViewWithTitle:@"请选择预约上门时间"];
        return;
    }
    
    
    
    NSMutableDictionary *allDict=[NSMutableDictionary dictionary];
    [allDict setObject:_orderID forKey:@"orderId"];
    [allDict setObject:_statusString forKey:@"status"];
    [allDict setObject:locationString forKey:@"location"];
    [allDict setObject:timeString forKey:@"completeTime"];
    [allDict setObject:_orderType forKey:@"completeType"];
        [allDict setObject:_deviceType forKey:@"deviceType"];
        [allDict setObject:deviceSnString forKey:@"deviseSerialNumber"];
    
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
        
        _View5.frame = CGRectMake(x1, y+height,W1,1*HEIGHT_SIZE);
        
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
    _deviceType=@"";
    
    if (!_scrollView) { 
        [self initUI];
    }
    
    
    _titleLabel.text = self.model.title;
    
    NSArray *lableNameArray2=[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",_allValueDic[@"location"]],[NSString stringWithFormat:@"%@",_allValueDic[@"completeTime"]],[NSString stringWithFormat:@"%@",_allValueDic[@"completeState"]], nil];
    
    UILabel *L1=[_scrollView viewWithTag:2000];
    L1.text=lableNameArray2[0];
    
    UILabel *L2=[_scrollView viewWithTag:2001];
    L2.text=lableNameArray2[1];
    
    UILabel *L3=[_scrollView viewWithTag:2002];
    if ([_allValueDic[@"completeState"] intValue]==1) {
         L3.text=@"待观察";
    }else if ([_allValueDic[@"completeState"] intValue]==2) {
          L3.text=@"已完成";
    }

    
    UILabel *L4=[_scrollView viewWithTag:2003];
    if ([_allValueDic[@"deviceType"] intValue]==1) {
         L4.text=@"逆变器";
    }else if ([_allValueDic[@"deviceType"] intValue]==2) {
        L4.text=@"储能机";
    }else if ([_allValueDic[@"deviceType"] intValue]==3) {
        L4.text=@"采集器";
    }
    
    
    
    if ([_statusString isEqualToString:statusNum]) {
    //    _textfield2.text=[NSString stringWithFormat:@"%@",_allValueDic[@"remarks"]];
          L3.text=@"";
    }
    
    if ([_statusString isEqualToString:@"4"]) {
     _titleImage.image=IMAGE(@"yuan_2.png");
    }else{
         _titleImage.image=IMAGE(@"yuan_1.png");
    }
    
    if (![_statusString isEqualToString:statusNum]) {
   
        _textfield.text=[NSString stringWithFormat:@"%@",_allValueDic[@"deviseSerialNumber"]];
    }
    
    if (self.model.isShowMoreText){ // 展开状态
        // 计算文本高度
        float y=_scrollView.frame.origin.y;
       
           float buttonY=_goBut.frame.origin.y;
        
      //  float H=SCREEN_Height-90*HEIGHT_SIZE-(38*HEIGHT_SIZE*2)-40*HEIGHT_SIZE;
        float Vx=_View3.frame.origin.x; float Vy=_View3.frame.origin.y;
        
         _scrollView.frame=CGRectMake(0, y, SCREEN_Width, buttonY+60*HEIGHT_SIZE+140*HEIGHT_SIZE);
        _View3.frame = CGRectMake(Vx,Vy, 0.3*NOW_SIZE,buttonY+170*HEIGHT_SIZE+140*HEIGHT_SIZE);
        
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
    
    float H=620*HEIGHT_SIZE+remarkH-20*HEIGHT_SIZE+140*HEIGHT_SIZE;
    if (![status isEqualToString:@"3"]) {
        H=270*HEIGHT_SIZE;
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
    
    UILabel *L2=[_scrollView viewWithTag:2001];
    L2.text=_goTimeString;
    
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}




@end
