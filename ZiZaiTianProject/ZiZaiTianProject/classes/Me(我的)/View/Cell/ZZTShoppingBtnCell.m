//
//  ZZTShoppingBtnCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTShoppingBtnCell.h"
#import "ZZTShoppingMallCell.h"
#import "ZZTShoppingBtnModel.h"

@interface ZZTShoppingBtnCell ()<UICollectionViewDelegate,UICollectionViewDataSource,DCNewWelfareLayoutDelegate>

@property (strong , nonatomic)UICollectionView *collectionView;

@end

static NSString *const zztShoppingBtnCell = @"zztShoppingBtnCell";

@implementation ZZTShoppingBtnCell

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        //行距
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 5;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake((Screen_Width-275)/2, 0, 275 , 100);

        [self addSubview:_collectionView];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"ZZTShoppingMallCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:zztShoppingBtnCell];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"]; //注册头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusableView"]; //注册尾部
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpBase];
    }
    return self;
}
#pragma mark - initialize
- (void)setUpBase
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZZTShoppingMallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:zztShoppingBtnCell forIndexPath:indexPath];
    ZZTShoppingBtnModel *model = self.array[indexPath.row];
    cell.btn = model;
    return cell;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(50, 100);
    }
    return CGSizeZero;
}
@end
