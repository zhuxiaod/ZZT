//
//  ZZTSignInView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZTSignButton;

@protocol ZZTSignInViewDelegate <NSObject>

@optional

- (void)signViewDidClickSignBtn:(ZZTSignButton *)btn;
- (void)signViewDidClickapGesture;

@end

@interface ZZTSignInView : UIView

+(instancetype)SignView;

-(void)isget:(NSInteger)signCount isSign:(NSInteger)isSign;

/** 代理属性*/
@property (nonatomic, weak) id<ZZTSignInViewDelegate> delegate;

@end
