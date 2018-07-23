//
//  ZZTMaterialKindView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMaterialKindView.h"

@interface ZZTMaterialKindView()
{
    CGFloat Btnx;
}
@property (nonatomic,strong) NSArray *buttonData;

@property (nonatomic,assign) CGFloat btnWidth;

@property (nonatomic,strong)NSString *recodeStr;

@property (nonatomic,strong) NSMutableArray *buttons;


@end

@implementation ZZTMaterialKindView

-(NSMutableArray *)buttons{
    if(!_buttons){
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)init:(NSArray *)array Width:(CGFloat)width{
    if(self = [self init]){
        self.buttonData = array;
        _btnWidth = SCREEN_WIDTH/array.count;
        [self initButtons];
        if(self.buttons.count > 0){
            UIButton *btn = self.buttons[0];
            btn.selected = YES;
            [self buttonSelected:btn];
        }
    }
    return self;
}

-(void)initButtons{
    CGFloat W = _btnWidth;
    CGFloat H = 20;
    //每行列数
    NSInteger rank = _buttonData.count;
    //每列间距
    CGFloat rankMargin = 0;
    //每行间距
    CGFloat rowMargin = 0;
    //Item索引 ->根据需求改变索引
    NSUInteger index = _buttonData.count;
    
    for (int i = 0 ; i< index; i++) {
        //Item X轴
        CGFloat X = (i % rank) * (W + rankMargin);
        //Item Y轴
        NSUInteger Y = (i / rank) * (H +rowMargin);
        //Item top
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:_buttonData[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(X, Y, W, H);
        btn.selected = NO;
        btn.tag = index;
        [btn addTarget:self action:@selector(buttonSelected:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:btn];
        [self addSubview:btn];
    }

}

-(void)buttonSelected:(UIButton *)btn{
    self.recodeStr = btn.titleLabel.text;
    for (UIButton *button in self.buttons) {
        if([btn.titleLabel.text isEqualToString:button.titleLabel.text]){
            button.selected = YES;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor blackColor]];
        }else{
            button.selected = NO;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor]];
        }
    }
    
}

@end
