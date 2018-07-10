//
//  ZZTCartonnPlayModel.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/30.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartonnPlayModel.h"

@implementation ZZTCartonnPlayModel
+(instancetype)initPlayWithImage:(NSString *)image labelName:(NSString *)labelName title:(NSString *)title{
    ZZTCartonnPlayModel *model = [[ZZTCartonnPlayModel alloc] init];
    model.chapterName = image;
    model.bookName = labelName;
    model.bookType = title;
    return model;
}

@end
