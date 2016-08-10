//
//  HtmlCommon.m
//  ShineLink
//
//  Created by sky on 16/8/10.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "HtmlCommon.h"
#import "LWLoadingView.h"
#import "addServerViewController.h"

@interface HtmlCommon ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView* webView;
@property (nonatomic,strong) NSString* HtmlContent;

@end

@implementation HtmlCommon

- (void)viewDidLoad {
    [super viewDidLoad];
self.view.backgroundColor = [UIColor whiteColor];
    
    [self getNet];
    
    
}

-(void)getNet{

    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSString *_languageValue ;
    
    if ([currentLanguage isEqualToString:@"zh-Hans-CN"]) {
        _languageValue=@"0";
    }else if ([currentLanguage isEqualToString:@"en-CN"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }
    
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"id":_idString,@"language":_languageValue} paramarsSite:@"/questionAPI.do?op=getUsualQuestionInfo" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getUsualQuestionInfo=: %@", content);
        
        if(content){
           
            _HtmlContent=content[@"content"];
            
            [self initUI];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];


}

-(void)initUI{
    float Height1=460;
    
    NSString *serviceBool=[[NSUserDefaults standardUserDefaults]objectForKey:@"serviceBool"];
    
    //serviceBool=@"0";
    
    if ([serviceBool isEqualToString:@"1"]) {
     self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, Height1*HEIGHT_SIZE)];
    }else{
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    
    
    
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
   // NSString* html=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"view" ofType:@"html"] encoding:NSUTF8StringEncoding error:NULL];
    
    [self.webView loadHTMLString:_HtmlContent baseURL:nil];
    
    
 if ([serviceBool isEqualToString:@"1"]) {
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, (Height1)*HEIGHT_SIZE, SCREEN_Width,5*HEIGHT_SIZE)];
    lineView.backgroundColor=COLOR(228, 235, 245, 1);
     [self.view addSubview:lineView];
    
    NSString *PV2LableContent=root_haimei_jiejue_wenti;
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, (Height1+5)*HEIGHT_SIZE, 150*NOW_SIZE,30*HEIGHT_SIZE)];
    PV2Lable.text=PV2LableContent;
    PV2Lable.backgroundColor=[UIColor whiteColor];
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=COLOR(113, 113, 113, 1);
    PV2Lable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    NSDictionary *attributes1 = @{NSFontAttributeName:[UIFont systemFontOfSize:16*HEIGHT_SIZE],};
    CGSize textSize1 = [PV2LableContent boundingRectWithSize:CGSizeMake(180*NOW_SIZE,30*HEIGHT_SIZE) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;;
    [PV2Lable setFrame:CGRectMake(10*NOW_SIZE, (Height1+5)*HEIGHT_SIZE, textSize1.width, 30*HEIGHT_SIZE)];
    [self.view addSubview:PV2Lable];
    
    
    NSString *lable3Content=root_xiang_kefu_tiwen;
    UILabel *Lable3=[[UILabel alloc]initWithFrame:CGRectMake(180*NOW_SIZE, (Height1+5)*HEIGHT_SIZE, 150*NOW_SIZE,30*HEIGHT_SIZE)];
    Lable3.text=lable3Content;
    Lable3.backgroundColor=[UIColor whiteColor];
    Lable3.textAlignment=NSTextAlignmentLeft;
    Lable3.textColor=MainColor;
    Lable3.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16*HEIGHT_SIZE],};
    CGSize textSize = [lable3Content boundingRectWithSize:CGSizeMake(180*NOW_SIZE,30*HEIGHT_SIZE) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    [Lable3 setFrame:CGRectMake(310*NOW_SIZE-textSize.width, (Height1+5)*HEIGHT_SIZE, textSize.width, 30*HEIGHT_SIZE)];
    
    Lable3.userInteractionEnabled=YES;
    UITapGestureRecognizer * addAnswer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addAnswer)];
    [Lable3 addGestureRecognizer:addAnswer];
    [self.view addSubview:Lable3];
    
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(310*NOW_SIZE-textSize.width-22*HEIGHT_SIZE, (Height1+12)*HEIGHT_SIZE, 20*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    image2.userInteractionEnabled = YES;
    UITapGestureRecognizer * addAnswer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addAnswer)];
    [image2 addGestureRecognizer:addAnswer1];
    image2.image = IMAGE(@"play_icon.png");
    [self.view addSubview:image2];

   }
    
    
}


-(void)addAnswer{
    addServerViewController *go=[[addServerViewController alloc]init];
     [self.navigationController pushViewController:go animated:NO];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [LWLoadingView showInView:self.view];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [LWLoadingView hideInViwe:self.view];
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
