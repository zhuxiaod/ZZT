//
//  EditImageView.m
//  WaterMarkDemo
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "EditImageView.h"

@interface EditImageView ()<UIGestureRecognizerDelegate>{
    BOOL isMove;
    CGPoint legend_point;
}

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
    
    
    //拖动
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(selfMove:)];
    panGestureRecognizer.delegate = self;
    [self addGestureRecognizer:panGestureRecognizer];
}

-(void)handlePich:(UIPinchGestureRecognizer *)recognizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(EditImageViewWithViewInRectangleView:)]) {
        [self.delegate EditImageViewWithViewInRectangleView:self];
    }
    if([self.curType isEqualToString:self.type]){
        recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
        self.scale = recognizer.scale;
        
        recognizer.scale = 1;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(updateImageViewTransform:)]) {
            [self.delegate updateImageViewTransform:self];
        }
    }
}

-(void)handleRotate:(UIRotationGestureRecognizer *)recognizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(EditImageViewWithViewInRectangleView:)]) {
        [self.delegate EditImageViewWithViewInRectangleView:self];
    }
    if([self.curType isEqualToString:self.type]){
        recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
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

-(void)setIsHide:(BOOL)isHide{
    _isHide = isHide;
    if(isHide == YES){
        [self hideEditBtn];
    }
}

//隐藏
- (void)hideEditBtn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkViewIsHidden:)]) {
        [self.delegate checkViewIsHidden:self];
    }
}

////点击的开始
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //方框的
//    //所在方框上的
//    if ([self.superViewName isEqualToString:@"UIView"]) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(EditImageViewWithViewInRectangleView:)]) {
//            [self.delegate EditImageViewWithViewInRectangleView:self];
//        }
//    }else{
//        //所在cell上的
//        if (self.delegate && [self.delegate respondsToSelector:@selector(EditImageViewWithViewIncell:)]) {
//            [self.delegate EditImageViewWithViewIncell:self];
//        }
//    }
//
//    self.isHide = NO;
//    UITouch *touch = [touches anyObject];
//    //获取点击时所在父View的位置
//    _startTouchPoint = [touch locationInView:self.superview];
//    _startTouchCenter = self.center;
//    //正在移动
//    _isMove = YES;
//    CGPoint p = [touch locationInView:self];
//
//    //判断一个CGPoint 是否包含再另一个UIView的CGRect里面,常用与测试给定的对象之间是否又重叠
//    if (CGRectContainsPoint(_editImgView.frame,p)) {
////        _isMove = NO;
//    }
//}
//
////正在移动
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    //如果是正在移动
//    if (_isMove) {
//        //获得当前的位置
//        if([self.curType isEqualToString:self.type]){
//            CGPoint curPoint = [[touches anyObject] locationInView:self.superview];
//
//            //中心
//            self.center =  CGPointMake(curPoint.x-(_startTouchPoint.x-_startTouchCenter.x), curPoint.y - (_startTouchPoint.y-_startTouchCenter.y));
//
//            //没有变化的中心
//            if (self.delegate && [self.delegate respondsToSelector:@selector(updateImageViewFrame:)]) {
//                [self.delegate updateImageViewFrame:self];
//            }
//        }
//    }
//}
//
////切换状态
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    _isMove = NO;
//}

#pragma mark 移动
-(void)selfMove:(UIPanGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){

            //默认状态为no
            isMove = NO;
            if([self.curType isEqualToString:self.type]){
                self.isHide = NO;
            }
            //获取响应事件的对象
            //获取在屏幕上的点
            CGPoint point = [gesture locationInView:self.superview];
            //如果这个点在V2的范围里面
            //也就是说点击到了V2
            if (CGRectContainsPoint(self.frame, point)) {
                //记录这个点
                legend_point = [gesture locationInView:self];
                //可移动状态
                isMove = YES;
            }
    }else if (gesture.state == UIGestureRecognizerStateChanged){
  
            //    如果是可移动状态
            if (!isMove) {
                return;
            }
            //自动释放池
            @autoreleasepool {
                CGPoint translation = [gesture translationInView:self.superview];
                gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, translation.x, translation.y);
                [gesture setTranslation:CGPointZero inView:self.superview];
            }
        }
}

#pragma mark - 代理方法实现旋转 + 缩放捏合 可同时进行
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
