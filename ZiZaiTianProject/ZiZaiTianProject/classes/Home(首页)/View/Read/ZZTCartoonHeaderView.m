//
//  ZZTCartoonHeaderView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 zxd. All rights reserved.
//
static const CGFloat spaceing = 10.0f;
static const CGFloat contentHeight = 22.0f;

#import "ZZTCartoonHeaderView.h"
@interface ZZTCartoonHeaderView ()
@property (weak, nonatomic)  UILabel *titleView;
@property (weak, nonatomic)  UIButton *more;
@property (weak, nonatomic)  UIView *yellowView;

@end

@implementation ZZTCartoonHeaderView

-(instancetype)init{
    self = [super init];
    if(self){
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    CGFloat w = 5;
//    //黄色图标
//    UIView *yellowView = [[UIView alloc] init];
//
//    yellowView.backgroundColor = subjectColor;
//    yellowView.layer.cornerRadius  = w * 0.5;
//    yellowView.layer.masksToBounds = YES;
//
//    [self addSubview:yellowView];
//
//    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
//        make.left.equalTo(self).offset(spaceing);
//        make.height.equalTo(@(contentHeight * 0.8));
//        make.width.equalTo(@(w));
//    }];
    
    //标题
    UILabel *titleView = [[UILabel alloc] init];
    
    titleView.font = [UIFont systemFontOfSize:15];
    titleView.textColor = colorWithWhite(0.5);
    self.titleView = titleView;
    [titleView setTextColor:[UIColor blackColor]];
    [self addSubview:titleView];
    self.titleView = titleView;
    
    //更多button
    UIButton *more = [[UIButton alloc] init];
    [more setTitle:@"更多" forState:UIControlStateNormal];
    [more setBackgroundImage:[UIImage imageNamed:@"作品-按钮-更多"] forState:UIControlStateNormal];
    more.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    more.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    more.titleLabel.font = [UIFont systemFontOfSize:14];
    [more setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [more addTarget:self action:@selector(moreEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:more];
    self.more = more;

}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(spaceing);
        make.height.equalTo(@(contentHeight));
    }];
    
    [self.more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-spaceing);
        make.height.equalTo(@(contentHeight));
        make.top.equalTo(@(2));
        make.width.equalTo(@(60));
    }];
}
//先走
-(void)setTitle:(NSString *)title{
    _title = title;
    [self.titleView setText:title];
}
-(void)moreEvent:(UIButton *)btn{
    if(self.moreOnClick){
        self.moreOnClick(btn);
    }
}

@end
