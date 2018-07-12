//
//  HYHttpTool.m
//  study
//
//  Created by hy on 2018/4/21.
//  Copyright © 2018年 hy. All rights reserved.
//

#import "AFNHttpTool.h"

static AFHTTPSessionManager *manager;

@implementation AFNHttpTool

+ (AFHTTPSessionManager *)sharedHttpSession
{
    static dispatch_once_t onctToken;
    dispatch_once(&onctToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
    });
    return manager;
}

+(void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFNHttpTool sharedHttpSession];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            
//            if (![responseObject[@"code"] isEqualToString:@"0"]) {
//                HYLog(@"")
//            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFNHttpTool sharedHttpSession];
//    [SVProgressHUD show];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
//            if ([responseObject[@"code"] isEqualToString:@"100"]) {
//                MyLog(@"token - 失效");
//                MyLog(@"%@",url)
//                [self loginBackInViewController];
//            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismissWithDelay:1.0];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
//        [SVProgressHUD showErrorWithStatus:@"网络超时, 请稍后再试!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismissWithDelay:1.0];
        });
    }];
}




@end
