//
//  ZZTUserShoppingModel.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTUserShoppingModel.h"

@implementation ZZTUserShoppingModel

+(instancetype)initWith:(NSString *)title content:(NSString *)content{
    ZZTUserShoppingModel *user = [[ZZTUserShoppingModel alloc] init];
    user.topTitle = title;
    user.topContent = content;
    return user;
}
@end
