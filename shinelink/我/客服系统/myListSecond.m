//
//  myListSecond.m
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "myListSecond.h"
#import "myListSecondTableViewCell.h"
#import "AnswerViewController.h"
#import "GetServerViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0


CGFloat const kChatInputTextViewHeight = 33.0f;

@interface myListSecond ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    CGSize _currentTextViewContentSize;
    NSInteger _textLine;
    float keyboradH;
       float textViewW;
    float H2;
    float H1;
    float allH;
    
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)NSMutableArray *nameArray;
@property(nonatomic,strong)NSMutableArray *nameID;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *timeArray;
@property(nonatomic,strong)NSMutableArray *questionAll;
@property(nonatomic,strong)NSMutableArray *imageName;
@property(nonatomic,strong)NSString *titleString;
@property(nonatomic,strong)NSString *SnString;
@property(nonatomic,strong)NSString *QuestionTypeString;
@property(nonatomic,strong)NSString *createrTimeString;
@property(nonatomic,strong)NSString *statusString;
@property(nonatomic,strong)NSString *ContentString;
@property(nonatomic,strong)NSString *PhoneString;
@property(nonatomic,strong)UIImage *headImageUser;
@property (nonatomic, strong) NSMutableDictionary *allDict;

@property(nonatomic,strong)NSString *typeString;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIView *textViewAll;

@property(nonatomic,strong)NSMutableDictionary *allDic;


@property(nonatomic,strong)UIView *imageViewAll;
@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong) NSMutableArray *picArray;

@end

@implementation myListSecond

-(void)viewDidAppear:(BOOL)animated
{
   // [self.view removeFromSuperview];
  //  [self netGetAgain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
     H2=self.navigationController.navigationBar.frame.size.height;
     H1=[[UIApplication sharedApplication] statusBarFrame].size.height;
     allH=40*HEIGHT_SIZE;
    _picArray=[NSMutableArray array];
    
    //设置两个通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyHiden:) name: UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyWillAppear:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self netGetAgain];
}




-(void)initUI{


  
    
   //  [self initHeadView];
    if (!_tableView) {
         _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0, SCREEN_Width,SCREEN_HEIGHT-allH-H2-H1 )];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView=_headView;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_tableView];
    }
   
   

   
    
       textViewW=[UIScreen mainScreen].bounds.size.width-allH-allH;
    _textViewAll = [[UIView alloc]initWithFrame:CGRectMake(0*HEIGHT_SIZE,[UIScreen mainScreen].bounds.size.height-allH-H2-H1 , SCREEN_Width, allH)];
    _textViewAll.backgroundColor =COLOR(242, 242, 242, 1);
    _textViewAll.userInteractionEnabled = YES;
    [self.view addSubview:_textViewAll];
    
    UIView *VI = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0*HEIGHT_SIZE, allH,allH )];
    VI.backgroundColor =[UIColor clearColor];
     VI.userInteractionEnabled = YES;
    UITapGestureRecognizer * forget1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(controlPhoto)];
    [VI addGestureRecognizer:forget1];
    [_textViewAll addSubview:VI];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 20*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    image4.userInteractionEnabled = YES;
    image4.image = IMAGE(@"pic_icon.png");
    [VI addSubview:image4];
    
    UIView *V2 = [[UIView alloc]initWithFrame:CGRectMake(textViewW+allH, 0, allH,allH )];
    V2.backgroundColor =[UIColor clearColor];
    V2.userInteractionEnabled = YES;
    UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(finishDone)];
    [V2 addGestureRecognizer:forget2];
    [_textViewAll addSubview:V2];
    
    UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(8*NOW_SIZE, 10*HEIGHT_SIZE, 22*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    image5.userInteractionEnabled = YES;
    image5.image = IMAGE(@"send_icon.png");
    [V2 addSubview:image5];
    
   
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(allH,7*HEIGHT_SIZE , textViewW, 26*HEIGHT_SIZE)];
    _textView.delegate = self;
    _textView.font=[UIFont systemFontOfSize:12*HEIGHT_SIZE];
    _textView.backgroundColor =[UIColor whiteColor];
    [_textViewAll addSubview:_textView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}


