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
#import "ZZTPaletteView.h"
#import "RectangleView.h"
#import "ZZTFangKuangModel.h"

#define MainOperationView self.currentCell.operationView
@interface ZZTCreatCartoonViewController ()<MaterialLibraryViewDelegate,EditImageViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,PaletteViewDelegate,RectangleViewDelegate,UIGestureRecognizerDelegate>
//舞台
@property (weak, nonatomic) IBOutlet UIView *midView;

@property (weak, nonatomic) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) ZZTMaterialLibraryView *materialLibraryView;

@property (nonatomic,strong) NSString *str;

@property (nonatomic,strong) NSMutableArray *editImageArray;

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,strong) UIView *currentView;

@property (nonatomic,strong) NSArray *array;

@property (nonatomic,strong) NSMutableArray *recoverArray;
//是否清空
@property (nonatomic,assign) BOOL isEmpty;

@property (nonatomic,strong) NSMutableArray *cartoonEditArray;
//当前被选中的行
@property (nonatomic,assign) NSInteger selectRow;
//恢复数据 只执行一次
@property (nonatomic,assign) BOOL isOnce;
//取色板所选取的颜色
@property (nonatomic,strong) UIColor *choiceColor;

@property (nonatomic,strong) ZZTPaletteView *paletteView;
//当前被选中的Cell
@property (nonatomic,weak) ZZTCartoonDrawView *currentCell;
//执行一次
@property (nonatomic,assign) BOOL operationOnce;
//全局tag值
@property (nonatomic,assign) NSInteger tagNum;

//框
@property (nonatomic,strong) UIView *mainView;
//是否被移动之后
@property (nonatomic,assign) BOOL isMoveAfter;
//是否能向方框添加素材
@property (nonatomic,assign) BOOL isAddM;

@property (nonatomic,assign) CGFloat proportion;

@property (nonatomic,strong) RectangleView *currentRectangleView;
@end

@implementation ZZTCreatCartoonViewController

//漫画页
-(NSMutableArray *)cartoonEditArray{
    if(!_cartoonEditArray){
        _cartoonEditArray = [NSMutableArray array];
    }
    return _cartoonEditArray;
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
    //初始化tag值
    [self setBOOL];
   
    //测试数据
    ZZTDIYCellModel *cell = [ZZTDIYCellModel initCellWith:600 isSelect:YES];
    [self.cartoonEditArray addObject:cell];
    
    //注册移除image的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeEdit:) name:@"remove" object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeRectangleView:) name:@"removeRectangleView" object:NULL];

    
    //UICollectionView
    [self setupCollectionView];
    
}
#pragma 定义初始变量
-(void)setBOOL{
    //恢复只执行一次
    self.isOnce = YES;
    self.operationOnce = YES;
    //默认当前行
    self.selectRow = 0;
    //初始化tag值
    self.tagNum = 0;
    //是否清空
    self.isEmpty = NO;
    //是否能向方框  添加素材
    self.isAddM = NO;
    //关闭滑动返回
    self.rr_backActionDisAble = YES;
    //隐藏nav
    self.rr_navHidden = YES;
    //方框是否移动之后
    self.isMoveAfter = NO;
    //交互开启
    self.view.userInteractionEnabled = YES;
    self.midView.userInteractionEnabled = YES;
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
    //不重用
    NSString *identifier=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"ZZTCartoonDrawView" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    //使cell 不重用
    ZZTCartoonDrawView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    //每个cell的数据
    ZZTDIYCellModel *model = self.cartoonEditArray[indexPath.row];
    
  
//    //恢复操作 并用 isOnce 控制
//    if(self.isOnce == YES){
//        for (int i = 0; i < model.imageArray.count; i++) {
//            //不能用View 存数据
//            ZZTEditImageViewModel *view = model.imageArray[i];
//            EditImageView *review = [[EditImageView alloc] initWithFrame:view.imageViewFrame];
//            view.imageView = review;
//            review.image = [UIImage imageNamed:view.imageUrl];
//            [cell.operationView addSubview:review];
//        }
//    }
    
    //恢复只执行一次（展示最后一个之后 结束遍历）
    if(indexPath.row == (self.cartoonEditArray.count - 1))
    {
        self.isOnce = NO;
    }
    
    if(self.operationOnce == YES){
        if (indexPath == [NSIndexPath indexPathForRow:0 inSection:0]) {
            self.mainView = cell.operationView;
        }
        self.currentCell = cell;
        self.operationOnce = NO;
    }
    //cell是否被选中
    cell.isSelect = model.isSelect;

    return cell;
}

