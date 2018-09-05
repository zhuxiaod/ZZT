//
//  EditImageView.m
//  WaterMarkDemo
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "EditImageView.h"

@interface EditImageView ()<UIGestureRecognizerDelegate>

@property (nonatomic,assign) CGFloat scale;

@property (nonatomic,assign) CGFloat rad;

@end

@implementation EditImageView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //可以进行交互
        self.userInteractionEnabled = YES;
        //添加UI
        [self addUI];
    }
    return self;
}

-(void)setViewFrame:(CGRect)viewFrame{
    _viewFrame = viewFrame;
}

- (void)addUI{
   _len = sqrt(self.frame.size.width/2*self.frame.size.width/2+self.frame.size.height/2*self.frame.size.height/2);
    //放大缩小
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePich:)];
    pinchGestureRecognizer.delegate = self;
    [self addGestureRecognizer:pinchGestureRecognizer];

    //旋转
    UIRotationGestureRecognizer *rotateRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    rotateRecognizer.delegate = self;
    [self addGestureRecognizer:rotateRecognizer];
}

-(void)handlePich:(UIPinchGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    self.scale = recognizer.scale;
   
    recognizer.scale = 1;

    if (self.delegate && [self.delegate respondsToSelector:@selector(updateImageViewTransform:)]) {
        [self.delegate updateImageViewTransform:self];
    }
}

-(void)handleRotate:(UIRotationGestureRecognizer *)recognizer
{
    //旋转前位置  旋转和放大 都不能记载位置  只能移动记载
    //旋转的角度
    if(recognizer.state == UIGestureRecognizerStateChanged){
        recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
        self.rad += recognizer.rotation;
        //试一下  写一个代理
        if (self.delegate && [self.delegate respondsToSelector:@selector(updateImageViewTransform:)]) {
            [self.delegate updateImageViewTransform:self];
        }
        recognizer.rotation = 0;
    }
}

/*
调自己  然后隐藏
删除数据的
 */
- (void)closeBtnClick{
    self.hidden = YES;
    //发送移除通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"remove" object:self];
}

//可编辑状态
- (void)showEditBtn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkViewIsHidden:)]) {
        [self.delegate checkViewIsHidden:self];
    }
}
-(void)setIsHide:(BOOL)isHide{
    _isHide = isHide;
    if(isHide == YES){
        [self hideEditBtn];
    }else{
        [self showEditBtn];
    }
}
//隐藏
- (void)hideEditBtn{
//    _isHide = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkViewIsHidden:)]) {
        [self.delegate checkViewIsHidden:self];
    }
//    _borderView.hidden = YES;
//    _editImgView.hidden = YES;
//    _closeImgView.hidden = YES;
}

//点击的开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //方框的
    //所在方框上的
    if ([self.superViewName isEqualToString:@"UIView"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(EditImageViewWithViewInRectangleView:)]) {
            [self.delegate EditImageViewWithViewInRectangleView:self];
        }
    }else{
        //所在cell上的
        if (self.delegate && [self.delegate respondsToSelector:@selector(EditImageViewWithViewIncell:)]) {
            [self.delegate EditImageViewWithViewIncell:self];
        }
    }
    
    //展示框
//    [self showEditBtn];
    self.isHide = NO;
    UITouch *touch = [touches anyObject];
    //获取点击时所在父View的位置
    _startTouchPoint = [touch locationInView:self.superview];
    _startTouchCenter = self.center;
    //正在移动
    _isMove = YES;
    CGPoint p = [touch locationInView:self];
    
    //判断一个CGPoint 是否包含再另一个UIView的CGRect里面,常用与测试给定的对象之间是否又重叠
    if (CGRectContainsPoint(_editImgView.frame,p)) {
        _isMove = NO;
    }
}

//正在移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesMoved");
    //如果是正在移动
    if (_isMove) {
        //获得当前的位置
        CGPoint curPoint = [[touches anyObject] locationInView:self.superview];
        //没有变化的位置

        //中心
        self.center =  CGPointMake(curPoint.x-(_startTouchPoint.x-_startTouchCenter.x), curPoint.y-(_startTouchPoint.y-_startTouchCenter.y));
        //没有变化的中心

        if (self.delegate && [self.delegate respondsToSelector:@selector(updateImageViewFrame:)]) {
            [self.delegate updateImageViewFrame:self];
        }
    }
}
//切换状态
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(updateImageViewFrame:curPoint:)]) {
////        [self.delegate updateImageViewFrame:self curPoint:0];
//    }
    _isMove = NO;
    self.viewFrame = _editImgView.frame;
}


#pragma mark - 代理方法实现旋转 + 缩放捏合 可同时进行
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
