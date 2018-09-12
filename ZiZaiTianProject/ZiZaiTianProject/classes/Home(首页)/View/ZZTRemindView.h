//
//  ZZTRemindView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnValueBlock) (UIButton *btn);

@interface ZZTRemindView : UIView

@property (nonatomic,copy) ReturnValueBlock btnBlock;

@property (nonatomic,strong) NSString *viewTitle;

@end
