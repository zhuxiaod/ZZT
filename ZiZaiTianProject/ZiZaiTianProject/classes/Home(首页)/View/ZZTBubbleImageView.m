//
//  ZZTBubbleImageView.m
//  汽泡demo
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZZTBubbleImageView.h"

#define IS_IOS_7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f)
#define IMAGE_ICON_SIZE   20
#define MAX_FONT_SIZE     500
CG_INLINE CGPoint CGRectGetCenter(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CG_INLINE CGFloat CGAffineTransformGetAngle(CGAffineTransform t)
{
    return atan2(t.b, t.a);
}

CG_INLINE CGFloat CGPointGetDistance(CGPoint point1, CGPoint point2)
{
    //Saving Variables.
    CGFloat fx = (point2.x - point1.x);
    CGFloat fy = (point2.y - point1.y);
    
    return sqrt((fx*fx + fy*fy));
}

@interface ZZTBubbleImageView(){
    CGPoint prevPoint;
    CGPoint touchLocation;
    
    CGPoint beginningPoint;
    CGPoint beginningCenter;
    
    CGRect beginBounds;
    
    CGRect initialBounds;
    CGFloat initialDistance;
    
    CGFloat deltaAngle;
    //外边栏
    UIView *_borderView;
    //图片
    UIButton *_editImgView;
    //关闭按钮
    UIButton *_closeImgView;
    //长度？
    CGFloat _len;
    //起始点
    CGPoint _startTouchPoint;
    //起始中间
    CGPoint _startTouchCenter;
    UIImage *editImage;
    //是否在移动
    BOOL _isMove;
    UITextView *TextView;
}

@property (nonatomic,strong)UITextView * textView;
@property (strong, nonatomic) UIImageView *resizingControl;//旋转图片
@property (strong, nonatomic) UIImageView *deleteControl;//删除图片
@property (nonatomic,assign)BOOL isDeleting;

@end

@implementation ZZTBubbleImageView
/*
 只co我想co的代码
 汽泡实现
 1.关闭按钮
 2.图片显示
 3.旋转按钮
 4.textView
 
 怎么操作呢？？？
 界面布局
 关闭、旋转按钮百分比设置
 
 图片显示
 难点：
    计算出图片与文字的关系  文字需要在图片里面
    这里关系要写好
    显示文字的区域是一定的 但是随着字体的增加 字体需要改变字号
    将其显示在里面 - -
 
 先把界面和手势搭建好
 
 用状态来管理 这个里面的东西
 不能闪烁
 
 缩小后
 重新计算字号
 */

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        //设置字体
        UIFont *font = [UIFont systemFontOfSize:14];
        self.curFont = font;
        self.minFontSize = font.pointSize;
        ////创建TextView
        [self createTextViewWithFrame:CGRectZero text:nil font:nil];
        
        //旋转 以后要添加点击状态
        self.resizingControl = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IMAGE_ICON_SIZE, IMAGE_ICON_SIZE)];
        self.resizingControl.image = [UIImage imageNamed:@"Enlarge.png"];
        //        self.resizingControl.backgroundColor = [UIColor redColor];
        self.resizingControl.userInteractionEnabled = YES;
        [self addSubview:self.resizingControl];
        
        //删除
        self.deleteControl = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IMAGE_ICON_SIZE, IMAGE_ICON_SIZE)];
        self.deleteControl.image = [UIImage imageNamed:@"Close.png"];
        //        self.deleteControl.backgroundColor = [UIColor purpleColor];
        self.deleteControl.userInteractionEnabled = YES;
        [self addSubview:self.deleteControl];
        
        //关闭
        UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteControlTapAction:)];
        [self.deleteControl addGestureRecognizer:closeTap];
        
        //移动
        UIPanGestureRecognizer *moveGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveGestureAction:)];
        [self addGestureRecognizer:moveGesture];
        
        //旋转
        UIPanGestureRecognizer *panRotateGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotateViewPanGesture:)];
        [self.resizingControl addGestureRecognizer:panRotateGesture];
        
        [moveGesture requireGestureRecognizerToFail:closeTap];
        
        [self layoutSubViewWithFrame:frame];
        
        CGFloat cFont = 1;
        
        self.textView.text = text;
        
        self.minSize = CGSizeMake(IMAGE_ICON_SIZE, IMAGE_ICON_SIZE);
        //如果图片高度大于 本身的高度 或者 图片宽度大于本身的宽 或者 高度小于零  或者宽度小于零
        if (self.minSize.height >  frame.size.height ||
            self.minSize.width  >  frame.size.width  ||
            self.minSize.height <= 0 || self.minSize.width <= 0)
        {
            //宽 高 设置为本身的三分之一
            self.minSize = CGSizeMake(frame.size.width/3.f, frame.size.height/3.f);
        }
        
        CGSize  tSize = IS_IOS_7?[self textSizeWithFont:cFont text:[text length]?nil:@"点击输入内容"]:CGSizeZero;
        do
        {
            if (IS_IOS_7)
            {
                tSize = [self textSizeWithFont:++cFont text:[text length]?nil:@"点击输入内容"];
            }
            else
            {
                [self.textView setFont:[self.curFont fontWithSize:++cFont]];
            }
        }
        while (![self isBeyondSize:tSize] && cFont < MAX_FONT_SIZE);

        if (cFont < /*self.minFontSize*/0) return nil;
        cFont = (cFont < MAX_FONT_SIZE) ? cFont : self.minFontSize;
        [self.textView setFont:[self.curFont fontWithSize:--cFont]];
        [self centerTextVertically];
        
    }
    return self;
}

