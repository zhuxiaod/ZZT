//
//  HYHttpTool.h
//  study
//
//  Created by hy on 2018/4/21.
//  Copyright © 2018年 hy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
// 七牛云

@interface AFNHttpTool : NSObject

+ (AFHTTPSessionManager *)sharedHttpSession;

/**
 *  发送一个GET请求
 *
 *  @param url        http:// -- url
 *  @param parameters 请求所需要的参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败之后的回调
 */
+ (void)GET:(NSString *)url
 parameters:(NSDictionary *)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url        http:// -- url
 *  @param parameters 请求所需要的参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败之后的回调
 */
+ (void)POST:(NSString *)url
  parameters:(NSDictionary *)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;



@end
