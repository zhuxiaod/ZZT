//
//  ZZTFindWorldViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTFindWorldViewController.h"
#import "ZZTCaiNiXiHuanView.h"

@interface ZZTFindWorldViewController ()

@end

@implementation ZZTFindWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //猜你喜欢
    self.view.backgroundColor = [UIColor redColor];
    ZZTCaiNiXiHuanView *view = [ZZTCaiNiXiHuanView CaiNiXiHuanView];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
    [self.view addSubview:view];
    
    
}



@end
