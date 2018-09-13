//
//  ZZTMaterialKindView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMaterialKindView.h"
#import "ZZTKindModel.h"
#import "ZZTTypeModel.h"
#import "RankButton.h"

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

-(instancetype)init:(NSArray *)array Width:(CGFloat)width isMe:(BOOL)isMe{
    if(self = [self init]){
        self.buttonData = array;
        _btnWidth = SCREEN_WIDTH / array.count;
        [self initButtons];
        if(self.buttons.count > 0){
            UIButton *btn = [[UIButton alloc] init];
            if(isMe == YES){
                btn = self.buttons[self.buttons.count - 1];
            }
            else{
                btn = self.buttons[0];
            }
            [self buttonSelected:btn];
        }
    }
    return self;
}

-(void)initButtons{
    CGFloat W = _btnWidth;
    CGFloat H = 30;
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
        ZZTTypeModel *model = self.buttonData[i];
        //修改btn的样式
        RankButton *btn = [[RankButton alloc] init];
        [btn setTitle:model.type forState:UIControlStateNormal];
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
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        if([btn.titleLabel.text isEqualToString:button.titleLabel.text]){
            button.selected = YES;
            [btn setTitleColor:[UIColor colorWithHexString:@"#7B7BE4"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"排行榜-当前榜单"] forState:UIControlStateNormal];
            
            if(i == (self.buttons.count - 1)){
                NSNotification *notification = [NSNotification notificationWithName:@"obtionMyDataSource" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }else{
                //代理传值
                NSDictionary *dic = @{
                                      @"text":btn.titleLabel.text
                                      };
                NSNotification *notification = [NSNotification notificationWithName:@"btnText" object:nil userInfo:dic];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
            
            //点击判断是索引 传出去
        }else{
            button.selected = NO;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setImage:nil forState:UIControlStateNormal];
        }
    }
}

@end
