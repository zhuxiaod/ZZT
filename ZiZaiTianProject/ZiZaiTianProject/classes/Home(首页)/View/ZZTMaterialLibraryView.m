//
//  ZZTMaterialLibraryView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMaterialLibraryView.h"
#import "ZZTMaterialKindView.h"
#import "ZZTMaterialTypeView.h"
#import "ZZTFodderListModel.h"
@interface ZZTMaterialLibraryView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSArray *kinds;
@property (nonatomic,strong)NSArray *typs;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)UICollectionView *collectionView;


@end

@implementation ZZTMaterialLibraryView

-(NSArray *)kinds{
    if(!_kinds){
        _kinds = @[@"背景图",@"场景",@"角色",@"当前框",@"所有框"];
    }
    return _kinds;
}

-(NSArray *)typs{
    if(!_typs){
        _typs = @[@"2格",@"3格",@"4格"];
    }
    return _typs;
}

-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    self.dataArray = dataSource;
    [_collectionView reloadData];
}
//分三层 如何分层 我要写一个 低配版的
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        //创建kinds
        ZZTMaterialKindView *MaterialKindView = [[ZZTMaterialKindView alloc] init:self.kinds Width:SCREEN_WIDTH];
        MaterialKindView.frame = CGRectMake(0, 5, SCREEN_WIDTH, 20);
        MaterialKindView.backgroundColor = [UIColor blackColor];
        [self addSubview:MaterialKindView];
    
        //创建typs
        ZZTMaterialTypeView *materialTypeView = [[ZZTMaterialTypeView alloc] init:self.typs Width:SCREEN_WIDTH];
        materialTypeView.frame = CGRectMake(0, MaterialKindView.frame.origin.y + 20 + 10, SCREEN_WIDTH, 20) ;
        [self addSubview:materialTypeView];
        
        //素材库
        UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 60, Screen_Width, self.height - 60 - 5);
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:_collectionView];
    }
    return self;
}
-(UICollectionViewFlowLayout *)setupCollectionViewFlowLayout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //修改尺寸(控制)
    layout.itemSize = CGSizeMake(100,200);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //行距
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
    return layout;
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - collectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    ZZTFodderListModel *model = self.dataArray[indexPath.row];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"peien"]];
    [cell.contentView addSubview:imageView];
    
    return cell;
}
/*明天计划
 三级联动
 button点击更新数据
 */

@end
