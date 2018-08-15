//
//  HYHttpTool.m
//  study
//
//  Created by hy on 2018/4/21.
//  Copyright © 2018年 hy. All rights reserved.
//

#import "AFNHttpTool.h"
#import "GTMBase64.h"
#import "QN_GTM_Base64.h"

static AFHTTPSessionManager *manager;
static QNUploadManager *upManager;
static AFHTTPSessionManager *manager;
@interface AFNHttpTool()
@property (nonatomic , assign) int expires;
@end
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

// 七牛云
/**
 *  初始化
 *
 */
+ (QNUploadManager *)sharedUpload
{
    static dispatch_once_t onctToken;
    dispatch_once(&onctToken, ^{
        upManager = [[QNUploadManager alloc] init];
    });
    return upManager;
}

/**
 *    上传文件
 *
 *    @param path          文件路径
 *    @param key               上传到云存储的key，为nil时表示是由七牛生成
 *    token             上传需要的token, 由服务器生成
 */

+ (void)putImagePath:(NSString *)path key:(NSString *)key token:(NSString *)token complete:(void (^)(id objc))complete
{
    QNUploadManager *unpmanager = [AFNHttpTool sharedUpload];
    [unpmanager putFile:path key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        //        NSLog(@"------ %@",resp);
        if (info.ok) {
            if (complete) {
                complete(key);
            }
        }else{
            NSLog(@"上传失败");
        }
        
        
        
        //        HYLog(@"%@-%@-%@",info,key,resp);
    } option:nil];
}
- (NSString *)makeToken:(NSString *)accessKey secretKey:(NSString *)secretKey {
    const char *secretKeyStr = [secretKey UTF8String];
    NSString *policy = [self marshal];
    NSData *policyData = [policy dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedPolicy = [GTMBase64 stringByWebSafeEncodingData:policyData padded:TRUE];
    const char *encodedPolicyStr = [encodedPolicy cStringUsingEncoding:NSUTF8StringEncoding];
    char digestStr[CC_SHA1_DIGEST_LENGTH]; bzero(digestStr, 0);
    CCHmac(kCCHmacAlgSHA1, secretKeyStr, strlen(secretKeyStr), encodedPolicyStr, strlen(encodedPolicyStr), digestStr);
    NSString *encodedDigest = [GTMBase64 stringByWebSafeEncodingBytes:digestStr length:CC_SHA1_DIGEST_LENGTH padded:TRUE];
    NSString *token = [NSString stringWithFormat:@"%@:%@:%@", accessKey, encodedDigest, encodedPolicy];
    return token;//得到了token
    
}
- (NSString *)marshal {
    time_t deadline;
    time(&deadline);//返回当前系统时间
    //@property (nonatomic , assign) int expires; 怎么定义随你...
    deadline += (self.expires > 0) ? self.expires : 3600;
    // +3600秒,即默认token保存1小时.
    NSNumber *deadlineNumber = [NSNumber numberWithLongLong:deadline];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //users是我开辟的公共空间名（即bucket），aaa是文件的key，
    //按七牛“上传策略”的描述： <bucket>:<key>，表示只允许用户上传指定key的文件。在这种格式下文件默认允许“修改”，若已存在同名资源则会被覆盖。如果只希望上传指定key的文件，并且不允许修改，那么可以将下面的 insertOnly 属性值设为 1。
    //所以如果参数只传users的话，下次上传key还是aaa的文件会提示存在同名文件，不能上传。
    //传users:aaa的话，可以覆盖更新，但实测延迟较长，我上传同名新文件上去，下载下来的还是老文件。
    [dic setObject:@"image" forKey:@"scope"];//根据
    [dic setObject:deadlineNumber forKey:@"deadline"];
    NSString *json = [dic mj_JSONString];
    return json;
    
}

@end
