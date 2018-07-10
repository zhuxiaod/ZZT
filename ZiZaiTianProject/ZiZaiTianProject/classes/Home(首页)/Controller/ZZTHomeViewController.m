//
//  ZZTHomeViewController.m
//  ZiZaiTianProject
//
//  Created by zxd on 2018/6/24.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTHomeViewController.h"
#import "CommonMacro.h"
#import "ListView.h"
#import "ZZTReadTableView.h"
#import "ZZTCycleCell.h"
#import "ZZTEasyBtnModel.h"

@interface ZZTHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIView *customNavBar;

@property (nonatomic,weak) ListView *listView;

@property (nonatomic,weak) ZZTReadTableView *collectView;
@property (nonatomic,weak) ZZTReadTableView *ReadView;
@property (nonatomic,weak) ZZTReadTableView *CreationView;
@property (nonatomic,weak) ZZTCycleCell * cycleCell;
@property (nonatomic,weak) UIScrollView *mainView;

@end

@implementation ZZTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#58006E"];
    
    //设置Bar
    [self setupNavBar];
    
    //设置主视图
    [self setupMainView];
    
    //自定义listView
    [self setupListView];
    
    //设置子页
    [self setupChildView];
    //listView的第三个控件颜色加载有问题
    //接下来可以开始设置tableView了
    //轮播定时
    //代理定时
}

#pragma mark - 设置主视图
- (void)setupMainView {
    
    UIScrollView *mainView = [[UIScrollView alloc] init];
    //1.是否有弹簧效果
    mainView.bounces = NO;
    //整页平移是否开启
    mainView.pagingEnabled = YES;
    //显示水平滚动条
    mainView.showsHorizontalScrollIndicator = NO;
    //显示垂直滚动条
    mainView.showsVerticalScrollIndicator = NO;
    
    mainView.delegate = self;
    
    [self.view addSubview:mainView];
    
    self.mainView = mainView;
}

#pragma mark - 设置ListView
- (void)setupListView {
    //设置自动调整滚动视图
    [self setAutomaticallyAdjustsScrollViewInsets:NO];

    NSArray *textArray = @[@"创作",@"阅读",@"收藏"];
    
    //0.66 默认
    CGFloat listViewWidth    = self.view.width * 0.5;
    CGFloat listViewItemSize = (listViewWidth - SPACEING * 2)/textArray.count;
    
    ListViewConfiguration *lc = [ListViewConfiguration new];
    //设置动画
    lc.hasSelectAnimate = YES;
    //选择时的颜色
    lc.labelSelectTextColor = [UIColor whiteColor];
    lc.labelTextColor = [UIColor grayColor];
//    lc.lineColor  = subjectColor;
    lc.font       = [UIFont systemFontOfSize:14];
    lc.spaceing   = SPACEING;
    lc.labelWidth = listViewItemSize;
    lc.monitorScrollView = self.mainView;
    
    ListView *listView = [[ListView alloc] initWithFrame:CGRectMake(0,0,listViewWidth,44) TextArray:textArray Configuration:lc];
    //重点！！！
    self.navigationItem.titleView = listView;
    //全局
    self.listView = listView;
}

#pragma mark - 设置添加滚动子页
-(void)setupChildView{
    //btn 的数据模型
   
    //阅读页
    ZZTReadTableView *collectVC = [[ZZTReadTableView alloc] init];
    collectVC.backgroundColor = [UIColor whiteColor];
    self.collectView = collectVC;
    collectVC.btnTpye = @"1";
    collectVC.viewWidth = self.mainView.width;
    collectVC.viewHeight = self.mainView.height;
    [self.mainView addSubview:collectVC];
    
    //创作页
    ZZTReadTableView *readVC = [[ZZTReadTableView alloc] init];
    readVC.backgroundColor = [UIColor whiteColor];
    self.ReadView = readVC;
//    readVC.btnArray = btnArray;
    readVC.viewWidth = self.mainView.width;
    readVC.viewHeight = self.mainView.height;
    [self.mainView addSubview:readVC];
    
    //收藏页
    ZZTReadTableView *creationVC = [[ZZTReadTableView alloc] init];
    creationVC.backgroundColor = [UIColor whiteColor];
    self.CreationView = creationVC;
    creationVC.viewWidth = self.mainView.width;
    creationVC.viewHeight = self.mainView.height;
    [self.mainView addSubview:creationVC];
}
#pragma mark - 设置滚动视图
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat height = self.view.height  - navHeight +20;
    CGFloat width  = self.view.width;
    
    //主页的位置
    [self.mainView setFrame:CGRectMake(0,0,width,height)];
    self.mainView.contentSize  = CGSizeMake(width * 3, 0);
    
    //提前加载
    [_ReadView setFrame:CGRectMake(0, 0, width, height)];
    [_collectView setFrame:CGRectMake(width, 0, width, height)];
    [_CreationView setFrame:CGRectMake(width * 2, 0, width, height)];
    [self.mainView setContentOffset:CGPointMake(width, 0)];
}

//Bar隐藏
//计时器开始
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //反正是一个页面一起跑页没什么不好吧
    //cell 还没有创建故不能在这里搞
    [_ReadView reloadData];
    [_collectView reloadData];
    [_CreationView reloadData];
}
//计时器结束
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //可以控制定时关闭
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

#pragma mark - 设置导航条
-(void)setupNavBar
{
    //右边导航条
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"search"] highImage:[UIImage imageNamed:@"search"] target:self action:@selector(history)];
    //左边导航条
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"time"] highImage:[UIImage imageNamed:@"time"] target:self action:@selector(history)];

}

-(void)history{
    NSLog(@"你是傻逼？");
}
-(void)dealloc{
    NSLog(@"我走了");
}

@end
