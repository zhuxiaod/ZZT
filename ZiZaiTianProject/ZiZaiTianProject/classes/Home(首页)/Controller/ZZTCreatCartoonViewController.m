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
#import "ZZTBubbleImageView.h"
#import "ZZTChapterlistModel.h"
#import "ColorInButton.h"
#import "ToolBtn.h"
#import "ZZTRemindView.h"

#define MainOperationView self.currentCell.operationView

@interface ZZTCreatCartoonViewController ()<MaterialLibraryViewDelegate,EditImageViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,PaletteViewDelegate,RectangleViewDelegate,UIGestureRecognizerDelegate,ZZTBubbleImageViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//工具栏
@property (weak, nonatomic) IBOutlet ToolBtn *upBtn;
@property (weak, nonatomic) IBOutlet ToolBtn *downBtn;
@property (weak, nonatomic) IBOutlet ToolBtn *coloringBtn;
@property (weak, nonatomic) IBOutlet ToolBtn *paletteBtn;
@property (weak, nonatomic) IBOutlet ToolBtn *collectBtn;
@property (weak, nonatomic) IBOutlet ToolBtn *meBtn;
@property (weak, nonatomic) IBOutlet ToolBtn *deletBtn;
@property (weak, nonatomic) IBOutlet ToolBtn *emptyBtn;
@property (weak, nonatomic) IBOutlet ToolBtn *previewBtn;
@property (weak, nonatomic) IBOutlet ToolBtn *flipBtn;
@property (weak, nonatomic) IBOutlet ToolBtn *uploadBtn;

//舞台
@property (weak, nonatomic) IBOutlet UIView *midView;

@property (weak, nonatomic) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) ZZTMaterialLibraryView *materialLibraryView;

@property (nonatomic,strong) NSString *str;

@property (nonatomic,strong) NSMutableArray *editImageArray;

@property (weak, nonatomic) IBOutlet UIView *topView;

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
//图片地址数组
@property (nonatomic,strong) NSMutableArray *imageUrlArr;

@property (nonatomic,strong) NSArray *bottomArray;

//一章的卡通内容
@property (strong,nonatomic) NSMutableArray *cartoonArray;
//记录现在正在那一页面
@property (assign,nonatomic) NSInteger currentIndex;
//下一页索引为0是允许执行
@property (nonatomic,assign) BOOL isNext;

@property (weak, nonatomic) IBOutlet ColorInButton *coloInBtn;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIButton *cannelBtn;

@property (nonatomic,strong) UIImagePickerController *picker;

@property (nonatomic,strong) ZZTBubbleImageView *bubbleImageView;

@property (nonatomic,assign) CGFloat colorH;

@property (nonatomic,assign) CGFloat colorS;

@property (nonatomic,strong) UIView *topBtnView;

@property (nonatomic,strong) UIButton *closeBtn;
//当前类型
@property (nonatomic,strong) NSString *curType;
@property (weak, nonatomic) IBOutlet UIButton *buJuBtn;
@property (weak, nonatomic) IBOutlet UIButton *changJingBtn;
@property (weak, nonatomic) IBOutlet UIButton *jueSeBtn;
@property (weak, nonatomic) IBOutlet UIButton *xiaoGuoBtn;
@property (weak, nonatomic) IBOutlet UIButton *wenZiBtn;
@property (nonatomic,strong) ZZTRemindView *remindView;

@end

@implementation ZZTCreatCartoonViewController
//一章的卡通内容
-(NSMutableArray *)cartoonArray{
    if (!_cartoonArray) {
        _cartoonArray = [NSMutableArray array];
    }
    return _cartoonArray;
}

//图片地址数组
-(NSMutableArray *)imageUrlArr{
    if(!_imageUrlArr){
        _imageUrlArr = [NSMutableArray array];
    }
    return _imageUrlArr;
}

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
    
    self.rr_navHidden = YES;
    
    //设置工具栏样式
    [self setupToolBtnStyle];
 
    //初始化tag值
    [self setBOOL];

    //测试数据
    ZZTDIYCellModel *cell = [ZZTDIYCellModel initCellWith:SCREEN_HEIGHT - 100 isSelect:YES];
    [self.cartoonEditArray addObject:cell];

//    注册移除image的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeEdit:) name:@"remove" object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeRectangleView:) name:@"removeRectangleView" object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeBubbleView:) name:@"removeBubbleView" object:NULL];


    //UICollectionView
    [self setupCollectionView];

    //方框初始化
//    [self setupRectangleView];
//    ColorInButton *btn = [ColorInButton ColorInButtonView];
//    btn.viewColor = [UIColor yellowColor];
//    self.coloInBtn = btn;
}

-(void)setupRectangleView{
    
//    ZZTFangKuangModel *mode1 = [ZZTFangKuangModel initWithViewFrame:CGRectMake(5, 265, 200, _midView.height - 270) tagNum:self.tagNum];
//    RectangleView *rectangView1 = [self createFuangKuangViewWithModel:mode1];
//    [self addFangKuangModelWithView:rectangView1];
//
//    ZZTFangKuangModel *mode2 = [ZZTFangKuangModel initWithViewFrame:CGRectMake(150, 80, _midView.width - 155, _midView.height - 270) tagNum:self.tagNum];
//    RectangleView *rectangView2 = [self createFuangKuangViewWithModel:mode2];
//    [self addFangKuangModelWithView:rectangView2];
//
//    ZZTFangKuangModel *mode3 = [ZZTFangKuangModel initWithViewFrame:CGRectMake(5, 5, 200, 200) tagNum:self.tagNum];
//    RectangleView *rectangView3 = [self createFuangKuangViewWithModel:mode3];
//    [self addFangKuangModelWithView:rectangView3];

}

#pragma mark 设置工具栏按钮样式
-(void)setupToolBtnStyle{
    [self.upBtn setImage:[UIImage imageNamed:@"编辑器图标-上移一层"] forState:UIControlStateNormal];
    [self.upBtn setTitle:@"往上" forState:UIControlStateNormal];
    
    [self.downBtn setImage:[UIImage imageNamed:@"编辑器图标-下移一层"] forState:UIControlStateNormal];
    [self.downBtn setTitle:@"往下" forState:UIControlStateNormal];
    
    [self.coloringBtn setImage:[UIImage imageNamed:@"WechatIMG293"] forState:UIControlStateNormal];
    self.coloringBtn.imageView.backgroundColor = [UIColor whiteColor];
    [self.coloringBtn setTitle:@"填色" forState:UIControlStateNormal];
    
    [self.paletteBtn setImage:[UIImage imageNamed:@"编辑器图标-调色"] forState:UIControlStateNormal];
    [self.paletteBtn setTitle:@"调色" forState:UIControlStateNormal];
    
    [self.collectBtn setImage:[UIImage imageNamed:@"编辑器图标-收藏"] forState:UIControlStateNormal];
    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    
    [self.meBtn setImage:[UIImage imageNamed:@"编辑器图标-我的素材"] forState:UIControlStateNormal];
    [self.meBtn setTitle:@"我的" forState:UIControlStateNormal];
    
    [self.deletBtn setImage:[UIImage imageNamed:@"编辑器图标-删除"] forState:UIControlStateNormal];
    [self.deletBtn setTitle:@"删除" forState:UIControlStateNormal];
    
    [self.emptyBtn setImage:[UIImage imageNamed:@"编辑器图标-清空"] forState:UIControlStateNormal];
    [self.emptyBtn setTitle:@"清空" forState:UIControlStateNormal];
    
    [self.previewBtn setImage:[UIImage imageNamed:@"编辑器图标-预览"] forState:UIControlStateNormal];
    [self.previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    
    [self.flipBtn setImage:[UIImage imageNamed:@"WechatIMG294"] forState:UIControlStateNormal];
    [self.flipBtn setTitle:@"翻转" forState:UIControlStateNormal];
    
    [self.uploadBtn setImage:[UIImage imageNamed:@"WechatIMG320"] forState:UIControlStateNormal];
    [self.uploadBtn setTitle:@"本地" forState:UIControlStateNormal];
    
    NSArray *array = [NSArray arrayWithObjects:self.buJuBtn,self.changJingBtn,self.jueSeBtn,self.xiaoGuoBtn,self.wenZiBtn,nil];
    _bottomArray = array;
    
    [self setBottomBtn:self.buJuBtn];
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
    //编辑器制作页初始化为0
    _currentIndex = 0;
    _isNext = YES;
}

#pragma mark 设置CollectionView
-(void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //足的长
    flowLayout.footerReferenceSize =CGSizeMake(SCREEN_WIDTH, 40);
    [self.view layoutIfNeeded];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH - 40, SCREEN_HEIGHT - 80) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor  grayColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    _collectionView = collectionView;
    [collectionView registerNib:[UINib nibWithNibName:@"ZZTAddLengthFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    collectionView.scrollEnabled = NO;
    [self.midView addSubview:collectionView];
}

#pragma mark - collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cartoonEditArray.count;//1
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //不重用
    NSString *identifier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"ZZTCartoonDrawView" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    //使cell 不重用
    ZZTCartoonDrawView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    //每个cell的数据
    ZZTDIYCellModel *model = self.cartoonEditArray[indexPath.row];
    
    if(self.operationOnce == YES){
        if (indexPath == [NSIndexPath indexPathForRow:0 inSection:0]) {
            self.mainView = cell.operationView;
        }
        self.currentCell = cell;
        self.operationOnce = NO;
        [self setupRectangleView];
    }
    //cell是否被选中
    cell.isSelect = model.isSelect;

    return cell;
}

#pragma mark 定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //动态定义cell的大小
    return CGSizeMake(SCREEN_WIDTH - 40,SCREEN_HEIGHT - 80);
}

