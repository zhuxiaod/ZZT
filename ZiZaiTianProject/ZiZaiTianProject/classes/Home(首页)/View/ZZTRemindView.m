//
//  ZZTRemindView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTRemindView.h"

@implementation ZZTRemindView

#pragma mark 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSomeUI];
    }
    return self;
}

-(void)addSomeUI{
    //背景
    UIButton *backgroundBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backgroundBtn.backgroundColor = [UIColor blackColor];
    backgroundBtn.alpha = 0.55;
    [backgroundBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backgroundBtn];
    
    //title
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2 - 75, self.height/2 - 70, 140, 50)];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.backgroundColor = [UIColor redColor];
    [titleView setText:@"确定发布"];
    [self addSubview:titleView];
    
    //确定按钮
    UIButton *tureBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2-90, self.height / 2, 100, 50)];
    tureBtn.backgroundColor = [UIColor redColor];

    [tureBtn addTarget:self action:@selector(tureTarget) forControlEvents:UIControlEventTouchUpInside];
    [tureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:tureBtn];
    //取消按钮
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2 + 20, self.height / 2, 100, 50)];
    cancelBtn.backgroundColor = [UIColor redColor];

    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
}

-(void)cancel{
    [self removeFromSuperview];
}
-(void)tureTarget{
    
}
@end