-(void)initHeadView{
    
  _headView = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width,500*HEIGHT_SIZE )];
    _headView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:_headView];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSData *pic=[ud objectForKey:@"userPic"];
    
    float imageSize=40*HEIGHT_SIZE;  float imageW=10*HEIGHT_SIZE;
    UIImageView *userImage= [[UIImageView alloc] initWithFrame:CGRectMake(imageW, imageW+5*HEIGHT_SIZE, imageSize, imageSize)];
    userImage.layer.masksToBounds=YES;
    userImage.layer.cornerRadius=imageSize/2.0;
    [userImage setUserInteractionEnabled:YES];
    
    if((pic==nil) || (pic.length==0)){
        [userImage setImage:[UIImage imageNamed:@"touxiang.png"]];
    }else{
        UIImage *image = [UIImage imageWithData: pic];
        _headImageUser=image;
        [userImage setImage:image];
    }
    [_headView addSubview:userImage];
    
    float lableH=20*HEIGHT_SIZE;   float lableW0=SCREEN_Width-imageSize-3*imageW;
        UILabel *nameLable=[[UILabel alloc]initWithFrame:CGRectMake(imageW*2+imageSize, imageW, lableW0,lableH )];
            nameLable.text=_titleString;
        nameLable.textAlignment=NSTextAlignmentLeft;
        nameLable.textColor=COLOR(51, 51, 51, 1);
        nameLable.font = [UIFont systemFontOfSize:13*HEIGHT_SIZE];
        [_headView addSubview:nameLable];
    
        float lableW=(SCREEN_Width-imageSize-3*imageW-6*NOW_SIZE)/3;
    
    if (_PhoneString==nil || _PhoneString==NULL||([_PhoneString isEqual:@""] )) {
       _PhoneString=@"";
    }
    NSArray *lableArray=[NSArray arrayWithObjects:_QuestionTypeString, _SnString,_PhoneString,nil];
    for (int i=0; i<3; i++) {
        UILabel *Lable0=[[UILabel alloc]initWithFrame:CGRectMake(imageW*2+imageSize+lableW*i, imageW+lableH, lableW,lableH )];
        Lable0.text=lableArray[i];
        Lable0.textAlignment=NSTextAlignmentLeft;
        Lable0.adjustsFontSizeToFitWidth=YES;
        Lable0.textColor=COLOR(153, 153, 153, 1);
        Lable0.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        [_headView addSubview:Lable0];
    }
    
      NSArray *lableArray1=[NSArray arrayWithObjects: _statusString,_createrTimeString,nil];
    for (int i=0; i<2; i++) {
        UILabel *Lable1=[[UILabel alloc]initWithFrame:CGRectMake(imageW*2+imageSize+lableW*i, imageW+lableH*2, lableW,lableH )];
        if (i==1) {
            Lable1.frame=CGRectMake(imageW*2+imageSize+lableW*i, imageW+lableH*2, lableW+30*NOW_SIZE,lableH );
        }
        Lable1.text=lableArray1[i];
        Lable1.textAlignment=NSTextAlignmentLeft;
        Lable1.textColor=COLOR(153, 153, 153, 1);
        if (i==0) {
            if ([_statusString isEqualToString:@"0"]) {
                 Lable1.text=@"待处理";
                 Lable1.textColor=COLOR(227, 74, 33, 1);
            }else if ([_statusString isEqualToString:@"1"]){
                 Lable1.text=@"处理中";
                Lable1.textColor=COLOR(94, 195, 53, 1);
            }else if([_statusString isEqualToString:@"2"]){
                 Lable1.text=@"已处理";
                 Lable1.textColor=COLOR(157, 157, 157, 1);
            }else if([_statusString isEqualToString:@"3"]){
                 Lable1.text=@"待跟进";
                 Lable1.textColor=COLOR(227, 164, 33, 1);
            }
        }
        Lable1.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
        [_headView addSubview:Lable1];
    }
    
    float LableContentW=SCREEN_Width-2*imageW;
    NSString *LableContentText=_ContentString;
    CGSize Lrect=[self getStringSize:12*HEIGHT_SIZE Wsize:LableContentW Hsize:MAXFLOAT stringName:LableContentText];
    UILabel *LableContent=[[UILabel alloc]initWithFrame:CGRectMake(imageW, imageW+lableH*3+5*HEIGHT_SIZE, LableContentW,Lrect.height+20*HEIGHT_SIZE )];
    LableContent.text=LableContentText;
    LableContent.textAlignment=NSTextAlignmentLeft;
    LableContent.textColor=COLOR(102, 102, 102, 1);
    LableContent.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    LableContent.numberOfLines=0;
    [_headView addSubview:LableContent];
    
    UILabel *LableS=[[UILabel alloc]initWithFrame:CGRectMake(imageW, imageW+lableH*3+5*HEIGHT_SIZE+Lrect.height+25*HEIGHT_SIZE, 150*NOW_SIZE,20*HEIGHT_SIZE)];
    LableS.text=@"回复问题";
    LableS.textAlignment=NSTextAlignmentLeft;
    LableS.textColor=COLOR(102, 102, 102, 1);
    LableS.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    LableS.numberOfLines=0;
    [_headView addSubview:LableS];
    
    if (_questionPicArray.count>1) {
    UILabel *LableImage=[[UILabel alloc]initWithFrame:CGRectMake(220*NOW_SIZE, imageW+lableH*3+5*HEIGHT_SIZE+Lrect.height+25*HEIGHT_SIZE,90*NOW_SIZE, 20*HEIGHT_SIZE)];
    LableImage.text=@"查看图片";
    LableImage.textAlignment=NSTextAlignmentRight;
    LableImage.textColor=COLOR(153, 153, 153, 1);
    LableImage.font = [UIFont systemFontOfSize:13*HEIGHT_SIZE];
    LableImage.userInteractionEnabled=YES;
            UITapGestureRecognizer * labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GetPhoto)];
            [LableImage addGestureRecognizer:labelTap1];
    [_headView addSubview:LableImage];
    }
    
    UIView *V1 = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, imageW+lableH*3+5*HEIGHT_SIZE+Lrect.height+45*HEIGHT_SIZE, SCREEN_Width,2*HEIGHT_SIZE )];
    V1.backgroundColor =COLOR(242, 242, 242, 1);
    [_headView addSubview:V1];
    
    _headView.frame=CGRectMake(0*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width,imageW+lableH*3+50*HEIGHT_SIZE+Lrect.height );
    
    [self initUI];
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (!_currentTextViewContentSize.width) {
        _currentTextViewContentSize = textView.contentSize;
    } else {
        if (_currentTextViewContentSize.height < textView.contentSize.height) {
            [self updateHeight:textView isInput:YES];
        } else if (_currentTextViewContentSize.height > textView.contentSize.height) {
            [self updateHeight:textView isInput:NO];
        }
    }
}


