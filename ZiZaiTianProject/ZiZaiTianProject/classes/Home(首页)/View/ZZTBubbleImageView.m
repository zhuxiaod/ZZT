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

@interface ZZTBubbleImageView()<UITextViewDelegate,UIGestureRecognizerDelegate>{
//    CGPoint prevPoint;
//    CGPoint touchLocation;
//
//    CGPoint beginningPoint;
//    CGPoint beginningCenter;
//
//    CGRect beginBounds;
//
//    CGRect initialBounds;
//    CGFloat initialDistance;
//
//    CGFloat deltaAngle;
//    //外边栏
//    UIView *_borderView;
//    //图片
//    UIButton *_editImgView;
//    //关闭按钮
//    UIButton *_closeImgView;
//    //长度？
//    //起始点
//    CGPoint startTouchPoint;
//    //起始中间
//    CGPoint startTouchCenter;
//    UIImage *editImage;
    //是否在移动
//    CGPoint provePoint;
//    UITextView *TextView;
}

@property (nonatomic,strong) UITextView * textView;
@property (strong, nonatomic) UIImageView *resizingControl;//旋转图片
@property (strong, nonatomic) UIImageView *deleteControl;//删除图片
@property (nonatomic,assign)BOOL isDeleting;
@property (nonatomic,assign) CGFloat scale;

@end

@implementation ZZTBubbleImageView
/*
 
textView 大小问题 和 输入输出问题
 
 */

#pragma mark - 捏合手势
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    if([self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidBeginEditing:)]) {
        [self.bubbleDelegate bubbleViewDidBeginEditing:self];
    }
    //记录开始的bounds
    BOOL increase = NO;

    if([recognizer state] == UIGestureRecognizerStateChanged && [self.curType isEqualToString:self.type]){

        CGFloat scale = recognizer.scale;
        recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, scale, scale);
        increase = YES;
        if(scale != 1){
            if(scale > 1){
                self.scale += (scale - 1);
            }else{
                self.scale -= (1 - ABS(scale));
            }
        }
        NSLog(@"scale:%f",self.scale);
        if (self.bubbleDelegate && [self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidRotate:)]) {
            [self.bubbleDelegate bubbleViewDidRotate:self];
        }

        CGRect rect2 = CGRectMake(0, 0, roundf(self.bounds.size.width * self.scale), roundf(self.bounds.size.height * self.scale));

        [self layoutSubViewWithFrame:rect2];
        recognizer.scale = 1.0;

    }

        if (IS_IOS_7)
        {
            self.textView.textContainerInset = UIEdgeInsetsZero;
        }
        else
        {
            self.textView.contentOffset = CGPointZero;
        }

        if ([self.textView.text length])
        {
            CGFloat cFont = self.textView.font.pointSize;
            CGSize  tSize = IS_IOS_7?[self textSizeWithFont:cFont text:nil]:CGSizeZero;
            if (increase)
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
        }
        [self centerTextVertically];
}

-(void)hideEditBtn{
    //关闭键盘
    [self endEditing:YES];

}

-(void)setIsHide:(BOOL)isHide{
    _isHide = isHide;
    if(isHide == YES){
        [self hideEditBtn];
    }
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self layoutSubViewWithFrame:frame];
    [self textViewDidChange:_textView];
}

-(void)setModel:(ZZTEditImageViewModel *)model{
    _model = model;
}

- (NSString *)textString
{
    return self.textView.text;
}

#pragma mark - 代理方法实现旋转 + 缩放捏合 可同时进行
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text superView:(UIView *)superView{
    self = [super initWithFrame:frame];
    if(self){
        self.userInteractionEnabled = YES;
        UIFont *font = [UIFont systemFontOfSize:14];
        //设置字号
        self.curFont = font;
        //14 号为最小字体大小
        self.minFontSize = font.pointSize;
        //创建TextView
        [self createTextViewWithFrame:CGRectZero text:nil font:nil];
        
        //旋转手势  添加方法
        UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateViewPanGesture:)];
        rotationGestureRecognizer.delegate = self;
        [self addGestureRecognizer:rotationGestureRecognizer];
        
        //捏合
        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        pinchGestureRecognizer.delegate = self;
        [self addGestureRecognizer:pinchGestureRecognizer];
        
        _len = sqrt(self.frame.size.width/2*self.frame.size.width/2+self.frame.size.height/2*self.frame.size.height/2);
        
        [self layoutSubViewWithFrame:frame];
        
        //删除功能
        //文本视图
        CGFloat cFont = 1;
        self.textView.text = text;
        self.minSize = CGSizeMake(IMAGE_ICON_SIZE, IMAGE_ICON_SIZE);
        //安全处理  - 不会小到看不到了
        if (self.minSize.height >  frame.size.height ||
            self.minSize.width  >  frame.size.width  ||
            self.minSize.height <= 0 || self.minSize.width <= 0)
        {
            self.minSize = CGSizeMake(frame.size.width/3.f, frame.size.height/3.f);
        }
        CGSize tSize = IS_IOS_7?[self textSizeWithFont:cFont text:[text length]?nil:@"点击输入内容"]:CGSizeZero;
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
        
        //移动
        UIPanGestureRecognizer *PanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(selfMove:)];
        [self addGestureRecognizer:PanGestureRecognizer];
        
    }
    return self;
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

