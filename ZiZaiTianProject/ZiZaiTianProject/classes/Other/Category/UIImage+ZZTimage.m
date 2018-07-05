//
//  UIImage+ZZTimage.m
//  ZiZaiTianProject
//
//  Created by zxd on 2018/6/24.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "UIImage+ZZTimage.h"

@implementation UIImage (ZZTimage)
+(UIImage *)imageOriginalWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
