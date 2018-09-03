//
//  ZZTBubbleImageView.h
//  汽泡demo
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZTEditImageViewModel;
@class ZZTBubbleImageView;

@protocol ZZTBubbleImageViewDelegate <NSObject>

@optional

- (void)bubbleViewDidBeginEditing:(ZZTBubbleImageView *)bubbleView;

- (void)bubbleViewDidBeginMoving:(ZZTBubbleImageView *)bubbleView;

- (void)bubbleViewDidBeginEnd:(ZZTBubbleImageView *)bubbleView;

- (void)bubbleViewDidRotate:(ZZTBubbleImageView *)bubbleView rad:(CGFloat)rad;

@end

@interface ZZTBubbleImageView : UIView<UITextViewDelegate,UIGestureRecognizerDelegate>
//当前字体
@property (retain, nonatomic) UIFont *curFont;
//最小字体字号
@property (assign, nonatomic) CGFloat minFontSize;

@property (assign, nonatomic) CGSize minSize;

@property (nonatomic,assign)id<ZZTBubbleImageViewDelegate> bubbleDelegate;

@property (nonatomic,assign) BOOL isHide;

@property (nonatomic,strong) ZZTEditImageViewModel *model;

@property (nonatomic,assign) NSInteger tagNum;

@property (nonatomic,strong) NSString *superViewName;

@property (nonatomic,strong) UIView *superView;

@property (nonatomic,strong) UIImageView *imageView;


-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text superView:(UIView *)superView;

-(void)deleteControlTapAction;

@end
