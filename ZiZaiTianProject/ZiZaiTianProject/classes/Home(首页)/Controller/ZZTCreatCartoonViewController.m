//
//  ZZTCreatCartoonViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCreatCartoonViewController.h"
#import "ZZTMaterialLibraryView.h"
#import "ZZTFodderListModel.h"
#import "EditImageView.h"
#import "ZZTImageEditView.h"
#import "ZZTEditImageViewModel.h"
#import "ZZTCartoonDrawView.h"
#import "ZZTDIYCellModel.h"
#import "ZZTAddLengthFooterView.h"

@interface ZZTCreatCartoonViewController ()<MaterialLibraryViewDelegate,EditImageViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
//舞台
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) ZZTMaterialLibraryView *materialLibraryView;

@property (nonatomic,strong) NSString *str;

@property (nonatomic,strong) NSMutableArray *editImageArray;

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,strong) EditImageView *currentView;

@property (nonatomic,assign) NSInteger tagID;

@property (nonatomic,strong) NSArray *array;

@property (nonatomic,strong) NSMutableArray *recoverArray;
//是否清空
@property (nonatomic,assign) BOOL isEmpty;

@property (nonatomic,strong) NSMutableArray *cartoonEditArray;
//当前被选中的行
@property (nonatomic,assign) NSInteger selectRow;

@end

@implementation ZZTCreatCartoonViewController
//漫画页
-(NSMutableArray *)cartoonEditArray{
    if(!_cartoonEditArray){
        _cartoonEditArray = [NSMutableArray array];
    }
    return _cartoonEditArray;
}
//舞台组
-(NSMutableArray *)editImageArray{
    if(!_editImageArray){
        _editImageArray = [NSMutableArray array];
    }
    return _editImageArray;
}
//恢复组
-(NSMutableArray *)recoverArray{
    if(!_recoverArray){
        _recoverArray = [NSMutableArray array];
    }
    return _recoverArray;
}
//数据源
-(NSArray *)dataSource{
    if(!_dataSource){
        _dataSource = [NSArray array];
    }
    return _dataSource;
}
#pragma mark - viewDidLoad
-(void)viewDidLoad {
    [super viewDidLoad];
    ZZTDIYCellModel *cell = [ZZTDIYCellModel initCellWith:300 isSelect:YES];
    [self.cartoonEditArray addObject:cell];
    //是否清空
    self.isEmpty = NO;
    //关闭滑动返回
    self.rr_backActionDisAble = YES;
    //隐藏nav
    self.rr_navHidden = YES;
    //注册移除image的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeEdit:) name:@"remove" object:NULL];
    
    self.view.userInteractionEnabled = YES;
    self.midView.userInteractionEnabled = YES;
    
    //设置隐藏View
    [self setupTapView];
    
    //UICollectionView
    [self setupCollectionView];
    
}
#pragma mark 设置CollectionView
-(void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //足的长
    flowLayout.footerReferenceSize =CGSizeMake(SCREEN_WIDTH, 40);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,self.midView.width, self.midView.height) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor  grayColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    _collectionView = collectionView;
    [collectionView registerNib:[UINib nibWithNibName:@"ZZTAddLengthFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    [self.midView addSubview:collectionView];
}
#pragma mark - collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cartoonEditArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    [collectionView registerNib:[UINib nibWithNibName:@"ZZTCartoonDrawView" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    //使cell 不重用
    ZZTCartoonDrawView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    ZZTDIYCellModel *model = self.cartoonEditArray[indexPath.row];
    
    //将数组的内容存到模型中
    //每个cell 对应一个  将对应的数据进行加载
    //在View上创建
    cell.isSelect = model.isSelect;

    return cell;
}

#pragma mark 定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZZTDIYCellModel *cell = self.cartoonEditArray[indexPath.row];
    return CGSizeMake(self.view.bounds.size.width,cell.height);
}

#pragma mark 漫画信息
-(void)setModel:(ZZTCreationEntranceModel *)model{
    _model = model;
    NSLog(@"%@",model);
}

#pragma mark 定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark 定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//数据要用model来装才行
#pragma mark 点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self hideAllBtn];
    //点击 控制cell的颜色
    ZZTDIYCellModel *model = self.cartoonEditArray[indexPath.row];
    self.selectRow = indexPath.row;
    for (ZZTDIYCellModel *mod in self.cartoonEditArray) {
        if(mod == model){
            mod.isSelect = YES;
        }else{
            mod.isSelect = NO;
        }
    }
    [self.collectionView reloadData];
}

#pragma mark 设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//足视图创建
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ZZTAddLengthFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView"forIndexPath:indexPath];
        
        footerView.addLengthBtnClick = ^(UIButton *btn) {
            
        };
        footerView.addCellBtnClick = ^(UIButton *btn) {
            ZZTDIYCellModel *cell = [ZZTDIYCellModel initCellWith:300 isSelect:NO];
            NSMutableArray *array = self.cartoonEditArray;
            [array addObject:cell];
            self.cartoonEditArray = array;
            
            [self.collectionView reloadData];
        };
        return footerView;
    }
    return nil;
}

