//
//  ZZTRemindView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTRemindView.h"
@interface ZZTRemindView ()

@property (nonatomic,strong) UIButton *tureBtn;
@property (nonatomic,strong) UILabel *titleView;

@end

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
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2 - 75, self.height/2 - 70, 150, 50)];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.backgroundColor = [UIColor clearColor];
    [titleView setText:@"确定发布"];
    _titleView = titleView;
    [titleView setTextColor:[UIColor whiteColor]];
    [titleView setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [self addSubview:titleView];
    
    //确定按钮
    UIButton *tureBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2-110, self.height / 2, 100, 50)];
    _tureBtn = tureBtn;
    tureBtn.backgroundColor = [UIColor redColor];

    [tureBtn addTarget:self action:@selector(tureTarget:) forControlEvents:UIControlEventTouchUpInside];
    [tureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [tureBtn setBackgroundImage:[UIImage imageNamed:@"按钮-确定"] forState:UIControlStateNormal];
    [self addSubview:tureBtn];
    
    //取消按钮
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2 + 10, self.height / 2, 100, 50)];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"按钮-取消"] forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
}

-(void)cancel{
    [self removeFromSuperview];
}

-(void)tureTarget:(UIButton *)button{
    // 判断下这个block在控制其中有没有被实现
    if (self.btnBlock) {
        // 调用block传入参数
        self.btnBlock(button);
    }
}
-(void)setViewTitle:(NSString *)viewTitle{
    [_titleView setText:viewTitle];
}
@end
