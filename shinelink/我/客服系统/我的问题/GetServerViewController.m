//
//  GetServerViewController.m
//  shinelink
//
//  Created by sky on 16/4/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "GetServerViewController.h"
#import "moreBigImage.h"

@interface GetServerViewController ()
@property(nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong)UIImageView  *imageBig1;
@end

@implementation GetServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArray=[NSMutableArray array];
    //_picArray=[NSMutableArray array];
    [self netGet];
    
}

-(void)netGet{
//    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
//    NSString *userID=[ud objectForKey:@"userID"];
    
//    for(int i=0;i<_picArray.count-1;i++){
//    [self showProgressView];
//    [BaseRequest requestImageWithMethodByGet:HEAD_URL paramars:@{@"userId":userID,@"imageName":_picArray[i]} paramarsSite:@"/questionAPI.do?op=getQuestionImg" sucessBlock:^(id content) {
//        [self hideProgressView];
//         NSLog(@"getQuestionImg=: %@", content);
//        
//        [_imageArray addObject:content];
//        
//        if (_imageArray.count==(_picArray.count-1)) {
//              [self initUI];
//        }
//        
//        
//    } failure:^(NSError *error) {
//        [self hideProgressView];
//        [self showToastViewWithTitle:root_Networking];
//        
//    }];
//    }
    
     NSString *headURL=@"http://cdn.growatt.com/onlineservice";
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        NSString *userID=[ud objectForKey:@"userName"];
    
    [self showProgressView];
    for (int i=0; i<_picArray.count-1; i++) {
        
       
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imageURL=[NSString stringWithFormat:@"%@/%@/%@",headURL,userID,_picArray[i]];
            UIImage * result;
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
            
            if (data!= nil) {
                result = [UIImage imageWithData:data];
                
                [_imageArray addObject:result];
               
                
                if (_imageArray.count==(_picArray.count-1)) {
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                         [self hideProgressView];
                         [self initUI];
                    });
                    
                }
            }else{
                    [self hideProgressView];
              
            }
        });
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
        image2.userInteractionEnabled=YES;
        image2.tag=1000+i;
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreBigImage:)];
      
        [image2 addGestureRecognizer:tap];
        [_scrollView addSubview:image2];
        
//        if (i==0) {
//            _imageBig1=[[UIImageView alloc]initWithFrame:CGRectMake(50*NOW_SIZE, 10*HEIGHT_SIZE+0*240*HEIGHT_SIZE, 220*NOW_SIZE,220*HEIGHT_SIZE )];
//            _imageBig1.image = _imageArray[i];
//            UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreBigImage:)];
//            [_imageBig1 addGestureRecognizer:tap];
//            [_scrollView addSubview:_imageBig1];
//        }
    }
    
    
}



-(void)moreBigImage:(UITapGestureRecognizer*)tap{
    int K=tap.view.tag-1000;
    
    moreBigImage *go=[[moreBigImage alloc]init];
   go.paramsImageArray=[NSMutableArray arrayWithObject:_imageArray[K]];
    [self.navigationController pushViewController:go animated:YES];
    
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
