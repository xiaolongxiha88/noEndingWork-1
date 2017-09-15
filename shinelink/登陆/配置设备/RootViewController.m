//
//  RootViewController.m
//  ShinePhone
//
//  Created by LinKai on 15/5/18.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "RootViewController.h"
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonDigest.h>


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //背景图
//    UIImage *bgImage = IMAGE(@"bg_login.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
    
    //导航栏
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName :[UIColor whiteColor]
                                                                      }];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        _languageType=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        _languageType=@"1";
    }else{
        _languageType=@"2";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)urlFormat:(NSString *)urlStr {
    NSString *url = urlStr;
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *characters = @"!$&'()*+,-./:;=?@_~%#[]";
    url = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,  (__bridge CFStringRef)url, (__bridge CFStringRef)characters, nil, kCFStringEncodingUTF8));
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return url;
}

- (void)showToastViewWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.labelText = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}


- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
}

- (void)showProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

- (void)hideProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}





- (NSString *)MD5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        NSString *tStr = [NSString stringWithFormat:@"%x", digest[i]];
        if (tStr.length == 1) {
            [result appendString:@"c"];
        }
        [result appendFormat:@"%@", tStr];
    }
    return result;
}


- (UIImage *)createImageWithColor:(UIColor *)color rect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


-(CGSize)getStringSize:(float)fontSize  Wsize:(float)Wsize Hsize:(float)Hsize stringName:(NSString*)stringName{

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    CGSize size = [stringName boundingRectWithSize:CGSizeMake(Wsize, Hsize) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size;

}



-(NSString*)getValidCode:(NSString*)serialNum{
    if (serialNum==NULL||serialNum==nil) {
        return @"";
    }
    NSData *testData = [serialNum dataUsingEncoding: NSUTF8StringEncoding];
    int sum=0;
    Byte *snBytes=(Byte*)[testData bytes];
    for(int i=0;i<[testData length];i++)
    {
        sum+=snBytes[i];
    }
    NSInteger B=sum%8;
    NSString *B1= [NSString stringWithFormat: @"%ld", (long)B];
    int C=sum*sum;
    NSString *text = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1x",C]];
    int length = [text length];
    NSString *resultTemp;
    NSString *resultTemp3;
    NSString *resultTemp1=[text substringWithRange:NSMakeRange(0, 2)];
    NSString *resultTemp2=[text substringWithRange:NSMakeRange(length - 2, 2)];
    resultTemp3= [resultTemp1 stringByAppendingString:resultTemp2];
    resultTemp=[resultTemp3 stringByAppendingString:B1];
    NSString *result = @"";
    char *charArray = [resultTemp cStringUsingEncoding:NSASCIIStringEncoding];
    for (int i=0; i<[resultTemp length]; i++) {
        if (charArray[i]==0x30||charArray[i]==0x4F||charArray[i]==0x4F) {
            charArray[i]++;
        }
        result=[result stringByAppendingFormat:@"%c",charArray[i]];
    }
    return [result uppercaseString];
}


//自定义UITabBarItem
- (UITabBarItem *)createTabBarItem:(NSString *)strTitle normalImage:(NSString *)strNormalImg selectedImage:(NSString *)strSelectedImg itemTag:(NSInteger)intTag {
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:strTitle image:nil tag:intTag];
    
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSBackgroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [item setTitlePositionAdjustment:UIOffsetMake(item.titlePositionAdjustment.horizontal, item.titlePositionAdjustment.vertical - 5.0)];
    
    [item setImage:[IMAGE(strNormalImg) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [item setSelectedImage:[IMAGE(strSelectedImg) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    return item;
}


@end
