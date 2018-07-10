//
//  ZZTEasyBtnModel.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTEasyBtnModel.h"

@implementation ZZTEasyBtnModel

+(instancetype)initWithTitle:(NSString *)btnTitle btnImage:(NSString *)btnImage{
    ZZTEasyBtnModel *model = [[ZZTEasyBtnModel alloc] init];
    model.btnImage = btnImage;
    model.btnTitile = btnTitle;
    return model;
}
@end
