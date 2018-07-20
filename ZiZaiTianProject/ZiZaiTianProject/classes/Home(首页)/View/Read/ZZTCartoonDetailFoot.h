//
//  ZZTCartoonDetailFoot.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/16.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZTCartoonDetailFoot : UIView

@property (weak, nonatomic) UIButton *userWrite;
@property (weak, nonatomic) UIButton *likeUp;

@property (nonatomic,copy) void (^userWriteBtnClick)(UIButton *btn);

@property (nonatomic,copy) void (^likeUpBtnClick)(UIButton *btn);

@end
