//
//  ZZTShoppingBtnModel.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTShoppingBtnModel.h"

@implementation ZZTShoppingBtnModel

+(instancetype)initShopBtnWith:(NSString *)BtnImage ticketNumber:(NSString *)ticketNumber BNumber:(NSString *)BNumber{
    ZZTShoppingBtnModel *btn = [[ZZTShoppingBtnModel alloc] init];
    btn.BtnImage = BtnImage;
    btn.ticketNumber = ticketNumber;
    btn.BNumber = BNumber;
    return btn;
}
@end
