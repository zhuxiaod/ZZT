//
//  ZZTMeTopView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMeTopView.h"
@interface ZZTMeTopView ()

@property (weak, nonatomic) IBOutlet UIButton *zBiButton;
@property (weak, nonatomic) IBOutlet UIButton *integralButton;
@property (weak, nonatomic) IBOutlet UIButton *readTicket;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *headButton;

@end

@implementation ZZTMeTopView 

+(instancetype)meTopView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [super awakeFromNib];
    [self.zBiButton setTitle:@"5000 \nZ币" forState:UIControlStateNormal];
    self.zBiButton.titleLabel.lineBreakMode = 0;
    [self.integralButton setTitle:@"500 \n积分" forState:UIControlStateNormal];
    self.zBiButton.titleLabel.lineBreakMode = 0;
    [self.readTicket setTitle:@"500 \n阅读卷" forState:UIControlStateNormal];
    self.zBiButton.titleLabel.lineBreakMode = 0;
    [self.headButton setImage:[UIImage imageNamed:@"peien"] forState:UIControlStateNormal];
    self.headButton.layer.cornerRadius = self.headButton.frame.size.width/2;
    self.headButton.layer.masksToBounds=YES;//隐藏裁剪掉的部分
    self.headButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headButton.layer.borderWidth = 1.0f;
    self.userName.text = @"佩恩";
    //添加点击事件
    [_zBiButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_integralButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_readTicket addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_messageButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_signInButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //button索引
    _zBiButton.tag = 0;
    _integralButton.tag = 1;
    _readTicket.tag = 2;
    _messageButton.tag = 3;
    _headButton.tag = 4;
    _signInButton.tag = 5;
}

- (void)buttonClick:(UIButton *)button{
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(button);
    }
}

@end