#pragma mark 功能块
//返回
- (IBAction)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//保存
- (IBAction)save:(UIBarButtonItem *)sender {
    UIImage *viewImage = [self imageThumb];
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
}

//上一页
- (IBAction)previousPage:(id)sender {
}

//下一页
- (IBAction)nextPage:(id)sender {
}

//清空
- (IBAction)empty:(id)sender {
    //可以恢复
    self.isEmpty = YES;
    //复制数据
    self.recoverArray = [self.editImageArray mutableCopy];
    //清空所有图层
    for (ZZTEditImageViewModel *model in self.editImageArray) {
        model.imageView.hidden = YES;
    }
    [self.editImageArray removeAllObjects];
}

//提交
- (IBAction)commit:(id)sender {
}

//翻转
- (IBAction)spin:(id)sender {
    //是当前对象才能被翻转
    if(self.currentView && self.currentView.isHide == NO){
        self.currentView.image = [self.currentView.image flipHorizontal];
    }
}

#pragma mark 改变图片上下级功能
//上一层
- (IBAction)upLevel:(id)sender {
    //得到当前选择View在数据中的索引
    NSInteger index = [self getCurrentViewIndex];
    //如果是最后一个对象的话 会是count-1
    if(index == (self.editImageArray.count - 1)){
        NSLog(@"已经到最上方了");
    }else{
        //改变数据的位置
        [self exchangeViewIndex:index exchangeIndex:(index + 1)];
    }
}

//下一层
- (IBAction)downLevel:(id)sender {
    //得到当前选择View在数据中的索引
    NSInteger index = [self getCurrentViewIndex];
    if(index == 0){
        NSLog(@"已经到最下方了");
    }else{
        //改变数据的位置
        [self exchangeViewIndex:index exchangeIndex:(index - 1)];
    }
}
//查看当前View的索引
-(NSInteger)getCurrentViewIndex{
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.editImageArray.count; i++) {
        ZZTEditImageViewModel *model = self.editImageArray[i];
        if(model.imageView == self.currentView){
            index = i;
            break;
        }
    }
    return index;
}

//交换2个视图的层级位置 和 数据所在的位置
-(void)exchangeViewIndex:(NSInteger )index exchangeIndex:(NSInteger )exchangeIndex{
    
    if(self.editImageArray.count > 0){
        ZZTEditImageViewModel *model1 = self.editImageArray[index];
        model1.imageView.layer.zPosition = exchangeIndex;
        ZZTEditImageViewModel *model2 = self.editImageArray[exchangeIndex];
        model2.imageView.layer.zPosition = index;
        [self.editImageArray exchangeObjectAtIndex:index withObjectAtIndex:exchangeIndex];
    }
}

//前进
- (IBAction)advance:(id)sender {
}

//后退 清空恢复
- (IBAction)retreat:(id)sender {
    if (_isEmpty == YES) {
        self.editImageArray = self.recoverArray;
        for (int i = 0; i < self.editImageArray.count; i++) {
            //不能用View 存数据
            ZZTEditImageViewModel *view = self.editImageArray[i];
            EditImageView *review = [[EditImageView alloc] initWithFrame:view.imageViewFrame];
            view.imageView = review;
            [review sd_setImageWithURL:[NSURL URLWithString:view.imageUrl]];
            [self.midView addSubview:review];
        }
        _isEmpty = NO;
    }
}

//调色板
-(IBAction)colourModulation:(id)sender {
}

//收藏
- (IBAction)collect:(id)sender {
}

//收藏夹
- (IBAction)favorite:(id)sender {
}

//清空图层
- (IBAction)emptyView:(id)sender {
}

#pragma mark ZZTMaterialLibraryViewDelegate 按索引获取数据
-(void)sendRequestWithStr:(NSString *)fodderType modelType:(NSString *)modelType modelSubtype:(NSString *)modelSubtype
{
    [self loadMaterialData:fodderType modelType:modelType modelSubtype:modelSubtype];
}

