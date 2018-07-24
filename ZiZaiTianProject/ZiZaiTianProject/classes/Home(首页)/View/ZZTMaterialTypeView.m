//
//  ZZTMaterialTypeView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMaterialTypeView.h"
#import "ZZTDetailModel.h"

@interface ZZTMaterialTypeView ()

@property (nonatomic,strong) NSArray *buttonData;

@property (nonatomic,assign) CGFloat btnWidth;

@property (nonatomic,strong)NSString *recodeStr;

@property (nonatomic,strong) NSMutableArray *buttons;


@end

@implementation ZZTMaterialTypeView

-(NSMutableArray *)buttons{
    if(!_buttons){
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

-(instancetype)init:(NSArray *)array Width:(CGFloat)width{
    if(self = [self init]){
        self.buttonData = array;
        _btnWidth = 60;
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
    CGFloat rankMargin = 5;
    //每行间距
    CGFloat rowMargin = 5;
    //Item索引 ->根据需求改变索引
    NSUInteger index = _buttonData.count;
    
    for (int i = 0 ; i< index; i++) {
        //Item X轴
        CGFloat X = (i % rank) * (W + rankMargin)+5;
        //Item Y轴
        NSUInteger Y = (i / rank) * (H +rowMargin);
        //Item top
        ZZTDetailModel *model = self.buttonData[i];
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:model.detail forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor grayColor]];
        btn.frame = CGRectMake(X, Y, W, H);
        btn.selected = NO;
        btn.tag = index;
        [btn addTarget:self action:@selector(buttonSelected:)
      forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:btn];
        [self addSubview:btn];
    }
}
//ok
-(void)buttonSelected:(UIButton *)btn{
    self.recodeStr = btn.titleLabel.text;
    for (UIButton *button in self.buttons) {
        if([btn.titleLabel.text isEqualToString:button.titleLabel.text]){
            button.selected = YES;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor blueColor]];
            //代理传值
            NSDictionary *dic = @{
                                  @"text":btn.titleLabel.text
                                  };
            NSNotification *notification = [NSNotification notificationWithName:@"btnIndex" object:nil userInfo:dic];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }else{
            button.selected = NO;
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor]];
        }
    }
}
@end
