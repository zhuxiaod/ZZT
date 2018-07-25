//
//  EditImageView.m
//  WaterMarkDemo
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "EditImageView.h"

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

- (void)addUI{
    //间距 20
    CGFloat space = 20;
    //外框
    //整个view
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(space,space, self.frame.size.width-space*2, self.frame.size.height-space*2)];
    borderView.backgroundColor = [UIColor clearColor];
    borderView.layer.borderColor = [UIColor whiteColor].CGColor;
    borderView.layer.borderWidth = 2;
    borderView.layer.masksToBounds = YES;
    [self addSubview:borderView];
    _borderView = borderView;
//
    //编辑图标
    UIImage *editImg = [UIImage imageNamed:@"Enlarge.png"];
    UIImageView *editImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-editImg.size.width/2-5, -space, editImg.size.width, editImg.size.height)];
    editImgView.image = editImg;
    editImgView.center = CGPointMake(borderView.frame.origin.x+borderView.frame.size.width, borderView.frame.origin.y);
    [self addSubview:editImgView];
    _editImgView = editImgView;
    
    //关闭按钮
    UIImage *norImage = [UIImage imageNamed:@"Close.png"];
    UIImage *selImage = [UIImage imageNamed:@"Close.png"];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(1, self.frame.size.height - space, norImage.size.width, norImage.size.height);
    [closeBtn setImage:norImage forState:UIControlStateNormal];
    [closeBtn setImage:selImage forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    closeBtn.center = CGPointMake(borderView.frame.origin.x, borderView.frame.origin.y+borderView.frame.size.height);
    _closeImgView = closeBtn;
    
   _len = sqrt(self.frame.size.width/2*self.frame.size.width/2+self.frame.size.height/2*self.frame.size.height/2);
}

- (void)closeBtnClick:(UIButton *)btn{
    self.hidden = YES;
    //发送移除通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"remove" object:self];
}
//可编辑状态
- (void)showEditBtn{
    _isHide = NO;
    _borderView.hidden = NO;
    _editImgView.hidden = NO;
    _closeImgView.hidden = NO;
}
//隐藏
- (void)hideEditBtn{
    _isHide = YES;              
    _borderView.hidden = YES;
    _editImgView.hidden = YES;
    _closeImgView.hidden = YES;
}
//点击的开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.delagate && [self.delagate respondsToSelector:@selector(EditImageViewWithView:)]) {
        [self.delagate EditImageViewWithView:self];
    }
    //展示框
    NSLog(@"%ld",(long)self.tag);
    //把tag传出去 就知道是哪个传的了
    [self showEditBtn];
    UITouch *touch = [touches anyObject];
    //获取点击时所在父View的位置
    _startTouchPoint = [touch locationInView:self.superview];
    _startTouchCenter = self.center;
    //正在移动
    _isMove = YES;
    CGPoint p = [touch locationInView:self];
    
    NSLog(@"ttddddddddd----- %@   %@",NSStringFromCGRect(_editImgView.frame),NSStringFromCGPoint(p));
    //判断一个CGPoint 是否包含再另一个UIView的CGRect里面,常用与测试给定的对象之间是否又重叠
    if (CGRectContainsPoint(_editImgView.frame,p)) {
        _isMove = NO;
    }

}


//正在移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%ld",(long)self.tag);
    NSLog(@"touchesMoved");
    //如果是正在移动
    if (_isMove) {
        //获得当前的位置
        CGPoint curPoint = [[touches anyObject] locationInView:self.superview];
        //中心
        self.center =  CGPointMake(curPoint.x-(_startTouchPoint.x-_startTouchCenter.x), curPoint.y-(_startTouchPoint.y-_startTouchCenter.y));
    }else{
        //停止移动
        //比较位置
        CGPoint curPoint = [[touches anyObject] locationInView:self.superview];
        CGFloat sx = curPoint.x - self.center.x;
        CGFloat sy = curPoint.y - self.center.y;
        CGFloat curLen = sqrtf(sx*sx+sy*sy);
        CGFloat scale = curLen/_len;
        CGFloat tan = atanf(sy/sx);  //取到弧度
        CGFloat angle = tan * 180/M_PI;
        if (sx >= 0) {
            angle = angle + 45;
        }else{
            angle = angle + 225;
        }
        //图形变化
        _editImgView.transform = CGAffineTransformMakeScale(1.0f/scale, 1.0f/scale);
        _closeImgView.transform = CGAffineTransformMakeScale(1.0f/scale, 1.0f/scale);
        _borderView.layer.borderWidth = 2*1.0f/scale;
        
        CGFloat rad = angle/180*M_PI;
        self.transform = CGAffineTransformMakeScale(scale, scale);
        self.transform = CGAffineTransformRotate(self.transform,rad);
//        self.transform = CGAffineTransformMakeRotation(ra);
    }
}
//切换状态
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isMove = NO;

}




@end
