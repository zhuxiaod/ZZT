//
//  ZZTSecondBtn.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTSecondBtn.h"
#import "UIView+Frame.h"

@implementation ZZTSecondBtn

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews{
    //这里约束肯定有问题
    CGFloat height1 = self.height - 25;
    //调整文字的位置和尺寸
    self.titleLabel.x = 0;
    self.titleLabel.y = height1/2;
    self.titleLabel.width = self.width;
    self.titleLabel.height = height1;
    //设置button样式
    self.layer.cornerRadius = 10;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0f;
}
@end
