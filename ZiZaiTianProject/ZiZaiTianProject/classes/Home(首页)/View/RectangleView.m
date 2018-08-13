//
//  RectangleView.m
//  手势改动的多边形
//
//  Created by mac on 2018/8/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RectangleView.h"
#import "UIView+Extension.h"
#import "Masonry.h"
@interface RectangleView (){
    //当前的比例
    CGFloat currentProportion;
    
    CGFloat startX;
    CGFloat startY;
    CGFloat startWidth;
    CGFloat startHeight;
    
    CGFloat pinchWidth;
    CGFloat pinchHeight;

    CGFloat selfWidth;
    CGFloat selfHeight;
    CGFloat proportion;
    CGRect lastFrame;
    
    CGPoint _startTouchPoint;
    CGPoint _startTouchCenter;
}

@property (nonatomic,weak) UIView *topBorder;
@property (nonatomic,weak) UIView *leftBorder;
@property (nonatomic,weak) UIView *rightBorder;
@property (nonatomic,weak) UIView *bottomBorder;
@property (nonatomic,strong) UIPanGestureRecognizer *click1;
@property (nonatomic,strong) UIPanGestureRecognizer *click2;
@property (nonatomic,strong) UIPanGestureRecognizer *click3;
@property (nonatomic,strong) UIPanGestureRecognizer *click4;

@end

@implementation RectangleView

int i = 0;

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.userInteractionEnabled = YES;
        //添加UI
        [self addUI];
        currentProportion = 0;
        self.isBig = NO;
        self.isClick = NO;
    }
    return self;
}

-(void)setIsBig:(BOOL)isBig{
    _isBig = isBig;
    //没有变大
    if(isBig == NO){
            self.mainView.userInteractionEnabled = NO;
            [self.topBorder addGestureRecognizer:self.click1];
            [self.leftBorder addGestureRecognizer:self.click2];
            [self.rightBorder addGestureRecognizer:self.click3];
            [self.bottomBorder addGestureRecognizer:self.click4];
    }else{
        //变大
        self.mainView.userInteractionEnabled = YES;
        //边失去控制
        [self.topBorder removeGestureRecognizer:self.click1];
        
        [self.leftBorder removeGestureRecognizer:self.click2];
        
        [self.rightBorder removeGestureRecognizer:self.click3];
        
        [self.bottomBorder removeGestureRecognizer:self.click4];

    }
}
#pragma mark - 对边操作
-(void)tapTarget:(UIPanGestureRecognizer *)panGesture{
    //改变变量
    CGFloat width = startWidth;
    CGFloat height = startHeight;
    CGFloat x = startX;
    CGFloat y = startY;
    
    //限制这条边的移动范围
    if(panGesture.state == UIGestureRecognizerStateBegan){
        //获取当前状态
        startHeight = self.height;
        startWidth = self.width;
        startX = self.x;
        startY = self.y;
        
        //记录在自己的那个点
        legend_point = [panGesture locationInView:panGesture.view];
        
    }else if(panGesture.state == UIGestureRecognizerStateEnded) {
        
        startHeight = self.height;
        startWidth = self.width;
        startX = self.x;
        startY = self.y;
        //结束时
        lastFrame = self.frame;
        
    }else if (panGesture.state == UIGestureRecognizerStateChanged){
        width = startWidth;
        height = startHeight;
        x = startX;
        y = startY;
        
        CGPoint point = [panGesture translationInView:self.superView];
        //换算成中心点
        point.x += panGesture.view.frame.size.width/2.0f - legend_point.x;
        point.y += panGesture.view.frame.size.height/2.0f - legend_point.y;
        //点到自己的位置
        if(panGesture.view.tag == 4){
            height = startHeight + point.y;
            if (height >= self.superView.height - startY) {
                height = self.superView.height - startY;
            }
            height = [self minimumlimit:height];
            
        }else if(panGesture.view.tag == 3){
            width = startWidth + point.x;
            if (width >= self.superView.width - startX) {
                width = self.width;
            }
            width = [self minimumlimit:width];
            
        }else if (panGesture.view.tag == 2){
            x = startX + point.x;
            point.x = [self oppositeNumber:point.x];
            width = startWidth + point.x;
            if (x < 1) {
                x = 1;
                width = self.width;
            }
            width = [self minimumlimit:width];
            if(width == 100){
                x = self.x;
            }else{
                x = startX - point.x;
            }
        }else{
            point.y = [self oppositeNumber:point.y];
            height = startHeight + point.y;
            if (y < 1) {
                y = 1;
                height = self.height;
            }
            height = [self minimumlimit:height];
            if(height == 100){
                y = self.y;
            }else{
                y = startY - point.y;
            }
        }
        self.frame = CGRectMake(x, y, width, height);
    }
}

