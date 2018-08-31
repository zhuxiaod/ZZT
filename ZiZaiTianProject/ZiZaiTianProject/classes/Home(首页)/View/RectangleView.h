//
//  RectangleView.h
//  手势改动的多边形
//
//  Created by mac on 2018/8/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RectangleView;


@protocol RectangleViewDelegate <NSObject>

-(void)checkRectangleView:(RectangleView *)rectangleView;

-(void)setupMainView:(RectangleView *)rectangleView;

-(void)enlargedAfterEditView:(RectangleView *)rectangleView isBig:(BOOL)isBig proportion:(CGFloat)proportion;

-(void)updateRectangleViewFrame:(RectangleView *)view;

@end

@interface RectangleView : UIView

@property (nonatomic,strong) UIView *superView;

@property(nonatomic,weak) id<RectangleViewDelegate>   delegate;

@property (nonatomic,assign) BOOL isClick;

@property (nonatomic,assign) BOOL isBig;

@property (nonatomic,assign) BOOL isHide;

@property (nonatomic,assign) NSInteger tagNum;
//方框存放视图的东西
@property (nonatomic,strong) UIView *mainView;

-(void)tapGestureTarget:(UITapGestureRecognizer *)gesture;

-(void)removeGestureRecognizer;

@end