#pragma mark 定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //动态定义cell的大小
    ZZTDIYCellModel *cell = self.cartoonEditArray[indexPath.row];
    return CGSizeMake(self.midView.bounds.size.width,cell.height);
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
#pragma mark 点击CollectionViewCell 触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //点击cell 空白处 隐藏图层编辑框
    [self hideAllBtn];
    //材料选择栏关闭
    [_materialLibraryView removeFromSuperview];
    //调色板关闭
    [_paletteView removeFromSuperview];
    //当有方框变大时
    if(self.isAddM == YES){
        //找到这个方框
        RectangleView *rectangleView = (RectangleView *)self.currentRectangleView;
        //缩小操作
        [rectangleView tapGestureTarget:nil];
    }
    //获取cell
    ZZTDIYCellModel *model = self.cartoonEditArray[indexPath.row];
    self.mainView = self.currentCell.operationView;
    self.currentView = MainOperationView;
    //当前行
    self.selectRow = indexPath.row;
    [self.collectionView layoutIfNeeded];
    //当前cell
    self.currentCell = (ZZTCartoonDrawView *)[self.collectionView cellForItemAtIndexPath:indexPath];
    //判断view 移动后会触发一次 那一次是不会响应这一条的
    if(self.isMoveAfter == NO){
        [self cannelFangKuangColor];
    }{
        self.isMoveAfter = NO;
    }

    //改变选中状态
    for (ZZTDIYCellModel *mod in self.cartoonEditArray) {
        if(mod == model){
            mod.isSelect = YES;
        }else{
            mod.isSelect = NO;
        }
    }
    [self.collectionView reloadData];
}
//将在cell上的方框颜色改变 (全部设置为不是主View）
-(void)cannelFangKuangColor{
    self.mainView = MainOperationView;
    for (int i = 0; i < MainOperationView.subviews.count; i++) {
        if([NSStringFromClass([MainOperationView.subviews[i] class]) isEqualToString:@"RectangleView"]){
            if (MainOperationView.subviews[i] != self.mainView) {
                RectangleView *rectangleView = MainOperationView.subviews[i];
                rectangleView.mainView.backgroundColor = [UIColor grayColor];
            }
        }
    }
    self.collectionView.scrollEnabled = YES;
}

