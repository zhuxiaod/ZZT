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
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UIButton *more;
@property (weak, nonatomic) IBOutlet UIView *yellowView;

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
    //黄色图标
    UIView *yellowView = [[UIView alloc] init];
    
    yellowView.backgroundColor = subjectColor;
    yellowView.layer.cornerRadius  = w * 0.5;
    yellowView.layer.masksToBounds = YES;
    
    [self addSubview:yellowView];
    
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(spaceing);
        make.height.equalTo(@(contentHeight * 0.8));
        make.width.equalTo(@(w));
    }];
    
    //标题
    UILabel *titleView = [[UILabel alloc] init];
    
    titleView.font = [UIFont systemFontOfSize:15];
    titleView.textColor = colorWithWhite(0.5);
    
    [self addSubview:titleView];
    
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(yellowView.mas_right).offset(spaceing * 0.5);
        make.height.equalTo(@(contentHeight));
    }];
    
    self.titleView = titleView;
    //更多button
    UIButton *more = [[UIButton alloc] init];
    [more setTitle:@"更多" forState:UIControlStateNormal];
    more.titleLabel.font = [UIFont systemFontOfSize:14];
    more.layer.cornerRadius = w * 2;
    more.layer.borderWidth = 1.0f;
    more.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [more setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [more addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:more];
    
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-spaceing);
        make.height.equalTo(@(contentHeight));
        make.width.equalTo(@(40));
    }];
    
    
    self.more = more;
}

//先走
-(void)setTitle:(NSString *)title{
    _title = title;
    [self.titleView setText:title];
}
-(void)moreEvent{
    if(self.moreOnClick){
        self.moreOnClick();
    }
}

@end
