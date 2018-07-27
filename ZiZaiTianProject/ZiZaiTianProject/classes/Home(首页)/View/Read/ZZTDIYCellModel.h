//
//  ZZTDIYCellModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTDIYCellModel : NSObject

@property (nonatomic,assign)CGFloat height;

@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,assign) NSMutableArray *imageArray;

+(instancetype)initCellWith:(CGFloat )height isSelect:(BOOL)isSelect;

@end