#pragma mark 设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//足视图创建
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        //注册
        ZZTAddLengthFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView"forIndexPath:indexPath];
        //加长btn事件
        footerView.addLengthBtnClick = ^(UIButton *btn) {
            
        };
        //加页cell
        footerView.addCellBtnClick = ^(UIButton *btn) {
            //cell的属性
            ZZTDIYCellModel *cell = [ZZTDIYCellModel initCellWith:300 isSelect:NO];
            //更新cell的数据源
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

//保存（未解决）
- (IBAction)save:(UIBarButtonItem *)sender {
    [self imageThumb];
}

//上一页
- (IBAction)previousPage:(id)sender {
}

//下一页
- (IBAction)nextPage:(id)sender {
}

#pragma mark - 全部清空
- (IBAction)empty:(id)sender {
    //可以恢复
//    self.isEmpty = YES;

    //数据全部清除
    for(int i = 0;i < self.cartoonEditArray.count;i++){
        ZZTDIYCellModel *cellModel = self.cartoonEditArray[i];
        [cellModel.imageArray removeAllObjects];
        ZZTCartoonDrawView *currentCell = (ZZTCartoonDrawView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        for (UIView *view in currentCell.operationView.subviews) {
            view.hidden = YES;
        }
    }
    [self.collectionView reloadData];
}

//提交  未做
- (IBAction)commit:(id)sender {
}

//翻转  有bug
- (IBAction)spin:(id)sender {
    //是当前对象才能被翻转   如果是方框里面的要翻转 还不行
    if([NSStringFromClass([self.currentView class]) isEqualToString:@"EditImageView"]){
        EditImageView *currentView = (EditImageView *)self.currentView;
        if(currentView && currentView.isHide == NO){
            currentView.image = [currentView.image flipHorizontal];
        }
    }else{
        //如果是方框
        //如果实现这个 需要算法
    }
}

#pragma mark 改变图片上下级功能
#pragma 当前被选中的方框
-(RectangleView *)rectangleViewFromMainOperationView{
    
    RectangleView *rectangleView = [[RectangleView alloc] init];
    //在cell上获得这个方框  凡是有几种类型的 应该多加判断
    for (int i = 0; i < MainOperationView.subviews.count; i++) {
        //从cell中得到方框
        if([NSStringFromClass([MainOperationView.subviews[i] class])isEqualToString:@"RectangleView"]){
            rectangleView = MainOperationView.subviews[i];
            if(rectangleView.mainView.tag == self.mainView.tag){
                break;
            }
        }
    }
    return rectangleView;
}
#pragma 上一层
- (IBAction)upLevel:(id)sender {
    //如果选中的是方框
    if([NSStringFromClass([self.currentView class])isEqualToString:@"RectangleView"]){
        //获取方框的索引
        [self exchangeViewUpIndex:2];
    }else{
        EditImageView *imageView = (EditImageView *)self.currentView;
        //改素材在方框上面
        if ([imageView.superViewName isEqualToString:@"UIView"]) {
            [self exchangeFangKuangViewUpIndex];
        }else{
            [self exchangeViewUpIndex:1];
        }
    }
}

//方框之中的位置交换 上一层
-(void)exchangeFangKuangViewUpIndex{
    //获得正在编辑的View
    NSArray *array = self.mainView.subviews;
    //方框
    NSInteger index = [self getCurrentViewIndex:array];
    
    [self exchangeViewAtIndexInFangKuang:index exchangeIndex:(index + 1) limit:array.count-1];
}
//方框中的交换接口
-(void)exchangeViewAtIndexInFangKuang:(NSInteger)index exchangeIndex:(NSInteger)exchangeIndex limit:(NSInteger)limit{
    
    RectangleView *rectangleView = [self rectangleViewFromMainOperationView];
    
    ZZTFangKuangModel *model = [self rectangleModelFromView:rectangleView];
    
    if(index == limit){
        NSLog(@"不能交换");
    }else{
        [self.mainView exchangeSubviewAtIndex:index withSubviewAtIndex:exchangeIndex];
        
        [model.viewArray exchangeObjectAtIndex:index withObjectAtIndex:exchangeIndex];
    }
}
//在View之中上一层 view中 类型不同 需要判断
-(void)exchangeViewUpIndex:(NSInteger)integer{
    
    NSArray *array = MainOperationView.subviews;
    
    NSInteger index = [self viewIndexFromArray:array integer:integer];
    
    [self exchangeViewAtIndexInView:index exchangeIndex:index + 1 limit:array.count - 1];
}
//获取不同类型的索引
-(NSInteger)viewIndexFromArray:(NSArray *)array integer:(NSInteger)integer{
    NSInteger index = 0;
    if(integer == 1){
        index = [self getCurrentViewIndex:array];
        
    }else{
        index = [self getFangKuangViewIndex:array];
    }
    return index;
}
#pragma 下一层
- (IBAction)downLevel:(id)sender {
    //如果我当前选择的这个东西是一个方框
    if([NSStringFromClass([self.currentView class])isEqualToString:@"RectangleView"]){

        [self exchangeViewDownIndex:2];
    }else{
        EditImageView *imageView = (EditImageView *)self.currentView;
        //改素材在方框上面
        if ([imageView.superViewName isEqualToString:@"UIView"]) {
            [self exchangeFangKuangViewDownIndex];
        }else{
            [self exchangeViewDownIndex:1];
        }
    }
}
//方框中下一层
-(void)exchangeFangKuangViewDownIndex{
    NSArray *array = self.mainView.subviews;
    
    NSInteger index = [self getCurrentViewIndex:array];
    
    [self exchangeViewAtIndexInFangKuang:index exchangeIndex:(index - 1) limit:0];

}
//View中下一层   没有判断啊
-(void)exchangeViewDownIndex:(NSInteger)integer{
    NSArray *array = MainOperationView.subviews;
    
    //这里 判断是什么东西
    NSInteger index = [self viewIndexFromArray:array integer:integer];
    
    [self exchangeViewAtIndexInView:index exchangeIndex:index - 1 limit:0];
}
//在View之中的层级交换接口
-(void)exchangeViewAtIndexInView:(NSInteger)index exchangeIndex:(NSInteger)exchangeIndex limit:(NSInteger)limit{
    
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];
    
    if(index == limit){
        NSLog(@"已经到无法交换了");
    }else{
        //防止崩溃
        if(MainOperationView.subviews.count >= 2){
            //改变数据的位置
            [MainOperationView exchangeSubviewAtIndex:index withSubviewAtIndex:exchangeIndex];
            [cellModel.imageArray exchangeObjectAtIndex:index withObjectAtIndex:exchangeIndex];
            
            [self.collectionView reloadData];
        }
    }
}
//查看当前View的索引
-(NSInteger)getCurrentViewIndex:(NSArray *)array{
    //不仅要知道当前选中的index
    //还要知道前一个的索引
    NSInteger index = 0;
    for (int i = 0; i < array.count; i++) {
        if([NSStringFromClass([array[i] class]) isEqualToString:@"EditImageView"]){
            EditImageView *imageView = array[i];
            if(imageView.tag == self.currentView.tag){
                index = i;
                break;
            }
        }
    }
    return index;
}
//获取索引  有问题 这里是 查看方框的索引的
-(NSInteger)getFangKuangViewIndex:(NSArray *)array{
    NSInteger index = 0;
    RectangleView *currentView = (RectangleView *)self.currentView;
    //获取所在视图上的索引
    for (int i = 0; i < array.count; i++) {
        //写一个判断 如果不是方框的话 是没有这个属性的
        if([NSStringFromClass([array[i] class])isEqualToString:@"RectangleView"]){
            RectangleView *imageView = array[i];
            if(imageView.tagNum == currentView.tagNum){
                index = i;
                break;
            }
        }
    }
    return index;
}

#pragma 获取当前方框的模型
-(ZZTFangKuangModel *)rectangleModelFromView:(RectangleView *)rectangleView{
    //取到模型组  改变模型的数据
    ZZTFangKuangModel *model = [[ZZTFangKuangModel alloc] init];
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];
    for (int i = 0; i < cellModel.imageArray.count; i++) {
        if ([NSStringFromClass([cellModel.imageArray[i] class])isEqualToString:@"ZZTFangKuangModel"]) {
            model = cellModel.imageArray[i];
            if(model.tagNum == rectangleView.tag){
                break;
            }
        }
    }
    return model;
}
#pragma mark - 创建方框
- (IBAction)advance:(id)sender {
    //方框View
    RectangleView *rectangView = [[RectangleView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    //方框永远在cell之上
    rectangView.superView = MainOperationView;
    rectangView.delegate = self;
    rectangView.isClick = YES;
    rectangView.tagNum = self.tagNum;
    self.tagNum = self.tagNum + 1;
    //设置方框为当前View
    [self checkRectangleView:rectangView];
    
    [MainOperationView addSubview:rectangView];
    
    //cell
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];
    
    //位置数据
    CGRect startRect = [rectangView convertRect:rectangView.bounds toView:MainOperationView];
    //方框模型
    ZZTFangKuangModel *FKModel = [ZZTFangKuangModel initWithViewFrame:startRect tagNum:rectangView.tagNum];
    [cellModel.imageArray addObject:FKModel];
}

//设置方框为当前View
-(void)checkRectangleView:(RectangleView *)rectangleView{
    
    self.currentView = rectangleView;
    self.collectionView.scrollEnabled = NO;
    self.mainView = rectangleView.mainView;
    self.currentRectangleView = rectangleView;
    self.mainView.backgroundColor = [UIColor redColor];
    
    //遍历cell上的视图
    for (int i = 0; i < MainOperationView.subviews.count; i++) {
        //如果是cell上的方框
        if([NSStringFromClass([MainOperationView.subviews[i] class]) isEqualToString:@"RectangleView"]){
            //非选中方框
            if(MainOperationView.subviews[i] != rectangleView){
                RectangleView *view = MainOperationView.subviews[i];
                view.mainView.backgroundColor = [UIColor grayColor];
            }
        }else{
            //如果是素材
            EditImageView *imageView = MainOperationView.subviews[i];
            [imageView hideEditBtn];
        }
    }
}

//方框是否移动了
-(void)setupMainView:(RectangleView *)rectangleView{
    self.isMoveAfter = YES;
}

#pragma mark 获取cell之上的方框模型
-(ZZTFangKuangModel *)FangKuangModelFromCellModel{
    
    ZZTFangKuangModel *FKModel = [[ZZTFangKuangModel alloc] init];
    
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];

    for (int i = 0; i < cellModel.imageArray.count; i++) {
        if([NSStringFromClass([cellModel.imageArray[i] class]) isEqualToString:@"ZZTFangKuangModel"]){
            if([NSStringFromClass([self.currentRectangleView class])isEqualToString:@"RectangleView"]){
                RectangleView *rectangleView = (RectangleView *)self.currentRectangleView;
                ZZTFangKuangModel *model = cellModel.imageArray[i];
                if (model.tagNum == rectangleView.tagNum) {
                    FKModel = cellModel.imageArray[i];
                }
            }
        }
    }
    return FKModel;
}

