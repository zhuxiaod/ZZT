//
//  ZZTPaletteView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTPaletteView.h"
#import "Palette.h"

@interface ZZTPaletteView ()<PaletteDelegate,UIGestureRecognizerDelegate>
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
    //调色板Size
    CGFloat paletteW = self.bounds.size.height * 0.6;
    CGFloat space = self.bounds.size.height * 0.03;
    Palette *palette = [[Palette alloc] initWithFrame:CGRectMake(0, 0, paletteW, paletteW)];
    palette.delegate = self;
    [self addSubview:palette];
    
    //展示颜色
    CGFloat choicesColorViewW = self.bounds.size.height * 0.19;
    self.choicesColorView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - choicesColorViewW)/2, paletteW+space, choicesColorViewW, choicesColorViewW)];
    self.choicesColorView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.choicesColorView];
    
    //确定按钮
    UIButton *ture = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - 60, paletteW+space+choicesColorViewW+space, 50, choicesColorViewW - 20)];
    [ture setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ture setTitle:@"确定" forState:UIControlStateNormal];
    self.btn = ture;
    [self addSubview:ture];
    
    //取消按钮
    UIButton *cannel = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 + 10, paletteW+space+choicesColorViewW+space, 50, choicesColorViewW - 20)];
    [cannel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cannel setTitle:@"取消" forState:UIControlStateNormal];
    [cannel addTarget:self action:@selector(clickPaletteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cannel];
    //样式
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0f;
    
    ture.layer.borderColor = [UIColor grayColor].CGColor;
    ture.layer.borderWidth = 1.0f;
    
    cannel.layer.borderColor = [UIColor grayColor].CGColor;
    cannel.layer.borderWidth = 1.0f;
    
    self.choicesColorView.layer.borderColor = [UIColor grayColor].CGColor;
    self.choicesColorView.layer.borderWidth = 1.0f;
}

-(void)clickPaletteBtn:(UITapGestureRecognizer *)sender{
    [self removeFromSuperview];
}

#pragma mark 取色板代理方法
-(void)patette:(Palette *)patette choiceColor:(UIColor *)color colorPoint:(CGPoint)colorPoint colorH:(CGFloat)colorH colorS:(CGFloat)colorS{
    self.choicesColorView.backgroundColor = color;
    if ([self.delegate respondsToSelector:@selector(patetteView:choiceColor:colorPoint:colorH:colorS:)]){
        [self.delegate patetteView:self choiceColor:color colorPoint:colorPoint colorH:colorH colorS:colorS];
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

@end
