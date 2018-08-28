//
//  ZZTCaiNiXiHuanView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCaiNiXiHuanView.h"

@interface ZZTCaiNiXiHuanView ()

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIButton *updateBtn;

@end

@implementation ZZTCaiNiXiHuanView

+(instancetype)CaiNiXiHuanView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


@end