//放大后编辑方框 bug
-(void)enlargedAfterEditView:(RectangleView *)rectangleView isBig:(BOOL)isBig proportion:(CGFloat)proportion{
    //记录放大缩小的状态
    self.isAddM = isBig;
    
    //这个计算是变大以后的
    if(isBig == YES){
        self.proportion = proportion;
    }
    //获取方框的模型
    ZZTFangKuangModel *FKModel = [self FangKuangModelFromCellModel];
    //如果已经放大
    if(self.isAddM == YES){
        
        for (int i = 0; i < FKModel.viewArray.count; i++) {
            ZZTEditImageViewModel *model = FKModel.viewArray[i];
            CGFloat x  = model.imageViewFrame.origin.x * self.proportion;
            CGFloat y  = model.imageViewFrame.origin.y * self.proportion;
            CGFloat w  = model.imageViewFrame.size.width * self.proportion;
            CGFloat h  = model.imageViewFrame.size.height * self.proportion;
            CGRect frame = CGRectMake(x, y, w, h);
            if (model.tagNum == self.mainView.subviews[i].tag) {
                EditImageView *image = self.mainView.subviews[i];
                image.frame = frame;
            }
            model.imageViewFrame = frame;
        }
    }else{
        for (int i = 0; i < FKModel.viewArray.count; i++) {
            ZZTEditImageViewModel *model = FKModel.viewArray[i];
            CGFloat x  = model.imageViewFrame.origin.x / self.proportion;
            CGFloat y  = model.imageViewFrame.origin.y / self.proportion;
            CGFloat w  = model.imageViewFrame.size.width / self.proportion;
            CGFloat h  = model.imageViewFrame.size.height / self.proportion;
            CGRect frame = CGRectMake(x, y, w, h);
            if (model.tagNum == self.mainView.subviews[i].tag) {
                EditImageView *image = self.mainView.subviews[i];
                image.frame = frame;
                [image hideEditBtn];
            }
            model.imageViewFrame = frame;
        }
    }
}
//更新方框的坐标
-(void)updateRectangleViewFrame:(RectangleView *)view{
    //获取对应行
    CGRect startRact = [view convertRect:view.bounds toView:MainOperationView];
    
    ZZTFangKuangModel *model = [self rectangleModelFromView:view];

    model.viewFrame = startRact;
}

