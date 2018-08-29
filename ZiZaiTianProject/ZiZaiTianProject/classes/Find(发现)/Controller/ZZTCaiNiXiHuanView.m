//
//  ZZTCaiNiXiHuanView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCaiNiXiHuanView.h"

@interface ZZTCaiNiXiHuanView ()



@property (weak, nonatomic) IBOutlet UIButton *updateBtn;

@end

@implementation ZZTCaiNiXiHuanView

+(instancetype)CaiNiXiHuanView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [_updateBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick:(UIButton *)button{
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(button);
    }
}
@end
