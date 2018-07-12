//
//  ZZTWordsOptionsHeadView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWordsOptionsHeadView.h"
#import "ZZTOptionBtn.h"

@interface ZZTWordsOptionsHeadView()

//这是这个线  紫色的  ==你要点击效果？不是先布局  点击效果demo有 我先给你说一下
@property (weak, nonatomic) UIView *line;

@end

@implementation ZZTWordsOptionsHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.backgroundColor = [UIColor whiteColor];
    
    _leftBtn = [self creatBtn];
    [self.leftBtn setTitle:@"详情" forState:UIControlStateNormal];
    _leftBtn.selected = YES;
    _leftBtn.backgroundColor = [UIColor colorWithHexString:@"#E4C1D9"];
    
    _midBtn = [self creatBtn];
    [self.midBtn setTitle:@"目录" forState:UIControlStateNormal];
    _midBtn.backgroundColor = [UIColor colorWithHexString:@"#5D4256"];
    _midBtn.selected = NO;
    _rightBtn = [self creatBtn];
    [self.rightBtn setTitle:@"评论" forState:UIControlStateNormal];
    _rightBtn.backgroundColor = [UIColor colorWithHexString:@"#5D4256"];
    _rightBtn.selected = NO;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    //底线
    UIView *bottomLine = [self creatSpaceLine];
    bottomLine.backgroundColor = [UIColor grayColor];
    //中线
    UIView *centerLine1 = [self creatSpaceLine];
    centerLine1.backgroundColor = [UIColor grayColor];
    UIView *centerLine2 = [self creatSpaceLine];
    centerLine2.backgroundColor = [UIColor grayColor];

    weakself(self);
    CGFloat line_h = wordsOptionsHeadViewHeight * 0.6;
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH / 3);
        make.height.mas_equalTo(wordsOptionsHeadViewHeight);
        make.left.mas_equalTo(self.mas_left);
    }];
    
    [_midBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftBtn.mas_right);
        make.width.mas_equalTo(weakSelf.leftBtn.mas_width);
        make.height.mas_equalTo(weakSelf.leftBtn.mas_height);
        make.centerY.mas_equalTo(weakSelf.leftBtn.mas_centerY);
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.midBtn.mas_right);
        make.right.mas_equalTo(self.mas_right);
        make.width.mas_equalTo(weakSelf.leftBtn.mas_width);
        make.height.mas_equalTo(weakSelf.leftBtn.mas_height);
        make.centerY.mas_equalTo(weakSelf.leftBtn.mas_centerY);
    }];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    [centerLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.midBtn.mas_left);
        make.height.mas_equalTo(line_h);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(weakSelf.rightBtn.mas_centerY);
    }];
    [centerLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.midBtn.mas_right);
        make.height.mas_equalTo(line_h);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(weakSelf.rightBtn.mas_centerY);
    }];
}
//点击判断
- (void)btnClick:(ZZTOptionBtn *)btn {

    if (btn.selected == YES) return;

    btn.selected = YES;
    //如果是左
    if(btn == self.leftBtn){
        self.rightBtn.selected = NO;
        self.midBtn.selected = NO;
        if (self.leftBtnClick) {
            self.leftBtnClick(self.leftBtn);
        }
    }else if(btn == self.midBtn){
        self.rightBtn.selected = NO;
        self.leftBtn.selected = NO;
        if(self.midBtnClick){
            self.midBtnClick(self.midBtn);
        }// 程序开始让那条线显示在哪边
    }else{
        self.leftBtn.selected = NO;
        self.midBtn.selected = NO;
    
        if (self.rightBtnClick) {
            self.rightBtnClick(self.rightBtn);
        }
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
    }];
}
//线和按钮的创建方法
- (UIView *)creatSpaceLine {
    
    UIView *spaceLine = [[UIView alloc] init];
    spaceLine.backgroundColor = [[UIColor alloc] initWithWhite:0.9 alpha:1];
    [self addSubview:spaceLine];
    
    return spaceLine;
}

- (ZZTOptionBtn *)creatBtn {
    
    ZZTOptionBtn *btn = [[ZZTOptionBtn alloc] init];
    
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#582547"] forState:UIControlStateSelected];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    return btn;
}

@end
