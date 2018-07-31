//
//  ZZTPaletteView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTPaletteView.h"
#import "Palette.h"

@interface ZZTPaletteView ()<PaletteDelegate>
//显示颜色View
@property (nonatomic,strong) UIView *choicesColorView;

@end
@implementation ZZTPaletteView

#pragma mark 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSomeUI];
    }
    return self;
}

#pragma mark 添加UI
-(void)addSomeUI{
    //调色板
    Palette *palette = [[Palette alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    palette.delegate = self;
    [self addSubview:palette];
    //展示颜色
    CGFloat choicesColorViewW = 30;
    self.choicesColorView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - choicesColorViewW)/2, 160, choicesColorViewW, choicesColorViewW)];
    self.choicesColorView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.choicesColorView];
    
    //确定按钮
    UIButton *ture = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - 60, 200, 50, 30)];
    ture.backgroundColor = [UIColor redColor];
    [ture setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ture setTitle:@"确定" forState:UIControlStateNormal];
    self.btn = ture;
    [self addSubview:ture];
    [ture addTarget:self action:@selector(clickPaletteBtn:) forControlEvents:UIControlEventTouchUpInside];
    //取消按钮
    UIButton *cannel = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 + 10, 200, 50, 30)];
    cannel.backgroundColor = [UIColor redColor];

    [cannel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cannel setTitle:@"取消" forState:UIControlStateNormal];
    [cannel addTarget:self action:@selector(clickPaletteBtn:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPaletteBtn:)];
    [cannel addGestureRecognizer:click];
    [self addSubview:cannel];
    
}

-(void)clickPaletteBtn:(UITapGestureRecognizer *)sender{
    NSLog(@"11111");
}
#pragma mark 取色板代理方法
-(void)patette:(Palette *)patette choiceColor:(UIColor *)color colorPoint:(CGPoint)colorPoint{
    self.choicesColorView.backgroundColor = color;
    if ([self.delegate respondsToSelector:@selector(patetteView:choiceColor:colorPoint:)]) {
        [self.delegate patetteView:self choiceColor:color colorPoint:colorPoint];
    }
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *result = [super hitTest:point withEvent:event];
    if (result == self) {
        return nil;
    }else {
        return result;
    }
    
}
#pragma mark 开始触摸或者点击
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"11111");
}
#pragma mark 滑动触摸
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"11111");
}
#pragma mark 结束触摸
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"11111");
}
//手势来解决
@end
