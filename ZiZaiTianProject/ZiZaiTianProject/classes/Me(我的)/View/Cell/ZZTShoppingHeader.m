//
//  ZZTShoppingHeader.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTShoppingHeader.h"

@interface ZZTShoppingHeader()

@property (weak, nonatomic) IBOutlet UIImageView *hearImage;

@end

@implementation ZZTShoppingHeader

-(void)awakeFromNib{
    self.hearImage.image = [UIImage imageNamed:@"home_logo"];
}

@end
