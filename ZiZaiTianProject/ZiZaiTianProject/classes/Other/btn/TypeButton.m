//
//  TypeButton.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/24.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "TypeButton.h"

@implementation TypeButton
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentRight;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //图片在上 文字在下
    //文字
    
    self.titleLabel.width = self.width * 0.7;
    self.titleLabel.height = self.height;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.x = 0;
    self.titleLabel.y = 0;
    self.titleLabel.textAlignment = NSTextAlignmentRight;//设置title的字体居中
    //调整图片的位置和尺寸
    
    self.imageView.width = self.width * 0.2;
    self.imageView.height = self.height * 0.7;
    
    self.imageView.centerY = self.height / 2;

    self.imageView.x = self.width * 0.7;
    
    self.adjustsImageWhenHighlighted = NO;
}
@end