- (IBAction)retreat:(id)sender {
    
}

#pragma mark 调色板
-(IBAction)colourModulation:(id)sender {
    ZZTPaletteView *paletteView = [[ZZTPaletteView alloc] initWithFrame:CGRectMake(0, 200, 150, 250)];
    paletteView.backgroundColor = [UIColor whiteColor];
    paletteView.delegate = self;

    self.paletteView = paletteView;
    [paletteView.btn addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.midView addSubview:paletteView];
}

//改变cell的颜色
-(void)changeColor{
    self.mainView.backgroundColor = self.choiceColor;
}

#pragma mark 取色板代理方法
-(void)patetteView:(ZZTPaletteView *)patetteView choiceColor:(UIColor *)color colorPoint:(CGPoint)colorPoint{
    self.choiceColor = color;
}

- (IBAction)collect:(id)sender {
}

//收藏夹
- (IBAction)favorite:(id)sender {
}

#pragma mark - 单页清空
- (IBAction)emptyView:(id)sender {
    //当前cell的数据
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    //清空cell中的数据
    [cellModel.imageArray removeAllObjects];
    
    ZZTCartoonDrawView *currentCell = (ZZTCartoonDrawView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:0]];
    for (UIView *view in currentCell.operationView.subviews) {
        view.hidden = YES;
    }
    
    [self.collectionView reloadData];
}

