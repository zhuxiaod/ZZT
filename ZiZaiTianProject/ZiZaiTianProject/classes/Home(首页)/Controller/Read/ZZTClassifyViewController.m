//
//  ZZTClassifyViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTClassifyViewController.h"
#import "ZZTBookType.h"
#import "RankButton.h"

@interface ZZTClassifyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,PYSearchViewControllerDelegate,PYSearchViewControllerDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *titles;

@property (nonatomic,strong) NSMutableArray *btns;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,weak) PYSearchViewController *searchVC;

@property (nonatomic,strong) NSMutableArray *searchSuggestionArray;

@end
NSString *SuggestionView2 = @"SuggestionView2";

@implementation ZZTClassifyViewController

-(NSMutableArray *)searchSuggestionArray{
    if(!_searchSuggestionArray){
        _searchSuggestionArray = [NSMutableArray array];
    }
    return _searchSuggestionArray;
}

-(NSArray *)titles{
    if(!_titles){
        _titles = [NSArray array];
    }
    return _titles;
}

-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)btns{
    if(!_btns){
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分类";
    
    self.view.backgroundColor = [UIColor whiteColor];
    //分类
    [self setupScrollView];
    
    [self setupCollectionView];

    //请求
    [self loadTopViewData];
    
    [self setupNavBar];
}

-(void)setupCollectionView{
    //数据源传进来
    UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];
    
    [self setupCollectionView:layout];
}
#pragma mark - 创建流水布局
-(UICollectionViewFlowLayout *)setupCollectionViewFlowLayout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //修改尺寸(控制)
    layout.itemSize = CGSizeMake(120,200);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //行距
    layout.minimumLineSpacing = 0;
    
    layout.minimumInteritemSpacing = 5;
    
    return layout;
}

#pragma mark - 创建CollectionView
-(void)setupCollectionView:(UICollectionViewFlowLayout *)layout
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.scrollView.y + self.scrollView.height, Screen_Width, Screen_Height - self.scrollView.height) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.dataSource = self;
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:@"ZZTCartoonCell" bundle:nil] forCellWithReuseIdentifier:@"cellId"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZTCartoonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    ZZTCartonnPlayModel *car = self.dataArray[indexPath.row];
    cell.cartoon = car;
    return cell;
}
-(void)addBtn{
    
    CGFloat titleW = 60;
    CGFloat titleH = 40;
    CGFloat space = 5;
    
    for (int i = 0; i < self.titles.count; i++) {
        ZZTBookType *bookType = self.titles[i];
        RankButton *btn = [[RankButton alloc] init];
        [btn setTitle:bookType.bookTypeName forState:UIControlStateNormal];
        btn.rankType = [NSString stringWithFormat:@"%ld",bookType.id];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.scrollView addSubview:btn];

        CGFloat x = space + (titleW + space) * i;

        btn.frame = CGRectMake(x, 10, titleW, titleH);
        [btn addTarget:self action:@selector(btnTarget:) forControlEvents:UIControlEventTouchUpInside];
        [self.btns addObject:btn];
    }
    self.scrollView.contentSize = CGSizeMake(space + (titleW + space) * self.titles.count, 60);
    [self btnTarget:self.btns[0]];
}

-(void)btnTarget:(RankButton *)btn{
    for (RankButton *button in self.btns) {
        if(button == btn){
            [btn setTitleColor:[UIColor colorWithHexString:@"#7B7BE4"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"排行榜-当前榜单"] forState:UIControlStateNormal];
            [self loadData:btn];
        }else{
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setImage:nil forState:UIControlStateNormal];
        }
    }
}

-(void)loadData:(RankButton *)btn{
    NSDictionary *dic = @{
                          @"bookType":btn.rankType,
                          //众创
                          @"cartoonType":@"1",
                          @"pageNum":@"1",
                          @"pageSize":@"10"
                          };
    
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"cartoon/cartoonlist"] parameters:dic success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSMutableArray *array = [ZZTCartonnPlayModel mj_objectArrayWithKeyValuesArray:dic];
        self.dataArray = array;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    self.scrollView = scrollView;
    self.scrollView.bounces = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
}

-(void)loadTopViewData{

    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"cartoon/getBookType"] parameters:nil success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSMutableArray *array = [ZZTBookType mj_objectArrayWithKeyValuesArray:dic];
        self.titles = array;
        [self addBtn];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 设置导航条
-(void)setupNavBar
{
    //右边导航条
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"search"] highImage:[UIImage imageNamed:@"search"] target:self action:@selector(search)];
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
        [AFNHttpTool POST:@"http://120.79.178.191:8888/cartoon/queryFuzzy" parameters:dic success:^(id responseObject) {
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
    UITableViewCell *cell = [searchSuggestionView dequeueReusableCellWithIdentifier:SuggestionView2];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SuggestionView2];
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
