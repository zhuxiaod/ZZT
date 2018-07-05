//
//  ZZTSettingModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/3.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTSettingModel : NSObject
@property (nonatomic,strong) NSString *modelTitle;
@property (nonatomic,strong) NSString *modelDetail;

+(instancetype)initSettingModelWith:(NSString *)title detail:(NSString *)detail;

@end