#pragma mark ZZTMaterialLibraryViewDelegate 按索引获取数据
-(void)sendRequestWithStr:(NSString *)fodderType modelType:(NSString *)modelType modelSubtype:(NSString *)modelSubtype
{
    [self loadMaterialData:fodderType modelType:modelType modelSubtype:modelSubtype];
}

#pragma mark 添加一个图层并备份
-(void)sendImageWithModel:(ZZTFodderListModel *)model{
    //获取当前行的数据
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];
    //新图层
    EditImageView *imageView = [self speedInitImageView:model.img];
    //设置tag值
    imageView.tag = self.tagNum;
    self.tagNum = self.tagNum + 1;
    imageView.superViewTag = self.mainView.tag;
    //记录位置
    CGRect startRect = [imageView convertRect:imageView.bounds toView:self.mainView];
    //素材Model
    ZZTEditImageViewModel *imageModel = [ZZTEditImageViewModel initImgaeViewModel:startRect imageUrl:model.img tagNum:imageView.tag superView:NSStringFromClass([self.mainView class]) superViewTag:self.mainView.tag];
    //如果是方框
    if ([NSStringFromClass([self.mainView class]) isEqualToString:@"UIView"]) {
        //如果可以加入素材 便加入图层
        if(self.isAddM == YES){
            [self.mainView addSubview:imageView];

            ZZTFangKuangModel *FKModel = [self rectangleModelFromView:(RectangleView *)self.mainView];

            [FKModel.viewArray addObject:imageModel];
            [self EditImageViewWithViewInRectangleView:imageView];

        }else{
            //否则失败
            NSLog(@"必须放大View以后才能添加素材");
        }
    }else{
        //不是方框可直接添加素材到cell之中
        [cellModel.imageArray addObject:imageModel];
        [self.mainView addSubview:imageView];
        [self EditImageViewWithViewIncell:imageView];
    }
}

