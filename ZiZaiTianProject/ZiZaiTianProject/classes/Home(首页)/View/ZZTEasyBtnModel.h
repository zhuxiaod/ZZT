//
//  ZZTEasyBtnModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTEasyBtnModel : NSObject

@property (nonatomic,strong) NSString *btnTitile;

@property (nonatomic,strong) NSString *btnImage;

+(instancetype)initWithTitle:(NSString *)btnTitle btnImage:(NSString *)btnImage;
@end
