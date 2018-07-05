//
//  ZZTCartoonViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonViewController.h"
#import "ZZTCartoonCell.h"
#import "ZZTAttentionCell.h"
#import "ZZTMyCircleCellCollectionViewCell.h"

//请求192.168.0.165:8888/great/daiti?id=daiti
@interface ZZTCartoonViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,strong) EncryptionTools *encryptionManager;
//获得数据
@property (nonatomic,strong) NSString *getData;
//cartoons
@property (nonatomic,strong) NSArray *cartoons;

@property (nonatomic,strong) NSArray *books;
@end


@implementation ZZTCartoonViewController

#pragma mark - 懒加载
- (EncryptionTools *)encryptionManager{
    if(!_encryptionManager){
        _encryptionManager = [EncryptionTools sharedEncryptionTools];
    }
    return _encryptionManager;
}

- (NSArray *)cartoons{
    if (!_cartoons) {
        _cartoons = [NSArray array];
    }
    return _cartoons;
}

- (NSArray *)books{
    if (!_books) {
        _books = [NSArray array];
    }
    return _books;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

//cell注册(控制)
static NSString *collectionID = @"collectionID";
static NSString *AttentionCell = @"AttentionCell";
static NSString *circleCell = @"circleCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //流水布局
    UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];

    //创建UICollectionView：黑色
    [self setupCollectionView:layout];

    //注册cell
    [self registerCell];
}

#pragma mark 注册Cell(控制)
-(void)registerCell{
    UINib *nib1= [UINib nibWithNibName:@"ZZTCartoonCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib1 forCellWithReuseIdentifier:collectionID];
    
    UINib *nib2= [UINib nibWithNibName:@"ZZTAttentionCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib2 forCellWithReuseIdentifier:AttentionCell];
    
    UINib *nib3= [UINib nibWithNibName:@"ZZTMyCircleCellCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib3 forCellWithReuseIdentifier:circleCell];
}

-(void)loadData{
    //请求参数
    NSLog(@"dataIndex:%@",self.dataIndex);
    NSDictionary *paramDict = @{
                                @"userId":@"1",
                                @"type":self.dataIndex
                                };
    NSLog(@"index:%@",self.dataIndex);
    [self.manager POST:@"http://192.168.0.165:8888/great/userCollect" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@---%@",[responseObject class],responseObject);
        self.getData = responseObject[@"result"];
        //成功运行的方法
        [self decry];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败 -- %@",error);
        [self failure];
    }];
}

//请求到数据了
-(void)decry{
    //解密
    NSString *data = [self.encryptionManager decryptString:self.getData keyString:@"ZIZAITIAN@666666" iv:[@"A-16-Byte-String" dataUsingEncoding:kCFStringEncodingUTF8]];
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"data:%@",data);
    //转模型
    self.books = [ZZTCartonnPlayModel mj_objectArrayWithKeyValuesArray:dic];
    
    self.cartoons = self.books;
    //刷新
    [self.collectionView reloadData];
}
//没有请求到
-(void)failure{
    self.cartoons = nil;
}
#pragma mark - 创建流水布局
-(UICollectionViewFlowLayout *)setupCollectionViewFlowLayout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //修改尺寸(控制)
    if([self.cellType isEqualToString:@"collection"]){
        layout.itemSize = CGSizeMake(120,200);
    }else if ([self.cellType isEqualToString:@"tableView1"]){
        layout.itemSize = CGSizeMake(Screen_Width,100);
    }else if ([self.cellType isEqualToString:@"tableView2"]){
        layout.itemSize = CGSizeMake(Screen_Width,100);
    }
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
    [self.view addSubview:self.collectionView];
    collectionView.dataSource = self;
    collectionView.delegate = self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cartoons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //cell类型改变
    //model改变(控制)
    UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
    if([self.cellType isEqualToString:@"collection"]){
        ZZTCartoonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
        ZZTCartonnPlayModel *car = self.cartoons[indexPath.row];
        if (car) {
            cell.cartoon = car;
        }
        return cell;
    }else if ([self.cellType isEqualToString:@"tableView2"]){
        ZZTAttentionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AttentionCell forIndexPath:indexPath];
        ZZTCartonnPlayModel *car = self.cartoons[indexPath.row];
        if (car) {
            cell.cartoon = car;
        }
        return cell;
    }else if ([self.cellType isEqualToString:@"tableView1"]){
        ZZTMyCircleCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:circleCell forIndexPath:indexPath];
        ZZTCartonnPlayModel *car = self.cartoons[indexPath.row];
        if (car) {
            cell.cartoon = car;
        }
        return cell;
    }
    return cell;
}
//加载数据
- (void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}
@end