#pragma mark 漫画信息
-(void)setModel:(ZZTCreationEntranceModel *)model{
    _model = model;
    NSLog(@"%@",model);
}

//数据要用model来装才行
#pragma mark 点击CollectionViewCell 触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //获取cell
    ZZTDIYCellModel *model = self.cartoonEditArray[indexPath.row];
    self.mainView = MainOperationView;
    self.currentView = MainOperationView;
    //当前行
    self.selectRow = indexPath.row;
    [self.collectionView layoutIfNeeded];
    //当前cell
    self.currentCell = (ZZTCartoonDrawView *)[self.collectionView cellForItemAtIndexPath:indexPath];
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
        [rectangleView tapGestureTarget];
        
    }
    
    //判断view 移动后会触发一次 那一次是不会响应这一条的
    if(self.isMoveAfter == NO){
    }{
        self.isMoveAfter = NO;
        [self bubbleViewDidBeginEditing:self.bubbleImageView];
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

#pragma mark 设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

////足视图创建
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
//        //注册
//        ZZTAddLengthFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView"forIndexPath:indexPath];
//        //加长btn事件
//        footerView.addLengthBtnClick = ^(UIButton *btn) {
//
//        };
//        //加页cell
//        footerView.addCellBtnClick = ^(UIButton *btn) {
//            //cell的属性
//            ZZTDIYCellModel *cell = [ZZTDIYCellModel initCellWith:self.view.height - 88   isSelect:NO];
//            //更新cell的数据源
//            NSMutableArray *array = self.cartoonEditArray;
//            [array addObject:cell];
//            self.cartoonEditArray = array;
//
//            [self.collectionView reloadData];
//        };
//        return footerView;
//    }
//    return nil;
//}

#pragma mark 功能块
//返回
- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//保存（未解决）
- (IBAction)save:(UIButton *)sender{

//    [self imageThumb];
}

#pragma mark 遍历显示
-(void)restoreAtIndex{
    [self.collectionView reloadData];
    //获得当前行的数据  但是只有一页  那么应该是死的
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    //获取上一页的内容
    ZZTDIYCellModel *indexModel = self.cartoonArray[self.currentIndex];
    //遍历这一页 第一层数据
    for (int i = 0; i < indexModel.imageArray.count; i++) {
         self.mainView = MainOperationView;
        //如果是第一层的素材
        if([NSStringFromClass([indexModel.imageArray[i] class])isEqualToString:@"ZZTEditImageViewModel"]){
            //获取素材模型
            ZZTEditImageViewModel *model = (ZZTEditImageViewModel *)indexModel.imageArray[i];
            //如果是普通的素材
            if(model.viewType == 1){
                //根据属性快速创建
                ZZTEditImageViewModel *imageModel = [[ZZTEditImageViewModel alloc] init];
                if(!model.imageUrl){
                    EditImageView *imageView = [self speedInitImageView:model];
                    //重新记录数据
                    imageModel = [ZZTEditImageViewModel initImgaeViewModel:model.imageViewFrame imageUrl:nil tagNum:imageView.tagNum viewType:1 localResource:model.localResource viewTransform:imageView.transform];
                }else{
                    EditImageView *imageView = [self speedInitImageView:model];
                    //重新记录数据
                    imageModel = [ZZTEditImageViewModel initImgaeViewModel:model.imageViewFrame imageUrl:model.imageUrl tagNum:imageView.tagNum viewType:1 localResource:nil viewTransform:imageView.transform];
                }
                imageModel.type = model.type;

                //不是方框可直接添加素材到cell之中
                [cellModel.imageArray addObject:imageModel];
            }else{
                //文字框
                ZZTBubbleImageView *bubbleImageView = [self createBubbleImageViewWithModel:model];
                //素材Model
                ZZTEditImageViewModel *imageModel = [ZZTEditImageViewModel initImgaeViewModel:model.imageViewFrame imageUrl:model.imageUrl tagNum:bubbleImageView.tagNum viewType:2 localResource:nil viewTransform:bubbleImageView.transform];
                imageModel.viewContent = model.viewContent;
                imageModel.type = model.type;
                bubbleImageView.type = model.type;

                //不是方框可直接添加素材到cell之中
                [cellModel.imageArray addObject:imageModel];
            }
        }else if([NSStringFromClass([indexModel.imageArray[i] class])isEqualToString:@"ZZTFangKuangModel"]){
            //方框
            self.mainView = MainOperationView;
            //通过上一页的数据重新加载了View 却没有上床数据
            ZZTFangKuangModel *mode = (ZZTFangKuangModel *)indexModel.imageArray[i];
            //恢复方框
            RectangleView *rectangView = [self createFuangKuangViewWithModel:mode];
            rectangView.mainView.backgroundColor = [UIColor colorWithHue:mode.colorH saturation:mode.colorS brightness:1.0 alpha:1.0];
            ZZTFangKuangModel *fangKuangModel = [self addFangKuangModelWithView:rectangView];
            fangKuangModel.type = mode.type;
            if(mode.isCircle == YES){
                rectangView.isCircle = YES;
                rectangView.layer.cornerRadius = rectangView.width/2;
                fangKuangModel.isCircle = YES;
            }
            if(mode.isBlack == YES){
                rectangView.layer.borderColor = [UIColor whiteColor].CGColor;
            }else{
                rectangView.layer.borderColor = [UIColor blackColor].CGColor;
            }
            rectangView.isHide = YES;
            fangKuangModel.isBlack = mode.isBlack;

            if(mode.colorF == 1){
                //黑色
                rectangView.mainView.backgroundColor = [UIColor colorWithHue:mode.colorH saturation:mode.colorS brightness:0 alpha:1.0];
            }else if (mode.colorF == 2){
                rectangView.mainView.backgroundColor = [UIColor colorWithHue:mode.colorH saturation:mode.colorS brightness:1 alpha:1.0];
            }
            fangKuangModel.colorF = mode.colorF;
            fangKuangModel.colorH = mode.colorH;
            fangKuangModel.colorS = mode.colorS;

            //添加方框model
            //如果这个方框里面是有内容的
            //位置的更新没有被传进去
            if(mode.viewArray.count > 0){
                NSInteger num = mode.viewArray.count;
                for (int i = 0; i < num; i++) {
                    if([NSStringFromClass([mode.viewArray[i] class])isEqualToString:@"ZZTEditImageViewModel"]){
                        //设置添加视图
                        ZZTEditImageViewModel *model = (ZZTEditImageViewModel *)mode.viewArray[i];
                        if(model.viewType == 1){
                            self.mainView = rectangView.mainView;

                            ZZTEditImageViewModel *imageModel = [[ZZTEditImageViewModel alloc] init];
                            if(!model.imageUrl){
                                EditImageView *imageView = [self speedInitImageView:model];
                                //重新记录数据
                                imageModel = [ZZTEditImageViewModel initImgaeViewModel:model.imageViewFrame imageUrl:nil tagNum:imageView.tagNum viewType:1 localResource:model.localResource viewTransform:imageView.transform];

                            }else{
                                EditImageView *imageView = [self speedInitImageView:model];
                                //重新记录数据
                                imageModel = [ZZTEditImageViewModel initImgaeViewModel:model.imageViewFrame imageUrl:model.imageUrl tagNum:imageView.tagNum viewType:1 localResource:nil viewTransform:imageView.transform];
                            }
                            imageModel.type = model.type;

                            //不是方框可直接添加素材到cell之中
                            [fangKuangModel.viewArray addObject:imageModel];
                        }else{
                            self.mainView = rectangView.mainView;
                            ZZTBubbleImageView *bubbleImageView = [self createBubbleImageViewWithModel:model];
                            //素材Model
                            ZZTEditImageViewModel *imageModel = [ZZTEditImageViewModel initImgaeViewModel:model.imageViewFrame imageUrl:model.imageUrl tagNum:bubbleImageView.tagNum viewType:2 localResource:nil viewTransform:bubbleImageView.transform];
                            imageModel.viewContent = model.viewContent;
                            imageModel.type = model.type;
                            //不是方框可直接添加素材到cell之中
                            [fangKuangModel.viewArray addObject:imageModel];
                        }
                    }
                }
            }
        }
    }
}

#pragma mark 添加当前cell
-(void)seveCurrentView{
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    ZZTDIYCellModel *model = [cellModel copy];
    [self.cartoonArray addObject:model];
    cellModel.imageArray = nil;
    for (UIView *view in MainOperationView.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark 替换当前数据
-(void)replaceCurrentView{
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    ZZTDIYCellModel *model = [cellModel copy];
    [self.cartoonArray replaceObjectAtIndex:self.currentIndex withObject:model];
    
    cellModel.imageArray = nil;
    
    for (UIView *view in MainOperationView.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark 上一页
- (IBAction)previousPage:(id)sender {
    //安全操作
    if(self.currentIndex == 0){
        NSLog(@"没有上一页");
        //最后一个  保存当前类型
    }else if(self.currentIndex == self.cartoonArray.count){
        //保存当前页
        [self seveCurrentView];
        
        self.currentIndex--;

        [self restoreAtIndex];

    }else{
        //保存并替换内容
        [self replaceCurrentView];
        
        self.currentIndex--;
        if (self.currentIndex != self.cartoonArray.count) {
            [self restoreAtIndex];
        }
    }
}

#pragma mark 下一页
- (IBAction)nextPage:(id)sender {
    if(self.currentIndex == self.cartoonArray.count){
        //添加
        [self seveCurrentView];
        self.currentIndex++;
    }else if(self.currentIndex < self.cartoonArray.count){
        //替换
        [self replaceCurrentView];
        self.currentIndex++;
        //当恢复正常添加的时候 是不需要重新展示的
        if (self.currentIndex != self.cartoonArray.count) {
            [self restoreAtIndex];
        }
    }
    else{
        [self replaceCurrentView];
        self.currentIndex++;
        [self restoreAtIndex];
    }
}
#pragma mark 恢复文字框
-(ZZTBubbleImageView *)createBubbleImageViewWithModel:(ZZTEditImageViewModel *)model{
    //文字没有保存
    //恢复数据
    ZZTBubbleImageView *imageView = [[ZZTBubbleImageView alloc] initWithFrame:model.imageViewFrame text:model.viewContent superView:self.mainView];
    imageView.bubbleDelegate = self;
    imageView.superViewName = NSStringFromClass([self.mainView class]);
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    //设置tag值
    imageView.tagNum = self.tagNum;
    self.tagNum = self.tagNum + 1;
    [self.mainView addSubview:imageView];
    imageView.transform = model.viewTransform;
    //清除框
    [self exceptCurrentViewHiddenOtherView:imageView];
    return imageView;
}


#pragma mark - 全部清空
- (IBAction)empty:(id)sender {
    //可以恢复
    ZZTRemindView *remindView = [[ZZTRemindView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _remindView = remindView;
    remindView.viewTitle = @"清空全部?";
    remindView.btnBlock = ^(UIButton *btn) {
        [self removeAll];
        [self.remindView removeFromSuperview];
    };
    [self.view addSubview:remindView];
  
}

-(void)removeAll{
    //数据全部清除
    for(int i = 0;i < self.cartoonEditArray.count;i++){
        ZZTDIYCellModel *cellModel = self.cartoonEditArray[i];
        [cellModel.imageArray removeAllObjects];
        self.mainView = MainOperationView;
        ZZTCartoonDrawView *currentCell = (ZZTCartoonDrawView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        for (UIView *view in currentCell.operationView.subviews) {
            [view removeFromSuperview];
        }
    }
    [self.collectionView reloadData];
    self.isAddM = NO;
//    self.currentRectangleView.isBig = NO;
}
#pragma mark 发布 未完成
- (IBAction)commit:(id)sender {
    ZZTRemindView *remindView = [[ZZTRemindView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    remindView.viewTitle = @"确认发布";
    remindView.btnBlock = ^(UIButton *btn) {
        [self publish];
        [self.remindView removeFromSuperview];
    };
    [self.view addSubview:remindView];
}

-(void)publish{
    //保存当前页的内容 (这里可能有bug) //判断当前页是否是最后的那一页
    if(self.currentIndex == self.cartoonArray.count){
        [self seveCurrentView];
    }
    //合成图数组
    NSMutableArray *imageArray = [NSMutableArray array];
    //合成完成
    UIView *view = [[UIView alloc] init];
    for (int i = 0; i < self.cartoonArray.count; i++) {
        self.currentIndex = i;
        //显示当前的内容
        [self restoreAtIndex];
        //取消所有view的状态
        [self exceptCurrentViewHiddenOtherView:view];
        //截图区域 和 比例
        UIImage *resultingImage = [self printscreen:MainOperationView];
        
        [imageArray addObject:resultingImage];
//        UIImageWriteToSavedPhotosAlbum(resultingImage, nil, nil, nil);
        
        //清屏
        ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
        cellModel.imageArray = nil;
        for (UIView *view in MainOperationView.subviews) {
            [view removeFromSuperview];
        }
    }
    //上传图片
    [self upLoadQiNiuLoad:imageArray];
    //说明有内容
    if(self.imageUrlArr.count > 0){
        
        NSString *string = [self.imageUrlArr componentsJoinedByString:@","];
        NSDictionary *dic = @{
                              @"userId":@"1",
                              @"cartoonId":@"1",
                              @"chapterCover":string,
                              @"chapterName":@"1",
                              @"chapterId":@"1"
                              };
        [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"cartoon/insertCartoonChapter"] parameters:dic success:^(id responseObject) {
            NSLog(@"成功了");
        } failure:^(NSError *error) {
            
        }];
    }else{
        //根据页面 需要来增删改查
        NSLog(@"无内容");
    }
    
    //提交完成后删除
    [self.cartoonArray removeAllObjects];
    self.currentIndex = 0;
}

#pragma mark 翻转(方框内内容翻转没做)
- (IBAction)spin:(id)sender {
    //是当前对象才能被翻转
    if([NSStringFromClass([self.currentView class]) isEqualToString:@"EditImageView"]){
        EditImageView *currentView = (EditImageView *)self.currentView;
        if(currentView){
            currentView.image = [currentView.image flipHorizontal];
        }
    }else if([NSStringFromClass([self.currentView class]) isEqualToString:@"ZZTBubbleImageView"]){
        ZZTBubbleImageView *currentView = (ZZTBubbleImageView *)self.currentView;
        if(currentView){
            currentView.image = [currentView.image flipHorizontal];
        }
    }
}

#pragma mark 改变图片上下级功能
#pragma mark 获取当前被选中的方框
-(RectangleView *)rectangleViewFromMainOperationView{
    
    RectangleView *rectangleView = [[RectangleView alloc] init];
    //在cell上获得这个方框  凡是有几种类型的 应该多加判断
    for (int i = 0; i < MainOperationView.subviews.count; i++) {
        //从cell中得到方框
        if([NSStringFromClass([MainOperationView.subviews[i] class])isEqualToString:@"RectangleView"]){
            rectangleView = MainOperationView.subviews[i];
            if(rectangleView.tagNum == self.currentRectangleView.tagNum)
            {
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
        
    }else if([NSStringFromClass([self.currentView class])isEqualToString:@"ZZTBubbleImageView"]){
        //如果是汽泡
        ZZTBubbleImageView *imageView = (ZZTBubbleImageView *)self.currentView;
        if([imageView.superViewName isEqualToString:@"UIView"]){
            //方框内的素材交换
            [self exchangeFangKuangViewUpIndex];
        }else{
            //素材交换
            [self exchangeViewUpIndex:1];
        }
    }else if([NSStringFromClass([self.currentView class])isEqualToString:@"EditImageView"]){
        EditImageView *imageView = (EditImageView *)self.currentView;
        //改素材在方框上面
        if ([imageView.superViewName isEqualToString:@"UIView"]) {
            [self exchangeFangKuangViewUpIndex];
        }else{
            [self exchangeViewUpIndex:1];
        }
    }
}

#pragma mark 获取方框内索引 交换
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
#pragma mark 交换
-(void)exchangeViewUpIndex:(NSInteger)integer{
    //得到cell上的所有View
    NSArray *array = MainOperationView.subviews;
    
    NSInteger index = [self viewIndexFromArray:array integer:integer];
    
    [self exchangeViewAtIndexInView:index exchangeIndex:index + 1 limit:array.count - 1];
}
//获取不同类型的索引
-(NSInteger)viewIndexFromArray:(NSArray *)array integer:(NSInteger)integer{
    NSInteger index = 0;
    if(integer == 1){
        //框外
        index = [self getCurrentViewIndex:array];
    }else{
        //框内
        index = [self getFangKuangViewIndex:array];
    }
    return index;
}
#pragma 下一层
- (IBAction)downLevel:(id)sender {
    //如果我当前选择的这个东西是一个方框
    if([NSStringFromClass([self.currentView class])isEqualToString:@"RectangleView"]){

        [self exchangeViewDownIndex:2];
    }else if([NSStringFromClass([self.currentView class])isEqualToString:@"ZZTBubbleImageView"]){
        //如果是汽泡
        ZZTBubbleImageView *imageView = (ZZTBubbleImageView *)self.currentView;
        if([imageView.superViewName isEqualToString:@"UIView"]){
            [self exchangeFangKuangViewDownIndex];
        }else{
            [self exchangeViewDownIndex:1];
        }
    }else if([NSStringFromClass([self.currentView class])isEqualToString:@"EditImageView"]){
        EditImageView *imageView = (EditImageView *)self.currentView;
        //改素材在方框上面
        if ([imageView.superViewName isEqualToString:@"UIView"]) {
            [self exchangeFangKuangViewDownIndex];
        }else{
            [self exchangeViewDownIndex:1];
        }
    }
}
//数据没有交换

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
    //3 2
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
            EditImageView *currentView = (EditImageView *)self.currentView;
            if(imageView.tagNum == currentView.tagNum){
                NSLog(@"%ld",imageView.tagNum);
                index = i;
                break;
            }
        }else if ([NSStringFromClass([array[i] class]) isEqualToString:@"ZZTBubbleImageView"]){
            ZZTBubbleImageView *imageView = array[i];
            ZZTBubbleImageView *currentView = (ZZTBubbleImageView *)self.currentView;
            if(imageView.tagNum == currentView.tagNum){
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
#warning 文字框 这里是有问题的诶
-(ZZTFangKuangModel *)rectangleModelFromView:(RectangleView *)rectangleView{
    //取到模型组  改变模型的数据
    ZZTFangKuangModel *model = [[ZZTFangKuangModel alloc] init];
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];
    for (int i = 0; i < cellModel.imageArray.count; i++) {
        if ([NSStringFromClass([cellModel.imageArray[i] class])isEqualToString:@"ZZTFangKuangModel"]) {
            model = cellModel.imageArray[i];
            if(model.tagNum == rectangleView.tagNum){
                break;
            }
        }
    }
    return model;
}

#pragma mark - 创建方框
- (IBAction)advance:(id)sender {
    RectangleView *rectangleView = [self createFuangKuangViewWithModel:nil];
    //添加方框模型
    [self addFangKuangModelWithView:rectangleView];
}

-(RectangleView *)createFuangKuangViewWithModel:(ZZTFangKuangModel *)model{
    CGRect viewFrame;
    if(model){
        //恢复
        viewFrame = model.viewFrame;
    }else{
        //第一次创建
        viewFrame = CGRectMake(self.midView.center.x/2 - 100, 20, 200, 200);
    }
    RectangleView *rectangView = [[RectangleView alloc] initWithFrame:viewFrame];
    //方框永远在cell之上
    rectangView.superView = MainOperationView;
    rectangView.delegate = self;

    
    rectangView.tagNum = self.tagNum;
    self.tagNum = self.tagNum + 1;
    rectangView.type = @"布局";
    #warning 这个代理是干什么的？？
    [self checkRectangleView:rectangView];
    
    [MainOperationView addSubview:rectangView];

    return rectangView;
}
#pragma mark 添加方框模型
-(ZZTFangKuangModel *)addFangKuangModelWithView:(RectangleView *)rectangleView{
    //cell
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];
    //位置数据
    //方框模型
     ZZTFangKuangModel *FKModel = [ZZTFangKuangModel initWithViewFrame:rectangleView.frame tagNum:rectangleView.tagNum];
    [cellModel.imageArray addObject:FKModel];
    return FKModel;
}

#pragma mark 设置当前方框
-(void)checkRectangleView:(RectangleView *)rectangleView{
    rectangleView.curType = self.curType;
    //如果点击的正是现在的方框 什么也不做
    if(self.currentRectangleView == rectangleView){
    
    }else if(self.currentRectangleView != rectangleView && self.currentRectangleView.isBig == YES){
        //如果
        [self.currentRectangleView closeView];
        [self.closeBtn removeFromSuperview];
        [self.topBtnView removeFromSuperview];
    }
    if(rectangleView.isBig == NO){
        //设置方框为当前View
        self.mainView = rectangleView.mainView;
        self.currentRectangleView = rectangleView;
        [self exceptCurrentViewHiddenOtherView:rectangleView];
    }
}

#pragma mark 方框移动 更新位置
-(void)setupMainView:(RectangleView *)rectangleView{
    self.isMoveAfter = YES;
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    
    for (ZZTFangKuangModel *model in cellModel.imageArray) {
        if(model.tagNum == rectangleView.tagNum){
            model.viewFrame = rectangleView.frame;
        }
    }
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

#pragma mark 方框放大操作
-(void)enlargedAfterEditView:(RectangleView *)rectangleView isBig:(BOOL)isBig proportion:(CGFloat)proportion{
    //记录放大缩小的状态
    self.isAddM = isBig;
    
    //如果已经变大
    if(isBig == YES){
        //防止重复
        self.proportion = proportion;
        [self.topBtnView removeFromSuperview];
        [self.closeBtn removeFromSuperview];
        //生成一个关闭的窗口
        UIView *topBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 30)];
        topBtnView.backgroundColor = [UIColor blackColor];
        _topBtnView = topBtnView;
        [self.view addSubview:topBtnView];
        //关闭按钮
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, topBtnView.width, topBtnView.height)];
        [closeBtn setTitle:@"确定" forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn = closeBtn;
        [topBtnView addSubview:closeBtn];
    }else{
        [self close];
        self.isAddM = NO;
        self.mainView = MainOperationView;
    }
}

-(void)close{
    if(self.currentRectangleView.isBig == YES){
        [self.currentRectangleView closeView];
    }
    self.currentRectangleView.isHide = YES;
    [self.closeBtn removeFromSuperview];
    [self.topBtnView removeFromSuperview];
}

//更新方框的坐标
-(void)updateRectangleViewFrame:(RectangleView *)view{
    ZZTFangKuangModel *model = [self rectangleModelFromView:view];
    model.viewFrame = view.frame;
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
    ZZTFangKuangModel *FKModel = [self rectangleModelFromView:self.currentRectangleView];
    FKModel.colorH = self.colorH;
    FKModel.colorS = self.colorS;
    FKModel.colorF = 0;
    self.mainView.backgroundColor = self.choiceColor;
    self.coloringBtn.imageView.backgroundColor = self.choiceColor;
}

#pragma mark 取色板代理方法
-(void)patetteView:(ZZTPaletteView *)patetteView choiceColor:(UIColor *)color colorPoint:(CGPoint)colorPoint colorH:(CGFloat)colorH colorS:(CGFloat)colorS{
    self.choiceColor = color;
    self.colorS = colorS;
    self.colorH = colorH;
}


//收藏夹
- (IBAction)favorite:(id)sender {
    NSString *image = [[NSString alloc] init];
    NSString *type = [[NSString alloc] init];

    if([NSStringFromClass([self.currentView class])isEqualToString:@"ZZTBubbleImageView"]){
        ZZTBubbleImageView *currentView = (ZZTBubbleImageView *)self.currentView;
        ZZTEditImageViewModel *model = [self getEditImageViewModelWithView:currentView];
        image = model.imageUrl;
        type = model.type;
    }else if([NSStringFromClass([self.currentView class])isEqualToString:@"EditImageView"]){
        EditImageView *currentView = (EditImageView *)self.currentView;
        ZZTEditImageViewModel *model = [self getImageViewModelWithView:currentView];
        image = model.imageUrl;
        type = model.type;
    }else if([NSStringFromClass([self.currentView class])isEqualToString:@"RectangleView"]){
        RectangleView *currentView = (RectangleView *)self.currentView;
        currentView.isHide = YES;
        //开启
        UIImage *resultingImage = [self printscreen:currentView];
        
        //上传图片
        NSString *imgName = [self getImgName];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imgName];
        BOOL result = [UIImagePNGRepresentation(resultingImage) writeToFile:filePath atomically:YES];
        if(result == YES){
            AFNHttpTool *tool = [[AFNHttpTool alloc] init];
            NSString *toke = [tool makeToken:ZZTAccessKey secretKey:ZZTSecretKey];
            
            [AFNHttpTool putImagePath:filePath key:imgName token:toke complete:^(id objc) {
                NSLog(@"%@",objc); //  上传成功并获取七牛云的图片地址
                [self collectImageWithImageName:imgName type:@"1"];
            }];
        }
    }
}

//截图
-(UIImage *)printscreen:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    UIImage *resultingImage = [[UIImage alloc] init];
    
    [resultingImage drawInRect:CGRectMake(0, 0,view.bounds.size.width, view.bounds.size.height)];
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return resultingImage;
}

-(void)collectImageWithImageName:(NSString *)image type:(NSString *)type{
    if([type isEqualToString:@"布局"]){
        type = @"1";
    }else if([type isEqualToString:@"场景"]){
        type = @"2";
    }else if([type isEqualToString:@"角色"]){
        type = @"3";
    }else if([type isEqualToString:@"效果"]){
        type = @"4";
    }else if([type isEqualToString:@"文字"]){
        type = @"5";
    }
    NSDictionary *dic = @{
                          @"userId":@"1",
                          @"fodderImg":image,
                          @"fodderType":type
                          };
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"fodder/insertUserFodderCollect"] parameters:dic success:^(id responseObject) {
        NSLog(@"收藏成功");
    } failure:^(NSError *error) {
        
    }];
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
    
    //通过字符串创建
    EditImageView *imageView = [self speedInitImageViewWithStr:model.img];
    //存储数据
    ZZTEditImageViewModel *imageModel = [ZZTEditImageViewModel initImgaeViewModel:imageView.frame imageUrl:model.img tagNum:imageView.tagNum viewType:1 localResource:nil viewTransform:imageView.transform];
    imageModel.type = imageView.type;
    
    //方框内
    if ([NSStringFromClass([self.mainView class]) isEqualToString:@"UIView"]) {
        //如果可以加入素材 便加入图层
        if(self.isAddM == YES){
            [self.mainView addSubview:imageView];
            //要方框数据
            ZZTFangKuangModel *FKModel = [self rectangleModelFromView:self.currentRectangleView];
            [FKModel.viewArray addObject:imageModel];
            [self exceptCurrentViewHiddenOtherView:imageView];
        }else{
            //否则失败
            NSLog(@"必须放大View以后才能添加素材");
        }
    }else{
        //不是方框可直接添加素材到cell之中
        [cellModel.imageArray addObject:imageModel];
        [self.mainView addSubview:imageView];
        [self exceptCurrentViewHiddenOtherView:imageView];
    }
}
/*
    先把文本框里面的内容UI统一 一下
    然后做一个关于这个view的增删改查
 */
#pragma mark - 添加文字框
-(void)sendTextImageWithModel:(ZZTFodderListModel *)model{

    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];

    ZZTBubbleImageView *imageView = [[ZZTBubbleImageView alloc] initWithFrame:CGRectMake(self.midView.center.x/2, 20, 200, 200) text:@"请输入内容" superView:self.mainView];
    imageView.type = self.curType;
    imageView.bubbleDelegate = self;
    imageView.superViewName = NSStringFromClass([self.mainView class]);
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    //设置tag值
    imageView.tagNum = self.tagNum;
    self.tagNum = self.tagNum + 1;
    //素材Model
    ZZTEditImageViewModel *imageModel = [ZZTEditImageViewModel initImgaeViewModel:imageView.frame imageUrl:model.img tagNum:imageView.tagNum viewType:2 localResource:nil viewTransform:imageView.transform];
    imageModel.viewContent = @"请输入内容";
    imageModel.type = imageView.type;

//    [self bubbleViewSaveText:imageView text:@"请输入内容"];

    //如果是加入方框
    if ([NSStringFromClass([self.mainView class]) isEqualToString:@"UIView"]) {
        //如果可以加入素材 便加入图层
        if(self.isAddM == YES){
            [self.mainView addSubview:imageView];
            
//            ZZTFangKuangModel *FKModel = [self rectangleModelFromView:(RectangleView *)self.mainView];
            ZZTFangKuangModel *FKModel = [self rectangleModelFromView:self.currentRectangleView];
            [FKModel.viewArray addObject:imageModel];
            //不管之前的呢 怎么快 怎么来
            [self exceptCurrentViewHiddenOtherView:imageView];
        }else{
            //否则失败
            NSLog(@"必须放大View以后才能添加素材");
        }
    }else{
        //不是方框可直接添加素材到cell之中
        [cellModel.imageArray addObject:imageModel];
        [self.mainView addSubview:imageView];
        [self exceptCurrentViewHiddenOtherView:imageView];
    }
}

//设置当前View
-(void)bubbleViewDidBeginEditing:(ZZTBubbleImageView *)bubbleView{
    bubbleView.curType = self.curType;
    self.isMoveAfter = YES;
    self.bubbleImageView = bubbleView;
    [self exceptCurrentViewHiddenOtherView:bubbleView];
}

//移动后更新位置
-(void)bubbleViewDidBeginEnd:(ZZTBubbleImageView *)bubbleView{
    CGAffineTransform lastTransform = bubbleView.transform;
    ZZTEditImageViewModel *model = [self getEditImageViewModelWithView:bubbleView];
    bubbleView.transform = CGAffineTransformIdentity;
    model.imageViewFrame = bubbleView.frame;
    bubbleView.transform = lastTransform;
}

//保存文字
-(void)bubbleViewSaveText:(ZZTBubbleImageView *)bubbleView text:(NSString *)text{
    ZZTEditImageViewModel *model = [self getEditImageViewModelWithView:bubbleView];
    model.viewContent = text;
}

#pragma mark 文字框移动
-(void)bubbleViewDidBeginMoving:(ZZTBubbleImageView *)bubbleView{

    ZZTEditImageViewModel *model = [self getEditImageViewModelWithView:bubbleView];
    
    CGAffineTransform lastTransform = bubbleView.transform;
    bubbleView.transform = CGAffineTransformIdentity;
    //变化前的位置
    model.imageViewFrame = bubbleView.frame;
    //回到变化后
    bubbleView.transform = lastTransform;
    model.viewTransform = bubbleView.transform;
}

#pragma mark 文字框旋转
-(void)bubbleViewDidRotate:(ZZTBubbleImageView *)bubbleView{
    //记录当前变化后的tansform  如果不能直接赋值 要求算出来
    ZZTEditImageViewModel *model = [self getEditImageViewModelWithView:bubbleView];
    CGAffineTransform lastTransform = bubbleView.transform;
    bubbleView.transform = CGAffineTransformIdentity;
    //变化前的位置
    model.imageViewFrame = bubbleView.frame;
    //回到变化后
    bubbleView.transform = lastTransform;
    model.viewTransform = bubbleView.transform;
}

#pragma mark 获取文字框的模型
-(ZZTEditImageViewModel *)getEditImageViewModelWithView:(ZZTBubbleImageView *)bubbleView{
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    ZZTEditImageViewModel *model = [[ZZTEditImageViewModel alloc]init];
    //如果是方框
    if([NSStringFromClass([self.mainView class]) isEqualToString:@"UIView"]){
        ZZTFangKuangModel *FKModel = [self rectangleModelFromView:self.currentRectangleView];
        //更新model中的数据
        for (int i = 0; i < FKModel.viewArray.count; i++) {
            model = FKModel.viewArray[i];
            if(model.tagNum == bubbleView.tagNum && model.viewType == 2){
                break;
            }
        }
    }else{
        //更新位置
        for (ZZTEditImageViewModel *imageViewModel in cellModel.imageArray) {
            if(imageViewModel.tagNum == bubbleView.tagNum && imageViewModel.viewType == 2){
                model = imageViewModel;
                break;
            }
        }
    }
    return model;
}

#pragma mark 恢复绘图素材
-(EditImageView *)speedInitImageView:(ZZTEditImageViewModel *)model{
    //位置
    EditImageView *imageView = [[EditImageView alloc] initWithFrame:model.imageViewFrame];
    imageView.transform = model.viewTransform;
    imageView.type = model.type;
    imageView.delegate = self;
    //记录父类的名字
    if(!model.imageUrl){
        imageView.image = model.localResource;
    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        }];
    }
    imageView.superViewName = NSStringFromClass([self.mainView class]);

    [self addEditImageView:imageView];
    imageView.transform = model.viewTransform;

    return imageView;
}

#pragma mark 创建素材
-(EditImageView *)speedInitImageViewWithStr:(NSString *)imgUrl{
    //创建坐标默认
    EditImageView *imageView = [[EditImageView alloc] initWithFrame:CGRectMake(self.midView.center.x/2, 20, 100, 100)];
    imageView.type = self.curType;
    imageView.delegate = self;
    //记录父类的名字
    imageView.superViewName = NSStringFromClass([self.mainView class]);
    [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    //设置tag值
    imageView.tagNum = self.tagNum;
    self.tagNum = self.tagNum + 1;
    imageView.superViewTag = self.mainView.tag;
    return imageView;
}

//添加到图层之中去
-(void)addEditImageView:(EditImageView *)imageView{
    //添加素材
    [self.mainView addSubview:imageView];
    //隐藏除了View 以外的其他视图
    [self exceptCurrentViewHiddenOtherView:imageView];
}

/*
    updateImageViewFrame
*/
#pragma mark 素材旋转
-(void)updateImageViewTransform:(EditImageView *)view{
    //记录当前变化后的tansform  如果不能直接赋值 要求算出来
    ZZTEditImageViewModel *model = [self getImageViewModelWithView:view];
    CGAffineTransform lastTransform = view.transform;
    view.transform = CGAffineTransformIdentity;
    //变化前的位置
    model.imageViewFrame = view.frame;
    //回到变化后
    view.transform = lastTransform;
    model.viewTransform = view.transform;
}

#pragma mark 得到素材模型
-(ZZTEditImageViewModel *)getImageViewModelWithView:(EditImageView *)view{
    //更新的位置
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    ZZTEditImageViewModel *model = [[ZZTEditImageViewModel alloc] init];
    //如果是方框
    if([NSStringFromClass([self.mainView class]) isEqualToString:@"UIView"]){
        ZZTFangKuangModel *FKModel = [self rectangleModelFromView:self.currentRectangleView];
        //更新model中的数据
        for (int i = 0; i < FKModel.viewArray.count; i++) {
            model = FKModel.viewArray[i];
            if(model.tagNum == view.tagNum){
                break;
            }
        }
    }else{
        //更新位置
        for (ZZTEditImageViewModel *imageViewModel in cellModel.imageArray) {
            if(imageViewModel.tagNum == view.tagNum){
                model = imageViewModel;
                break;
            }
        }
    }
    return model;
}
//隐藏其他View
-(void)EditImageViewWithViewIncell:(EditImageView *)view{
    view.curType = self.curType;
    [self exceptCurrentViewHiddenOtherView:view];
}
//隐藏其他View
-(void)EditImageViewWithViewInRectangleView:(EditImageView *)view{
    //给view发送当前的type
    view.curType = self.curType;
    [self exceptCurrentViewHiddenOtherView:view];
}

//更新素材的位置 updateImageViewTransform
-(void)updateImageViewFrame:(EditImageView *)view{
    CGAffineTransform lastTransform = view.transform;
    //更新的位置
    ZZTEditImageViewModel *model = [self getImageViewModelWithView:view];
    view.transform = CGAffineTransformIdentity;
    //变化前的位置
    model.imageViewFrame = view.frame;
    //回到变化后
    view.transform = lastTransform;
    model.viewTransform = view.transform;
}

#pragma mark 请求素材库
-(void)loadMaterialData:(NSString *)fodderType modelType:(NSString *)modelType modelSubtype:(NSString *)modelSubtype{
    NSDictionary *parameter = @{
                                @"fodderType":fodderType,
                                @"modelType":modelType,
                                @"modelSubtype":modelSubtype
                                };
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"fodder/fodderList"] parameters:parameter success:^(id responseObject) {
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
        if(model.tagNum == editImgView.tagNum)
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

-(void)removeBubbleView:(NSNotification *)notify{
    ZZTBubbleImageView *bubbleImageView = notify.object;
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[_selectRow];
    for (int i = 0; i < cellModel.imageArray.count; i++) {
        ZZTEditImageViewModel *model = cellModel.imageArray[i];
        if(model.tagNum == bubbleImageView.tagNum){
            [cellModel.imageArray removeObject:model];
            [bubbleImageView removeFromSuperview];
        }
    }
}

//隐藏所有Btn的状态 bug
- (void)hideAllBtn{
    UIView *view = [[UIView alloc] init];
    [self exceptCurrentViewHiddenOtherView:view];
}

//#pragma mark 截图 这里要搞个异步
//- (void)imageThumb{
//    [self hideAllBtn];
//    /*
//     保存
//     */
//    NSMutableArray *imageArray = [NSMutableArray array];
//
//    //循环截图
//    //多少个cell 截图多少次   更新了 要变换才行
//    for(int i = 0;i < self.cartoonEditArray.count;i++){
//        //数据管理cell  数据错误
//        ZZTCartoonDrawView *cell = (ZZTCartoonDrawView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        //开启
//        UIGraphicsBeginImageContextWithOptions(cell.bounds.size, NO, [UIScreen mainScreen].scale);
//
//        UIImage *resultingImage = [[UIImage alloc] init];
//        [resultingImage drawInRect:CGRectMake(0, 0,cell.bounds.size.width, cell.bounds.size.height)];
//
//        [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
//
//        resultingImage = UIGraphicsGetImageFromCurrentImageContext();
//
//        UIGraphicsEndImageContext();
//
//
//        [imageArray addObject:resultingImage];
//        //保存本地
////        resultingImage = [resultingImage stretchableImageWithLeftCapWidth:SCREEN_WIDTH topCapHeight:SCREEN_HEIGHT];
//        UIImageWriteToSavedPhotosAlbum(resultingImage, nil, nil, nil);
//
//    }
//
//}
//生成文件名
-(NSString *)getImgName{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [formatter stringFromDate:[NSDate date]];
    NSString *imgName = [formatter stringFromDate:[NSDate date]];
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:32];
    for (NSInteger i = 0; i < 32; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)letters.length)]];
    }
    imgName = [NSString stringWithFormat:@"%@%@.png",imgName,randomString];
    return imgName;
}
-(void)upLoadQiNiuLoad:(NSArray *)array{
    //上传七牛云
    for (int i = 0; i < array.count; i++) {
        //文件名
        NSString *imgName = [self getImgName];
        //写入本地
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imgName];
        BOOL result = [UIImagePNGRepresentation(array[i]) writeToFile:filePath atomically:YES];
        
        if (result == YES) {
            NSLog(@"保存成功");
            [self.imageUrlArr removeAllObjects];
            AFNHttpTool *tool = [[AFNHttpTool alloc] init];
            NSString *toke = [tool makeToken:ZZTAccessKey secretKey:ZZTSecretKey];
            
            [AFNHttpTool putImagePath:filePath key:imgName token:toke complete:^(id objc) {
                NSLog(@"%@",objc); //  上传成功并获取七牛云的图片地址
                [self.imageUrlArr addObject:objc];
            }];
            
        }else{
            NSLog(@"保存失败");
        }
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"remove" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"removeRectangleView" object:nil];

}

