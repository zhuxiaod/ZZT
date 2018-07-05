//
//  ZZTUserShoppingModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTUserShoppingModel : NSObject

@property (nonatomic,strong) NSString *topTitle;

@property (nonatomic,strong) NSString *topContent;

+(instancetype)initWith:(NSString *)title content:(NSString *)content;

@end
