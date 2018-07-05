//
//  ZZTSettingModel.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/3.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTSettingModel.h"

@implementation ZZTSettingModel

+(instancetype)initSettingModelWith:(NSString *)title detail:(NSString *)detail{
    ZZTSettingModel *model = [[ZZTSettingModel alloc] init];
    model.modelTitle = title;
    model.modelDetail = detail;
    return model;
}
@end
