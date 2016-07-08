//
//  ExtensionTwoViewController.m
//  shinelink
//
//  Created by sky on 16/5/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ExtensionTwoViewController.h"

  #define  headH2 100*HEIGHT_SIZE
  #define  headH 50*HEIGHT_SIZE
@interface ExtensionTwoViewController ()
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) UILabel *title1;
@property (nonatomic, strong) UITextView *detail;
@property (nonatomic, strong) NSString *outline;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) NSString *reconmend;
@property (nonatomic, strong) NSString *supplier;
@property (nonatomic, strong) NSString *picName;
@property (nonatomic, strong) NSMutableArray *picArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) UIImageView*image;
@property(nonatomic,strong)NSString *languageValue;
@end

@implementation ExtensionTwoViewController
{

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self netExtension];
    
}

-(void)netExtension{

    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    
    if ([currentLanguage isEqualToString:@"zh-Hans-CN"]) {
        _languageValue=@"0";
    }else if ([currentLanguage isEqualToString:@"en-CN"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"id":_idString,@"language":_languageValue} paramarsSite:@"/newExtensionAPI.do?op=getExtensionInfo" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getExtensionInfo=: %@", content);
        
        if(content){
           
            _outline=content[@"outline"];
            _supplier=content[@"supplier"];
            _area=content[@"area"];
            _price=content[@"price"];
            _phoneNum=content[@"phoneNum"];
            _reconmend=content[@"recommend"];
            _picName=content[@"imageName"];
            //_imageName=content[@"imageName"];
            
            [self uiOne];
            
            if (_picName.length>0) {
                
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSString *imageURL=[NSString stringWithFormat:@"%@/%@",HEAD_URL,_picName];
                    UIImage * resultImage;
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
                    
                    if (data!= nil) {
                    resultImage = [UIImage imageWithData:data];
                        
                        _picArray=[NSMutableArray arrayWithObject:resultImage];
                        
                  
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                                [self initPic];
                        });
 
                
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                              [self initContent];
                        });
                        
                    }
                });

//                
//                
//                
//                
//                NSString *imageURL=[NSString stringWithFormat:@"%@/%@",HEAD_URL,_picName];
//                UIImage * resultImage;
//                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
//                
//                if (data) {
//                     resultImage = [UIImage imageWithData:data];
//                    _picArray=[NSMutableArray arrayWithObject:resultImage];
//                    
//                    [self initPic];
//
//                }else{
//                   [self initContent];
//                
//                }
               

                
                
                
                
//                [BaseRequest requestImageWithMethodByGet:HEAD_URL paramars:@{@"imageName":_picName} paramarsSite:@"/newProductAPI.do?op=getProductImage" sucessBlock:^(id content2) {
//                    
//                    [self hideProgressView];
//                    
//                    NSLog(@"getProductImage=: %@", content2);
//                    if (content2) {
//                        _picArray=[NSMutableArray arrayWithObject:content2];
//                        
//                        [self initPic];
//                                            }
//                    
//                } failure:^(NSError *error) {
//                    [self hideProgressView];
//                     [self initContent];
//                }];
                
                
            }else{
                [self initContent];
                
            }
            
            
            
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];

    
}