#pragma mark 添加一个图层并备份
-(void)sendImageWithModel:(ZZTFodderListModel *)model{
    //得到当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_selectRow     inSection:0];
    ZZTCartoonDrawView *cell = (ZZTCartoonDrawView *)[self.collectionView cellForItemAtIndexPath:indexPath];
    //注意修改size
    //添加新的图层
    EditImageView *imageView = [self speedInitImageView:model.img];
    [cell.operationView addSubview:imageView];
    //记录位置
    CGRect startRact = [imageView convertRect:imageView.bounds toView:_midView];
    //数据备份
    ZZTEditImageViewModel *imageModel = [ZZTEditImageViewModel initImgaeViewModel:startRact imageUrl:model.img imageView:imageView];
    [self.editImageArray addObject:imageModel];

    //将新创建的view设置为当前View
    [self EditImageViewWithView:imageView];
    self.tagID++;
}
//快速创建方法
-(EditImageView *)speedInitImageView:(NSString *)imgUrl{
    EditImageView *imageView = [[EditImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.delagate = self;
    [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];

    return imageView;
}
#pragma mark EditImageViewDelegate
//控制collectionView是否可以滑动
-(void)checkViewIsHidden:(EditImageView *)view{
    //隐藏
//    if(view.isHide == YES && view == self.currentView){
//        _collectionView.scrollEnabled = NO;
//    }else{
//        //没隐藏
//        _collectionView.scrollEnabled = YES;
//    }
}
//设置当前View
-(void)EditImageViewWithView:(EditImageView *)view{
//    _collectionView.scrollEnabled = NO;

    for (ZZTEditImageViewModel *model in self.editImageArray) {
        if(model.imageView == view){
            self.currentView = view;
            //当前View被点击的时候 CollectionView 不能被滑动
            self.collectionView.scrollEnabled = NO;
        }else{
            [model.imageView hideEditBtn];
        }
    }
}
//更新移动的位置
-(void)updateImageViewFrame:(EditImageView *)view{
//    _collectionView.scrollEnabled = YES;

    //获取改变后的位置
    CGRect startRact = [view convertRect:view.bounds toView:_midView];
    //更新位置
    for (ZZTEditImageViewModel *model in self.editImageArray) {
        if(model.imageView == view){
            model.imageViewFrame = startRact;
        }
    }
}

#pragma mark 请求素材库
-(void)loadMaterialData:(NSString *)fodderType modelType:(NSString *)modelType modelSubtype:(NSString *)modelSubtype{
    NSDictionary *parameter = @{
                                @"fodderType":fodderType,
                                @"modelType":modelType,
                                @"modelSubtype":modelSubtype
                                };
    [AFNHttpTool POST:@"http://192.168.0.142:8888/fodder/fodderList" parameters:parameter success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSMutableArray *array = [ZZTFodderListModel mj_objectArrayWithKeyValuesArray:dic];
        self.dataSource = array;
        self.materialLibraryView.dataSource = array;
    } failure:^(NSError *error) {
        
    }];
}

//移除对象
-(void)removeEdit:(NSNotification *)notify{
    ZZTEditImageViewModel *editImgView = notify.object;
    [_editImageArray removeObject:editImgView];
}

//隐藏所有Btn的状态
- (void)hideAllBtn{
    //当没有选中时 可以滑动
    self.collectionView.scrollEnabled = YES;
    for (ZZTEditImageViewModel *model in _editImageArray) {
        [model.imageView hideEditBtn];
    }
}

//截图，获取到image(保存)
- (UIImage *)imageThumb{
    [self hideAllBtn];
    CGPoint point = [[self.midView superview] convertPoint:self.midView.frame.origin toView:self.midView];
    CGRect rect = CGRectMake(point.x, point.y, self.midView.frame.size.width, self.midView.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    [self.midView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

//设置隐藏View
-(void)setupTapView{
    UIView *TapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.midView.width, self.midView.height)];
    TapView.backgroundColor = [UIColor clearColor];
    [self.midView addSubview:TapView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [TapView addGestureRecognizer:tap];
}

- (void)tapClick:(UITapGestureRecognizer *)tapGesture{
    [_materialLibraryView removeFromSuperview];
    [self hideAllBtn];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"remove" object:nil];
}

//关闭底部View
-(void)handleTapBehind:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded){
        CGPoint location = [sender locationInView:nil];
        if (![_materialLibraryView pointInside:[_materialLibraryView convertPoint:location fromView:_materialLibraryView.window] withEvent:nil]){
            [_materialLibraryView.window removeGestureRecognizer:sender];
            [_materialLibraryView removeFromSuperview];
            [self hideAllBtn];
        }
    }
}

#pragma mark 素材库
//布局
- (IBAction)Layout:(id)sender {
    [self setupMaterialLibraryView:@"布局"];
}

//场景
- (IBAction)scene:(id)sender {
    [self setupMaterialLibraryView:@"场景"];
}

//角色
- (IBAction)role:(id)sender {
    [self setupMaterialLibraryView:@"角色"];
}

//效果
- (IBAction)specialEffects:(id)sender {
    [self setupMaterialLibraryView:@"效果"];
}

//文字
- (IBAction)textView:(id)sender {
    [self setupMaterialLibraryView:@"文字"];
}

-(void)setupMaterialLibraryView:(NSString *)str{
    [_materialLibraryView removeFromSuperview];
    CGFloat viewHeight = (SCREEN_HEIGHT - 88)/3;
    CGFloat y = (SCREEN_HEIGHT - 44) - viewHeight;
    _materialLibraryView = [[ZZTMaterialLibraryView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, viewHeight)];
    _materialLibraryView.str = str;
    _materialLibraryView.delagate = self;
    _materialLibraryView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_materialLibraryView];
    
    //添加取消手势
    UITapGestureRecognizer *recognizerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)]; [recognizerTap setNumberOfTapsRequired:1]; recognizerTap.cancelsTouchesInView = NO; [[UIApplication sharedApplication].keyWindow addGestureRecognizer:recognizerTap];
}
@end
