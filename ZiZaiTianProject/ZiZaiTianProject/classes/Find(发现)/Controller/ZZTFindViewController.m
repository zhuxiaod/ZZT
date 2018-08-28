//
//  ZZTFindViewController.m
//  ZiZaiTianProject
//
//  Created by zxd on 2018/6/24.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTFindViewController.h"
#import "DCPagerController.h"
#import "ZZTFindWorldViewController.h"
#import "ZZTFindAttentionViewController.h"

@interface ZZTFindViewController ()

@property (nonatomic, weak) UIViewController *currentVC;

@end

@implementation ZZTFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *titleScrollView = [[UIView alloc] initWithFrame:CGRectMake(ScreenW/2-100, 0, 200, 50)];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftBtn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 0;
    [leftBtn setTitle:@"世界" forState:UIControlStateNormal];
    [titleScrollView addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(titleScrollView.width - 50, 0, 50, 50)];
    [rightBtn setTitle:@"关注" forState:UIControlStateNormal];
    rightBtn.tag = 1;
    [rightBtn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
    [titleScrollView addSubview:rightBtn];
    
    self.navigationItem.titleView = titleScrollView;
    
    ZZTFindWorldViewController *findWorldVC = [[ZZTFindWorldViewController alloc] init];
    [self addChildViewController:findWorldVC];
    
    ZZTFindAttentionViewController *findVC = [[ZZTFindAttentionViewController alloc] init];
    [self addChildViewController:findVC];

    [self clickMenu:leftBtn];
}

-(void)clickMenu:(UIButton *)btn{
    // 取出选中的这个控制器
    UIViewController *vc = self.childViewControllers[btn.tag];
    // 设置尺寸位置
    vc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50);
    // 移除掉当前显示的控制器的view（移除的是view，而不是控制器）
    [self.currentVC.view removeFromSuperview];
    // 把选中的控制器view显示到界面上
    [self.view addSubview:vc.view];
    self.currentVC = vc;
}

@end
