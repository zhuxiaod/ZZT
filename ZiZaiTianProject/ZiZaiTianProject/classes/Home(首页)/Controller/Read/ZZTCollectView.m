//
//  ZZTCollectView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCollectView.h"
@interface ZZTCollectView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *cartoons;

@end

@implementation ZZTCollectView

- (NSArray *)cartoons{
    if (!_cartoons) {
        _cartoons = [NSArray array];
    }
    return _cartoons;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.delegate = self;
        self.dataSource = self;
        //流水布局
        UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];
        //创建UICollectionView：黑色
        [self setupCollectionView:layout];
    }
    return self;
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
    [self addSubview:self.collectionView];
    collectionView.dataSource = self;
    collectionView.delegate = self;
}
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return self.cartoons.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    ZZTCartoonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collection forIndexPath:indexPath];
//    ZZTCartonnPlayModel *car = self.cartoons[indexPath.row];
//    cell.cartoon = car;
//    return cell;
//}
@end