-(void)netGetAgain{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userID=[ud objectForKey:@"userID"];
    self.questionAll =[NSMutableArray array];
    
    self.nameArray =[NSMutableArray array];
    self.contentArray =[NSMutableArray array];
    self.timeArray =[NSMutableArray array];
    self.nameID =[NSMutableArray array];
    self.imageName =[NSMutableArray array];
    self.labelArray=[NSMutableArray arrayWithObjects:root_ME_biaoti,root_NBQ_leixing, root_ME_huifu_jilu,nil];
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"questionId":_qusetionId,@"userId":userID} paramarsSite:@"/questionAPI.do?op=getQuestionInfo" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getQuestionInfo=: %@", content);
        if(content){
            _allDic=[NSMutableDictionary dictionaryWithDictionary:content];
            _titleString=content[@"title"];
            _SnString=[NSString stringWithFormat:@"%@",content[@"questionDevice"]];
            _QuestionTypeString=[NSString stringWithFormat:@"%@",content[@"questionType"]];
            if ([_QuestionTypeString isEqualToString:@"1"]) {
                _QuestionTypeString=root_ME_nibianqi_guzhan;
            }else if ([_QuestionTypeString isEqualToString:@"2"]){
                _QuestionTypeString=root_ME_chunengji_guzhan;
            }else if ([_QuestionTypeString isEqualToString:@"3"]){
                _QuestionTypeString=root_ME_ruanjian_jianyi;
            }else if ([_QuestionTypeString isEqualToString:@"4"]){
                _QuestionTypeString=root_ME_ruanjian_guzhan;
            }else if ([_QuestionTypeString isEqualToString:@"5"]){
                _QuestionTypeString=root_ME_qita_shebei_guzhan;
            }else if ([_QuestionTypeString isEqualToString:@"6"]){
                _QuestionTypeString=root_ME_qita_wenti;
            }
            _createrTimeString=[NSString stringWithFormat:@"%@",content[@"createrTime"]];
            _statusString=[NSString stringWithFormat:@"%@",content[@"status"]];
            
            _ContentString=[NSString stringWithFormat:@"%@",content[@"content"]];
            
            
            _questionAll=[NSMutableArray arrayWithArray:content[@"serviceQuestionReplyBean"]];
            // NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
            //   [_questionAll sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
            
            for(int i=0;i<_questionAll.count;i++){
                NSString *nameU=[NSString stringWithFormat:@"%@",_questionAll[i][@"userName"]];
                NSString *nameId=[NSString stringWithFormat:@"%@",_questionAll[i][@"isAdmin"]];
                NSString *timeA=[NSString stringWithFormat:@"%@",_questionAll[i][@"time"]];
                NSString *contentA=[NSString stringWithFormat:@"%@",_questionAll[i][@"message"]];
                //NSString *imageNameA=[NSString stringWithFormat:@"%@",_questionAll[i][@"imageName"]];
                //                                NSString *imageNameA=[NSString stringWithFormat:@"%@",_questionAll[i][@"attachment"]];
                NSString *questionPIC=[NSString stringWithFormat:@"%@",_questionAll[i][@"attachment"]];
                NSArray *PIC = [questionPIC componentsSeparatedByString:@"_"];
                
                [_nameArray addObject:nameU];
                [_nameID addObject:nameId];
                [_timeArray addObject:timeA];
                [_contentArray addObject:contentA];
                [_imageName addObject:PIC];
            }
            //              [self initUI];
            
            if (_questionAll.count==_nameArray.count) {
                
                if (_tableView) {
                    [self.tableView reloadData];
                }else{
                    [self initHeadView];
                }
                
                
            }
            
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
}


