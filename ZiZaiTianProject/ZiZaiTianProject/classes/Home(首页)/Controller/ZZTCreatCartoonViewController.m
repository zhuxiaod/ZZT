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
@interface ZZTCreatCartoonViewController ()
//舞台
@property (weak, nonatomic) IBOutlet UIView *stageView;

@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) ZZTMaterialLibraryView *materialLibraryView;
@end

@implementation ZZTCreatCartoonViewController

-(NSArray *)dataSource{
    if(!_dataSource){
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.rr_navHidden = YES;
}

-(void)setModel:(ZZTCreationEntranceModel *)model{
    _model = model;
    NSLog(@"%@",model);
}

//返回
- (IBAction)back:(UIBarButtonItem *)sender {
}

//保存
- (IBAction)save:(UIBarButtonItem *)sender {
}

//上一页
- (IBAction)previousPage:(id)sender {
}

//下一页
- (IBAction)nextPage:(id)sender {
}

//清空
- (IBAction)empty:(id)sender {
}

//提交
- (IBAction)commit:(id)sender {
}

//旋转
- (IBAction)spin:(id)sender {
}

//上一层
- (IBAction)upLevel:(id)sender {
}

//下一层
- (IBAction)downLevel:(id)sender {
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

//布局
- (IBAction)Layout:(id)sender {
    //生成一个View
    //View分成三部分
    //第一步部分  九宫格
    //第二部分    九宫格
    //第三部分    collectionView
    //减去上下头 的三分之一
    CGFloat viewHeight = (SCREEN_HEIGHT - 88)/3;
    CGFloat y = (SCREEN_HEIGHT - 44) - viewHeight;
    _materialLibraryView = [[ZZTMaterialLibraryView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, viewHeight)];
    _materialLibraryView.backgroundColor = [UIColor whiteColor];
    [self loadMaterialData:@"1" modelType:@"1" modelSubtype:@"1"];
    _materialLibraryView.dataSource = self.dataSource;
    [self.view addSubview:_materialLibraryView];
    //在VC里面把数据请求好  监听事件  切换数据 刷新就行了
}

-(void)loadMaterialData:(NSString *)fodderType modelType:(NSString *)modelType modelSubtype:(NSString *)modelSubtype{
    NSDictionary *parameter = @{
                                @"fodderType":fodderType,
                                @"modelType":modelType,
                                @"modelSubtype":modelSubtype
                                };
    weakself(self);
    [AFNHttpTool POST:@"http://192.168.0.165:8888/fodder/fodderList" parameters:parameter success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSMutableArray *array = [ZZTFodderListModel mj_objectArrayWithKeyValuesArray:dic];
        weakSelf.dataSource = array;
        weakSelf.materialLibraryView.dataSource = array;
    } failure:^(NSError *error) {
        
    }];
}

//场景
- (IBAction)scene:(id)sender {
}
//角色
- (IBAction)role:(id)sender {
}
//效果
- (IBAction)specialEffects:(id)sender {
}
//文字
- (IBAction)textView:(id)sender {
}

@end
