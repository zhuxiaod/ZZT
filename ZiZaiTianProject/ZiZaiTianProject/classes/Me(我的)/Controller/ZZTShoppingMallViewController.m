//
//  ZZTShoppingMallViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTShoppingMallViewController.h"
#import "ZZTShoppingMallCell.h"
#import "ZZTShoppingBtnModel.h"

@interface ZZTShoppingMallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation ZZTShoppingMallViewController

NSString *zzTShoppingMallCell = @"zzTShoppingMallCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //数据源
    _dataArray = @[[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"5张" BNumber:@"50币"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"10张" BNumber:@"100币"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"50张" BNumber:@"480币"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"100张" BNumber:@"900币"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"300张" BNumber:@"2500币"]];
    //设置topView
//    [self setupTopView];
    
    //设置midVIew
    UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];
    //创建UICollectionView：黑色
    [self setupCollectionView:layout];
    
    //注册Cell
    [self registerCell];
}

-(void)registerCell{
    UINib *nib1= [UINib nibWithNibName:@"ZZTShoppingMallCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib1 forCellWithReuseIdentifier:zzTShoppingMallCell];
}

#pragma mark - CollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZTShoppingMallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:zzTShoppingMallCell forIndexPath:indexPath];
    cell.btn = self.dataArray[indexPath.row];
    return cell;
}
#pragma mark - 创建CollectionView
-(void)setupCollectionView:(UICollectionViewFlowLayout *)layout
{
    _collectionView.scrollEnabled = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.collectionViewLayout = layout;
}

#pragma mark - 创建流水布局
-(UICollectionViewFlowLayout *)setupCollectionViewFlowLayout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];

    layout.itemSize = CGSizeMake(50,100);
  
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //行距
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    return layout;
}

//
//-(void)setupTopView{
//    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _topView.bounds.size.width, _topView.bounds.size.height)];
//    topImageView.image = [UIImage imageNamed:@"home_logo"];
//    [self.topView addSubview:topImageView];
//}
@end