#pragma mark 素材库
//布局
- (IBAction)Layout:(UIButton *)sender {
    [self setBottomBtn:sender];
    [self setupMaterialLibraryView:@"布局"];
}

//场景
- (IBAction)scene:(UIButton *)sender {
    [self setBottomBtn:sender];
    [self setupMaterialLibraryView:@"场景"];
}

//角色
- (IBAction)role:(UIButton *)sender {
    [self setBottomBtn:sender];
    [self setupMaterialLibraryView:@"角色"];
}

//效果
- (IBAction)specialEffects:(UIButton *)sender {
    [self setBottomBtn:sender];
    [self setupMaterialLibraryView:@"效果"];
}

//文字
- (IBAction)textView:(UIButton *)sender {
    [self setBottomBtn:sender];
    [self setupMaterialLibraryView:@"文字"];
}

-(void)setBottomBtn:(UIButton *)sender{
    for (int i = 0;i < self.bottomArray.count;i++) {
        UIButton *btn = self.bottomArray[i];
        if([sender.titleLabel.text isEqualToString:btn.titleLabel.text]){
            UIImage *buttonImage = [UIImage imageNamed:btn.titleLabel.text];
            [btn setBackgroundImage:buttonImage forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            self.curType = btn.titleLabel.text;
        }else{
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        }
    }
}

//弹出底部View
-(void)setupMaterialLibraryView:(NSString *)str{
    ZZTMaterialLibraryView *view = [self MaterialLibraryViewWithStr:str];
    view.isMe = NO;
}

-(ZZTMaterialLibraryView *)MaterialLibraryViewWithStr:(NSString *)str{
    [_materialLibraryView removeFromSuperview];
    CGFloat viewHeight = (SCREEN_HEIGHT - 88)/3;
    CGFloat y = (SCREEN_HEIGHT - 30) - viewHeight;
    _materialLibraryView = [[ZZTMaterialLibraryView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, viewHeight)];
    _materialLibraryView.delagate = self;
    //调试入口
    _materialLibraryView.str = str;
    _materialLibraryView.backgroundColor = [UIColor colorWithHexString:@"#B1B1B1"];
    [self.view addSubview:_materialLibraryView];
    return _materialLibraryView;
}
#pragma mark 隐藏其他View的状态
-(void)exceptCurrentViewHiddenOtherView:(UIView *)view{
    self.currentView = view;
    self.collectionView.scrollEnabled = NO;
    
    RectangleView *rectangleView = [self rectangleViewFromMainOperationView];
    //遍历方框
    for (int i = 0; i < rectangleView.mainView.subviews.count; i++) {
        //如果不是当前素材 便隐藏内容
        if(rectangleView.mainView.subviews[i] != view){
            //如果方框中的类容是素材
            if ([NSStringFromClass([rectangleView.mainView.subviews[i] class])isEqualToString:@"EditImageView"]) {
                EditImageView *imageView = rectangleView.mainView.subviews[i];
                imageView.isHide = YES;
            }
            //如果是聊天框
            else if ([NSStringFromClass([rectangleView.mainView.subviews[i] class])isEqualToString:@"ZZTBubbleImageView"] && rectangleView.mainView.subviews[i] != view){
                ZZTBubbleImageView *BubbleImageView = rectangleView.mainView.subviews[i];
                BubbleImageView.isHide = YES;
            }
        }
    }
    for (int i = 0; i < MainOperationView.subviews.count; i++) {
        //如果不是当前素材 便隐藏内容
        if([NSStringFromClass([MainOperationView.subviews[i] class])isEqualToString:@"EditImageView"] && MainOperationView.subviews[i] != view){
            EditImageView *imageView = MainOperationView.subviews[i];
            imageView.isHide = YES;
        }//如果是聊天框
        else if ([NSStringFromClass([MainOperationView.subviews[i] class])isEqualToString:@"ZZTBubbleImageView"] && MainOperationView.subviews[i] != view){
            ZZTBubbleImageView *BubbleImageView = MainOperationView.subviews[i];
            BubbleImageView.isHide = YES;
        }else if ([NSStringFromClass([MainOperationView.subviews[i] class])isEqualToString:@"RectangleView"]){
            //如果是方框
            RectangleView *rectangleView = self.currentCell.operationView.subviews[i];
            if(rectangleView.mainView == self.mainView){
                rectangleView.isHide = NO;
            }else{
                rectangleView.isHide = YES;
            }
        }
    }
}

//预览
- (IBAction)previewTarget:(ToolBtn *)sender {
    //预览
    //截屏
    //开启
    UIImage *resultingImage = [self printscreen:_midView];
    
    //放在一个view上
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imageView.image = resultingImage;
    _imageView = imageView;
    self.collectionView.userInteractionEnabled = NO;
    [self.view addSubview:imageView];
    //取消btn
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _cannelBtn = btn;
    [btn addTarget:self action:@selector(removeImageView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)removeImageView{
    [self.imageView removeFromSuperview];
    [self.cannelBtn removeFromSuperview];
    self.collectionView.userInteractionEnabled = YES;
}

- (IBAction)upload:(ToolBtn *)sender {
    //初始化图像选择控制器
    _picker = [[UIImagePickerController alloc]init];
    _picker.allowsEditing = YES;  //重点是这两句
    
    //遵守代理
    _picker.delegate =self;
    //本地
    [self alert];
}

-(void)alert{
    //标题
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //相机
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushCamera];
    }];
    //相册
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushPhotoAlbum];
    }];
    
    //取消按钮
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    //添加各个按钮事件
    [alert addAction:camera];
    [alert addAction:photo];
    [alert addAction:cancel];
    //弹出sheet提示框
    [self presentViewController:alert animated:YES completion:nil];
}

