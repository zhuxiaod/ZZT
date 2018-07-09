//
//  ZXDButton.m
//  loginDemo
//
//  Created by zxd on 2018/6/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZXDButton.h"
#import "UIView+Frame.h"

@implementation ZXDButton

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //调整图片的位置和尺寸
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    //调整文字的位置和尺寸
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
