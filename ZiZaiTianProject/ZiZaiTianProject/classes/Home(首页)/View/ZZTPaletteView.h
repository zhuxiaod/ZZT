//
//  ZZTPaletteView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZTPaletteView;

@protocol PaletteViewDelegate<NSObject>

-(void)patetteView:(ZZTPaletteView *)patetteView choiceColor:(UIColor *)color colorPoint:(CGPoint)colorPoint;


@optional

@end

typedef void (^TureBtnBlock)(UIButton *sender);

@interface ZZTPaletteView : UIView

@property (nonatomic,strong) TureBtnBlock buttonAction;

@property (nonatomic,strong) UIButton *btn;

@property (nonatomic,weak) id<PaletteViewDelegate> delegate;

@end