//成为主View
-(void)beCurrentMainView{
    //把这个view传出去 然后
    if(self.delegate && [self.delegate respondsToSelector:@selector(checkRectangleView:)]){
        [self.delegate checkRectangleView:self];
    }
}

-(void)setIsClick:(BOOL)isClick{
    _isClick = isClick;
    if(self.delegate && [self.delegate respondsToSelector:@selector(checkRectangleView:)]){
        [self.delegate checkRectangleView:self];
    }
}

#pragma mark - 移动手势
BOOL isMove;
CGPoint legend_point;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    self.isClick = YES;
    if(self.delegate && [self.delegate respondsToSelector:@selector(checkRectangleView:)]){
        [self.delegate checkRectangleView:self];
    }

    //默认状态为no
    isMove = NO;
    //获取响应事件的对象
    UITouch *touch = [touches anyObject];
    //获取在屏幕上的点
    CGPoint point = [touch locationInView:self.superView];
    //如果这个点在V2的范围里面
    //也就是说点击到了V2
    if (CGRectContainsPoint(self.frame, point)) {
        //记录这个点
        legend_point = [touch locationInView:self];
        //可移动状态
        isMove = YES;
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(setupMainView:)]){
        [self.delegate setupMainView:self];
    }
//    如果是可移动状态
    if (!isMove) {
        return;
    }
    //自动释放池
    @autoreleasepool {
        //获得点击对象
        UITouch *touch = [touches anyObject];
        //在屏幕上的点
        CGPoint point = [touch locationInView:self.superView];
        //转化成相对的中心
        //可将点击的点 变成点击中心点 移动
        point.x += self.frame.size.width/2.0f - legend_point.x;
        point.y += self.frame.size.height/2.0f - legend_point.y;
        //        限制范围
        //如果点小于中心位置 那么直接变成中心位置
        if (point.x < self.width / 2.0f) {
            point.x = self.width / 2.0f;
        }
        if (point.y < self.height / 2.0f) {
            point.y = self.height / 2.0f;
        }
        //中心点不能离开 325的位置
        if (point.x > self.superView.width - self.width / 2.0f) {
            point.x = self.superView.width - self.width / 2.0f;
        }
        if (point.y > self.superView.height - self.height / 2.0f) {
            point.y = self.superView.height - self.height / 2.0f;
        }
        //通过点来计算中心点  控制中心点的位置
        self.center = point;
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateRectangleViewFrame:)]) {
        [self.delegate updateRectangleViewFrame:self];
    }
    
}
#pragma mark - 初始化
-(void)addUI{
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor grayColor];
    self.mainView = mainView;
    [self addSubview:mainView];
    //创建4条边
    UIView *topBorder = [[UIView alloc] init];
    topBorder.tag = 1;
    topBorder.backgroundColor = [UIColor blackColor];
    self.topBorder = topBorder;
    [self addSubview:topBorder];
    
    UIView *leftBorder = [[UIView alloc] init];
    leftBorder.tag = 2;
    leftBorder.backgroundColor = [UIColor blackColor];
    self.leftBorder = leftBorder;
    [self addSubview:leftBorder];
    
    UIView *rightBorder = [[UIView alloc] init];
    rightBorder.tag = 3;
    self.rightBorder = rightBorder;
    rightBorder.backgroundColor = [UIColor blackColor];
    [self addSubview:rightBorder];
    
    UIView *bottomBorder = [[UIView alloc] init];
    bottomBorder.tag = 4;
    self.bottomBorder = bottomBorder;
    bottomBorder.backgroundColor = [UIColor blackColor];
    [self addSubview:bottomBorder];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [topBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(8);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
    }];
    
    [leftBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(8);
    }];
    
    [rightBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
        make.width.mas_equalTo(8);
    }];
    
    [bottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(8);
    }];
    
    UIPanGestureRecognizer *click1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapTarget:)];

    UIPanGestureRecognizer *click2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapTarget:)];
    UIPanGestureRecognizer *click3 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapTarget:)];
    UIPanGestureRecognizer *click4 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapTarget:)];
    
    [topBorder addGestureRecognizer:click1];
    [leftBorder addGestureRecognizer:click2];
    [rightBorder addGestureRecognizer:click3];
    [bottomBorder addGestureRecognizer:click4];
    
    self.click1 = click1;
    self.click2 = click2;
    self.click3 = click3;
    self.click4 = click4;
    
    UIPinchGestureRecognizer *PinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self addGestureRecognizer:PinchGestureRecognizer];

    UITapGestureRecognizer *TapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTarget:)];
    TapGestureRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:TapGestureRecognizer];
    self.layer.masksToBounds = YES;
    
    //删除
    UITapGestureRecognizer *removeGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeGestureRecognizer:)];
    removeGestureRecognizer.numberOfTapsRequired = 3;
    [self addGestureRecognizer:removeGestureRecognizer];
}

