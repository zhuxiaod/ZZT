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
@property (weak, nonatomic) IBOutlet UIView *top;
@property (weak, nonatomic) IBOutlet UIView *mid;
@property (weak, nonatomic) IBOutlet UIView *buttom;

@end

@implementation ZZTVIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rr_navHidden = YES;
    self.rr_backActionDisAble = YES;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    ZZTVIPTopView *topView = [ZZTVIPTopView VIPTopView];

    [_top addSubview:topView];
    
    ZZTVIPMidView *midView = [ZZTVIPMidView VIPMidView];
    [_mid addSubview:midView];
    
    ZZTVIPBtView *btView = [ZZTVIPBtView VIPBtView];
    [_buttom addSubview:btView];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (IBAction)backBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
