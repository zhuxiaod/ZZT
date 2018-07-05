//
//  ZZTCircleImage.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCircleImage.h"

@implementation ZZTCircleImage
- (void)awakeFromNib
{
//    // 设置边框宽度
//    self.layer.borderWidth = 1.0;
//    // 设置边框颜色
//    self.layer.borderColor = [UIColor redColor].CGColor;
    // 设置圆角半径
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.masksToBounds = YES;
}
@end
