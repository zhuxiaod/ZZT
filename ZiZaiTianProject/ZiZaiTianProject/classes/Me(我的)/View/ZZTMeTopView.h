//
//  ZZTMeTopView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  ZZTMeTopView : UIView

typedef void(^ButtonClick)(UIButton * sender);

@property (nonatomic,copy) ButtonClick buttonAction;

//-(void)addTapBlock:(void(^)(UIButton *btn))block;

+(instancetype)meTopView;

@end
