//
//  ZZTCreationBtnCellTableViewCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCreationBtnCellTableViewCell.h"
#import "ZZTSecondBtn.h"
#import "ZZTSecondCell.h"
#import "ZZTEasyBtnModel.h"

@interface ZZTCreationBtnCellTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong , nonatomic) UICollectionView *collectionView;

@property (nonatomic,assign) CGFloat listViewItemSize;

@property (nonatomic,strong) NSArray *btnArray;

@end

@implementation ZZTCreationBtnCellTableViewCell

static NSString *const zztCreationCell = @"zztCreationCell";

- (NSArray *)btnArray{
    if(!_btnArray){
        _btnArray = @[[ZZTEasyBtnModel initWithTitle:@"创建漫画" btnColor:@"#8ACBBF"],[ZZTEasyBtnModel initWithTitle:@"创建剧本" btnColor:@"#88AECB"],[ZZTEasyBtnModel initWithTitle:@"更新" btnColor:@"#7979B2"]];
    }
    return _btnArray;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        //行距
        //        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        CGFloat listViewWidth = self.width;
        CGFloat listViewItemSize = 100;
        
        _collectionView.frame = CGRectMake((Screen_Width-listViewWidth)/2, 0, listViewWidth , 100);
        _listViewItemSize = listViewItemSize;
        [self addSubview:_collectionView];
        //注册
        [_collectionView registerNib:[UINib nibWithNibName:@"ZZTSecondCell" bundle:nil] forCellWithReuseIdentifier:zztCreationCell];
    }
    return _collectionView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setStr:(NSString *)str{
    [self setUpBase];
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
    return self.btnArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZZTSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:zztCreationCell forIndexPath:indexPath];
    ZZTEasyBtnModel *model = self.btnArray[indexPath.row];
    cell.btnMoedel = model;
    return cell;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 80);
}
@end
