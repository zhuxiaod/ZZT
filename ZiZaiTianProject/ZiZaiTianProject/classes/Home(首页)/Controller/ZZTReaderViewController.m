//
//  ZZTReaderViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTReaderViewController.h"
#import "ZZTCartoonDetailView.h"
#import "ZZTCartoonModel.h"
#import "UIView+Extension.h"
#import "ZZTStoryDetailView.h"

@interface ZZTReaderViewController ()<UINavigationControllerDelegate,UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *mainView;

@property (nonatomic,strong) ZZTStoryDetailView *mainCartoonDetail;
@property (nonatomic,strong) ZZTCartoonDetailView *secondCartoonDetail;
@property (nonatomic,strong) ZZTCartoonDetailView *playDetail;
@property (nonatomic,strong) NSArray *cartoonDetail;
@property (nonatomic,strong) UIButton *button;
@end

@implementation ZZTReaderViewController

-(NSArray *)cartoonDetail{
    if (!_cartoonDetail) {
        _cartoonDetail = [NSArray array];
    }
    return _cartoonDetail;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    //设置主视图
    [self setupMainView];
    //设置子页
    [self setupChildView];
    
    [self loadData];
}

#pragma mark - 设置主视图
- (void)setupMainView {
    
    UIScrollView *mainView = [[UIScrollView alloc] init];
    //1.是否有弹簧效果
    mainView.bounces = NO;
    //整页平移是否开启
    mainView.pagingEnabled = YES;
    //显示水平滚动条
    mainView.showsHorizontalScrollIndicator = NO;
    //显示垂直滚动条
    mainView.showsVerticalScrollIndicator = NO;
    
    mainView.delegate = self;
    
    [self.view addSubview:mainView];
    
    self.mainView = mainView;
}


#pragma mark - 设置添加滚动子页
-(void)setupChildView{
    //btn 的数据模型
      
    //故事详情页
    ZZTStoryDetailView *cartoonDetailView = [[ZZTStoryDetailView alloc] init];
    cartoonDetailView.backgroundColor = [UIColor whiteColor];
    self.mainCartoonDetail = cartoonDetailView;
    [self.mainView addSubview:cartoonDetailView];
    
    //漫画页
    ZZTCartoonDetailView *secondCartoonDetail = [[ZZTCartoonDetailView alloc] init];
    secondCartoonDetail.backgroundColor = [UIColor whiteColor];
    self.secondCartoonDetail = secondCartoonDetail;
    [self.mainView addSubview:secondCartoonDetail];
    
    //收藏页
    ZZTCartoonDetailView *collectVC = [[ZZTCartoonDetailView alloc] init];
    collectVC.backgroundColor = [UIColor whiteColor];
    self.playDetail = collectVC;
    [self.mainView addSubview:collectVC];
    
    //添加返回按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button = button;
    [self.button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)back:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 设置滚动视图
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat height = self.view.height;
    CGFloat width  = self.view.width;
    
    //主页的位置
    [self.mainView setFrame:CGRectMake(0,0,width,height)];
    self.mainView.contentSize  = CGSizeMake(width * 3, 0);
    
    //提前加载
    [_mainCartoonDetail setFrame:CGRectMake(0, 0, width, height)];
    [_secondCartoonDetail setFrame:CGRectMake(width, 0, width, height)];
    [_playDetail setFrame:CGRectMake(width * 2, 0, width, height)];
    [self.mainView setContentOffset:CGPointMake(width, 0)];
    //添加返回按钮
    [self.button setFrame:CGRectMake(10, 30, 30, 30)];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)loadData{
    weakself(self);
    NSDictionary *paramDict = @{
                                @"id":@"1"
                                };
    [AFNHttpTool POST:@"http://192.168.0.165:8888/cartoon/cartoonImg" parameters:paramDict success:^(id responseObject) {
        NSString *data = responseObject[@"result"];
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:data];
        NSArray *array = [ZZTCartoonModel mj_objectArrayWithKeyValuesArray:dic];
        weakSelf.cartoonDetail = array;
        weakSelf.secondCartoonDetail.cartoonDetail = array;
        [weakSelf.secondCartoonDetail reloadData];
    } failure:^(NSError *error) {
        
    }];
}

@end
