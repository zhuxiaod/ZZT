//
//  ZZTCreationEntranceModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTCreationEntranceModel : NSObject
@property (nonatomic,strong) NSArray *cartoonType;
@property (nonatomic,strong) NSString *cartoonName;
@property (nonatomic,strong) NSString *cartoonTitle;

+(instancetype)initWithTpye:(NSArray *)type cartoonName:(NSString *)cartoonName cartoonTitle:(NSString *)cartoonTitle;
@end
