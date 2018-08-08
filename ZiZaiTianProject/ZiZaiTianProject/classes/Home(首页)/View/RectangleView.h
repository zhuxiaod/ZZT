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

@end

@interface RectangleView : UIView

@property (nonatomic,strong) UIView *superView;

@property(nonatomic,weak) id<RectangleViewDelegate>   delegate;

@property (nonatomic,assign) BOOL isClick;

@property (nonatomic,assign) NSInteger tagNum;
//方框存放视图的东西
@property (nonatomic,strong) UIView *mainView;

@end
