//
//  ZZTHomeViewController.m
//  ZiZaiTianProject
//
//  Created by zxd on 2018/6/24.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTHomeViewController.h"

@interface ZZTHomeViewController ()

@end

@implementation ZZTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self setupNavBar];
    
    //隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
}

#pragma mark - 设置导航条
-(void)setupNavBar
{
    //右边导航条
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"search"] highImage:[UIImage imageNamed:@"search"] target:self action:@selector(history)];
    //左边导航条
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"time"] highImage:[UIImage imageNamed:@"time"] target:self action:@selector(history)];
    
    //中间导航条
    self.navigationItem.title = @"首页";
}
-(void)history{
    NSLog(@"你是傻逼？");
}
@end
