//
//  ColorInButton.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/18.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ColorInButton.h"
@interface ColorInButton ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ColorInButton

+(instancetype)ColorInButtonView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}



-(void)setViewColor:(UIColor *)viewColor{
    self.colorView.backgroundColor = viewColor;
}

@end