//快速创建方法
-(EditImageView *)speedInitImageView:(NSString *)imgUrl{
    EditImageView *imageView = [[EditImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.delegate = self;
    
    //记录父类的名字
    imageView.superViewName = NSStringFromClass([self.mainView class]);
    [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];

    return imageView;
}
#pragma mark EditImageViewDelegate
//控制collectionView是否可以滑动
-(void)checkViewIsHidden:(EditImageView *)view{
    //btn没有隐藏
    if (view.isHide == NO) {
        //collectionView不能动
        self.collectionView.scrollEnabled = NO;
    }
    else{
        //collectionView能动
        self.collectionView.scrollEnabled = YES;
    }
}

//将素材加入到cell之中
-(void)EditImageViewWithViewIncell:(EditImageView *)view{
   
    self.currentView = view;
    self.collectionView.scrollEnabled = NO;
    
    for(int i = 0;i < MainOperationView.subviews.count;i++){
        //如果素材
        if([NSStringFromClass([MainOperationView.subviews[i] class]) isEqualToString:@"EditImageView"]){
            //如果素材在cell上
            if(MainOperationView.subviews[i] != view){
                EditImageView *imageView = self.currentCell.operationView.subviews[i];
                [imageView hideEditBtn];
            }
        }else{
            //如果是方框
            RectangleView *rectangleView = self.currentCell.operationView.subviews[i];
            if(rectangleView.mainView == self.mainView){
                rectangleView.mainView.backgroundColor = [UIColor redColor];
            }else{
                rectangleView.mainView.backgroundColor = [UIColor grayColor];
            }
        }
    }
}
//素材放在方框之中
-(void)EditImageViewWithViewInRectangleView:(EditImageView *)view{
    self.currentView = view;
    self.collectionView.scrollEnabled = NO;
    
    RectangleView *rectangleView = [self rectangleViewFromMainOperationView];
    //遍历方框
    for (int i = 0; i < rectangleView.mainView.subviews.count; i++) {
        //如果不是当前素材 便隐藏内容
        if(rectangleView.mainView.subviews[i] != view){
            EditImageView *imageView = rectangleView.mainView.subviews[i];
            [imageView hideEditBtn];
        }
    }
}

//更新素材的位置
-(void)updateImageViewFrame:(EditImageView *)view{
    //更新的位置
    CGRect startRact = [view convertRect:view.bounds toView:self.mainView];
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    
//    //如果是方框
    if([NSStringFromClass([self.mainView class]) isEqualToString:@"UIView"]){
        ZZTFangKuangModel *FKModel = [self rectangleModelFromView:(RectangleView *)self.mainView];

        //更新model中的数据
        for (int i = 0; i < FKModel.viewArray.count; i++) {
            ZZTEditImageViewModel *model = FKModel.viewArray[i];
            if(model.tagNum == view.tag){
                model.imageViewFrame = startRact;
                NSLog(@"model.imageViewFrame:%@",NSStringFromCGRect(model.imageViewFrame));
            }
        }
    }else{
        //更新位置
        for (ZZTEditImageViewModel *model in cellModel.imageArray) {
            if(model.tagNum == view.tag){
                model.imageViewFrame = startRact;
            }
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
    //传过来的是一个view
    EditImageView *editImgView = notify.object;
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    
    for (int i = 0; i < cellModel.imageArray.count; i++) {
        ZZTEditImageViewModel *model = cellModel.imageArray[i];
        if(model.tagNum == editImgView.tag)
        {
            [cellModel.imageArray removeObject:model];
            [editImgView removeFromSuperview];
        }
    }
    
    [self.collectionView reloadData];
}

//移除方框
-(void)removeRectangleView:(NSNotification *)notify{
    RectangleView *rectangleView = notify.object;
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];

    for (int i = 0; i < cellModel.imageArray.count; i++) {
        ZZTFangKuangModel *model = cellModel.imageArray[i];
        if(model.tagNum == rectangleView.tagNum){
            [cellModel.imageArray removeObject:model];
            [rectangleView removeFromSuperview];
        }
    }
}

//隐藏所有Btn的状态
- (void)hideAllBtn{
    //获取当前行的数据
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    //当没有选中时 可以滑动
    self.collectionView.scrollEnabled = YES;
    //隐藏cell上素材的框 框的状态如何变化 还没写
    for (int i = 0; i < cellModel.imageArray.count; i++) {
        //如果是素材 隐藏框
        if(![NSStringFromClass([MainOperationView.subviews[i] class]) isEqualToString:@"RectangleView"]){
            EditImageView *imageView = MainOperationView.subviews[i];
            [imageView hideEditBtn];
        }
    }
    [self.collectionView reloadData];
}

//截图，获取到image(保存) 未解决
- (void)imageThumb{
    [self hideAllBtn];
    NSMutableArray *imageArray = [NSMutableArray array];
   
    //循环截图
    //多少个cell 截图多少次
    for(int i = 0;i < self.cartoonEditArray.count;i++){
        
        ZZTCartoonDrawView *cell = (ZZTCartoonDrawView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.alpha = 1;
        
        CGPoint point = [[cell superview] convertPoint:cell.frame.origin toView:cell];
        CGRect rect = CGRectMake(point.x, point.y, cell.frame.size.width, cell.frame.size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [imageArray addObject:viewImage];
        //保存本地
        UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
        
        cell.alpha = 0.6;
    }
    //恢复当前cell的透明度
    ZZTCartoonDrawView *cell = (ZZTCartoonDrawView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:0]];
    cell.alpha = 1;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"remove" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"removeRectangleView" object:nil];
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

}
@end
