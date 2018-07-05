//
//  ZZTTableSwitchView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableSwitchViewDelegate;

@interface ZZTTableSwitchView : UIView

@property (nonatomic,assign) id<TableSwitchViewDelegate> delegate;

/*
 设置左右两边的按钮标题
 
 */
- (instancetype)initWithLeftText:(NSString *)leftText
                   withRightText:(NSString *)rightText;

/*
获取左右两边按钮的索引
*/
- (void)clickButtonWithIndex:(NSInteger)index;

@end

@protocol TableSwitchViewDelegate <NSObject>

@required

- (void)tableSwitchView:(ZZTTableSwitchView *)tableSwitchView didSelectedButton:(UIButton *)button forIndex:(NSInteger)index;

@optional

@end
