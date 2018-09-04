//
//  AppDelegate.m
//  ZiZaiTianProject
//
//  Created by zxd on 2018/6/24.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "AppDelegate.h"
#import "ZZTNavigationViewController.h"
#import "ZZTHomeViewController.h"
#import "ZZTTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置窗口根控制器
    ZZTTabBarViewController *tabBarVC = [[ZZTTabBarViewController alloc]init];
//    RTRootNavigationController *tabBarVC = [[RTRootNavigationController alloc]init];

    self.window.rootViewController = tabBarVC;
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    return YES;
}

void uncaughtExceptionHandler(NSException *exception) {
    
    NSLog(@"reason: %@", exception);
    
    // Internal error reporting
    
}



@end