-(void)finishDone{
    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
    //    for (int i=0; i<_picArray.count; i++) {
    //        NSData *imageData = UIImageJPEGRepresentation(_picArray[i], 0.5);
    //        NSString *imageName=@"imageName";
    //        [dataImageDict setObject:imageData forKey:imageName];
    //    }
    
    NSMutableArray *picAll=[NSMutableArray arrayWithArray:_picArray];
    [picAll removeObject:@"del"];
    for (int i=0; i<picAll.count; i++) {
        NSData *imageData = UIImageJPEGRepresentation(picAll[i], 0.5);
        NSString *imageName=[NSString stringWithFormat:@"image%d",i+1];
        [dataImageDict setObject:imageData forKey:imageName];
    }
    
        if ([[_textView text] isEqual:@""]) {
            [self showToastViewWithTitle:root_ME_shuru_leirong];
            return;
        }
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userID=[ud objectForKey:@"userID"];
    _allDict=[NSMutableDictionary dictionary];
    [_allDict setObject:[_textView text] forKey:@"message"];
    [_allDict setObject:_qusetionId forKey:@"questionId"];
    [_allDict setObject:userID forKey:@"userId"];
    
    [self showProgressView];
    [BaseRequest uplodImageWithMethod:HEAD_URL paramars:_allDict paramarsSite:@"/questionAPI.do?op=replyMessage" dataImageDict:dataImageDict sucessBlock:^(id content) {
        NSLog(@"addCustomerQuestion==%@", content);
        [self hideProgressView];
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if (content1) {
            if ([content1[@"success"] integerValue] == 1) {
                _textView.text=@"";
                if (_imageViewAll) {
                    [ _imageViewAll removeFromSuperview];
                    _imageViewAll=nil;
                }
                
                  [_textView resignFirstResponder];
               NSNotification * notice = [NSNotification notificationWithName:@"ReLoadTableView" object:nil userInfo:nil];
                [self keyHiden:notice];
                [self showAlertViewWithTitle:nil message:root_ME_tianjia_chenggong cancelButtonTitle:root_Yes];
                   [self netGetAgain];
          
            }else{
                [self showAlertViewWithTitle:nil message:root_ME_tianjia_shibai cancelButtonTitle:root_Yes];
     
            }
        }
    } failure:^(NSError *error) {
        [self showToastViewWithTitle:root_Networking];
        [self hideProgressView];
 
    }];
    
}


