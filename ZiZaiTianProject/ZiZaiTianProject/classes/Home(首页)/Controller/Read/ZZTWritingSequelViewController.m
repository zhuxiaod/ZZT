//
//  ZZTWritingSequelViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWritingSequelViewController.h"

@interface ZZTWritingSequelViewController ()

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *cartoons;

@property (nonatomic,strong) NSArray *caiNiXiHuan;

@end

static NSString *collectionID = @"collectionID";

@implementation ZZTWritingSequelViewController

- (NSArray *)cartoons{
    if (!_cartoons) {
        _cartoons = [NSArray array];
    }
    return _cartoons;
}

- (NSArray *)caiNiXiHuan{
    if (!_caiNiXiHuan) {
        _caiNiXiHuan = [NSArray array];
    }
    return _caiNiXiHuan;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"作品续作";
    
    [self loadData];
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
-(void)loadData{
        //请求参数
        NSDictionary *paramDict = @{
                                    @"userId":@"1",
                                    };
        [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"great/userCollect"] parameters:paramDict success:^(id responseObject) {
            NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
            NSArray *array = [ZZTCartonnPlayModel mj_objectArrayWithKeyValuesArray:dic];
            self.cartoons = array;
            [self.collectionView reloadData];
        } failure:^(NSError *error) {
            
        }];
}
@end
