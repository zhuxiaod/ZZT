
//
//  ZZTTopUpView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTTopUpView.h"

@implementation ZZTTopUpView

+(instancetype)TopUpView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
