//
//  ZZTSignButton.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTSignButton.h"

@implementation ZZTSignButton

-(void)awakeFromNib{
    [super awakeFromNib];
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = [UIColor blackColor].CGColor;
    
}
-(void)setIsGet:(BOOL)isGet{
    _isGet = isGet;
    if(isGet == NO){
        [self setBackgroundImage:[UIImage imageNamed:@"我的-签到-领取-已领（未领）"] forState:UIControlStateNormal];
        [self setTitle:@"领取" forState:UIControlStateNormal];
        [self setEnabled:NO];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"我的-签到-领取-已领（未领）"] forState:UIControlStateNormal];
        [self setTitle:@"已领" forState:UIControlStateNormal];
        [self setEnabled:NO];
    }
}
-(void)setIfSign:(BOOL)ifSign{
    _ifSign = ifSign;
    if(ifSign == NO){
        [self setBackgroundImage:[UIImage imageNamed:@"我的-签到-领取-可领取"] forState:UIControlStateNormal];
        [self setTitle:@"领取" forState:UIControlStateNormal];
        [self setEnabled:YES];

    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"我的-签到-领取-已领（未领）"] forState:UIControlStateNormal];
        [self setTitle:@"已领" forState:UIControlStateNormal];
        [self setEnabled:NO];
    }
}
-(void)setIsNo:(BOOL)isNo{
    _isNo = isNo;
    [self setBackgroundImage:[UIImage imageNamed:@"我的-签到-领取-已领（未领）"] forState:UIControlStateNormal];
    [self setTitle:@"领取" forState:UIControlStateNormal];
    [self setEnabled:NO];
}
@end