- (void)updateHeight:(UITextView *)textView isInput:(BOOL)isInput {
   
    

//    float H2=self.navigationController.navigationBar.frame.size.height;
//    float H1=[[UIApplication sharedApplication] statusBarFrame].size.height;
//    float allH=40*HEIGHT_SIZE;
    float textViewAllH=14*HEIGHT_SIZE;
    
     isInput ? ++_textLine : --_textLine;
    _currentTextViewContentSize = textView.contentSize;
    CGFloat height = _currentTextViewContentSize.height;
     CGFloat height11 = textViewAllH +_currentTextViewContentSize.height;
    
    
    if (height >=112) {
         height =112;
         height11 = textViewAllH +height;
    }
    [UIView animateWithDuration:0.25f animations:^{
        
        _textViewAll.frame = CGRectMake(0*HEIGHT_SIZE,[UIScreen mainScreen].bounds.size.height-H2-H1-height11-keyboradH , SCREEN_Width,height11);
        
        _textView.frame=CGRectMake(allH,7*HEIGHT_SIZE , textViewW, height);
        
        _tableView.frame =CGRectMake(0*NOW_SIZE, 0, SCREEN_Width,[UIScreen mainScreen].bounds.size.height-H2-H1-height11-keyboradH );
    }];
}

#pragma mark-键盘出现隐藏事件
-(void)keyHiden:(NSNotification *)notification
{
    // self.tooBar.frame = rect;
    [UIView animateWithDuration:0.25 animations:^{
        //恢复原样
        _textViewAll.transform = CGAffineTransformIdentity;
        //        commentView.hidden = YES;
        float imageH=40*HEIGHT_SIZE;   float ViewH=imageH+10*HEIGHT_SIZE;
        float ViewY=_textViewAll.frame.origin.y-ViewH;
        if ([[_textView text] isEqualToString:@""]) {
            _textViewAll.frame = CGRectMake(0*HEIGHT_SIZE,[UIScreen mainScreen].bounds.size.height-allH-H2-H1 , SCREEN_Width, allH);
            _textView.frame =CGRectMake(allH,7*HEIGHT_SIZE , textViewW, 26*HEIGHT_SIZE);
        }
        
        if (_imageViewAll) {
            _imageViewAll.frame=CGRectMake(0, ViewY, SCREEN_Width,ViewH );
            _tableView.frame =CGRectMake(0*NOW_SIZE, 0, SCREEN_Width,SCREEN_HEIGHT-_imageViewAll.frame.origin.y );
        }else{
        _tableView.frame =CGRectMake(0*NOW_SIZE, 0, SCREEN_Width,_textViewAll.frame.origin.y);
        }
        
        
    }];
    
    
}
-(void)keyWillAppear:(NSNotification *)notification
{
    
    
    //获得通知中的info字典
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect= [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    keyboradH=rect.size.height;
    

     _tableView.frame =CGRectMake(0*NOW_SIZE, 0, SCREEN_Width,[UIScreen mainScreen].bounds.size.height-H2-H1-allH-keyboradH );
    // self.tooBar.frame = rect;
    [UIView animateWithDuration:0.25 animations:^{
        _textViewAll.transform = CGAffineTransformMakeTranslation(0, -([UIScreen mainScreen].bounds.size.height-rect.origin.y));
        
    }];
    
    
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
   [_textView resignFirstResponder];
}




-(void)Answer{
    AnswerViewController *AN=[[AnswerViewController alloc]init];
    AN.qusetionId=_qusetionId;
    [self.navigationController pushViewController:AN animated:NO];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myListSecondTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[myListSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell.contentView setBackgroundColor: [UIColor whiteColor] ];
    
    NSString *WebString;
    if ([_nameID[indexPath.row] isEqualToString:@"1"]) {
          cell.image.image = IMAGE(@"kefu_iconOSS.png");
        cell.nameLabel.textColor = COLOR(102, 102, 102, 1);
        WebString=self.contentArray[indexPath.row];
    }else{
  
        if (_headImageUser!=nil) {
            cell.image.image =_headImageUser;
        }else{
          cell.image.image = IMAGE(@"touxiang.png");
        }
        
         cell.nameLabel.textColor =COLOR(102, 102, 102, 1);
     //   NSString *N1=@"<body width=280px style=\"word-wrap:break-word; font-family:Arial\">";
       NSString *N1=@"";
        NSString *WebString1=[NSString stringWithFormat:@"<p style=\"word-wrap:break-word;\">%@%@</p>",N1,self.contentArray[indexPath.row]];
         WebString=WebString1;
    }
      NSMutableArray *PICarray=[NSMutableArray arrayWithArray:_imageName[indexPath.row]];
    
    if (PICarray.count>1) {
        cell.picLabel.hidden=NO;
        [cell.picArray addObject:PICarray];
    }else{
        cell.picLabel.hidden=YES;
    }
    cell.nameLabel.text= self.nameArray[indexPath.row];
    cell.timeLabel.text= self.timeArray[indexPath.row];
    
    cell.WebContent= self.contentArray[indexPath.row];
   
    cell.content=self.contentArray[indexPath.row];
    
    NSString *Name1=_contentArray[indexPath.row];
    NSString *Name0=[self removeHTML:Name1];
    float contentW=SCREEN_Width-20*NOW_SIZE-40*HEIGHT_SIZE-10*NOW_SIZE;
    CGRect fcRect = [Name0 boundingRectWithSize:CGSizeMake(contentW, 5000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12*HEIGHT_SIZE]} context:nil];
    
    cell.contentLabel.frame =CGRectMake(15*NOW_SIZE+40*HEIGHT_SIZE, 52*HEIGHT_SIZE, contentW, fcRect.size.height+10*HEIGHT_SIZE);
  
     [cell.contentLabel loadHTMLString:WebString baseURL:nil];
    
  //  cell.titleView.frame=CGRectMake(0, 70*HEIGHT_SIZE+fcRect.size.height,SCREEN_WIDTH, 2*HEIGHT_SIZE);
  //  cell.timeLabel.frame=CGRectMake(SCREEN_WIDTH-100*NOW_SIZE, 45*NOW_SIZE+fcRect.size.height,100*NOW_SIZE, 20*NOW_SIZE );
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contentArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    NSString *Name1=_contentArray[indexPath.row];
    NSString *Name0=[self removeHTML:Name1];
     float contentW=SCREEN_Width-20*NOW_SIZE-40*HEIGHT_SIZE-10*NOW_SIZE;
    CGRect fcRect = [Name0 boundingRectWithSize:CGSizeMake(contentW, 5000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12*HEIGHT_SIZE]} context:nil];
    return 70*HEIGHT_SIZE+fcRect.size.height;
    
}

