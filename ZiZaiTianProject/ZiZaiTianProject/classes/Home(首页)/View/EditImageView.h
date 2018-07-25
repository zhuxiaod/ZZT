//
//  EditImageView.h
//  WaterMarkDemo
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditImageView;

@protocol EditImageViewDelegate<NSObject>

-(void)EditImageViewWithView:(EditImageView *)view;

@end

@interface EditImageView : UIImageView{
    //是否在移动
    BOOL _isMove;
    //起始点
    CGPoint _startTouchPoint;
    //起始中间
    CGPoint _startTouchCenter;
    //外边栏
    UIView *_borderView;
    //图片
    UIImageView *_editImgView;
    //关闭按钮
    UIButton *_closeImgView;
    //长度？
    CGFloat _len;
    //imageView

}

- (void)hideEditBtn;

- (void)closeBtnClick:(UIButton *)btn;

@property (nonatomic,strong)id<EditImageViewDelegate>delagate;

@property (nonatomic,assign) BOOL isHide;

@end
