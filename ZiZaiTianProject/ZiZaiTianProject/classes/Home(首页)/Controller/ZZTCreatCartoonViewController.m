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

@interface ZZTCreatCartoonViewController ()<MaterialLibraryViewDelegate,EditImageViewDelegate>
//舞台
@property (weak, nonatomic) IBOutlet ZZTImageEditView *imagEditView;

@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) ZZTMaterialLibraryView *materialLibraryView;

@property (nonatomic,strong) NSString *str;

@property (nonatomic,strong) NSMutableArray *editImageArray;

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,strong) EditImageView *currentView;

@property (nonatomic,assign) NSInteger tagID;

@property (nonatomic,strong) NSArray *array;
@end

@implementation ZZTCreatCartoonViewController

-(NSMutableArray *)editImageArray{
    if(!_editImageArray){
        _editImageArray = [NSMutableArray array];
    }
    return _editImageArray;
}

-(NSArray *)dataSource{
    if(!_dataSource){
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

-(NSArray *)array{
    if(!_array){
        _array = [NSArray array];
    }
    return _array;
}
#pragma mark - viewDidLoad
-(void)viewDidLoad {
    [super viewDidLoad];
    self.tagID = 0;
    
    self.rr_backActionDisAble = YES;
    self.rr_navHidden = YES;
    //注册移除image的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeEdit:) name:@"remove" object:NULL];
    
    self.view.userInteractionEnabled = YES;
    self.imagEditView.userInteractionEnabled = YES;
    
    //设置隐藏View
    [self setupTapView];
}

-(void)setModel:(ZZTCreationEntranceModel *)model{
    _model = model;
    NSLog(@"%@",model);
}

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
    for (EditImageView *imageView in _editImageArray) {
        imageView.hidden = YES;
    }
    [self.editImageArray removeAllObjects];
}

//提交
- (IBAction)commit:(id)sender {
}

//翻转
- (IBAction)spin:(id)sender {
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
        if(self.editImageArray[i] == self.currentView){
            index = i;
            break;
        }
    }
    return index;
}
//交换2个视图的层级位置 和 数据所在的位置
-(void)exchangeViewIndex:(NSInteger )index exchangeIndex:(NSInteger )exchangeIndex{
    if(self.editImageArray.count > 0){
        EditImageView *indexView = self.editImageArray[index];
        indexView.layer.zPosition = exchangeIndex;
        EditImageView *indexLowView = self.editImageArray[exchangeIndex];
        indexLowView.layer.zPosition = index;
        [self.editImageArray exchangeObjectAtIndex:index withObjectAtIndex:exchangeIndex];
    }
}

//前进
- (IBAction)advance:(id)sender {
}

//后退
- (IBAction)retreat:(id)sender {
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



//点击下面的图片 可以在View上显示一个 图片
#pragma mark ZZTMaterialLibraryViewDelegate
-(void)sendRequestWithStr:(NSString *)fodderType modelType:(NSString *)modelType modelSubtype:(NSString *)modelSubtype
{
    [self loadMaterialData:fodderType modelType:modelType modelSubtype:modelSubtype];
}

//选择素材 并将数据放入到舞台上
-(void)sendImageWithModel:(ZZTFodderListModel *)model{
    //如果想让外框和在图片的外面 ViewFrame 要和image Frame 相等 先知道image的size 根据size来创建imageView  这样才行
    EditImageView *imageView = [[EditImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.delagate = self;
    imageView.tag = self.tagID;
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.img] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//        imageView.frame = CGRectMake(0, 0, 100, 100);
    }];
    [_imagEditView addSubview:imageView];
    [self.editImageArray addObject:imageView];
    [self EditImageViewWithView:imageView];
    self.tagID++;
    //通过tag来知道是哪个
}

#pragma mark EditImageViewDelegate
-(void)EditImageViewWithView:(EditImageView *)view{
    for (EditImageView *imageView in self.editImageArray) {
        if(imageView == view){
            self.currentView = view;
        }else{
            [imageView hideEditBtn];
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
    EditImageView *editImgView = notify.object;
    [_editImageArray removeObject:editImgView];
}

//隐藏所有Btn的状态
- (void)hideAllBtn{
    for (EditImageView *editImgView in _editImageArray) {
        [editImgView hideEditBtn];
    }
}

//截图，获取到image(保存)
- (UIImage *)imageThumb{
    [self hideAllBtn];
    CGPoint point = [[self.imagEditView superview] convertPoint:self.imagEditView.frame.origin toView:self.imagEditView];
    CGRect rect = CGRectMake(point.x, point.y, self.imagEditView.frame.size.width, self.imagEditView.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    [self.imagEditView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

//设置隐藏View
-(void)setupTapView{
    UIView *TapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.imagEditView.width, self.imagEditView.height)];
    TapView.backgroundColor = [UIColor clearColor];
    [self.imagEditView addSubview:TapView];
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
//改变数组的位置
@end
