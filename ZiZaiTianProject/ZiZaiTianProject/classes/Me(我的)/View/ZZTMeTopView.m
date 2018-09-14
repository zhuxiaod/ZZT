//
//  ZZTMeTopView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMeTopView.h"
#import "ZZTSignInViewController.h"

@interface ZZTMeTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *VIPBtn;
@property (weak, nonatomic) IBOutlet UILabel *ZBLab;
@property (weak, nonatomic) IBOutlet UILabel *jiFenLab;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (weak, nonatomic) IBOutlet UILabel *fansNum;
@property (weak, nonatomic) IBOutlet UILabel *followNum;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@end

@implementation ZZTMeTopView 

-(void)setUserModel:(ZZTUserModel *)userModel{
    _userModel = userModel;
    if(userModel.isLogin == YES){
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:userModel.headimg]];
        [self.userName setText:userModel.nickName];
        if([userModel.userType isEqualToString:@"1"]){
            self.VIPBtn.hidden = YES;
        }
        [self.jiFenLab setText:[NSString stringWithFormat:@"%ld积分",(long)userModel.integralNum]];
    }else{
        [self.userName setText:@"未登录"];
    }
    
}
+(instancetype)meTopView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    //样式和事件
    [_headBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_VIPBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_signInBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    _VIPBtn.layer.cornerRadius = 10.0f;
    _signInBtn.layer.cornerRadius = 10.0f;
    _headBtn.tag = 0;
    [_headBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick:(UIButton *)button{
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction && self.userModel.isLogin == YES) {
        // 调用block传入参数
        self.buttonAction(button);
    }else{
        //登录
        self.loginAction(button);
    }
}

//跳转签到界面
- (IBAction)pushSignInView:(id)sender {
    //登录了才能签到
    if(self.userModel.isLogin == YES){
        ZZTSignInViewController *signInVC = [[ZZTSignInViewController alloc] init];
        signInVC.hidesBottomBarWhenPushed = YES;
        [[self myViewController].navigationController pushViewController:signInVC animated:YES];
    }else{
        self.loginAction(sender);
    }
}

@end
