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

@property (nonatomic,assign) NSInteger tagID;

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
    //恢复只执行一次
    self.isOnce = YES;
    self.operationOnce = YES;
    //默认当前行
    self.selectRow = 0;
    self.tagNum = 0;
   //测试数据
    ZZTDIYCellModel *cell = [ZZTDIYCellModel initCellWith:600 isSelect:YES];
//    EditImageView *imageView1 = [self speedInitImageView:@"peien"];
//    ZZTEditImageViewModel *imageModel1 = [ZZTEditImageViewModel initImgaeViewModel:CGRectMake(100, 100, 100, 100) imageUrl:@"peien" imageView:imageView1];
//    NSMutableArray *arrt = [NSMutableArray array];
//    [arrt addObject:imageModel1];
//    cell.imageArray = arrt;
    [self.cartoonEditArray addObject:cell];
    
    //是否清空
    self.isEmpty = NO;
    //是否能向方框  添加素材
    self.isAddM = NO;
    //关闭滑动返回
    self.rr_backActionDisAble = YES;
    //隐藏nav
    self.rr_navHidden = YES;
    
    //当前cell之中是否有方框
    //方框是否移动之后
    self.isMoveAfter = NO;
    
    //注册移除image的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeEdit:) name:@"remove" object:NULL];
    
    self.view.userInteractionEnabled = YES;
    self.midView.userInteractionEnabled = YES;
    
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
    //点击cell 空白处 隐藏图层编辑框
    [self hideAllBtn];
    //材料选择栏关闭
    [_materialLibraryView removeFromSuperview];
    //调色板关闭
    [_paletteView removeFromSuperview];
    
    //获取cell
    ZZTDIYCellModel *model = self.cartoonEditArray[indexPath.row];
    
    //记录当前行号 和 内容
    self.selectRow = indexPath.row;
        [self.collectionView layoutIfNeeded];
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
//点击cell 切换mainView
-(void)cannelFangKuangColor{
    self.mainView = self.currentCell.operationView;
    for (int i = 0; i < self.currentCell.operationView.subviews.count; i++) {
        if([NSStringFromClass([self.currentCell.operationView.subviews[i] class]) isEqualToString:@"RectangleView"]){
            if (self.currentCell.operationView.subviews[i] != self.mainView) {
                RectangleView *rectangleView = self.currentCell.operationView.subviews[i];
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

//清空(cell)
- (IBAction)empty:(id)sender {
    //可以恢复
    self.isEmpty = YES;
    
    //复制数据
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    self.recoverArray = cellModel.imageArray;

    //清空所有图层
    for (int i = 0; i < cellModel.imageArray.count; i++) {
        EditImageView *imageView = self.currentCell.operationView.subviews[i];
        imageView.hidden = YES;
    }
    
    for (UIView *view in self.currentCell.operationView.subviews) {
        view.hidden = YES;
    }
    
    [cellModel.imageArray removeAllObjects];
}

//提交
- (IBAction)commit:(id)sender {
}

//翻转
- (IBAction)spin:(id)sender {
    //是当前对象才能被翻转
    EditImageView *currentView = (EditImageView *)self.currentView;
    if(currentView && currentView.isHide == NO){
        currentView.image = [currentView.image flipHorizontal];
    }
}

#pragma mark 改变图片上下级功能
//上一层
- (IBAction)upLevel:(id)sender {
    //影响点  index 前面为空
    //图层的index
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];
    //得到当前选择View在数据中的索引
    NSInteger index = [self getCurrentViewIndex:cellModel];
    //如果是最后一个对象的话 会是count-1
    if(index == (self.currentCell.operationView.subviews.count - 1)){
        NSLog(@"已经到最上方了");
    }else{
        //改变数据的位置
        [self exchangeViewIndex:index exchangeIndex:(index + 1)];
        
        [self.collectionView reloadData];
    }
}

//下一层
- (IBAction)downLevel:(id)sender {
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];
    //得到当前选择View在数据中的索引
    NSInteger index = [self getCurrentViewIndex:cellModel];
    if(index == 0){
        NSLog(@"已经到最下方了");
    }else{
        //改变数据的位置
        [self exchangeViewIndex:index exchangeIndex:(index - 1)];
    }
}
//查看当前View的索引
-(NSInteger)getCurrentViewIndex:(ZZTDIYCellModel *)cellModel{
    //不仅要知道当前选中的index
    //还要知道前一个的索引
    NSInteger index = 0;
    for (int i = 0; i < self.currentCell.operationView.subviews.count; i++) {
        EditImageView *imageView = self.currentCell.operationView.subviews[i];
        if(imageView.tag == self.currentView.tag){
            index = i;
            break;
        }
    }
    return index;
}

//交换2个视图的层级位置 和 数据所在的位置
-(void)exchangeViewIndex:(NSInteger )index exchangeIndex:(NSInteger )exchangeIndex{
    //得到当前行
    //为什么没创建
    ZZTCartoonDrawView *cell = (ZZTCartoonDrawView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:0]];
    
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];

    if(cellModel.imageArray.count > 0){
        [cell.operationView exchangeSubviewAtIndex:index withSubviewAtIndex:exchangeIndex];
        //交换两个视图的位置
        [cellModel.imageArray exchangeObjectAtIndex:index withObjectAtIndex:exchangeIndex];
    }
}