#pragma mark - 删除
-(void)deleteControlTapAction:(UIGestureRecognizer *)gesture{
    [self removeFromSuperview];
    //    if([self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidClose:)]) {
    //        [self.bubbleDelegate bubbleViewDidClose:self];
    //    }
}

- (void)layoutSubViewWithFrame:(CGRect)frame{
    
    CGRect tRect = frame;
    
    tRect.size.width = self.bounds.size.width * 0.64;
    tRect.size.height = self.bounds.size.height * 0.53;
    tRect.origin.x = (self.bounds.size.width - tRect.size.width) * 0.5;
    
    CGFloat orignY = 0.23;
    tRect.origin.y = self.bounds.size.height * orignY;
    
    [self.textView setFrame:tRect];
    
    [self.deleteControl setFrame:CGRectMake(0, 0, IMAGE_ICON_SIZE, IMAGE_ICON_SIZE)];
    
    [self.resizingControl setFrame:CGRectMake(self.bounds.size.width - IMAGE_ICON_SIZE, self.bounds.size.height-IMAGE_ICON_SIZE, IMAGE_ICON_SIZE, IMAGE_ICON_SIZE)];
}

- (void)showEditBtn{    
    self.resizingControl.hidden = NO;
    self.deleteControl.hidden = NO;
}

-(void)hideEditBtn{
    //关闭键盘
    [self endEditing:YES];
    self.resizingControl.hidden = YES;
    self.deleteControl.hidden = YES;
}
-(void)setIsHide:(BOOL)isHide{
    _isHide = isHide;
    if(isHide == YES){
        [self hideEditBtn];
    }else{
        [self showEditBtn];
    }
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self layoutSubViewWithFrame:frame];
    [self textViewDidChange:TextView];