//调用相机
-(void)pushCamera{
    //告诉是哪一个btn
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        // 将sourceType设为UIImagePickerControllerSourceTypeCamera代表拍照或拍视频
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置拍摄照片
        _picker.cameraCaptureMode =UIImagePickerControllerCameraCaptureModePhoto;
        // 设置使用手机的后置摄像头（默认使用后置摄像头）
        _picker.cameraDevice =UIImagePickerControllerCameraDeviceRear;
        // 设置使用手机的前置摄像头。
        //picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        // 设置拍摄的照片允许编辑
        _picker.allowsEditing =YES;
    }else{
        NSLog(@"模拟器无法打开摄像头");
    }
    // 显示picker视图控制器
    [self presentViewController:_picker animated:YES completion:nil];
}

//调用相册
-(void)pushPhotoAlbum{
    //告诉是哪一个btn
    //调用系统相册的类
    //    _picker = [[UIImagePickerController alloc]init];
    //设置选取的照片是否可编辑
    _picker.allowsEditing = YES;
    //设置相册呈现的样式
    _picker.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    //    _picker.delegate = self;
    [self.navigationController presentViewController:_picker animated:YES completion:^{
        
    }];
}

#pragma mark - 相册代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //生成素材
    //获取当前行的数据
    ZZTDIYCellModel *cellModel = self.cartoonEditArray[self.selectRow];

    //创建坐标默认
    EditImageView *imageView = [[EditImageView alloc] initWithFrame:CGRectMake(self.midView.center.x/2, 20, 100, 100)];
    imageView.delegate = self;
    //记录父类的名字
    imageView.superViewName = NSStringFromClass([self.mainView class]);
    [imageView setImage:resultImage];
    //设置tag值
    imageView.tagNum = self.tagNum;
    self.tagNum = self.tagNum + 1;
    imageView.superViewTag = self.mainView.tag;
    //存储数据
    ZZTEditImageViewModel *imageModel = [ZZTEditImageViewModel initImgaeViewModel:imageView.frame imageUrl:nil tagNum:imageView.tagNum viewType:1 localResource:resultImage viewTransform:imageView.transform];

    //方框内
    if ([NSStringFromClass([self.mainView class]) isEqualToString:@"UIView"]) {
        //如果可以加入素材 便加入图层
        if(self.isAddM == YES){
            [self.mainView addSubview:imageView];
            //要方框数据
            ZZTFangKuangModel *FKModel = [self rectangleModelFromView:self.currentRectangleView];
            [FKModel.viewArray addObject:imageModel];
            [self exceptCurrentViewHiddenOtherView:imageView];
        }else{
            //否则失败
            NSLog(@"必须放大View以后才能添加素材");
        }
    }else{
        //不是方框可直接添加素材到cell之中
        [cellModel.imageArray addObject:imageModel];
        [self.mainView addSubview:imageView];
        [self exceptCurrentViewHiddenOtherView:imageView];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)deletView:(ToolBtn *)sender {
//    删除
    if([NSStringFromClass([self.currentView class]) isEqualToString:@"EditImageView"]){
        EditImageView *view = (EditImageView *)self.currentView;
        [view closeBtnClick];
    }else if([NSStringFromClass([self.currentView class]) isEqualToString:@"ZZTBubbleImageView"]){
        ZZTBubbleImageView *view = (ZZTBubbleImageView *)self.currentView;
        [view deleteControlTapAction];
    }else if([NSStringFromClass([self.currentView class]) isEqualToString:@"RectangleView"]){
        RectangleView *view = (RectangleView *)self.currentView;
        [view removeGestureRecognizer];
        self.currentView = MainOperationView;
        self.isAddM = YES;
    }
}

