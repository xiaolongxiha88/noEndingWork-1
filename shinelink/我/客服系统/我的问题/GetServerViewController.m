//
//  GetServerViewController.m
//  shinelink
//
//  Created by sky on 16/4/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "GetServerViewController.h"

@interface GetServerViewController ()
@property(nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation GetServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArray=[NSMutableArray array];
    //_picArray=[NSMutableArray array];
    [self netGet];
    
}

-(void)netGet{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userID=[ud objectForKey:@"userID"];
    
    for(int i=0;i<_picArray.count-1;i++){
    [self showProgressView];
    [BaseRequest requestImageWithMethodByGet:HEAD_URL paramars:@{@"userId":userID,@"imageName":_picArray[i]} paramarsSite:@"/questionAPI.do?op=getQuestionImg" sucessBlock:^(id content) {
        [self hideProgressView];
         NSLog(@"getQuestionImg=: %@", content);
        
        [_imageArray addObject:content];
        
        if (_imageArray.count==(_picArray.count-1)) {
              [self initUI];
        }
        
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
    }];
    }
    


}


-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0*NOW_SIZE, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,900*NOW_SIZE);
    [self.view addSubview:_scrollView];
    
    for (int i=0; i<_imageArray.count; i++) {
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(50*NOW_SIZE, 10*HEIGHT_SIZE+i*240*HEIGHT_SIZE, 220*NOW_SIZE,220*HEIGHT_SIZE )];
      
        image2.image = _imageArray[i];
        [_scrollView addSubview:image2];
        
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