//    [self test:@"请点击输入内容"];
    //超出才会再次计算
}
-(void)setModel:(ZZTEditImageViewModel *)model{
    _model = model;
    
}
#pragma 移动手势
-(void)moveGestureAction:(UIGestureRecognizer *)recognizer{
    //起点
    touchLocation = [recognizer locationInView:self.superview];
    //开始的时候
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (self.bubbleDelegate && [self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidBeginEditing:)]) {
            [self.bubbleDelegate bubbleViewDidBeginEditing:self];
        }
        self.isHide = NO;
        //起点 - 中心点
        beginningPoint = touchLocation;
        beginningCenter = self.center;
        [self setCenter:CGPointMake(beginningCenter.x+(touchLocation.x-beginningPoint.x), beginningCenter.y+(touchLocation.y-beginningPoint.y))];
        beginBounds = self.bounds;
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (self.bubbleDelegate && [self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidBeginMoving:)]) {
            [self.bubbleDelegate bubbleViewDidBeginMoving:self];
        }
        [self setCenter:CGPointMake(beginningCenter.x+(touchLocation.x-beginningPoint.x), beginningCenter.y+(touchLocation.y-beginningPoint.y))];

    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self setCenter:CGPointMake(beginningCenter.x+(touchLocation.x-beginningPoint.x), beginningCenter.y+(touchLocation.y-beginningPoint.y))];

    }
    prevPoint = touchLocation;
}

#pragma mark - 旋转
- (void)rotateViewPanGesture:(UIGestureRecognizer *)recognizer{
    touchLocation = [recognizer locationInView:self.superview];
    
    CGPoint center = CGRectGetCenter(self.frame);
    
    if ([recognizer state] == UIGestureRecognizerStateBegan) {
        //求出反正切角
        deltaAngle = atan2(touchLocation.y-center.y, touchLocation.x-center.x)-CGAffineTransformGetAngle(self.transform);
        initialBounds = self.bounds;
        initialDistance = CGPointGetDistance(center, touchLocation);

    } else if([recognizer state] == UIGestureRecognizerStateChanged){
        BOOL increase = NO;
        //如果self的宽度 小于 最小尺寸  或则  高度 小于  最小的高度
        if(self.bounds.size.width < self.minSize.width || self.bounds.size.height < self.minSize.height){
            //设置最小的大小
            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.minSize.width, self.minSize.height);
            //旋转的位置
            self.resizingControl.frame = CGRectMake(self.bounds.size.width - IMAGE_ICON_SIZE, self.bounds.size.height - IMAGE_ICON_SIZE, IMAGE_ICON_SIZE, IMAGE_ICON_SIZE);
            self.deleteControl.frame = CGRectMake(0, 0, IMAGE_ICON_SIZE, IMAGE_ICON_SIZE);
            prevPoint = [recognizer locationInView:self];
        } else{
            //如果移动的是负数
            CGPoint point = [recognizer locationInView:self];
            float wChange = 0.0,hChange = 0.0;
            wChange = (point.x - prevPoint.x);
            hChange = (point.y - prevPoint.y);
            if(ABS(wChange) > 20.0f || ABS(hChange) > 20.f){
                prevPoint = [recognizer locationInView:self];
                return;
            }
            if(YES){
                if (wChange < 0.0f && hChange < 0.0f) {
                    float change = MIN(wChange, hChange);
                    wChange = change;
                    hChange = change;
                }
                if (wChange < 0.0f) {
                    hChange = wChange;
                }else if (hChange < 0.0f){
                    wChange = hChange;
                }else{
                    float change = MAX(wChange, hChange);
                    wChange = change;
                    hChange = change;
                }
            }
            increase = wChange > 0?YES:NO;
            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width + (wChange), self.bounds.size.height + (hChange));
            
            [self layoutSubViewWithFrame:self.bounds];
            
            self.resizingControl.frame = CGRectMake(self.bounds.size.width-IMAGE_ICON_SIZE, self.bounds.size.height-IMAGE_ICON_SIZE, IMAGE_ICON_SIZE, IMAGE_ICON_SIZE);
            
            self.deleteControl.frame = CGRectMake(0, 0, IMAGE_ICON_SIZE, IMAGE_ICON_SIZE);
            prevPoint = [recognizer locationInView:self];
        }
        float ang = atan2([recognizer locationInView:self.superview].y - self.center.y,[recognizer locationInView:self.superview].x - self.center.x);
        float angleDiff = deltaAngle - ang;
        self.transform = CGAffineTransformMakeRotation(-angleDiff);
        
        if (IS_IOS_7) {
            self.textView.textContainerInset = UIEdgeInsetsZero;
        }else{
            self.textView.contentOffset = CGPointZero;
        }
        
        if([self.textView.text length]){
            CGFloat cFont = self.textView.font.pointSize;
            CGSize  tSize = IS_IOS_7?[self textSizeWithFont:cFont text:nil]:CGSizeZero;
            if(increase){
                do{
                    if (IS_IOS_7) {
                        tSize = [self textSizeWithFont:++cFont text:nil];
                    }
                    else{
                        [self.textView setFont:[self.curFont fontWithSize:++cFont]];
                    }
                }
                while (![self isBeyondSize:tSize] && cFont < MAX_FONT_SIZE);
                cFont = (cFont < MAX_FONT_SIZE) ? cFont : self.minFontSize;
                [self.textView setFont:[self.curFont fontWithSize:--cFont]];
            }
            else{
                while ([self isBeyondSize:tSize] && cFont > 0) {
                    if(IS_IOS_7){
                        tSize = [self textSizeWithFont:--cFont text:nil];
                    }
                    else{
                        [self.textView setFont:[self.curFont fontWithSize:--cFont]];
                    }
                }
                [self.textView setFont:[self.curFont fontWithSize:cFont]];
            }
        }
        [self centerTextVertically];
    }else if ([recognizer state] == UIGestureRecognizerStateEnded){
        
    }
}