- (CGSize)textSizeWithFont:(CGFloat)font text:(NSString *)string
{
    //获得文字
    NSString *text = string ? string : self.textView.text;
    //视图的大小
    CGFloat pO = self.textView.textContainer.lineFragmentPadding * 2;
    CGFloat cW = self.textView.frame.size.width - pO;
    CGSize  tH = [text sizeWithFont:[self.curFont fontWithSize:font]
                  constrainedToSize:CGSizeMake(cW, MAXFLOAT)
                      lineBreakMode:NSLineBreakByWordWrapping];
    return  tH;
}

#pragma mark - 旋转手势
-(void)rotateViewPanGesture:(UIRotationGestureRecognizer *)recognizer{
    if([self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidBeginEditing:)]) {
        [self.bubbleDelegate bubbleViewDidBeginEditing:self];
    }
    if([self.curType isEqualToString: self.type]){
        recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
        recognizer.rotation = 0.0;
        if (self.bubbleDelegate && [self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidRotate:)]) {
            [self.bubbleDelegate bubbleViewDidRotate:self];
        }
    }
}

#pragma mark - 移动手势
-(void)selfMove:(UIPanGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){
        _startTouchPoint = [gesture locationInView:self.superView];
        _startTouchCenter = self.center;
        //正在移动
        _isMove = YES;
        if([self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidBeginEditing:)]) {
            [self.bubbleDelegate bubbleViewDidBeginEditing:self];
        }
    }else if(gesture.state == UIGestureRecognizerStateChanged){
        if (_isMove && [self.curType isEqualToString:self.type]) {
            //获得当前的位置
            CGPoint curPoint = [gesture locationInView:self.superView];
            //中心
            self.center = CGPointMake(curPoint.x-(_startTouchPoint.x-_startTouchCenter.x), curPoint.y-(_startTouchPoint.y-_startTouchCenter.y));
            if([self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidBeginMoving:)]) {
                [self.bubbleDelegate bubbleViewDidBeginMoving:self];
            }
        }
    }else if(gesture.state == UIGestureRecognizerStateEnded){
            _isMove = NO;
    }
}

- (void)layoutSubViewWithFrame:(CGRect)frame
{
    CGRect tRect = frame;
    tRect.size.width = self.bounds.size.width * 0.64;
    tRect.size.height = self.bounds.size.height * 0.46;
    tRect.origin.x = (self.bounds.size.width - tRect.size.width) * 0.5;
    
    CGFloat orignY = 0.23;
    tRect.origin.y = self.bounds.size.height * orignY;
    
    [self.textView setFrame:tRect];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidBeginEditing:)]) {
        [self.bubbleDelegate bubbleViewDidBeginEditing:self];
    }
  
    
    if ([text isEqualToString:@"\n"])
    {
        [self endEditing:YES];

        return NO;
    }

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
    if (self.bubbleDelegate && [self.bubbleDelegate respondsToSelector:@selector(bubbleViewSaveText:text:)]) {
        [self.bubbleDelegate bubbleViewSaveText:self text:calcStr];
    }
}
#pragma mark 开启键盘
- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView
{
    if (self.bubbleDelegate && [self.bubbleDelegate respondsToSelector:@selector(bubbleViewDidBeginEditing:)]) {
        [self.bubbleDelegate bubbleViewDidBeginEditing:self];
    }
    if([self.curType isEqualToString:self.type]){
        return YES;
    }
    return NO;
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

#pragma mark - 删除事件
-(void)deleteControlTapAction{
    self.hidden = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeBubbleView" object:self];
}

@end
