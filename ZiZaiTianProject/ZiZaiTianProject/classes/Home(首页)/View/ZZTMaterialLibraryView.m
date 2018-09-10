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
#import "ZZTKindModel.h"
#import "ZZTTypeModel.h"
#import "ZZTDetailModel.h"
#import "ZZTMaterialLibraryCell.h"

@interface ZZTMaterialLibraryView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSMutableArray *kinds;
@property (nonatomic,strong)NSMutableArray *typs;
//@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *materialLibrary;

@property (nonatomic,strong)ZZTMaterialKindView *MaterialKindView;
@property (nonatomic,strong)ZZTMaterialTypeView *materialTypeView;

@property (nonatomic,strong)NSString *fodderType;
@property (nonatomic,strong)NSString *modelType;
@property (nonatomic,strong)NSString *modelSubtype;

@end

@implementation ZZTMaterialLibraryView

-(NSArray *)materialLibrary{
    if(!_materialLibrary){
        _materialLibrary = [NSArray array];
    }
    return _materialLibrary;
}

-(NSMutableArray *)kinds{
    if(!_kinds){
        _kinds = [NSMutableArray array];
    }
    return _kinds;
}

-(id)JsonObject:(NSString *)jsonStr{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonStr ofType:nil];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error;
    id JsonObject= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    return JsonObject;
}

-(NSMutableArray *)typs{
    if(!_typs){
        _typs = [NSMutableArray array];
    }
    return _typs;
}

//设置图片数据 刷新
-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

//分三层 如何分层 我要写一个 低配版的
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor colorWithHexString:@"#B1B1B1"];
        //素材库
        UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#B1B1B1"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 60, Screen_Width, self.height - 60 - 5);
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[ZZTMaterialLibraryCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:_collectionView];
        
        //解析json
        NSArray *arr = [self JsonObject:@"materialLibrary.json"];
        self.materialLibrary = [ZZTKindModel mj_objectArrayWithKeyValuesArray:arr];
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnData:)name:@"btnText" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnIndex:)name:@"btnIndex" object:nil];
//        self.fodderType = @"1";
        self.modelType = @"1";
        self.modelSubtype = @"1";
        
    }
    return self;
}

//1 点击事件 获得
//2级创建的时候 触发一次
-(void)btnData:(NSNotification *)text{
    //寻找这个对象
    for (ZZTTypeModel *model in self.kinds) {
        
        //找到点击的btn 相对应的模型
        if ([model.type isEqualToString:text.userInfo[@"text"]]) {
            //记录模型的索引
            self.modelType = model.typeCode;
            //解析模型数据
            _typs = [ZZTDetailModel mj_objectArrayWithKeyValuesArray:model.typeList];
            //创建三级的视图
        }
    }
    [self creatTypeView:_typs];
}

//3级视图创建时 触发
-(void)btnIndex:(NSNotification *)text{
    NSLog(@"111%@",text.userInfo[@"text"]);
    for (ZZTDetailModel *model in self.typs) {
        if ([model.detail isEqualToString:text.userInfo[@"text"]]){
            self.modelSubtype = model.detailCode;
            //代理传出去
            [self getData:self.fodderType modelType:self.modelType modelSubtype:self.modelSubtype];
        }
    }
}

-(void)setStr:(NSString *)str{
    //第一次创建 2次  第二次为想要的
    _str = str;
    _kinds = nil;
    _typs = nil;
    //把数组准备好
    for (ZZTKindModel *material in self.materialLibrary) {
        if([str isEqualToString:material.kind]){
            //找到索引
            self.fodderType = material.code;
            //2级数据
            _kinds = [ZZTTypeModel mj_objectArrayWithKeyValuesArray:material.kindList];
            ZZTTypeModel *type = _kinds[0];
            //默认第一个3级数据
            _typs = [ZZTDetailModel mj_objectArrayWithKeyValuesArray:type.typeList];
            //暴力方法
        }
    }
    //创建2级视图
    [self creatView:_kinds];
}

//2级创建方法
-(void)creatView:(NSMutableArray *)kinds{
    //2次
    [_MaterialKindView removeFromSuperview];

    _MaterialKindView = [[ZZTMaterialKindView alloc] init:kinds Width:SCREEN_WIDTH];
    _MaterialKindView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    _MaterialKindView.backgroundColor = [UIColor colorWithHexString:@"#E1E2E3"];
    [self addSubview:_MaterialKindView];
}

//3级创建方法
-(void)creatTypeView:(NSMutableArray *)type{
    [_materialTypeView removeFromSuperview];
    //创建typs
    _materialTypeView = [[ZZTMaterialTypeView alloc] init:type Width:SCREEN_WIDTH];
    _materialTypeView.frame = CGRectMake(0, 35, SCREEN_WIDTH, 20);
    [self addSubview:_materialTypeView];
}

//代理方法
-(void)getData:(NSString *)fodderType modelType:(NSString *)modelType modelSubtype:(NSString *)modelSubtype{
    if (self.delagate && [self.delagate respondsToSelector:@selector(sendRequestWithStr:modelType:modelSubtype:)]) {
        [self.delagate sendRequestWithStr:fodderType modelType:modelType modelSubtype:modelSubtype];
    }
}

-(UICollectionViewFlowLayout *)setupCollectionViewFlowLayout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //修改尺寸(控制)
    layout.itemSize = CGSizeMake(100,self.height - 60 - 5);
    
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
//还是数据源有问题  数据源先后
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZTMaterialLibraryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ZZTFodderListModel *model = self.dataSource[indexPath.row];
    
    cell.imageURl = model.img;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取View的信息
    ZZTFodderListModel *model = self.dataSource[indexPath.row];
    model.owner = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    if([self.str isEqualToString:@"文字"]){
        //设置一个文字的代理方法
        if(self.delagate && [self.delagate respondsToSelector:@selector(sendTextImageWithModel:)]){
            [self.delagate sendTextImageWithModel:model];
        }
    }else if([self.fodderType isEqualToString:@"1"] && [self.modelType isEqualToString:@"1"] && [self.modelSubtype isEqualToString:@"1"]){
        if(self.delagate && [self.delagate respondsToSelector:@selector(sendTuKuangWithModel:)]){
            [self.delagate sendTuKuangWithModel:model];
        }
    }else if([self.fodderType isEqualToString:@"1"] && [self.modelType isEqualToString:@"1"] && [self.modelSubtype isEqualToString:@"2"]){
        //圆形
        if(self.delagate && [self.delagate respondsToSelector:@selector(sendTuKuangWithModel:)]){
            [self.delagate sendYuanKuangWithModel:model];
        }
    }else{
        if(self.delagate && [self.delagate respondsToSelector:@selector(sendImageWithModel:)]){
            [self.delagate sendImageWithModel:model];
        }
    }
    //如果是方框
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"btnText" object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"btnIndex" object:self];
}
@end
