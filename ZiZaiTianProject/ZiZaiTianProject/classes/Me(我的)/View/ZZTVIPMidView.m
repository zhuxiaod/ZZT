//
//  ZZTVIPMidView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTVIPMidView.h"

@implementation ZZTVIPMidView

+(instancetype)VIPMidView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
