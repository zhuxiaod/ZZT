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
#import "ZZTShoppingHeader.h"
#import "ZZTShoppingBtnCell.h"
#import "ZZTMaterialCell.h"
#import "ZZTShoppingHeaderView.h"


@interface ZZTShoppingMallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *dataArray;

@property (weak, nonatomic) IBOutlet UILabel *viewControllerTitle;

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ZZTShoppingMallViewController

NSString *zztShoppingBtnCell = @"zztShoppingBtnCell";
NSString *zzTShoppingHeader = @"zzTShoppingHeader";
NSString *zzTShoppingBottomCell = @"zzTShoppingBottomCell";
NSString *zzTMaterialCell = @"zzTMaterialCell";

NSString *zzTShoppingHeaderView = @"zzTShoppingHeaderView";
NSString *zzTShoppingHead = @"zzTShoppingHead";

#pragma mark - lazyLoad
- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.headerReferenceSize = CGSizeMake(Screen_Width, 20);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 64, Screen_Width, Screen_Height - 64);
        _collectionView.showsVerticalScrollIndicator = NO;
        
        //注册
        [_collectionView registerNib:[UINib nibWithNibName:@"ZZTShoppingHeader" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:zzTShoppingHeader];
        [_collectionView registerClass:[ZZTShoppingBtnCell class] forCellWithReuseIdentifier:zztShoppingBtnCell];
        [_collectionView registerNib:[UINib nibWithNibName:@"ZZTMaterialCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:zzTMaterialCell];
        [_collectionView registerNib:[UINib nibWithNibName:@"ZZTShoppingHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:zzTShoppingHeaderView];
         [_collectionView registerNib:[UINib nibWithNibName:@"ZZTShoppingHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:zzTShoppingHead];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //启动
    [self setUpBase];
    [self setViewTitle:_viewTitle];
}

-(void)setViewTitle:(NSString *)viewTitle{
    _viewTitle = viewTitle;
    [self.viewControllerTitle setText:viewTitle];
}
-(void)setIsShopping:(BOOL)isShopping{
    _isShopping = isShopping;
    if(isShopping == YES){
        //中间数据源
        _dataArray = @[[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"5张" BNumber:@"50币"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"10张" BNumber:@"100币"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"50张" BNumber:@"480币"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"100张" BNumber:@"900币"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"300张" BNumber:@"2500币"]];
    }else{
        //数据源
        _dataArray = @[[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"5张" BNumber:@"500分"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"10张" BNumber:@"1000分"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"50张" BNumber:@"4800分"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"100张" BNumber:@"9000分"],[ZZTShoppingBtnModel initShopBtnWith:@"integral_1" ticketNumber:@"300张" BNumber:@"25000分"]];
    }
}
#pragma mark - CollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 10;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:zzTShoppingHeader forIndexPath:indexPath];
    if(indexPath.section == 0){
        ZZTShoppingHeader *cell = [collectionView dequeueReusableCellWithReuseIdentifier:zzTShoppingHeader forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        ZZTShoppingBtnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:zztShoppingBtnCell forIndexPath:indexPath];
        //控制
        cell.array = self.dataArray;
        return cell;
    }else if (indexPath.section == 2){
        //素材
        ZZTMaterialCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:zzTMaterialCell forIndexPath:indexPath];
        return cell;
    }else{
        return cell;
    }
    return cell;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(Screen_Width,175);
    }else if (indexPath.section == 1){
        return CGSizeMake(Screen_Width, 100);
    }else if (indexPath.section == 2){
        return CGSizeMake(115, 200);
    }
    return CGSizeZero;
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = ZZTBGColor;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
//加内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if(section == 2){
         return UIEdgeInsetsMake(0, 5 ,0, 5);
    }
    return UIEdgeInsetsMake(0,0,0,0);
}
//返回上一页
- (IBAction)backBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//头视图(不用改)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if(kind == UICollectionElementKindSectionHeader){
        if(indexPath.section == 1){
            ZZTShoppingHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:zzTShoppingHeaderView forIndexPath:indexPath];
            headerView.viewTitle = @"阅读卷";
            return headerView;
        }else if (indexPath.section == 2){
            ZZTShoppingHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:zzTShoppingHeaderView forIndexPath:indexPath];
            headerView.viewTitle = @"素材";
            return headerView;
        }else{
            ZZTShoppingHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:zzTShoppingHeaderView forIndexPath:indexPath];
            return headerView;
        }
    }
    return reusableview;
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return CGSizeZero;
    }else if (section == 1){
        return CGSizeMake(Screen_Width,20);
    }else if (section == 2)
    {
        return CGSizeMake(Screen_Width,20);
    }
    return CGSizeZero;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end
