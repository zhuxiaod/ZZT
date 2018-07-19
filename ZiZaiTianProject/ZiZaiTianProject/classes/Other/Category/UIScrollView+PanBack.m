//
//  UIScrollView+PanBack.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/19.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "UIScrollView+PanBack.h"

@implementation UIScrollView (PanBack)

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([self panBack:gestureRecognizer]) {
        return NO;
    }
    return YES;
}
-(BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer{
    //是滑动返回距左边的有效长度
    int location_X =0.15*SCREEN_WIDTH;
    if (gestureRecognizer ==self.panGestureRecognizer) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self];
        UIGestureRecognizerState state = gestureRecognizer.state;
        if (UIGestureRecognizerStateBegan == state ||UIGestureRecognizerStatePossible == state) {
            CGPoint location = [gestureRecognizer locationInView:self];
            //这是允许每张图片都可实现滑动返回
            int temp1 = location.x;
            int temp2 = SCREEN_WIDTH;
            NSInteger XX = temp1 % temp2;
            if (point.x >0 && XX < location_X) {
                return YES;
                
                }
            }
        }
        return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self panBack:gestureRecognizer]) {
        return YES;
    }
    return NO;
}
@end
