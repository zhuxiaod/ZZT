//
//  ZXDLoginRegisterView.m
//  loginDemo
//
//  Created by zxd on 2018/6/22.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZXDLoginRegisterView.h"
#import "ZXDLoginRegisterTextField.h"
#import "ZXDLoginRegisterTextField.h"
@interface ZXDLoginRegisterView()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;
@property (weak, nonatomic) IBOutlet UIButton *verificationButton;
@property (weak, nonatomic) IBOutlet ZXDLoginRegisterView *phoneNumber1;
@property (weak, nonatomic) IBOutlet ZXDLoginRegisterTextField *phoneNumber2;

@end

@implementation ZXDLoginRegisterView

+(instancetype)loginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self)  owner:nil options:nil] firstObject];
}
//登录注册
- (IBAction)clickRegister:(id)sender {
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(sender);
    }
}
//验证码
- (IBAction)getVerification:(UIButton *)sender {
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(sender);
    }
}

+(instancetype)registerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self)  owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    //获得当前button的图片
    UIImage *image = _loginRegisterButton.currentBackgroundImage;
    
    //可拉伸的宽度
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    // 让按钮背景图片不要被拉伸
    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
    
    //tag
    _verificationButton.tag = 0;
    _loginRegisterButton.tag = 1;
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(verifictionPhoneNumber) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)verifictionPhoneNumber
{
    NSLog(@"asdfasdfa");
}
@end
