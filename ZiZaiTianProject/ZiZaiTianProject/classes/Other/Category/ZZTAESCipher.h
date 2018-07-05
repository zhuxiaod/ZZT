//
//  ZZTAESCipher.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTAESCipher : NSObject
NSString * aesEncryptString(NSString *content, NSString *key);
NSString * aesEncryptHexStr(NSString *content, NSString *key);//16进制表现形式
NSString * aesDecryptString(NSString *content, NSString *key);
NSString * hexStringFromString(NSString *string);


NSData * aesEncryptData(NSData *data, NSData *key);
NSData * aesDecryptData(NSData *data, NSData *key);
@end
