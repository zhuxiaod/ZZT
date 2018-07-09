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
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    
}
-(void)setIsGet:(BOOL)isGet{
    _isGet = isGet;
    if(isGet == NO){
        self.backgroundColor = [UIColor grayColor];
        [self setTitle:@"领取" forState:UIControlStateNormal];
        [self setEnabled:NO];
    }else{
        self.backgroundColor = [UIColor grayColor];
        [self setTitle:@"已领" forState:UIControlStateNormal];
        [self setEnabled:NO];
    }
}
-(void)setIfSign:(BOOL)ifSign{
    _ifSign = ifSign;
    if(ifSign == NO){
        self.backgroundColor = [UIColor colorWithHexString:@"#FDB12E"];
        [self setTitle:@"领取" forState:UIControlStateNormal];
        [self setEnabled:YES];

    }else{
        [self setBackgroundColor:[UIColor grayColor]];
        [self setTitle:@"已领" forState:UIControlStateNormal];
        [self setEnabled:NO];
    }
}
-(void)setIsNo:(BOOL)isNo{
    _isNo = isNo;
    [self setBackgroundColor:[UIColor grayColor]];
    [self setTitle:@"领取" forState:UIControlStateNormal];
    [self setEnabled:NO];

}
@end
