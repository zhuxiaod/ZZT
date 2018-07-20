//
//  ZZTCartoonBtnCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonBtnCell.h"
#import "ZZTFirstViewBtn.h"
#import "ZZTEasyBtnModel.h"
#import "ZZTCartoonHeaderView.h"

@interface ZZTCartoonBtnCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong , nonatomic)UICollectionView *collectionView;
@property (nonatomic,assign)CGFloat listViewItemSize;
@property (nonatomic,strong) NSArray *btnArray;
@end
@implementation ZZTCartoonBtnCell

static NSString *const zxdCartoonBtnCell = @"zxdCartoonBtnCell";

#pragma mark - lazyload
- (NSArray *)btnArray{
    if(!_btnArray){
        _btnArray = [NSArray array];
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
        CGFloat listViewWidth = self.width * 0.9;
        CGFloat listViewItemSize = 100;

        _collectionView.frame = CGRectMake((Screen_Width-listViewWidth)/2, 0, listViewWidth , 100);
        _listViewItemSize = listViewItemSize;
        [self addSubview:_collectionView];
        //注册
        [_collectionView registerNib:[UINib nibWithNibName:@"ZZTFirstViewBtn" bundle:nil] forCellWithReuseIdentifier:zxdCartoonBtnCell];
    }
    return _collectionView;
}

-(void)setStr:(NSString *)str{
    _str = str;
    [self setUpBase];
}
-(void)setArray:(NSArray *)array{
    _array = array;
    self.btnArray = array;
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
    ZZTFirstViewBtn *cell = [collectionView dequeueReusableCellWithReuseIdentifier:zxdCartoonBtnCell forIndexPath:indexPath];
    ZZTEasyBtnModel *model = self.btnArray[indexPath.row];
    cell.btnModel = model;
    return cell;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        return CGSizeMake(60, 100);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //通过数据来控制btn的多少
    //通过数据来控制btn的类型
}

@end
