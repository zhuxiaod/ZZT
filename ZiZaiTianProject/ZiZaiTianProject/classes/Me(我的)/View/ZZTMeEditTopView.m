//
//  ZZTMeEditTopView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/4.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMeEditTopView.h"
@interface ZZTMeEditTopView()
@property (weak, nonatomic) IBOutlet UIButton *cannelBrn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *backgroundBtn;
@property (weak, nonatomic) IBOutlet UIButton *userHead;
@property (weak, nonatomic) IBOutlet UILabel *VIP;

@end
@implementation ZZTMeEditTopView

+(instancetype)ZZTMeEditTopView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)awakeFromNib{
    self.userHead.layer.cornerRadius = self.userHead.frame.size.width/2;
    self.userHead.layer.masksToBounds=YES;//隐藏裁剪掉的部分
    self.userHead.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userHead.layer.borderWidth = 2.0f;
    //添加点击事件
    [_cannelBrn addTarget:self action:@selector(clickBrn:) forControlEvents:UIControlEventTouchUpInside];
    [_saveBtn addTarget:self action:@selector(clickBrn:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundBtn addTarget:self action:@selector(clickBrn:) forControlEvents:UIControlEventTouchUpInside];
    [_userHead addTarget:self action:@selector(clickBrn:) forControlEvents:UIControlEventTouchUpInside];

    //button索引
    _cannelBrn.tag = 0;
    _saveBtn.tag = 1;
    _backgroundBtn.tag = 2;
    _userHead.tag = 3;
}

-(void)clickBrn:(UIButton *)btn{
    if(self.buttonAction){
        self.buttonAction(btn);
    }
}
@end
