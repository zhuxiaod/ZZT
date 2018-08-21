//
//  ZZTProductionShowViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTProductionShowViewController.h"

@interface ZZTProductionShowViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,PYSearchViewControllerDelegate,PYSearchViewControllerDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *cartoons;

@property (nonatomic,weak) PYSearchViewController *searchVC;

@property (nonatomic,strong) NSMutableArray *searchSuggestionArray;

@end

NSString *SuggestionView1 = @"SuggestionView1";

@implementation ZZTProductionShowViewController

-(NSMutableArray *)searchSuggestionArray{
    if(!_searchSuggestionArray){
        _searchSuggestionArray = [NSMutableArray array];
    }
    return _searchSuggestionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //返回按钮
    //中间字
    //搜索item
    
    //数据源传进来
    UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];
    
    [self setupCollectionView:layout];
    
    self.navigationItem.title = self.viewTitle;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];

    [self setupNavBar];
}

-(void)setArray:(NSArray *)array{
    _array = array;
    [self.collectionView reloadData];
}

-(void)setViewTitle:(NSString *)viewTitle{
    _viewTitle = viewTitle;
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
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:@"ZZTCartoonCell" bundle:nil] forCellWithReuseIdentifier:@"cellId"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZTCartoonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    ZZTCartonnPlayModel *car = self.array[indexPath.row];
    cell.cartoon = car;
    return cell;
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

//    [self.navigationController pushViewController:searchVC animated:YES];
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
    UITableViewCell *cell = [searchSuggestionView dequeueReusableCellWithIdentifier:SuggestionView1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SuggestionView1];
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
