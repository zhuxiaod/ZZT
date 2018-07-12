//
//  ZZTWordDescSectionHeadView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZTWordDescSectionHeadView : UIView

@property (nonatomic,copy) NSString *desc;

@property (nonatomic,copy) void (^needReloadHeight)();

- (CGFloat)myHeight;

@end
