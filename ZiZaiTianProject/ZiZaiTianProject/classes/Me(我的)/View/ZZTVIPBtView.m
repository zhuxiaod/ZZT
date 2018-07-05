//
//  ZZTVIPBtView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTVIPBtView.h"

@implementation ZZTVIPBtView

+(instancetype)VIPBtView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