- (NSString *)textString
{
    return self.textView.text;
}

#pragma mark TextView
- (void)createTextViewWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font
{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    TextView = textView;
    //禁止滚动
    textView.scrollEnabled = NO;
    textView.delegate = self;
    //键盘风格
    textView.keyboardType  = UIKeyboardTypeASCIICapable;
    //回城风格
    textView.returnKeyType = UIReturnKeyDone;
    //文字中央
    textView.textAlignment = NSTextAlignmentCenter;
    //背景颜色
    [textView setBackgroundColor:[UIColor clearColor]];
    //文字颜色
    [textView setTextColor:[UIColor redColor]];
    //设置内容
    [textView setText:text];
    //设置字体
    [textView setFont:font];
    //自动修正
    [textView setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self addSubview:textView];
    //处于最底处
    [self sendSubviewToBack:textView];
    
    if (IS_IOS_7)
    {
        textView.textContainerInset = UIEdgeInsetsZero;
    }
    else
    {
        textView.contentOffset = CGPointZero;
    }
    [self setTextView:textView];
}
//文字尺寸与字体 文字
- (CGSize)textSizeWithFont:(CGFloat)font text:(NSString *)string
{
    //文字内容
    NSString *text = string ? string : self.textView.text;
    //行内边距
    CGFloat pO = self.textView.textContainer.lineFragmentPadding * 2;
    //
    CGFloat cW = self.textView.frame.size.width - pO;
    //设置文字大小
    CGSize  tH = [text sizeWithFont:[self.curFont fontWithSize:font]
                  constrainedToSize:CGSizeMake(cW, MAXFLOAT)
                      lineBreakMode:NSLineBreakByWordWrapping];
    return  tH;
}

//中央字体垂直
- (void)centerTextVertically
{
    if (IS_IOS_7)
    {
        CGSize tH = [self textSizeWithFont:self.textView.font.pointSize text:nil];
        CGFloat offset = (self.textView.frame.size.height - tH.height)/2.f;
        
        self.textView.textContainerInset = UIEdgeInsetsMake(offset, 0, offset, 0);
    }
    else
    {
        CGFloat fH = self.textView.frame.size.height;
        CGFloat cH = self.textView.contentSize.height;
        [self.textView setContentOffset:CGPointMake(0, (cH-fH)/2.f)];
    }
    
#if TEST_CENTER_ALIGNMENT
    [self.indicatorView setFrame:CGRectMake(0, offset, self.frame.size.width, tH.height)];
#else
    // ...
#endif
}