- (NSString *)removeHTML:(NSString *)html {
    
    NSScanner *theScanner;
    
    NSString *text = nil;

    theScanner = [NSScanner scannerWithString:html];

    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        
        //(you can filter multi-spaces out later if you wish)
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
        
    html = [html stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
    }
    
    return html;
    
}

-(void)GetPhoto{
    GetServerViewController *get=[[GetServerViewController alloc]init];
    
    get.picArray=[NSMutableArray arrayWithArray:_questionPicArray];
    
    [self.navigationController pushViewController:get animated:NO];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *PICarray=[NSMutableArray arrayWithArray:_imageName[indexPath.row]];
  if (PICarray.count>1)
  {
     // NSMutableArray *test=[NSMutableArray arrayWithObject:_imageName[indexPath.row]];
      
      GetServerViewController *get=[[GetServerViewController alloc]init];
      
      get.picArray=[NSMutableArray arrayWithArray:PICarray];
      
      [self.navigationController pushViewController:get animated:NO];
  }
    
    
}



-(void)controlPhoto{
    if (_image1 &&_image2 &&_image3) {
        [self showAlertViewWithTitle:nil message:@"最多上传3张图片" cancelButtonTitle:root_Yes];
    }else{
        
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
            [self presentViewController:_cameraImagePicker animated:YES completion:nil];
            
        }]];
        [alertController addAction: [UIAlertAction actionWithTitle: root_xiangkuang_xuanQu style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            //处理点击从相册选取
            self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
            self.photoLibraryImagePicker.allowsEditing = YES;
            self.photoLibraryImagePicker.delegate = self;
            self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
            
            
        }]];
        [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController: alertController animated: YES completion: nil];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
    float size5=70*NOW_SIZE;
    
    float imageH=40*HEIGHT_SIZE;   float ViewH=imageH+10*HEIGHT_SIZE;   float imageX=20*NOW_SIZE; float ButtonImage=16*HEIGHT_SIZE;
    float ViewY=_textViewAll.frame.origin.y-ViewH;
    if (!_imageViewAll) {
        _imageViewAll = [[UIView alloc]initWithFrame:CGRectMake(0, ViewY, SCREEN_Width,ViewH )];
        _imageViewAll.backgroundColor =COLOR(242, 242, 242, 1);
        _imageViewAll.userInteractionEnabled = YES;
        [self.view addSubview:_imageViewAll];
    }

    
    if(!_image1){
        [_picArray insertObject:image atIndex:0];
        _image1=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*0, 10*HEIGHT_SIZE, imageH,imageH )];
        _image1.userInteractionEnabled = YES;
        _image1.image = image;
        _image1.tag=1+3000;
        [_imageViewAll addSubview:_image1];
        
        _button1= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*0+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
        [_button1 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
        _button1.tag=2000+1;
        [_button1 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_imageViewAll addSubview:_button1];
        
    }else if(_image1 && !_image2){
        [_picArray insertObject:image atIndex:1];
        _image2=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*1, 10*HEIGHT_SIZE, imageH,imageH )];
        _image2.userInteractionEnabled = YES;
        _image2.image = image;
        _image2.tag=2+3000;
        [_imageViewAll addSubview:_image2];
        
        _button2= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*1+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
  [_button2 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
        _button2.tag=2000+2;
        // _button2.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        [_button2 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_imageViewAll addSubview:_button2];
        
    }else if(_image1 && _image2 && !_image3){
        [_picArray insertObject:image atIndex:2];
        _image3=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*2, 10*HEIGHT_SIZE, imageH,imageH )];
        _image3.userInteractionEnabled = YES;
        _image3.image = image;
        _image3.tag=3+3000;
        [_imageViewAll addSubview:_image3];
        
        _button3= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*2+imageH-ButtonImage/2, 10*HEIGHT_SIZE-ButtonImage/2, ButtonImage,ButtonImage)];
  [_button3 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
        _button3.tag=2000+3;
        //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        [_button3 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_imageViewAll addSubview:_button3];
    }
    
    
  //  picTime++;
    
}

-(void)delPicture:(UIButton*)del{
    UIButton  *a=del;
    NSString *replaceName=@"del";
    
    [_picArray replaceObjectAtIndex:a.tag-2001 withObject:replaceName];
    
    if ((a.tag-2000)==1) {
        [_image1 removeFromSuperview];
        [_button1 removeFromSuperview];
        _image1=nil;
        _button1=nil;
    }else  if ((a.tag-2000)==2) {
        [_image2 removeFromSuperview];
        [_button2 removeFromSuperview];
        _image2=nil;
        _button2=nil;
    }else  if ((a.tag-2000)==3) {
        [_image3 removeFromSuperview];
        [_button3 removeFromSuperview];
        _image3=nil;
        _button3=nil;
    }
    
    if ((!_image1)&&(!_image2)&&(!_image3)) {
        [ _imageViewAll removeFromSuperview];
        _imageViewAll=nil;
    }
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
