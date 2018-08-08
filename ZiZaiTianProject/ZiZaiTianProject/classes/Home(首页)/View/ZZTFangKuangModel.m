//
//  ZZTFangKuangModel.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTFangKuangModel.h"

@implementation ZZTFangKuangModel

+(instancetype)initWithViewFrame:(CGRect)viewFrame tagNum:(NSInteger)tagNum{
    ZZTFangKuangModel *model = [[ZZTFangKuangModel alloc] init];
    model.viewFrame = viewFrame;
    model.tagNum = tagNum;
    return model;
}
@end
