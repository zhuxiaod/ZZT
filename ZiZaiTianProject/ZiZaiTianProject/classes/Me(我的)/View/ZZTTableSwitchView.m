//
//  ZZTTableSwitchView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTTableSwitchView.h"

@interface ZZTTableSwitchView ()

@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIView *bottomLineView;
@property (nonatomic,strong) UIButton *selectedButton;

@end

@implementation ZZTTableSwitchView

-(instancetype)initWithLeftText:(NSString *)leftText withRightText:(NSString *)rightText
{
    self = [super init];
    if (self) {
        self.leftButton = [[UIButton alloc] init];
        self.rightButton = [[UIButton alloc] init];
        
        [self setButtonWith:self.leftButton title:leftText tag:1];
        [self setButtonWith:self.rightButton title:rightText tag:2];
        
        [self setBottom];
        [self buttonClick:self.leftButton];
    }
    return self;
}
#pragma mark - 按钮约束
- (void)layoutSubviews {
    [super layoutSubviews];
    self.leftButton.frame = CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height);
    self.rightButton.frame = CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height);
    self.bottomLineView.frame = CGRectMake(0, self.frame.size.height - 2, self.frame.size.width / 2, 2);
}


#pragma mark - 设置按钮相关
- (void)setButtonWith:(UIButton *)button title:(NSString *)title tag:(NSInteger)tag {
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = tag;
    button.highlighted = false;
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:button];
}

// 设置按钮下面的线条
- (void)setBottom {
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = [UIColor colorWithRed:155/255.0 green:196/255.0 blue:38/255.0 alpha:1.0];
    [self addSubview:self.bottomLineView];
}

- (void)buttonClick:(UIButton *)sender {
    if (self.selectedButton) {
        self.selectedButton.selected = false;
    }
    sender.selected = true;
    self.selectedButton = sender;
    [self bottomViewAnimationWithIndex:(CGFloat)(self.selectedButton.tag - 1)];
    [self.delegate tableSwitchView:self didSelectedButton:self.selectedButton forIndex:(self.selectedButton.tag - 1)];
}

- (void)bottomViewAnimationWithIndex:(CGFloat)index {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect bottomFrame = self.bottomLineView.frame;
        bottomFrame.origin.x = index * (self.frame.size.width / 2);
        self.bottomLineView.frame = bottomFrame;
    }];
}


- (void)clickButtonWithIndex:(NSInteger)index {
    UIButton *clickButton = (UIButton *)[self viewWithTag:(index + 1)];
    [self buttonClick:clickButton];
}
@end
