//
//  ZZTLoginRegisterViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTLoginRegisterViewController.h"
#import "ZXDLoginRegisterView.h"
#import "ZXDFastLoginView.h"

@interface ZZTLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midCons;

@end

@implementation ZZTLoginRegisterViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
// 获取cooick
//    https://blog.csdn.net/qthdsy/article/details/51991845
    
    //登录view
    ZXDLoginRegisterView *loginView = [ZXDLoginRegisterView loginView];
    [self.midView addSubview:loginView];
    
    //注册view
    ZXDLoginRegisterView *registerView = [ZXDLoginRegisterView registerView];
    [self.midView addSubview:registerView];
    
    loginView.buttonAction = ^(UIButton *sender) {
        [self loginButtonClick:sender];
    };

    registerView.buttonAction = ^(UIButton *sender) {
        [self loginButtonClick:sender];
    };
}

-(void)loginButtonClick:(UIButton *)button
{
    //验证码
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setValue:@"text/xml; charset=ut-8" forHTTPHeaderField:@"Content-Type"];
  

    
    if (button.tag == 0) {
        //1.创建会话管理者
        //获取验证码
        //http://192.168.0.165:8888/login/sendMsg?phoneNumber=18827514330
        //判断验证码是否够数位
        //如果够 发送  不够 就提示

        NSDictionary *paramDict = @{
                                    @"phone":@"18827514330"
                                    };
        //获取cookie
        NSData * cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: cookiesData forKey:@"Set-Cookie"];
        [defaults synchronize];

        [manager POST:@"http://192.168.0.165:8888/login/sendMsg" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@---%@",[responseObject class],responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败 -- %@",error);
        }];
        //取cookie
        NSArray * cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"Set-Cookie"]];
        NSHTTPCookieStorage * cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage]; for (NSHTTPCookie * cookie in cookies){
            [cookieStorage setCookie: cookie];
            NSLog(@"%@",cookie);
        }
    }else{
        //登录
        NSDictionary *paramDict = @{
                                    @"phone":@"18827514330",
                                    @"checkCode":@"268996"
                                    };
        [manager POST:@"http://192.168.0.165:8888/login/loginApp" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@---%@",[responseObject class],responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败 -- %@",error);
        }];
        
       
    }
}

-(void)registerButtonClick:(UIButton *)button
{
    
}

// viewDidLayoutSubviews:才会根据布局调整控件的尺寸
-(void)viewDidLayoutSubviews
{
    //一定要调用super
    [super viewDidLayoutSubviews];
    
    ZXDLoginRegisterView *loginView = self.midView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.midView.bounds.size.width * 0.5, self.midView.bounds.size.height);
    
    ZXDLoginRegisterView *registerView = self.midView.subviews[1];
    registerView.frame = CGRectMake(self.midView.bounds.size.width * 0.5, 0, self.midView.bounds.size.width * 0.5, self.midView.bounds.size.height);
}

- (IBAction)dissMiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected =! sender.selected;
    
    //平移中间View
    _midCons.constant = _midCons.constant == 0? -self.midView.bounds.size.width * 0.5:0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark 三方登录

- (IBAction)QQLogin:(UIButton *)sender {
    
}
- (IBAction)WeChatLogin:(UIButton *)sender {
    
}
- (IBAction)sinaLogin:(UIButton *)sender {
    
}
@end
