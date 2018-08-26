//
//  ZZTVIPViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTVIPViewController.h"
#import "ZZTVIPTopView.h"
#import "ZZTVIPMidView.h"
#import "ZZTVIPBtView.h"

@interface ZZTVIPViewController ()

@end

@implementation ZZTVIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"VIP";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [self.view addSubview:scrollView];
    
    //头部
    ZZTVIPTopView *VIPTopView = [ZZTVIPTopView VIPTopView];
    VIPTopView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    [scrollView addSubview:VIPTopView];

    //充值服务
    ZZTVIPMidView *midView = [ZZTVIPMidView VIPMidView];
    midView.frame = CGRectMake(0,VIPTopView.y+VIPTopView.height +15, SCREEN_WIDTH, 280);
    [scrollView addSubview:midView];
    
    //VIP特权
    ZZTVIPBtView *btView = [ZZTVIPBtView VIPBtView];
    btView.frame = CGRectMake(0, midView.y+midView.height+15, SCREEN_WIDTH, 280);
    [scrollView addSubview:btView];
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, btView.y+btView.height);

}


@end
