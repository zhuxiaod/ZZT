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
#import "ZZTCreationTableView.h"
#import "PYSearchSuggestionViewController.h"
#import "ZZTCarttonDetailModel.h"
#import "ZZTUpdateViewController.h"
#import "ZZTCollectView.h"
@interface ZZTHomeViewController ()<UIScrollViewDelegate,PYSearchViewControllerDelegate,PYSearchViewControllerDataSource,UITableViewDataSource>

@property (nonatomic,weak) UIView *customNavBar;
@property (nonatomic,weak) ListView *listView;
@property (nonatomic,weak) ZZTReadTableView *ReadView;
@property (nonatomic,weak) ZZTCreationTableView *CreationView;
@property (nonatomic,weak) ZZTCollectView *collectView;

@property (nonatomic,weak) ZZTCycleCell * cycleCell;
//@property (nonatomic,weak) UIScrollView *mainView;
@property (nonatomic,strong) NSMutableArray *searchSuggestionArray;
@property (nonatomic,weak) UITableView *suggestionView;
@property (nonatomic,weak) PYSearchViewController *searchVC;
@end
NSString *SuggestionView = @"SuggestionView";
@implementation ZZTHomeViewController

-(NSMutableArray *)searchSuggestionArray{
    if(!_searchSuggestionArray){
        _searchSuggestionArray = [NSMutableArray array];
    }
    return _searchSuggestionArray;
}
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

    //阅读页
    ZZTReadTableView *readVC = [[ZZTReadTableView alloc] init];
    readVC.backgroundColor = [UIColor whiteColor];
    self.ReadView = readVC;
    [self.mainView addSubview:readVC];
    
    //创作页
    ZZTCreationTableView *creationVC = [[ZZTCreationTableView alloc] init];
    self.CreationView = creationVC;
    creationVC.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:creationVC];
    
    //收藏页
    //直接在该页面创建一个collectionView
    //    ZZTCollectView *collectVC = [[ZZTCollectView alloc] init];
//    collectVC.backgroundColor = [UIColor whiteColor];
//    self.collectView = collectVC;
//    [self.mainView addSubview:collectVC];
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
    [_CreationView setFrame:CGRectMake(0, 0, width, height)];
    [_ReadView setFrame:CGRectMake(width, 0, width, height)];
    [_collectView setFrame:CGRectMake(width * 2, 0, width, height)];
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
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"search"] highImage:[UIImage imageNamed:@"search"] target:self action:@selector(search)];
    //左边导航条
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"time"] highImage:[UIImage imageNamed:@"time"] target:self action:@selector(history)];
}
//更新
-(void)history{
    ZZTUpdateViewController *updateVC = [[ZZTUpdateViewController alloc] init];
    updateVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:updateVC animated:YES];
}

-(void)dealloc{
    NSLog(@"我走了");
}

-(void)search{

    //设置热词
    NSArray *hotSeaches = @[@"妖神记", @"大霹雳", @"镖人", @"偷星九月天"];

    PYSearchViewController *searchVC = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索作品名、作者名、社区内容" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        
    }];
    searchVC.hotSearchTitle = @"热门搜索";
    searchVC.delegate = self;
    searchVC.dataSource = self;

    //set cancelButton
    [searchVC.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [searchVC.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self presentViewController:nav animated:YES completion:nil];
    _searchVC = searchVC;
}

//搜索文字已经改变
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        weakself(self);
        NSDictionary *dic = @{
                              @"fuzzy":searchText
                              };
        //添加数据
        [AFNHttpTool POST:@"http://192.168.0.165:8888/cartoon/queryFuzzy" parameters:dic success:^(id responseObject) {
            NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
            NSMutableArray *array = [ZZTCarttonDetailModel mj_objectArrayWithKeyValuesArray:dic];
            weakSelf.searchSuggestionArray = array;
            [searchViewController.searchSuggestionView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
}
-(NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)searchSuggestionView{
    return 1;
}
-(NSInteger)searchSuggestionView:(UITableView *)searchSuggestionView numberOfRowsInSection:(NSInteger)section{
    return self.searchSuggestionArray.count;
}
-(UITableViewCell *)searchSuggestionView:(UITableView *)searchSuggestionView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [searchSuggestionView dequeueReusableCellWithIdentifier:SuggestionView];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SuggestionView];
    }
    if(self.searchSuggestionArray.count > 0){
        ZZTCarttonDetailModel *str = self.searchSuggestionArray[indexPath.row];
        cell.textLabel.text = str.bookName;
    }
    return cell;
}
- (CGFloat)searchSuggestionView:(UITableView *)searchSuggestionView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}

@end
