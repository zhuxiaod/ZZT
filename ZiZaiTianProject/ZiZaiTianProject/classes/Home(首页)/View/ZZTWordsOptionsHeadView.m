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
//    [self.leftBtn setTitle:@"详情" forState:UIControlStateNormal];
    _leftBtn.backgroundColor = [UIColor colorWithHexString:@"#E4C1D9"];
    
    _midBtn = [self creatBtn];
//    [self.midBtn setTitle:@"目录" forState:UIControlStateNormal];
    _midBtn.backgroundColor = [UIColor colorWithHexString:@"#5D4256"];
    _rightBtn = [self creatBtn];
//    [self.rightBtn setTitle:@"评论" forState:UIControlStateNormal];
    _rightBtn.backgroundColor = [UIColor colorWithHexString:@"#5D4256"];
}
-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self.leftBtn setTitle:titleArray[0] forState:UIControlStateNormal];
    [self.midBtn setTitle:titleArray[1] forState:UIControlStateNormal];
    [self.rightBtn setTitle:titleArray[2] forState:UIControlStateNormal];
}

-(void)setIsSelectStatus:(BOOL)isSelectStatus{
    _isSelectStatus = isSelectStatus;
    //初始化默认简介内容
    if(_isSelectStatus == YES){
        _leftBtn.selected = YES;
        _midBtn.selected = NO;
        _rightBtn.selected = NO;
    }
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
    if(btn == self.leftBtn && _isSelectStatus == YES){
        if(self.leftBtnClick && _isSelectStatus == YES){
            self.rightBtn.selected = NO;
            self.midBtn.selected = NO;
            self.leftBtnClick(self.leftBtn);
        }else{
            self.leftBtnClick(self.leftBtn);
        }
    }else if(btn == self.midBtn && _isSelectStatus == YES){
        if(self.midBtnClick && _isSelectStatus == YES){
            self.rightBtn.selected = NO;
            self.leftBtn.selected = NO;
            self.midBtnClick(self.midBtn);
        }else{
            self.midBtnClick(self.midBtn);
        }
    }else{
        if(self.rightBtnClick && _isSelectStatus == YES){
            self.leftBtn.selected = NO;
            self.midBtn.selected = NO;
            self.rightBtnClick(self.rightBtn);
        }else{
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
