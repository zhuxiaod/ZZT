//
//  ZZTNavigationViewController.m
//  ZiZaiTianProject
//
//  Created by zxd on 2018/6/24.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTNavigationViewController.h"
#import "UIBarButtonItem+Item.h"
#import "UIImage+ColorWithImage.h"

@interface ZZTNavigationViewController ()

@end

@implementation ZZTNavigationViewController

+(void)load
{
    //设置导航条标题 => UINavigationBar
    UINavigationBar *nab = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[UIView class]]];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [nab setTitleTextAttributes:attrs];
    nab.translucent = NO;
    
    //设置导航条的背景图片
    [nab setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#58006E"]] forBarMetrics:UIBarMetricsDefault];
//    [nab setShadowImage:[UIImage new]];
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    //全屏滑动
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//    
//    [self.view addGestureRecognizer:pan];
//
//    pan.delegate = self;
}

//如果非根子控制器则可以滑动
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    return self.childViewControllers.count > 1;
//}

//重写push方法 => push后如果是非控制器便添加一个返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count > 0)
    {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationbarBack"] highImage:[UIImage imageNamed:@"navigationbarBack"] target:self action:@selector(back) title:nil];
    }
    [super pushViewController:viewController animated:YES];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}

-(void)turnColor{
     [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#58006E"]] forBarMetrics:(UIBarMetricsDefault)];
}

//- (UIViewController *)childViewControllerForStatusBarStyle {
//    return self.visibleViewController;
//}
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}
//-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(BaseViewController *)viewController animated:(BOOL)animated
//{
//    if ([UIDevice currentDevice].systemVersion.floatValue < 10.0 && [viewController isKindOfClass:[BaseViewController class]]) {
//        if (!viewController.pushed) {
//            [self.navigationBar setHidden:[viewController getNaviHidden]];
//            viewController.pushed = YES;
//        }else
//        {
//            [self setNavigationBarHidden:[viewController getNaviHidden] animated:animated];
//        }
//    }
//}
@end