#pragma mark - 创建方框
- (IBAction)advance:(id)sender {
    //方框对象
    RectangleView *rectangView = [[RectangleView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    //获取tableView 当前View
    rectangView.superView = self.currentCell.operationView;
    rectangView.delegate = self;
    rectangView.isClick = YES;
    rectangView.tagNum = self.tagNum;
    self.tagNum = self.tagNum + 1;
//    self.mainView = rectangView.mainView;
    [self checkRectangleView:rectangView];
    [self.currentCell.operationView addSubview:rectangView];
    
    //cell
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];
    
    //位置数据
    CGRect startRect = [rectangView convertRect:rectangView.bounds toView:self.currentCell.operationView];
    //方框模型 此方框的数据  方便寻找 恢复
    ZZTFangKuangModel *FKModel = [ZZTFangKuangModel initWithViewFrame:startRect tagNum:rectangView.tagNum];
    [cellModel.imageArray addObject:FKModel];
}
#warning wwwwwwwww
//设置方框为当前View
-(void)checkRectangleView:(RectangleView *)rectangleView{
    
    self.currentView = rectangleView;
//    rectangleView.mainView.backgroundColor = [UIColor redColor];
    self.collectionView.scrollEnabled = NO;
    self.mainView = rectangleView.mainView;
    self.mainView.backgroundColor = [UIColor redColor];
    
    
    //除了此view 所有view隐藏
    for (int i = 0; i < self.currentCell.operationView.subviews.count; i++) {
        //做个判断
        //如果是方框 改变方框的颜色
        //如果是e 隐藏
        //如果是方框
        if([NSStringFromClass([self.currentCell.operationView.subviews[i] class]) isEqualToString:@"RectangleView"]){
            //每个都遍历一下 与方框不相同的
            if(self.currentCell.operationView.subviews[i] != rectangleView){
                RectangleView *view = self.currentCell.operationView.subviews[i];
                view.mainView.backgroundColor = [UIColor grayColor];
            }
        }else{
            EditImageView *imageView = self.currentCell.operationView.subviews[i];
            [imageView hideEditBtn];
        }
    }
}

//方框是否移动了
-(void)setupMainView:(RectangleView *)rectangleView{
    self.isMoveAfter = YES;
}
//双击编辑前双击编辑后 要把方框也传过来才行 不然不知道是那一个
-(void)enlargedAfterEditView:(RectangleView *)rectangleView isBig:(BOOL)isBig{
    self.isAddM = isBig;
    ZZTFangKuangModel *FKModel = [[ZZTFangKuangModel alloc] init];
    CGFloat pW = self.currentCell.operationView.width / rectangleView.width;
    CGFloat pH = self.currentCell.operationView.height / rectangleView.height;
    CGFloat proportion = 0;
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];
    for (int i = 0; i < cellModel.imageArray.count; i++) {
        if([NSStringFromClass([cellModel.imageArray[i] class]) isEqualToString:@"ZZTFangKuangModel"]){
            FKModel = cellModel.imageArray[i];
            //得到这个方框
            //也得到了这个方框里面的内容
        }
    }
    
    
    /*
     1.放大之后
     2.存储的数组 发生了改变
     3.记录所在方框位置的 并放入数组
     3.缩小之后 按比例重新计算
     4.计算出素材的大小
     5.计算出素材的坐标
     */
    //放大了应该怎么做
    if(self.isAddM == YES){
        for (UIView *view in self.mainView.subviews) {
            [view removeFromSuperview];
        }
        
        if (pW < pH) {
            proportion = pW;
        }else{
            proportion = pH;
        }
        
        for (int i = 0; i < FKModel.viewArray.count; i++) {
            ZZTEditImageViewModel *model = FKModel.viewArray[i];
            NSLog(@"frame:%@",NSStringFromCGRect(model.imageViewFrame));
            CGFloat x  = model.imageViewFrame.origin.x * proportion;
            CGFloat y  = model.imageViewFrame.origin.y * proportion;
            CGFloat w  = model.imageViewFrame.size.width * proportion;
            CGFloat h  = model.imageViewFrame.size.height * proportion;
            CGRect frame = CGRectMake(x, y, w, h);
            NSLog(@"frame:%@",NSStringFromCGRect(frame));
            EditImageView *imageView = [[EditImageView alloc] initWithFrame:frame];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
            [self.mainView addSubview:imageView];
            model.imageViewFrame = frame;
        }
    }else{
        //缩小应该怎么做？？
        //得到放大之后的长宽 与 缩小后的长宽 比例是多少
        //一般放大的长宽为长和高   我只需要知道
        //获取这个方框的数组
        //将数组中的素材数据取出 通过计算重新添加  更新数据
        for (UIView *view in self.mainView.subviews) {
            [view removeFromSuperview];
        }
        
        if (pW < pH) {
            proportion = pW;
        }else{
            proportion = pH;
        }
        
        for (int i = 0; i < FKModel.viewArray.count; i++) {
            ZZTEditImageViewModel *model = FKModel.viewArray[i];
            NSLog(@"frame:%@",NSStringFromCGRect(model.imageViewFrame));
            CGFloat x  = model.imageViewFrame.origin.x / proportion;
            CGFloat y  = model.imageViewFrame.origin.y / proportion;
            CGFloat w  = model.imageViewFrame.size.width / proportion;
            CGFloat h  = model.imageViewFrame.size.height / proportion;
            CGRect frame = CGRectMake(x, y, w, h);
            NSLog(@"frame:%@",NSStringFromCGRect(frame));
            EditImageView *imageView = [[EditImageView alloc] initWithFrame:frame];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
            [self.mainView addSubview:imageView];
            model.imageViewFrame = frame;
        }
    }
}
-(void)updateRectangleViewFrame:(RectangleView *)view{
//    //获取对应行
//    CGRect startRact = [view convertRect:view.bounds toView:self.currentCell.operationView];
//
//    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
//    ZZTFangKuangModel *FKModel = [[ZZTFangKuangModel alloc] init];
//    for (int i = 0; i < cellModel.imageArray.count; i++) {
//        if([NSStringFromClass([cellModel.imageArray[i] class]) isEqualToString:@"ZZTFangKuangModel"] && FKModel.tagNum == self.mainView.tag){
//            FKModel = cellModel.imageArray[i];
//        }
//    }
//    //model
//    for (int i = 0; i < FKModel.viewArray.count; i++) {
//        ZZTFangKuangModel *model = FKModel.viewArray[i];
//        if(model.tagNum == view.tag){
//            model.viewFrame = startRact;
//            NSLog(@"updataFrame:%@",NSStringFromCGRect(startRact));
//        }
//    }
    
}
//后退 清空恢复
- (IBAction)retreat:(id)sender {
    if (_isEmpty == YES) {
        self.editImageArray = self.recoverArray;
        for (int i = 0; i < self.editImageArray.count; i++) {
            //不能用View 存数据
            ZZTEditImageViewModel *view = self.editImageArray[i];
            EditImageView *review = [[EditImageView alloc] initWithFrame:view.imageViewFrame];
            view.tagNum = review.tag;
            [review sd_setImageWithURL:[NSURL URLWithString:view.imageUrl]];
            [self.midView addSubview:review];
        }
        _isEmpty = NO;
    }
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
    self.currentCell.operationView.backgroundColor = self.choiceColor;
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
    //获取当前行的数据
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];
    //新图层
    EditImageView *imageView = [self speedInitImageView:model.img];
    imageView.tag = self.tagNum;
    self.tagNum = self.tagNum + 1;
    //记录位置
    CGRect startRect = [imageView convertRect:imageView.bounds toView:self.mainView];
    ZZTEditImageViewModel *imageModel = [ZZTEditImageViewModel initImgaeViewModel:startRect imageUrl:model.img tagNum:imageView.tag];
    NSLog(@"startRect:%@",NSStringFromCGRect(startRect));
    //这里改一下
    /*
        判断mainView是什么东西
        从而将素材加入到不同的数组
     
     */
    //如果是方框
    if ([NSStringFromClass([self.mainView class]) isEqualToString:@"UIView"]) {
        if(self.isAddM == YES){
            [self.mainView addSubview:imageView];
            //添加到数组
            //获取方框的模型
            for (int i = 0; i < cellModel.imageArray.count; i++) {
                if([NSStringFromClass([cellModel.imageArray[i] class]) isEqualToString:@"ZZTFangKuangModel"]){
                    ZZTFangKuangModel *FKModel = cellModel.imageArray[i];
                    //取出来方框
                    //对这个方框模型上加入视图
                    if(FKModel.tagNum == self.mainView.tag){
                        [FKModel.viewArray addObject:imageModel];
                    }
                }
            }
        }else{
            NSLog(@"必须放大View以后才能添加素材");
        }
    }else{
        //不是方框可直接添加素材
        //素材模型
        //这里能加 没问题
        [cellModel.imageArray addObject:imageModel];
        [self.mainView addSubview:imageView];
    }
    //将新创建的view设置为当前View
    [self EditImageViewWithView:imageView];
    self.tagID++;

}

