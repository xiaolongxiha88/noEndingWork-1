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


@end
