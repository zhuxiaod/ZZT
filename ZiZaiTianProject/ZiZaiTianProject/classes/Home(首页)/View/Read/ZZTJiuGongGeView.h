//
//  ZZTJiuGongGeView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZTCarttonDetailModel;

static CGFloat spaceing = 10;

@interface ZZTJiuGongGeView : UIView

@property (nonatomic,strong) ZZTCarttonDetailModel *model;

+ (void)jiuGongGeLayout:(NSArray<ZZTJiuGongGeView *> *)views WithMaxSize:(CGSize)maxSize WithRow:(NSInteger)row;

@end
