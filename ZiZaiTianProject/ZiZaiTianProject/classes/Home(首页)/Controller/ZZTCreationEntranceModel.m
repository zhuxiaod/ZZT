//
//  ZZTCreationEntranceModel.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCreationEntranceModel.h"

@implementation ZZTCreationEntranceModel
+(instancetype)initWithTpye:(NSArray *)type cartoonName:(NSString *)cartoonName cartoonTitle:(NSString *)cartoonTitle;
{
    ZZTCreationEntranceModel *model = [[ZZTCreationEntranceModel alloc] init];
    model.cartoonType = type;
    model.cartoonName = cartoonName;
    model.cartoonTitle = cartoonTitle;
    return model;
}
@end
