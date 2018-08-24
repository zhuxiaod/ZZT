//
//  ZZTWordDetailViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWordDetailViewController.h"
#import "ZZTWordsDetailHeadView.h"
#import "ZZTWordDescSectionHeadView.h"
#import "ZZTWordListCell.h"
#import "ZZTChapterlistModel.h"
#import "ZZTCartoonDetailViewController.h"

@interface ZZTWordDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) ZZTWordsDetailHeadView *head;

@property (nonatomic,strong) ZZTWordDescSectionHeadView *descHeadView;

@property (nonatomic,strong) ZZTCarttonDetailModel *ctDetail;

@property (nonatomic,strong) UITableView *contentView;

@property (nonatomic,strong) NSArray *wordList;

@end

NSString *zztWordListCell = @"zztWordListCell";

@implementation ZZTWordDetailViewController

-(NSArray *)wordList{
    if(!_wordList){
        _wordList = [NSArray array];
    }
    return _wordList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rr_navHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    //设置顶部页面
    [self setupTopView];
    //设置底部View
    [self setupBottomView];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"]; if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self setStatusBarBackgroundColor:[UIColor colorWithHexString:@"#42428E"]];
    
}

//设置底部View
-(void)setupBottomView{
    UIView *bottom = [[UIView alloc] init];
    bottom.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    bottom.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottom];
    //页码
    UIButton *pageBtn = [[UIButton alloc] init];
    pageBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3*2, 50);
    pageBtn.backgroundColor = [UIColor colorWithHexString:@"#DBDCDD"];
    [pageBtn setTitle:@"1 - 12页" forState:UIControlStateNormal];
    [pageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bottom addSubview:pageBtn];
    //开始阅读
    UIButton *starRead = [[UIButton alloc] init];
    starRead.frame = CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 50);
    [starRead setTitle:@"开始阅读" forState:UIControlStateNormal];
    starRead.backgroundColor = [UIColor colorWithHexString:@"#7778B2"];
    [starRead addTarget:self action:@selector(starRead) forControlEvents:UIControlEventTouchUpInside];
    [starRead setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottom addSubview:starRead];
}

//开始阅读
-(void)starRead{
    ZZTCartoonDetailViewController *cartoonDetailVC = [[ZZTCartoonDetailViewController alloc] init];
    cartoonDetailVC.hidesBottomBarWhenPushed = YES;
    cartoonDetailVC.type = _cartoonDetail.type;
    cartoonDetailVC.cartoonId = self.cartoonDetail.id;
    cartoonDetailVC.viewTitle = _cartoonDetail.bookName;
    [self.navigationController pushViewController:cartoonDetailVC animated:YES];
    
    //判断是剧本还是漫画
    //是剧本的话 跳转剧本
    //漫画跳转漫画
    //type 1 是漫画 2是剧本
    //传过去  判断是什么情况  基本用的cell 和漫画不同就ok了
}

//设置数据
-(void)setCartoonDetail:(ZZTCarttonDetailModel *)cartoonDetail{
    _cartoonDetail = cartoonDetail;
    if(cartoonDetail.id){
        //上部分View
        [self loadtopData:cartoonDetail.id];
       //目录
        [self loadListData:cartoonDetail.id];
       //评论
//        [self loadCommentData:cartoonDetail.id];
    }
}

//请求该漫画的资料
-(void)loadtopData:(NSString *)ID{
    //加载用户信息
    weakself(self);
    NSDictionary *paramDict = @{
                                @"id":ID
                                };
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"cartoon/particulars"] parameters:paramDict success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        //这里有问题 应该是转成数组 然后把对象取出
        ZZTCarttonDetailModel *mode = [ZZTCarttonDetailModel mj_objectWithKeyValues:dic];
        weakSelf.ctDetail = mode;

        [self.contentView reloadData];
    } failure:^(NSError *error) {
        
    }];
    [self.contentView reloadData];
}

//目录
-(void)loadListData:(NSString *)ID{
    weakself(self);
    NSDictionary *paramDict = @{
                                @"cartoonId":ID
                                };
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"cartoon/getChapterlist"] parameters:paramDict success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        //这里有问题 应该是转成数组 然后把对象取出
        NSArray *array = [ZZTChapterlistModel mj_objectArrayWithKeyValuesArray:dic];
        self.wordList = array;
        [self.contentView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)setupTopView{
    UITableView *contenView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    contenView.backgroundColor = [UIColor whiteColor];
    contenView.contentInset = UIEdgeInsetsMake(wordsDetailHeadViewHeight,0,0,0);
    contenView.delegate = self;
    contenView.dataSource = self;
    contenView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentView = contenView;
    
    [contenView  setSeparatorColor:[UIColor blueColor]];
    
    ZZTWordsDetailHeadView *head = [ZZTWordsDetailHeadView wordsDetailHeadViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, wordsDetailHeadViewHeight) scorllView:contenView];
    self.head = head;
    //设置数据
    self.head.detailModel = self.cartoonDetail;
    //先让数据显示
    [contenView registerNib:[UINib nibWithNibName:@"ZZTWordListCell" bundle:nil] forCellReuseIdentifier:zztWordListCell];
    
    [self.view addSubview:contenView];
    [self.view addSubview:head];
}

#pragma mark - 设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wordList.count;
}

#pragma mark - 内容设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTWordListCell *cell = [tableView dequeueReusableCellWithIdentifier:zztWordListCell];
    ZZTChapterlistModel *model = self.wordList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

//高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //字符串
    self.descHeadView.desc = self.ctDetail.intro;
    return self.descHeadView.myHeight;
}

//设置头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //介绍
    self.descHeadView.desc = self.ctDetail.intro;
    return self.descHeadView;
}

#pragma mark - lazyLoad
- (ZZTWordDescSectionHeadView *)descHeadView {
    if (!_descHeadView) {
        
        _descHeadView = [[ZZTWordDescSectionHeadView alloc] initWithFrame:self.view.bounds];
        _descHeadView.backgroundColor = [UIColor clearColor];
        weakself(self);
        
        [_descHeadView setNeedReloadHeight:^{
            
            [weakSelf.contentView reloadData];
            
        }];
    }
    return _descHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

//详情
-(ZZTCarttonDetailModel *)ctDetail{
    if (!_ctDetail) {
        _ctDetail = [[ZZTCarttonDetailModel alloc] init];
    }
    return _ctDetail;
}
@end
