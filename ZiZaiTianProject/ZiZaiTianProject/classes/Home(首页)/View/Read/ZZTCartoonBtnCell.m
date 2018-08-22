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
#import "ZXDCartoonFlexoBtn.h"
#import "ZZTProductionShowViewController.h"
#import "ZZTRankViewController.h"
#import "ZZTClassifyViewController.h"
@interface ZZTCartoonBtnCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong , nonatomic)UICollectionView *collectionView;
@property (nonatomic,assign)CGFloat listViewItemSize;
@property (nonatomic,strong) NSArray *btnArray;

@property (nonatomic,strong) ZXDCartoonFlexoBtn *multiplayer;
@property (nonatomic,strong) ZXDCartoonFlexoBtn *solo;
@property (nonatomic,strong) ZXDCartoonFlexoBtn *rank;
@property (nonatomic,strong) ZXDCartoonFlexoBtn *classify;
@property (nonatomic,strong) UIView *botttomView;
@property (nonatomic,strong) UIView *btnView;


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

-(void)setStr:(NSString *)str{
    _str = str;
}
-(void)setArray:(NSArray *)array{
    _array = array;
    self.btnArray = array;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *btnView = [[UIView alloc] init];
        _btnView = btnView;
        [self addSubview:btnView];
        
        //众创
        ZXDCartoonFlexoBtn *multiplayer = [[ZXDCartoonFlexoBtn alloc] init];
        self.multiplayer = multiplayer;
        [multiplayer setTitle:@"众创" forState:UIControlStateNormal];
        [multiplayer setImage:[UIImage imageNamed:@"阅读-分类入口-众创"] forState:UIControlStateNormal];
        multiplayer.titleLabel.textAlignment = NSTextAlignmentCenter;
        multiplayer.titleLabel.font = [UIFont systemFontOfSize:14];
        [multiplayer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //添加事件
        [multiplayer addTarget:self action:@selector(multiplayerTarget) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:multiplayer];
        
        //独创
        ZXDCartoonFlexoBtn *solo = [[ZXDCartoonFlexoBtn alloc] init];
        self.solo = solo;
        [solo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        solo.titleLabel.textAlignment = NSTextAlignmentCenter;

        [solo setTitle:@"独创" forState:UIControlStateNormal];
        [solo setImage:[UIImage imageNamed:@"阅读-分类入口-独创"] forState:UIControlStateNormal];
        solo.titleLabel.font = [UIFont systemFontOfSize:14];
        [solo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [solo addTarget:self action:@selector(soloTarget) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:solo];
        
        //排行
        ZXDCartoonFlexoBtn *rank = [[ZXDCartoonFlexoBtn alloc] init];
        self.rank = rank;
        [rank setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rank.titleLabel.textAlignment = NSTextAlignmentCenter;

        [rank setTitle:@"排行" forState:UIControlStateNormal];
        [rank setImage:[UIImage imageNamed:@"阅读-分类入口-排行"] forState:UIControlStateNormal];
        rank.titleLabel.font = [UIFont systemFontOfSize:14];
        [rank setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rank addTarget:self action:@selector(rankTarget) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:rank];
        
        //分类
        ZXDCartoonFlexoBtn *classify = [[ZXDCartoonFlexoBtn alloc] init];
        self.classify = classify;
        [classify setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        classify.titleLabel.textAlignment = NSTextAlignmentCenter;

        [classify setTitle:@"分类" forState:UIControlStateNormal];
        [classify setImage:[UIImage imageNamed:@"阅读-分类入口-分类"] forState:UIControlStateNormal];
        classify.titleLabel.font = [UIFont systemFontOfSize:14];
        [classify setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [classify addTarget:self action:@selector(classifyTarget) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:classify];
        
        //一条线
        UIView *bottomView = [[UIView alloc] init];
        self.botttomView = bottomView;
        bottomView.backgroundColor = [UIColor colorWithHexString:@"#F0F1F2"];
        [self addSubview:bottomView];
    }
    return self;
}

-(void)multiplayerTarget{
    ZZTProductionShowViewController *productionVC = [[ZZTProductionShowViewController alloc] init];
    [self myViewController].hidesBottomBarWhenPushed = YES;
    [[self myViewController].navigationController pushViewController:productionVC animated:YES];
    [self myViewController].hidesBottomBarWhenPushed = NO;
    productionVC.viewTitle = @"众创作品";
    [self loadProductionData:@"1" VC:productionVC];
}

-(void)soloTarget{
    ZZTProductionShowViewController *productionVC = [[ZZTProductionShowViewController alloc] init];
    [self myViewController].hidesBottomBarWhenPushed = YES;
    [[self myViewController].navigationController pushViewController:productionVC animated:YES];
    [self myViewController].hidesBottomBarWhenPushed = NO;
    productionVC.viewTitle = @"独创作品";
    [self loadProductionData:@"2" VC:productionVC];
}
-(void)rankTarget{
    ZZTRankViewController *rankVC = [[ZZTRankViewController alloc] init];
    [self myViewController].hidesBottomBarWhenPushed = YES;
    [[self myViewController].navigationController pushViewController:rankVC animated:YES];
    [self myViewController].hidesBottomBarWhenPushed = NO;
}
-(void)classifyTarget{
    ZZTClassifyViewController *classifyVC = [[ZZTClassifyViewController alloc] init];
    [self myViewController].hidesBottomBarWhenPushed = YES;
    [[self myViewController].navigationController pushViewController:classifyVC animated:YES];
    [self myViewController].hidesBottomBarWhenPushed = NO;
}
-(void)loadProductionData:(NSString *)cartoonType VC:(ZZTProductionShowViewController *)VC{
    NSDictionary *dic = @{
                          @"bookType":@"",
                          //众创
                          @"cartoonType":cartoonType,
                          @"pageNum":@"1",
                          @"pageSize":@"10"
                          };
    
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"cartoon/cartoonlist"] parameters:dic success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSMutableArray *array = [ZZTCartonnPlayModel mj_objectArrayWithKeyValuesArray:dic];
        VC.array = array;
    } failure:^(NSError *error) {
        
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat btnWidth = 40;
    CGFloat btnY = 25;
    CGFloat btnHeight = height - height/5 * 2;
    CGFloat btnViewWidth = width - 100;
    CGFloat btnViewHeight = height - 4;
    CGFloat space = (btnViewWidth - btnWidth*4)/3;
    
    self.btnView.frame = CGRectMake((width - btnViewWidth)/2, 0, btnViewWidth, btnViewHeight);

    self.multiplayer.frame = CGRectMake(0, btnY, btnWidth, btnHeight);

    self.solo.frame = CGRectMake(self.multiplayer.x+btnWidth+space, btnY, btnWidth, btnHeight);

    self.rank.frame = CGRectMake(self.solo.x+btnWidth+space, btnY, btnWidth, btnHeight);

    self.classify.frame = CGRectMake(self.rank.x+btnWidth+space, btnY, btnWidth, btnHeight);

    self.botttomView.frame = CGRectMake(0, height - 4, width, 4);
}

@end