-(void)uiOne{
    _nameArray=[NSMutableArray arrayWithObjects:root_FU_tigongshang, root_FU_shiyong_quyu, root_FU_jiage, root_FU_lianxi_fangshi, nil];
    _contentArray=[NSMutableArray arrayWithObjects:_supplier, _area, _price, _phoneNum, nil];
    
    _scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView2.scrollEnabled=YES;
    _scrollView2.contentSize = CGSizeMake(SCREEN_Width,2000*NOW_SIZE);
    [self.view addSubview:_scrollView2];
    
    _title1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*HEIGHT_SIZE, 300*NOW_SIZE,25*HEIGHT_SIZE )];
    _title1.text=_name2;
    _title1.textAlignment=NSTextAlignmentCenter;
    _title1.textColor=COLOR(0, 0, 0, 1);
    _title1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView2 addSubview:_title1];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*HEIGHT_SIZE+30*HEIGHT_SIZE, 300*NOW_SIZE,1*HEIGHT_SIZE )];
    line3.backgroundColor=[UIColor grayColor];
    [_scrollView2 addSubview:line3];
    
    
    UILabel *outlineTitle=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,45*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    outlineTitle.text=root_FU_gaisu;
    outlineTitle.textAlignment=NSTextAlignmentLeft;
    outlineTitle.textColor=COLOR(0, 0, 0, 1);
    outlineTitle.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView2 addSubview:outlineTitle];
    
    _detail=[[UITextView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,70*HEIGHT_SIZE, 300*NOW_SIZE,headH2-headH)];
    _detail.text=_outline;
    _detail.editable=NO;
    _detail.textAlignment=NSTextAlignmentLeft;
    _detail.textColor=COLOR(60, 60, 60, 1);
    _detail.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_scrollView2 addSubview:_detail];
    
    for (int i=0; i<4; i++) {
        UILabel *nameTitle=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,170*HEIGHT_SIZE-headH+20*HEIGHT_SIZE*i, 150*NOW_SIZE,20*HEIGHT_SIZE )];
        nameTitle.text=_nameArray[i];
        nameTitle.textAlignment=NSTextAlignmentLeft;
        nameTitle.textColor=COLOR(0, 0, 0, 1);
        nameTitle.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView2 addSubview:nameTitle];
    }
    
    for (int i=0; i<4; i++) {
        UILabel *contentTitle=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE,170*HEIGHT_SIZE-headH+20*HEIGHT_SIZE*i, 150*NOW_SIZE,20*HEIGHT_SIZE )];
        contentTitle.text=_contentArray[i];
        contentTitle.textAlignment=NSTextAlignmentLeft;
        contentTitle.textColor=COLOR(60, 60, 60, 1);
        contentTitle.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView2 addSubview:contentTitle];
    }
    
}

-(void)initPic{

    _image=[[UIImageView alloc] initWithFrame:CGRectMake(10*NOW_SIZE, 250*HEIGHT_SIZE-headH, 300*NOW_SIZE, 140*HEIGHT_SIZE)];
    [_image setImage:_picArray[0]];
    [_scrollView2 addSubview:_image];
     [self initContent];

}

-(void)initContent{

    UILabel *recommendTitle=[[UILabel alloc]init];
    UILabel *recommend=[[UILabel alloc]init];
    
 CGRect fcRect = [_reconmend boundingRectWithSize:CGSizeMake(300*NOW_SIZE, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 *HEIGHT_SIZE]} context:nil];
    //    return 110*HEIGHT_SIZE+fcRect.size.height;
    
    if (_image) {
        recommendTitle.frame=CGRectMake(10*NOW_SIZE, 390*HEIGHT_SIZE-headH, 300*NOW_SIZE, 20*HEIGHT_SIZE);
        recommend.frame=CGRectMake(10*NOW_SIZE, 410*HEIGHT_SIZE-headH, 300*NOW_SIZE, fcRect.size.height);
    }else{
        recommendTitle.frame=CGRectMake(10*NOW_SIZE, 390*HEIGHT_SIZE-120*HEIGHT_SIZE-headH, 300*NOW_SIZE, 20*HEIGHT_SIZE);
        recommend.frame=CGRectMake(10*NOW_SIZE, 410*HEIGHT_SIZE-120*HEIGHT_SIZE-headH, 300*NOW_SIZE, fcRect.size.height);
        
    }
    
    recommendTitle.text=root_FU_fuwu_jieshao;
    recommendTitle.textAlignment=NSTextAlignmentLeft;
    recommendTitle.textColor=COLOR(0, 0, 0, 1);
    recommendTitle.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView2 addSubview:recommendTitle];

    
   
    recommend.text=_reconmend;
   // recommend.editable=NO;
    recommend.numberOfLines=0;
    recommend.textAlignment=NSTextAlignmentLeft;
    recommend.textColor=COLOR(60, 60, 60, 1);
    recommend.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_scrollView2 addSubview:recommend];

    
    
  

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
