//
//  ZXDFastLoginView.m
//  loginDemo
//
//  Created by zxd on 2018/6/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZXDFastLoginView.h"

@implementation ZXDFastLoginView

+(instancetype)fastLogin{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self)  owner:nil options:nil] firstObject];
}

@end
