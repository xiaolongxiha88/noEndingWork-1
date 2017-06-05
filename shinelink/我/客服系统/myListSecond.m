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
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *nameArray;
@property(nonatomic,strong)NSMutableArray *nameID;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *timeArray;
@property(nonatomic,strong)NSMutableArray *questionAll;
@property(nonatomic,strong)NSMutableArray *imageName;
@property(nonatomic,strong)NSString *titleString;
@property(nonatomic,strong)NSString *typeString;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIView *textViewAll;

@property(nonatomic,strong)NSMutableDictionary *allDic;
@property(nonatomic,strong)UIView *headerView;

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
    [self netGetAgain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //设置两个通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyHiden:) name: UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyWillAppear:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
   // [self netGet];
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
                
                if (_scrollView) {
                    [self.tableView reloadData];
                }else{
                    [self initUI];
                }

                
            }
            
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
}



-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,0*NOW_SIZE);
    [self.view addSubview:_scrollView];
    float Size1=40*HEIGHT_SIZE;
    
    for(int i=0;i<_labelArray.count;i++)
    {
        UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 16*HEIGHT_SIZE+Size1*i, 80*NOW_SIZE,28*HEIGHT_SIZE )];
         PV1Lable.textAlignment=NSTextAlignmentLeft;
        if (i==2) {
            PV1Lable.frame=CGRectMake(15*NOW_SIZE, 16*HEIGHT_SIZE+Size1*i, 160*NOW_SIZE,28*HEIGHT_SIZE );
            PV1Lable.textAlignment=NSTextAlignmentLeft;
        }
        
        PV1Lable.text=_labelArray[i];
        PV1Lable.textColor=[UIColor blackColor];
        PV1Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:PV1Lable];
    }
    
    if (_questionPicArray.count>1) {
        UILabel *_picLabel= [[UILabel alloc] initWithFrame:CGRectMake(220*NOW_SIZE, 96*HEIGHT_SIZE,100*NOW_SIZE, 28*HEIGHT_SIZE)];
        _picLabel.text=root_ME_chakan_tupian;
        _picLabel.textColor=MainColor;
        _picLabel.textAlignment = NSTextAlignmentCenter;
        _picLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        _picLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer * labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GetPhoto)];
        [_picLabel addGestureRecognizer:labelTap1];
        [_scrollView addSubview:_picLabel];
    }
   
  
    for(int i=0;i<2;i++)
    {
        UIView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 42*HEIGHT_SIZE+Size1*i, 310*NOW_SIZE,1*HEIGHT_SIZE )];
        image1.backgroundColor=mainColor;
                [_scrollView addSubview:image1];
        
        UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(85*NOW_SIZE, 16*HEIGHT_SIZE+Size1*i, 210*NOW_SIZE,28*HEIGHT_SIZE )];
        if (i==0) {
               PV2Lable.text=_titleString;
        }else{
            
            if ([_qusetionType isEqualToString:@"1"]) {
                _qusetionType=root_ME_nibianqi_guzhan;
            }else if ([_qusetionType isEqualToString:@"2"]){
                 _qusetionType=root_ME_chunengji_guzhan;
            }else if ([_qusetionType isEqualToString:@"3"]){
                _qusetionType=root_ME_ruanjian_jianyi;
            }else if ([_qusetionType isEqualToString:@"4"]){
                _qusetionType=root_ME_ruanjian_guzhan;
            }else if ([_qusetionType isEqualToString:@"5"]){
                _qusetionType=root_ME_qita_shebei_guzhan;
            }else if ([_qusetionType isEqualToString:@"6"]){
                _qusetionType=root_ME_qita_wenti;
            }
            
            
            
          PV2Lable.text=_qusetionType;
        }
        
        PV2Lable.textAlignment=NSTextAlignmentLeft;
        PV2Lable.textColor=[UIColor blackColor];
        PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        [_scrollView addSubview:PV2Lable];
    }
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE+Size1*3, 310*NOW_SIZE,300*HEIGHT_SIZE )];
    image2.userInteractionEnabled = YES;
    image2.image = IMAGE(@"外框@3x.png");
    [_scrollView addSubview:image2];
    
    /*_scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 55*NOW_SIZE+Size1*3, 300*NOW_SIZE,300*NOW_SIZE )];
    _scrollView2.scrollEnabled=YES;
    _scrollView2.contentSize = CGSizeMake(300*NOW_SIZE,600*NOW_SIZE);
    [self.view addSubview:_scrollView2];*/
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 6*HEIGHT_SIZE+Size1*3, 300*NOW_SIZE,290*HEIGHT_SIZE )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
       [_scrollView addSubview:_tableView];
    
    
    CGRect fcRect = [_qusetionContent boundingRectWithSize:CGSizeMake(300*Width, 1000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 *HEIGHT_SIZE]} context:nil];
   // return 110*HEIGHT_SIZE+fcRect.size.height;
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,10*HEIGHT_SIZE+Size1*3,300*NOW_SIZE,35*HEIGHT_SIZE+fcRect.size.height)];
    _tableView.tableHeaderView = _headerView;
    
    
    UILabel *contentLable=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 210*NOW_SIZE,20*HEIGHT_SIZE )];
        contentLable.text=root_wenti_leirong;
    contentLable.textAlignment=NSTextAlignmentLeft;
    contentLable.textColor=[UIColor blackColor];
    contentLable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_headerView addSubview:contentLable];
    
    UILabel *contentLable2=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 28*HEIGHT_SIZE, 290*NOW_SIZE,fcRect.size.height )];
    contentLable2.text=_qusetionContent;
    contentLable2.textAlignment=NSTextAlignmentLeft;
    contentLable2.textColor=[UIColor grayColor];
    contentLable2.numberOfLines=0;
    contentLable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_headerView addSubview:contentLable2];
    
