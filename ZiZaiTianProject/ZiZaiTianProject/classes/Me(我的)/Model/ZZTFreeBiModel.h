//
//  ZZTFreeBiModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTFreeBiModel : NSObject

@property (nonatomic,strong) NSString *ZZTBtype;

@property (nonatomic,strong) NSString *ZZTBSpend;

@property (nonatomic,strong) NSString *btnType;

+(instancetype)initZZTFreeBiWith:(NSString *)Btype ZZTBSpend:(NSString *)ZZTBSpend btnType:(NSString *)btnType;


@end
