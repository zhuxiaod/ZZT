//
//  ZZTWordsOptionsBottomView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWordsOptionsBottomView.h"

@implementation ZZTWordsOptionsBottomView
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
    _leftBtn.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    _midBtn = [self creatBtn];
    _midBtn.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    _rightBtn = [self creatBtn];
    _rightBtn.backgroundColor = [UIColor colorWithHexString:@"#38D9B1"];
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self.leftBtn setTitle:titleArray[0] forState:UIControlStateNormal];
    [self.midBtn setTitle:titleArray[1] forState:UIControlStateNormal];
    [self.rightBtn setTitle:titleArray[2] forState:UIControlStateNormal];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //底线
    UIView *bottomLine = [self creatSpaceLine];
    bottomLine.backgroundColor = [UIColor grayColor];
    //中线
    UIView *centerLine1 = [self creatSpaceLine];
    centerLine1.backgroundColor = [UIColor colorWithHexString:@"#38D9B1"];
    UIView *centerLine2 = [self creatSpaceLine];
    centerLine2.backgroundColor = [UIColor colorWithHexString:@"#38D9B1"];
    
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
        make.left.mas_equalTo(weakSelf.midBtn.mas_left);
        make.height.mas_equalTo(line_h);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(weakSelf.rightBtn.mas_centerY);
    }];
}
//线和按钮的创建方法
- (UIView *)creatSpaceLine {
    
    UIView *spaceLine = [[UIView alloc] init];
    spaceLine.backgroundColor = [[UIColor alloc] initWithWhite:0.9 alpha:1];
    [self addSubview:spaceLine];
    
    return spaceLine;
}
//点击判断
- (void)btnClick:(UIButton *)btn {
    if(btn == self.leftBtn){
        if(self.leftBtnClick){
            self.leftBtnClick(self.leftBtn);
        }
    }else if(btn == self.midBtn){
        if(self.midBtnClick){
            self.midBtnClick(self.midBtn);
        }
    }else{
        if(self.rightBtnClick){
            self.rightBtnClick(self.rightBtn);
        }
    }
}
- (UIButton *)creatBtn {
    
    UIButton *btn = [[UIButton alloc] init];
    
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor colorWithHexString:@"#582547"] forState:UIControlStateSelected];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    return btn;
}

@end
