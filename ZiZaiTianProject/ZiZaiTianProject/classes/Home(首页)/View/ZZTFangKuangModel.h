//
//  ZZTFangKuangModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTFangKuangModel : NSObject

@property (nonatomic,assign) CGRect viewFrame;

@property (nonatomic,strong) NSMutableArray *viewArray;

@property (nonatomic,assign) NSInteger tagNum;

+(instancetype)initWithViewFrame:(CGRect)viewFrame tagNum:(NSInteger)tagNum;

@end
