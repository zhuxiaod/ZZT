//
//  ZZTShoppingBtnModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTShoppingBtnModel : NSObject
@property(nonatomic,strong) NSString *BtnImage;
@property(nonatomic,strong) NSString *ticketNumber;
@property(nonatomic,strong) NSString *BNumber;
+(instancetype)initShopBtnWith:(NSString *)BtnImage ticketNumber:(NSString *)ticketNumber BNumber:(NSString *)BNumber;
@end
