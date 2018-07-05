//
//  ZZTRoundRectButton.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTRoundRectButton.h"

@implementation ZZTRoundRectButton

-(void)awakeFromNib{
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
    self.backgroundColor = [UIColor colorWithHexString:@"#ECECEC"];
    self.layer.cornerRadius = 10;
    [self setTitleColor:[UIColor colorWithHexString:@"#FB9321"] forState:UIControlStateNormal];
}

@end
