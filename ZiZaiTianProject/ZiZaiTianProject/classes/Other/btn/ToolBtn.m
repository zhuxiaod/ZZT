//
//  ToolBtn.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ToolBtn.h"

@implementation ToolBtn

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //调整图片的位置和尺寸

    //    self.imageView.width = self.width - 2;
    self.imageView.width = self.width * 0.8;
//    self.imageView.height = self.height * 0.7;
    self.imageView.height = self.imageView.width;
    //位置写在后面
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    //调整文字的位置和尺寸
    [self.titleLabel sizeToFit];
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height+5;
    self.titleLabel.width = self.width;
//    self.titleLabel.height = self.height * 0.2;
    self.titleLabel.height = self.height - self.imageView.width;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.adjustsImageWhenHighlighted = NO;
}

@end
