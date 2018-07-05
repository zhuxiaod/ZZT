//
//  ZZTHistoryViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTHistoryViewController.h"
#import "ZZTCartoonViewController.h"

@interface ZZTHistoryViewController ()
@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (weak, nonatomic) IBOutlet UILabel *viewControllerTitle;
@property (strong,nonatomic) AFHTTPSessionManager *manager;

@end

@implementation ZZTHistoryViewController
#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTitle];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    //添加子页
    [self setUpAllChildViewController];
    
    //设置滑动栏的样式
    [self setupStyle];
    
}

-(void)setupTitle{
    [_viewControllerTitle setText:@"浏览历史"];
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
        *isOpenShade = YES;                             //是否开启字体渐变
    }];

    [self setUpTopTitleViewAttribute:^(CGFloat *topDistance, CGFloat *titleViewHeight, CGFloat *bottomDistance) {
        *topDistance = 64;
    }];

}
#pragma mark - 添加所有子控制器
- (void)setUpAllChildViewController
{
    //index1
    ZZTCartoonViewController *carttonVC = [[ZZTCartoonViewController alloc] init];
    carttonVC.title = [self.dic objectForKey:@"index1"];
    carttonVC.dataIndex = @"1";
    carttonVC.cellType = [self.dic objectForKey:@"cellType"];
    carttonVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:carttonVC];
    //index2
    ZZTCartoonViewController *playVC = [[ZZTCartoonViewController alloc] init];
    playVC.title = [self.dic objectForKey:@"index2"];
    playVC.dataIndex = @"2";
    playVC.cellType = [self.dic objectForKey:@"cellType"];
    playVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:playVC];
    //index3
    ZZTCartoonViewController *findVC = [[ZZTCartoonViewController alloc] init];
    findVC.title = [self.dic objectForKey:@"index3"];
    findVC.dataIndex = @"2";
    findVC.cellType = [self.dic objectForKey:@"cellType"];
    findVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:findVC];
}
//返回上一页
- (IBAction)clickBackBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