#pragma mark - 加入方框
-(void)sendTuKuangWithModel:(ZZTFodderListModel *)model{
    //如果已经有框 还是放大 那么缩小当前已经放大的框
    if(self.currentRectangleView && self.currentRectangleView.isBig == YES){
        //缩小
        [self.currentRectangleView closeView];
    }
    //判断是黑的还是白的
    if([model.owner isEqualToString:@"0"]){
        //黑
        [self speedInitFangKuangViewWith:YES colorF:1 isCircle:NO];
    }else{
        //白
        [self speedInitFangKuangViewWith:NO colorF:2 isCircle:NO];
    }
}

#pragma mark 圆框
-(void)sendYuanKuangWithModel:(ZZTFodderListModel *)model{
    //判断是黑的还是白的
    if([model.owner isEqualToString:@"0"]){
        //黑
        [self speedInitFangKuangViewWith:YES colorF:1 isCircle:YES];
    }
    else{
        //白
        [self speedInitFangKuangViewWith:NO colorF:2 isCircle:YES];
    }
}
-(void)speedInitFangKuangViewWith:(BOOL)isBlack colorF:(CGFloat)colorF isCircle:(BOOL)isCircle{
    RectangleView *rectangleView = [self createFuangKuangViewWithModel:nil];
    rectangleView.isCircle = isCircle;
    
    if(rectangleView.isCircle == YES){
        rectangleView.layer.cornerRadius = rectangleView.width/2;
    }
    
    if (isBlack == YES) {
        rectangleView.mainView.backgroundColor = [UIColor blackColor];
        rectangleView.layer.borderColor = [UIColor whiteColor].CGColor;
    }else{
        rectangleView.mainView.backgroundColor = [UIColor whiteColor];
        rectangleView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    //添加方框模型
    ZZTFangKuangModel *model = [self addFangKuangModelWithView:rectangleView];
    model.modelColor = rectangleView.mainView.backgroundColor;
    model.type = rectangleView.type;
    model.isCircle = isCircle;
    
    //记录边的颜色
    model.isBlack = isBlack;
    model.colorF = colorF;
    model.colorH = 0;
    model.colorS = 0;
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

#pragma mark 我的
- (IBAction)MyCollectTarget:(UIButton *)sender {
    //打开响应的底部View
    ZZTMaterialLibraryView *view = [self MaterialLibraryViewWithStr:self.curType];
    view.isMe = YES;
    //打开我的收藏夹
    
    //收到数据
    //让2级显示最后一个
    //数据请求新的接口
}

-(void)obtainMyDataSourse{
    NSString *type = [[NSString alloc] init];
    if([self.curType isEqualToString:@"布局"]){
        type = @"1";
    }else if([self.curType isEqualToString:@"场景"]){
        type = @"2";
    }else if([self.curType isEqualToString:@"角色"]){
        type = @"3";
    }else if([self.curType isEqualToString:@"效果"]){
        type = @"4";
    }else if([self.curType isEqualToString:@"文字"]){
        type = @"5";
    }
    NSDictionary *parameter = @{
                                @"userId":@"1",
                                @"fodderType":type
                                };
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"fodder/getFodderCollectInfo"] parameters:parameter success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSMutableArray *array = [ZZTFodderListModel mj_objectArrayWithKeyValuesArray:dic];
        self.dataSource = array;
        self.materialLibraryView.dataSource = array;
    } failure:^(NSError *error) {
        
    }];
}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if ([touches anyObject].view != _materialLibraryView) {
//        // 判断点击的区域如果不是菜单按钮_btnMenu, 则关闭菜单
//        [_materialLibraryView removeFromSuperview];
//    }
//}
@end
