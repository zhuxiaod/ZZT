//
//  UITextField+ZXDTextField.m
//  loginDemo
//
//  Created by zxd on 2018/6/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "UITextField+ZXDTextField.h"

//占位文字颜色
static NSString *const ZXDPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (ZXDTextField)

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    BOOL change = NO;
    
    //保证有占位文字
    if(self.placeholder == nil){
        self.placeholder = @"";
        change = YES;
    }
    
    //设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:ZXDPlaceholderColorKey];
    
    //恢复原状
    if(change){
        self.placeholderColor = nil;
    }
}

-(UIColor *)placeholderColor{
    return [self valueForKeyPath:ZXDPlaceholderColorKey];
}
@end