#pragma mark - 删除事件
-(void)removeGestureRecognizer:(UITapGestureRecognizer *)gesture{
    self.hidden = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeRectangleView" object:self];
}

#pragma mark - 双击事件
-(void)tapGestureTarget:(UITapGestureRecognizer *)gesture{
    selfHeight = self.height;
    selfWidth = self.width;
    //倍数越小的  越快放大
    CGFloat pW = self.superView.width / self.width;
    CGFloat pH = self.superView.height / self.height;
    
    //是放大
    if(self.isBig == NO){
        lastFrame = self.frame;

        //等比放大
        if(pW < pH){
            selfWidth = self.superView.width;
            proportion = self.superView.width / self.width;
            selfHeight = selfHeight * proportion;
        }else{
            selfHeight = self.superView.height;
            proportion = self.superView.height / self.height;
            selfWidth = selfWidth * proportion;
        }
        
        self.frame = CGRectMake(0, 0, selfWidth, selfHeight);
        //放大后代理
        self.isBig = YES;
        if(self.delegate && [self.delegate respondsToSelector:@selector(enlargedAfterEditView:isBig:proportion:)]){
            [self.delegate enlargedAfterEditView:self isBig:self.isBig proportion:proportion];
        }
    }else{
        self.frame = lastFrame;
        self.isBig = NO;
        if(self.delegate && [self.delegate respondsToSelector:@selector(enlargedAfterEditView:isBig:proportion:)]){
            [self.delegate enlargedAfterEditView:self isBig:self.isBig proportion:proportion];
        }
    }
}

#pragma mark - 捏合手势
-(void)pinch:(UIPinchGestureRecognizer *)gesture{
    CGFloat scale = gesture.scale;
    
    pinchWidth= gesture.view.width * scale;
    pinchHeight = gesture.view.height * scale;

    if(gesture.state == UIGestureRecognizerStateBegan){
        //获取当前状态
        startHeight = self.height;
        startWidth = self.width;
        startX = self.x;
        startY = self.y;
        
    }else if(gesture.state == UIGestureRecognizerStateEnded) {
        
        startHeight = self.height;
        startWidth = self.width;
        startX = self.x;
        startY = self.y;
        
    }else if (gesture.state == UIGestureRecognizerStateChanged){

        if(pinchWidth >= self.superView.width - startX){
            pinchWidth = self.width;
            pinchHeight = self.height;
        }
        if(pinchHeight >= self.superView.height - startY){
            pinchHeight = self.height;
            pinchWidth = self.width;
        }
        if(pinchWidth <= 100){
            pinchWidth = 100;
            pinchHeight = self.height;
        }
        if(pinchHeight <= 100){
            pinchHeight = 100;
            pinchWidth = self.width;
        }
        self.frame = CGRectMake(startX, startY, pinchWidth, pinchHeight);
    }
}

//最小限制
-(CGFloat)minimumlimit:(CGFloat)num{
    if(num < 100){
        num = 100;
    }
    return num;
}

//相反数
-(CGFloat)oppositeNumber:(CGFloat)number{
    if(number < 0){
        number = ABS(number);
    }else{
        number = -number;
    }
    return number;
}

@end
