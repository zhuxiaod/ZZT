//
//  ZZTTabBarViewController.m
//  ZiZaiTianProject
//
//  Created by zxd on 2018/6/24.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTTabBarViewController.h"
#import "ZZTHomeViewController.h"
#import "ZZTFindViewController.h"
#import "ZZTMeViewController.h"
#import "ZZTNavigationViewController.h"
#import "UIImage+ZZTimage.h"

@interface ZZTTabBarViewController ()

@end

@implementation ZZTTabBarViewController
+(void)load
{
    //获取那个类中的UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[UIView class]]];
    
    //设置按钮选中标题的颜色
    //创建一个描述文字属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    //字体只能在正常状态下设置
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllChildViewController];
    
    [self setupAllTittleButton];
}

#pragma mark - 添加所有子控制器
-(void)setupAllChildViewController
{
    //首页
    ZZTHomeViewController *homeVC = [[ZZTHomeViewController alloc] init];
    ZZTNavigationViewController *nac1 = [[ZZTNavigationViewController alloc] initWithRootViewController:homeVC];
    [self addChildViewController:nac1];
    
    //发现
    ZZTFindViewController *findVC = [[ZZTFindViewController alloc] init];
    ZZTNavigationViewController *nac2 = [[ZZTNavigationViewController alloc] initWithRootViewController:findVC];
    [self addChildViewController:nac2];
    
    //我的
    ZZTMeViewController *meVC = [[ZZTMeViewController alloc] init];
    ZZTNavigationViewController *nac3 = [[ZZTNavigationViewController alloc] initWithRootViewController:meVC];
    [self addChildViewController:nac3];
}

//设置所有button上的内容
-(void)setupAllTittleButton
{
    //2.2设置tabBar上按钮内容 ->由对应的子控制器
    //0:nav
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"众创";
    nav.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_essence_icon"];
    UIImage *image = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    nav.tabBarItem.selectedImage = image;
    
    //1:nav1
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"发现";
    nav1.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    //2:nav2
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"我的";
    nav2.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_me_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
}
@end
