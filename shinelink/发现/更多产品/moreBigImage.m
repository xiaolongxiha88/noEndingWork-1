//
//  moreBigImage.m
//  ShineLink
//
//  Created by sky on 16/7/29.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "moreBigImage.h"

@interface moreBigImage () <UIScrollViewDelegate>
{
    UIScrollView *_scrollview;
 UIImageView *_imageview;

}
@end

@implementation moreBigImage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1添加 UIScrollView
       //设置 UIScrollView的位置与屏幕大小相同
         _scrollview=[[UIScrollView alloc]initWithFrame:self.view.bounds];
   [self.view addSubview:_scrollview];

       //2添加图片
    //有两种方式
       //(1)一般方式
 //    UIImageView  *imageview=[[UIImageView alloc]init];
   //    UIImage *image=[UIImage imageNamed:@"minion"];
//    imageview.image=image;
    //    imageview.frame=CGRectMake(0, 0, image.size.width, image.size.height);

   //(2)使用构造方法
   UIImage *image=_paramsImageArray[0];
    
        _imageview=[[UIImageView alloc]initWithImage:image];
    
    
       //调用initWithImage:方法，它创建出来的imageview的宽高和图片的宽高一样
   [_scrollview addSubview:_imageview];

  //设置UIScrollView的滚动范围和图片的真实尺寸一致
    
     _scrollview.contentSize=CGSizeMake(image.size.width,image.size.height+30*HEIGHT_SIZE);
   //_scrollview.contentSize=image.size;


     //设置实现缩放
    //设置代理scrollview的代理对象
   _scrollview.delegate=self;
     //设置最大伸缩比例
      _scrollview.maximumZoomScale=2.0;
   //设置最小伸缩比例
    _scrollview.minimumZoomScale=0.5;
    
}

//告诉scrollview要缩放的是哪个子控件
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
 {
     return _imageview;
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
