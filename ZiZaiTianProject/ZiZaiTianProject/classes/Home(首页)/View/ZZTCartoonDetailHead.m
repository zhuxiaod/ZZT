//
//  ZZTCartoonDetailHead.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/16.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonDetailHead.h"
@interface ZZTCartoonDetailHead()

@property (nonatomic,weak) UILabel *titleLabel;

@property (nonatomic,weak) UILabel *authorName;

@property (nonatomic,weak) UIButton *likeup;

@end
static CGFloat spacing = 10;

@implementation ZZTCartoonDetailHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)updataUI {
    //更新点赞
    //更新名字
    //更新作者名字
    
//    [self.authorIcon sd_setImageWithURL:[NSURL URLWithString:self.model.topic.user.avatar_url] placeholderImage:[UIImage imageNamed:@"ic_author_info_headportrait_50x50_"]];
//
//    [self.authorName setText:self.model.topic.user.nickname];
//
//    self.follow.selected = self.model.is_favourite;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(20);
    }];
    
    [self.authorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.titleLabel);
        make.height.mas_equalTo(20);
    }];
    
    [self.likeup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
}

//点赞逻辑
- (void)like:(UIButton *)btn{
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        UILabel *name = [[UILabel alloc] init];
        [self addSubview:name];
        
        name.font = [UIFont systemFontOfSize:13];
        name.textAlignment = NSTextAlignmentLeft;
        name.textColor = [UIColor blackColor];
        name.text = @"第一段";
        _titleLabel = name;
        
    }
    return _titleLabel;
}

- (UILabel *)authorName {
    if (!_authorName) {
        
        UILabel *name = [[UILabel alloc] init];
        [self addSubview:name];
        
        name.font = [UIFont systemFontOfSize:13];
        name.textAlignment = NSTextAlignmentLeft;
        name.textColor = [UIColor blackColor];
        name.text = @"作者昵称";
        _authorName = name;
    }
    return _authorName;
}

- (UIButton *)likeup{
    if(!_likeup){
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        [btn setTitle:@"50赞" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor colorWithHexString:@"#E7A24F"] forState:UIControlStateNormal];
        _likeup = btn;
    }
    return _likeup;
}
@end