- (BOOL)isBeyondSize:(CGSize)size
{
    if (IS_IOS_7)
    {
        CGFloat ost = _textView.textContainerInset.top + _textView.textContainerInset.bottom;
        return size.height + ost > self.textView.frame.size.height;
    }
    else
    {
        //内容高度大于textView高度
        return self.textView.contentSize.height > self.textView.frame.size.height;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self endEditing:YES];
        //        if (self.delegate && [self.delegate respondsToSelector:@selector(textViewDidEndEditing:)])
        //        {
        //            [self.delegate textViewDidEndEditing:self];
        //        }
        return NO;
    }
    //
    _isDeleting = (range.length >= 1 && text.length == 0);
    
    if (textView.font.pointSize <= self.minFontSize && !_isDeleting) return NO;
    
    return YES;
}
//已经发生改变
- (void)textViewDidChange:(UITextView *)textView
{
    //获取字
    NSString *calcStr = textView.text;
    //字体没有长度的话  显示提示信息
    if (![textView.text length]) [self.textView setText:@"点击输入内容"];
    CGFloat cFont = self.textView.font.pointSize;
    //调整字体的大小
    CGSize  tSize = IS_IOS_7?[self textSizeWithFont:cFont text:nil]:CGSizeZero;
    //如果是iOS 7以上
    if (IS_IOS_7)
    {   //设置内边距
        self.textView.textContainerInset = UIEdgeInsetsZero;
    }
    else
    {
        self.textView.contentOffset = CGPointZero;
    }
    
    if (_isDeleting)
    {
        do
        {
            if (IS_IOS_7)
            {
                tSize = [self textSizeWithFont:++cFont text:nil];
            }
            else
            {
                [self.textView setFont:[self.curFont fontWithSize:++cFont]];
            }
        }
        while (![self isBeyondSize:tSize] && cFont < MAX_FONT_SIZE);
        
        cFont = (cFont < MAX_FONT_SIZE) ? cFont : self.minFontSize;
        [self.textView setFont:[self.curFont fontWithSize:--cFont]];
    }
    else
    {
        
        NSLog(@"---%d",[self isBeyondSize:tSize]);
        
        while ([self isBeyondSize:tSize] && cFont > 0)
        {
            if (IS_IOS_7)
            {
                tSize = [self textSizeWithFont:--cFont text:nil];
            }
            else
            {
                [self.textView setFont:[self.curFont fontWithSize:--cFont]];
            }
        }
        [self.textView setFont:[self.curFont fontWithSize:cFont]];
    }
    [self centerTextVertically];
    [self.textView setText:calcStr];
}
#pragma mark 开启键盘
- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView
{
    if (self.bubbleDelegate && [self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidBeginEditing:)]) {
        [self.bubbleDelegate bubbleViewDidBeginEditing:self];
    }
    self.isHide = NO;
    return YES;
}
-(void)test:(NSString *)str{
    
    NSString *calcStr = str;

    CGFloat cFont = self.textView.font.pointSize;
    CGSize  tSize = IS_IOS_7?[self textSizeWithFont:cFont text:nil]:CGSizeZero;

        do
        {
            if (IS_IOS_7)
            {
                tSize = [self textSizeWithFont:++cFont text:nil];
            }
            else
            {
                [self.textView setFont:[self.curFont fontWithSize:++cFont]];
            }
        }
        while (![self isBeyondSize:tSize] && cFont < MAX_FONT_SIZE);
        
        cFont = (cFont < MAX_FONT_SIZE) ? cFont : self.minFontSize;
        [self.textView setFont:[self.curFont fontWithSize:--cFont]];
    
    [self centerTextVertically];
    [self.textView setText:calcStr];
}
@end
