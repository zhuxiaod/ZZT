//
//  ZZTUpdateViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/19.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTUpdateViewController.h"
#import "ZZTUpdatePageViewController.h"

@interface ZZTUpdateViewController()
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UILabel *navTitle;
@property (weak, nonatomic) IBOutlet UIButton *clean;

@end
@interface ZZTUpdateViewController ()

@end

@implementation ZZTUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTitle];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加子页
    [self setUpAllChildViewController];

    //设置滑动栏的样式
    [self setupStyle];
    
    
}

-(void)setupTitle{
    [_navTitle setText:@"更新"];
}

#pragma mark - 设置样式
-(void)setupStyle{
    [self setUpDisplayStyle:^(UIColor *__autoreleasing *titleScrollViewBgColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIColor *__autoreleasing *proColor, UIFont *__autoreleasing *titleFont, CGFloat *titleButtonWidth, BOOL *isShowPregressView, BOOL *isOpenStretch, BOOL *isOpenShade) {
        *titleScrollViewBgColor = [UIColor whiteColor]; //标题View背景色（默认标题背景色为白色）
        *norColor = [UIColor darkGrayColor];            //标题未选中颜色（默认未选中状态下字体颜色为黑色）
        *selColor = [UIColor purpleColor];              //标题选中颜色（默认选中状态下字体颜色为红色）
        *proColor = [UIColor purpleColor];              //滚动条颜色（默认为标题选中颜色）
        *titleFont = [UIFont systemFontOfSize:16];      //字体尺寸 (默认fontSize为15)
        *isShowPregressView = YES;                      //是否开启标题下部Pregress指示器
        *isOpenStretch = YES;                           //是否开启指示器拉伸效果
        *isOpenShade = YES;
    }];
    
    [self setUpTopTitleViewAttribute:^(CGFloat *topDistance, CGFloat *titleViewHeight, CGFloat *bottomDistance) {
        *topDistance = 64;
    }];
}

#pragma mark - 添加所有子控制器
- (void)setUpAllChildViewController
{
    ZZTUpdatePageViewController *ctVC = [[ZZTUpdatePageViewController alloc] init];
    ctVC.view.backgroundColor = [UIColor redColor];
    ctVC.title = @"漫画";
    [self addChildViewController:ctVC];
    
    ZZTUpdatePageViewController *playVC = [[ZZTUpdatePageViewController alloc] init];
    playVC.title = @"剧本";
    playVC.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:playVC];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
