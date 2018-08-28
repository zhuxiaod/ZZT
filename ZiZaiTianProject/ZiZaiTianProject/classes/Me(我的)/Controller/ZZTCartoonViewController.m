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

-(AFHTTPSessionManager *)manager{
    if(!_manager){
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
    
    self.navigationItem.title = self.viewTitle;
    
    UIButton *leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    
    //[leftbutton setBackgroundColor:[UIColor blackColor]];
    
    [leftbutton setTitle:@"清空" forState:UIControlStateNormal];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    self.navigationItem.rightBarButtonItem = rightitem;
}

#pragma mark 注册Cell(控制)
-(void)registerCell{
    UINib *nib1= [UINib nibWithNibName:@"ZZTCartoonCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib1 forCellWithReuseIdentifier:collectionID];

}

-(void)loadData{
    if([self.viewType isEqualToString:@"1"]){
        //请求参数
        NSDictionary *paramDict = @{
                                    @"userId":self.user.userId,
                                    };
        [self.manager POST:[ZZTAPI stringByAppendingString:@"great/userCollect"] parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
            NSArray *array = [ZZTCartonnPlayModel mj_objectArrayWithKeyValuesArray:dic];
            self.cartoons = array;
            [self.collectionView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败 -- %@",error);
        }];
    }else{
        //请求参数
        NSDictionary *paramDict = @{
                                    @"userId":self.user.userId
                                    };
        
        [self.manager POST:[ZZTAPI stringByAppendingString:@"great/userCollect"] parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
            NSArray *array = [ZZTCartonnPlayModel mj_objectArrayWithKeyValuesArray:dic];
            self.cartoons = array;
            [self.collectionView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败 -- %@",error);
        }];
    }
   
}

#pragma mark - 创建流水布局
-(UICollectionViewFlowLayout *)setupCollectionViewFlowLayout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
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

    ZZTCartoonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    ZZTCartonnPlayModel *car = self.cartoons[indexPath.row];
    if (car) {
        cell.cartoon = car;
    }
    return cell;
}
//加载数据
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
@end
