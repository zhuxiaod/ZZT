//
//  ZZTCartoonDetailFoot.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/16.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonDetailFoot.h"

@implementation ZZTCartoonDetailFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    _userWrite = [self creatBtn];
    _userWrite.backgroundColor = [UIColor greenColor];
    [_userWrite setTitle:@"另写剧情" forState:UIControlStateNormal];
    _likeUp = [self creatBtn];
    _likeUp.backgroundColor = [UIColor grayColor];
    [_likeUp setTitle:@"点赞" forState:UIControlStateNormal];
}
 -(void)layoutSubviews
{
    [super layoutSubviews];
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0 , self.height - 1, SCREEN_WIDTH, 1)];
    bottomView.backgroundColor = [UIColor grayColor];
    [self addSubview:bottomView];

    self.backgroundColor = [UIColor whiteColor];
    //点赞
    CGFloat btnWidth = 80;
    [_likeUp setFrame:CGRectMake(SCREEN_WIDTH - btnWidth - 10, self.height/2 - 10, btnWidth, 20)];

    [_userWrite setFrame:CGRectMake(SCREEN_WIDTH - btnWidth * 2 - 30, self.height/2 - 10, btnWidth, 20)];
}
- (UIButton *)creatBtn {
    
    UIButton *btn = [[UIButton alloc] init];
    
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    return btn;
}

//点击判断
- (void)btnClick:(UIButton *)btn {
    if(btn == self.userWrite){
        if(self.userWrite){
            self.userWriteBtnClick(self.userWrite);
        }
    }else if (btn == self.likeUp){
        if(self.likeUp){
            self.likeUpBtnClick(self.likeUp);
        }
    }
}
@end
