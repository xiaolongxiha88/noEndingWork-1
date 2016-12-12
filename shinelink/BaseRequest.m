//
//  BaseRequest.m
//  shinelink
//
//  Created by sky on 16/2/26.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "BaseRequest.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "sys/utsname.h"

@implementation BaseRequest
+ (void)requestWithMethod:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site sucessBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html", nil];
    //text/html是以html的形式输出，比如<input type="text"/>就会在页面上显示一个文本框，而以plain形式就会在页面上原样显示这段代码
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"%@", url);
    [UserInfo defaultUserInfo].R_timer.fireDate=[NSDate distantPast];
    [manager POST:url parameters:paramars success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject[@"back"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        failure(error);
    }];
}


+ (void)requestWithMethodResponseStringResult:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site sucessBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"%@", url);
    [UserInfo defaultUserInfo].R_timer.fireDate=[NSDate distantPast];
    
    [manager POST:url parameters:paramars success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        failure(error);
    }];
}


+ (void)requestWithMethodByGet:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site sucessBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/javascript",  nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"%@", url);
    [UserInfo defaultUserInfo].R_timer.fireDate=[NSDate distantPast];
    [manager GET:url parameters:paramars success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject[@"back"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        failure(error);
    }];
}

+ (void)requestWithMethodResponseJsonByGet:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site sucessBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/javascript", nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"%@", url);
    
    [UserInfo defaultUserInfo].R_timer.fireDate=[NSDate distantPast];
    
    [manager GET:url parameters:paramars success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        failure(error);
    }];
}

+ (void)requestImageWithMethodByGet:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site sucessBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"%@", url);
    [UserInfo defaultUserInfo].R_timer.fireDate=[NSDate distantPast];
    
    [manager GET:url parameters:paramars success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        failure(error);
    }];
}

+ (void)requestWithMethod:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site dataImage:(NSData *)data sucessBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"image/png", nil];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:paramars];
    [dictionary setObject:data forKey:@"user_img"];
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    NSLog(@"%@", url);
    [UserInfo defaultUserInfo].R_timer.fireDate=[NSDate distantPast];
    
    [manager POST:url parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject[@""]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}

+ (void)uplodImageWithMethod:(NSString *)method paramars:(NSDictionary *)paramars paramarsSite:(NSString *)site dataImageDict:(NSMutableDictionary *)dataDict sucessBlock:(successBlock)successBlock failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",method,site];
    [UserInfo defaultUserInfo].R_timer.fireDate=[NSDate distantPast];
    
    [manager POST:url parameters:paramars constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *keys = dataDict.allKeys;
        for (NSString *key in keys) {
            //            NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
            //            [myFormatter setDateFormat:@"yyyyMMddhhmmss"];
            //            NSString *dateStr = [myFormatter stringFromDate:[NSDate date]];
            NSData *data = [[NSData alloc] initWithData:dataDict[key]];
            [formData appendPartWithFileData:data name:key fileName:key mimeType:@"image/png"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        failure(error);
    }];
    
}


+(void)getAppError:(NSString*)msg useName:(NSString*)useName{

    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSString *dataString1=[NSString stringWithString:dateString];
    
    NSString *SystemType=@"SystemType:2";
    NSString *version=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *AppVersion=[NSString stringWithFormat:@"AppVersion:%@",version];
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSString *SystemVersion=[NSString stringWithFormat:@"SystemVersion:%@",phoneVersion];
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    NSString *PhoneModel=[NSString stringWithFormat:@"PhoneModel:%@",platform];
  //  NSString *reUsername=[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *UserName=[NSString stringWithFormat:@"UserName:%@",useName];
    NSString *MSG=[NSString stringWithFormat:@"msg:%@",msg];
    
    NSString *errorMsg=[NSString stringWithFormat:@"%@;%@;%@;%@;%@;%@",SystemType,AppVersion,SystemVersion,PhoneModel,UserName,MSG];
    
    
    NSMutableDictionary *dicO=[NSMutableDictionary new];
    [dicO setObject:dataString1 forKey:@"time"];
    [dicO setObject:errorMsg forKey:@"msg"];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:dicO paramarsSite:@"/newLoginAPI.do?op=saveAppErrorMsg" sucessBlock:^(id content) {
        NSLog(@"saveAppErrorMsg: %@", content);
               id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if (jsonObj) {
          
        }
        
    } failure:^(NSError *error) {
    
    }
     
     ];
    
}


+(NSString*)getValidCode:(NSString*)serialNum{
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




@end