//快速创建方法
-(EditImageView *)speedInitImageView:(NSString *)imgUrl{
    EditImageView *imageView = [[EditImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.delegate = self;
    
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

#warning 正在施工。。。
//设置当前View
-(void)EditImageViewWithView:(EditImageView *)view{
    /*
        1.取出来的 不一定是一个类型
        2.判断取出来的是什么model类
        3.如果是E就照写
        4.如果是R就 空着
     
        但是会获取方框上的素材
        判断 点击的是方框上的  还是cell上的
        可以对mainView进行判断
     
        设置当前view
     
        如果是cell上的
     
     
        如果是方框上的
     
     */
    /*
        获取当前行
        扫描此行的所有空间
        找到当前点击的空间的数据
        设置当前view
        关闭cv滑动
        除这个view以外的view 隐藏
     */
    //如果是素材  选中 隐藏 ok
    self.currentView = view;
    self.collectionView.scrollEnabled = NO;
    
    //因为现在有方框了 所以要改变一下
    for(int i = 0;i < self.currentCell.operationView.subviews.count;i++){
        if([NSStringFromClass([self.currentCell.operationView.subviews[i] class]) isEqualToString:@"EditImageView"]){
            if(self.currentCell.operationView.subviews[i] != view){
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


//更新移动的位置 没有将入方框的 移动任务
-(void)updateImageViewFrame:(EditImageView *)view{
    //更新的位置
    CGRect startRact = [view convertRect:view.bounds toView:self.mainView];
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    ZZTFangKuangModel *FKModel = [[ZZTFangKuangModel alloc] init];
    
    //如果是方框
    if([NSStringFromClass([self.mainView class]) isEqualToString:@"UIView"]){
        for (int i = 0; i < cellModel.imageArray.count; i++) {
            if([NSStringFromClass([cellModel.imageArray[i] class]) isEqualToString:@"ZZTFangKuangModel"] && FKModel.tagNum == self.mainView.tag){
                FKModel = cellModel.imageArray[i];
            }
        }
        //model
        for (int i = 0; i < FKModel.viewArray.count; i++) {
            ZZTEditImageViewModel *model = FKModel.viewArray[i];
            if(model.tagNum == view.tag){
                model.imageViewFrame = startRact;
                NSLog(@"updataFrame:%@",NSStringFromCGRect(startRact));
            }
        }
    }else{
        //更新位置
        for (ZZTEditImageViewModel *model in cellModel.imageArray) {
            if(model.tagNum == view.tag){
                model.imageViewFrame = startRact;
                NSLog(@"updataFrame:%@",NSStringFromCGRect(startRact));
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

//隐藏所有Btn的状态
- (void)hideAllBtn{
    
//    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
//
//    //当没有选中时 可以滑动
//    self.collectionView.scrollEnabled = YES;
//    //判断如果是框 应该怎么搞？？
//    for (int i = 0; i < cellModel.imageArray.count; i++) {
//        //这个数组之中 有的不只是一个类型的元素
//        /*
//            取出这一个元素   判断对象类名
//            如果是这个  应该怎么样 如果是这个 应该怎么样
//         */
//        if([NSStringFromClass([self.mainView.subviews[i] class]) isEqualToString:@"EditImageView"]){
//                EditImageView *imageView = self.currentCell.operationView.subviews[i];
//            [imageView hideEditBtn];
//        }else{
//
//        }
//    }
//
//    [self.collectionView reloadData];
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
    UITapGestureRecognizer *recognizerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
    [recognizerTap setNumberOfTapsRequired:1];
    recognizerTap.cancelsTouchesInView = NO;
    [self.midView addGestureRecognizer:recognizerTap];
}
@end
