//
//  ZZTCartoonDetailFooter.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/16.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonDetailFooter.h"

@implementation ZZTCartoonDetailFooter

+ (instancetype)makeCartoonFlooterView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ZZTCartoonDetailFooter" owner:nil options:nil] firstObject];
}

@end
