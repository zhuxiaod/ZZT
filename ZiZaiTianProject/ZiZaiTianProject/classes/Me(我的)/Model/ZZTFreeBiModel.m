//
//  ZZTFreeBiModel.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTFreeBiModel.h"

@implementation ZZTFreeBiModel

+(instancetype)initZZTFreeBiWith:(NSString *)Btype ZZTBSpend:(NSString *)ZZTBSpend btnType:(NSString *)btnType{
    ZZTFreeBiModel *freeB = [[ZZTFreeBiModel alloc] init];
    freeB.btnType = btnType;
    freeB.ZZTBtype = Btype;
    freeB.ZZTBSpend = ZZTBSpend;
    return freeB;
}

@end
