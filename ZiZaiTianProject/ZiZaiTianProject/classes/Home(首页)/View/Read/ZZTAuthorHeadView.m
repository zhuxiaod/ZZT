//
//  ZZTAuthorHeadView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTAuthorHeadView.h"

@implementation ZZTAuthorHeadView

+(instancetype)AuthorHeadView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZZTAuthorHeadView" owner:nil options:nil]lastObject];
}

@end