////    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 35*HEIGHT_SIZE+fcRect.size.height, 290*NOW_SIZE,1*HEIGHT_SIZE)];
////    line1.backgroundColor=[UIColor grayColor];
////    [_headerView addSubview:line1];
//    
//    
//    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 315*HEIGHT_SIZE+Size1*3, 310*NOW_SIZE,30*HEIGHT_SIZE )];
//    image3.userInteractionEnabled = YES;
//    image3.image = IMAGE(@"frame2@2x.png");
//    UITapGestureRecognizer * forget=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Answer)];
//    [image3 addGestureRecognizer:forget];
//    
////    [_scrollView addSubview:image3];
//    
//    
//    UILabel *answerLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0, 290*NOW_SIZE,30*HEIGHT_SIZE )];
//    answerLable.text=root_ME_huifu;
//    answerLable.textAlignment=NSTextAlignmentCenter;
//    answerLable.textColor=MainColor;
//    answerLable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
//  //  [image3 addSubview:answerLable];
    

    
      float H2=self.navigationController.navigationBar.frame.size.height;
       float H1=[[UIApplication sharedApplication] statusBarFrame].size.height;
    float allH=40*HEIGHT_SIZE;
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
    UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Answer)];
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

- (void)updateHeight:(UITextView *)textView isInput:(BOOL)isInput {
   
    

    float H2=self.navigationController.navigationBar.frame.size.height;
    float H1=[[UIApplication sharedApplication] statusBarFrame].size.height;
    float allH=40*HEIGHT_SIZE;  float textViewAllH=14*HEIGHT_SIZE;
    
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
 
            _imageViewAll.frame=CGRectMake(0, ViewY, SCREEN_Width,ViewH );
            
    }];
    
    
}
-(void)keyWillAppear:(NSNotification *)notification
{
    
    
    //获得通知中的info字典
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect= [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    keyboradH=rect.size.height;
    
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
          cell.image.image = IMAGE(@"客服.png");
        cell.nameLabel.textColor = COLOR(63, 163, 220, 1);
        WebString=self.contentArray[indexPath.row];
    }else{
    cell.image.image = IMAGE(@"客户.png");
         cell.nameLabel.textColor =[UIColor blackColor];
        NSString *WebString1=[NSString stringWithFormat:@"<p>%@</p>",self.contentArray[indexPath.row]];
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
    CGRect fcRect = [cell.content boundingRectWithSize:CGSizeMake(300*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 *HEIGHT_SIZE]} context:nil];
    
    cell.contentLabel.frame =CGRectMake(5*NOW_SIZE, 55*HEIGHT_SIZE, 280*Width, fcRect.size.height+15*HEIGHT_SIZE);
  
     [cell.contentLabel loadHTMLString:WebString baseURL:nil];
    
    cell.titleView.frame=CGRectMake(0, 70*HEIGHT_SIZE+fcRect.size.height,SCREEN_WIDTH, 2*HEIGHT_SIZE);
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
    
    
    CGRect fcRect = [self.contentArray[indexPath.row] boundingRectWithSize:CGSizeMake(300*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13*HEIGHT_SIZE]} context:nil];
    return 70*HEIGHT_SIZE+fcRect.size.height;
    
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
