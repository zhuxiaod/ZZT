//
//  ZXDLoginRegisterTextField.m
//  loginDemo
//
//  Created by zxd on 2018/6/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZXDLoginRegisterTextField.h"
#import "UITextField+ZXDTextField.h"

// 默认的占位文字颜色
#define XMGPlaceholderDefaultColor [UIColor grayColor]
// 聚焦的占位文字颜色
#define XMGPlaceholderFocusColor [UIColor whiteColor]

@implementation ZXDLoginRegisterTextField

-(void)awakeFromNib
{
    //文本框的光标颜色
    self.tintColor = XMGPlaceholderFocusColor;
    //文字颜色
    self.textColor = XMGPlaceholderFocusColor;
    //设置占位文字颜色
    self.placeholderColor = XMGPlaceholderDefaultColor;
}

//文本框聚焦时调用(弹出当前文本框对应的键盘时调用)
-(BOOL)becomeFirstResponder
{
    self.placeholderColor = XMGPlaceholderFocusColor;\
    return [super becomeFirstResponder];
}

//文本框失去焦点时调用
-(BOOL)resignFirstResponder{
    self.placeholderColor = XMGPlaceholderDefaultColor;
    return [super resignFirstResponder];
}
@end
