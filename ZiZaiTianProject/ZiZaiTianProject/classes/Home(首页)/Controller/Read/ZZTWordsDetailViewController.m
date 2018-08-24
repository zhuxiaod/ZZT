//
//  ZZTWordsDetailViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWordsDetailViewController.h"
#import "ZZTWordsDetailHeadView.h"
#import "ZZTCarttonDetailModel.h"
#import "ZZTWordsDetailHeadView.h"
#import "ZZTWordsOptionsHeadView.h"
#import "ZZTWordCell.h"
#import "ZZTWordDescSectionHeadView.h"
#import "AFNHttpTool.h"
#import "ZZTChapterlistModel.h"
#import "ZZTCommentCell.h"
#import "ZZTCircleModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ZZTWordsOptionsBottomView.h"
#import "ZZTReaderViewController.h"

@interface ZZTWordsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,strong) EncryptionTools *encryptionManager;
@property (nonatomic,strong) NSString *getData;
@property (nonatomic,strong) ZZTCarttonDetailModel *ctDetail;
@property (nonatomic,weak)   UITableView *contentView;
@property (nonatomic,assign) NSInteger btnIndex;
@property (nonatomic,strong) ZZTWordsDetailHeadView *head;
@property (nonatomic,strong) ZZTWordDescSectionHeadView *descHeadView;
@property (nonatomic,strong) NSArray *ctList;

@property (nonatomic,assign) BOOL isDataCome;
@property (nonatomic,strong) NSArray *ctComment;
@end

NSString *zztWordCell = @"WordCell";
NSString *NoCell = @"NoCell";
NSString *zztComment = @"zztComment";

@implementation ZZTWordsDetailViewController
//目录
-(NSArray *)ctList{
    if (!_ctList) {
        _ctList = [NSArray array];
    }
    return _ctList;
}
-(NSArray *)ctComment{
    if (!_ctComment) {
        _ctComment = [NSArray array];
    }
    return _ctComment;
}
- (EncryptionTools *)encryptionManager{
    if(!_encryptionManager){
        _encryptionManager = [EncryptionTools sharedEncryptionTools];
    }
    return _encryptionManager;
}
//详情
-(ZZTCarttonDetailModel *)ctDetail{
    if (!_ctDetail) {
        _ctDetail = [[ZZTCarttonDetailModel alloc] init];
    }
    return _ctDetail;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rr_navHidden = YES;
    
    [self setup];

    //设置页面
    [self setupWordsDetailContentView];
    
    //设置底部View
    [self setupBottomView];
}

//初始化
-(void)setup{
    //默认是1
    self.btnIndex = 1;
    self.isDataCome = NO;
    self.view.backgroundColor = [UIColor redColor];
}
//获取漫画ID
-(void)setCartoonDetail:(ZZTCarttonDetailModel *)cartoonDetail{
    _cartoonDetail = cartoonDetail;
    if(cartoonDetail.id){
        //上部分View
        [self loadtopData:cartoonDetail.id];
        //目录
        [self loadListData:cartoonDetail.id];
        //评论
        [self loadCommentData:cartoonDetail.id];
    }
}
//请求该漫画的资料
-(void)loadtopData:(NSString *)ID{
    //加载用户信息
    weakself(self);
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *paramDict = @{
                                @"id":ID
                                };
    [AFNHttpTool POST:@"http://192.168.0.165:8888/cartoon/particulars" parameters:paramDict success:^(id responseObject) {
        NSDictionary *dic = [self decry:responseObject[@"result"]];
        //这里有问题 应该是转成数组 然后把对象取出
        ZZTCarttonDetailModel *mode = [ZZTCarttonDetailModel mj_objectWithKeyValues:dic];
        weakSelf.ctDetail = mode;
        weakSelf.head.detailModel = mode;
        weakSelf.isDataCome = YES;
//        [hud hideAnimated:YES];

    } failure:^(NSError *error) {
        //网络请求不会失败
//        hud.label.text = NSLocalizedString(@"链接失败", @"HUD message title");

    }];
    [self.contentView reloadData];
}

-(void)setupBottomView{
    ZZTWordsOptionsBottomView *headView = [[ZZTWordsOptionsBottomView alloc] init];
    [headView setFrame:CGRectMake(0, SCREEN_HEIGHT-wordsOptionsHeadViewHeight, SCREEN_WIDTH, wordsOptionsHeadViewHeight)];
    headView.titleArray = @[@"收藏",@"包月",@"开始阅读"];
    //收藏
    [headView setLeftBtnClick:^(UIButton *btn) {
    }];
    //包月
    [headView setMidBtnClick:^(UIButton *btn) {
    }];
    //开始阅读
    [headView setRightBtnClick:^(UIButton *btn) {
        ZZTReaderViewController *readerVC = [[ZZTReaderViewController alloc] init];
        readerVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:readerVC animated:YES];
    }];
    [self.view addSubview:headView];
}


#pragma mark - 请求数据
//目录
-(void)loadListData:(NSString *)ID{
    weakself(self);
    NSDictionary *paramDict = @{
                                @"cartoonId":ID
                                };
    [AFNHttpTool POST:@"http://192.168.0.165:8888/cartoon/getChapterlist" parameters:paramDict success:^(id responseObject) {
        NSString *data = responseObject[@"result"];
        NSDictionary *dic = [self decry:data];
        //这里有问题 应该是转成数组 然后把对象取出
        NSArray *array = [ZZTChapterlistModel mj_objectArrayWithKeyValuesArray:dic];
        weakSelf.ctList = array;
        weakSelf.isDataCome = YES;
    } failure:^(NSError *error) {
        
    }];
    [self.contentView reloadData];
}

//加载评论数据
-(void)loadCommentData:(NSString *)ID{
    weakself(self);
    NSDictionary *paramDict = @{
                                @"itemId":ID
                                };
    [AFNHttpTool POST:@"http://192.168.0.165:8888/circle/comment" parameters:paramDict success:^(id responseObject) {
        NSString *data = responseObject[@"result"];
        NSDictionary *dic = [self decry:data];
        //这里有问题 应该是转成数组 然后把对象取出
        NSArray *array1 = [ZZTCircleModel mj_objectArrayWithKeyValuesArray:dic];

        weakSelf.ctComment = array1;
        weakSelf.isDataCome = YES;
    } failure:^(NSError *error) {
        
    }];
    [self.contentView reloadData];
}
-(void)setIsDataCome:(BOOL)isDataCome{
    _isDataCome = isDataCome;
    if(isDataCome == YES){
        [self.contentView reloadData];
        self.isDataCome = NO;
    }
}

#pragma mark - 设置内容页面
- (void)setupWordsDetailContentView {
    UITableView *contenView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    contenView.backgroundColor = [UIColor colorWithHexString:@"#2B2B34"];
    contenView.contentInset = UIEdgeInsetsMake(wordsDetailHeadViewHeight,0,0,0);
    contenView.delegate = self;
    contenView.dataSource = self;
    contenView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contenView registerClass:[UITableViewCell class] forCellReuseIdentifier:NoCell];
    [contenView  setSeparatorColor:[UIColor blueColor]];
    //拿接口 上数据
    _head = [ZZTWordsDetailHeadView wordsDetailHeadViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, wordsDetailHeadViewHeight) scorllView:contenView];
    
    //选择头
    ZZTWordsOptionsHeadView *headView = [[ZZTWordsOptionsHeadView alloc] init];
    headView.titleArray = @[@"详情",@"目录",@"评价"];
    //初始化选择状态
    headView.isSelectStatus = YES;
    [headView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, wordsOptionsHeadViewHeight)];
    
    weakself(self);
    //左边事件
    [headView setLeftBtnClick:^(ZZTOptionBtn *btn) {
        weakSelf.btnIndex = 1;
        [weakSelf.contentView layoutIfNeeded];
        [weakSelf.contentView setContentOffset:CGPointMake(0, -wordsDetailHeadViewHeight)];
        [weakSelf.contentView reloadData];
    }];
    //中间事件
    [headView setMidBtnClick:^(ZZTOptionBtn *btn) {
        weakSelf.btnIndex = 2;
        [weakSelf.contentView reloadData];
    }];
    //右边事件
    [headView setRightBtnClick:^(ZZTOptionBtn *btn) {
        weakSelf.btnIndex = 3;
        [weakSelf.contentView reloadData];
    }];
    //点击响应Ok  中间也搞好了  两边上数据
    //注册
    [contenView registerNib:[UINib nibWithNibName:@"ZZTWordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:zztWordCell];
    [contenView registerNib:[UINib nibWithNibName:@"ZZTCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:zztComment];

    
    contenView.tableHeaderView = headView;
    [self.view addSubview:contenView];
    [self.view addSubview:_head];
    
    self.contentView = contenView;
}
#pragma mark 高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //根据点击的不同 判断应该有多少高度
    if (self.btnIndex == 1) {
        return 0;
    }else if(self.btnIndex == 2){
        return wordTableViewCellHeight;
    }else if(self.btnIndex == 3){
        return [self.contentView fd_heightForCellWithIdentifier:zztComment cacheByIndexPath:indexPath configuration:^(id cell) {
            ZZTCommentCell *CommentCell = (ZZTCommentCell *)cell;
            CommentCell.model = self.ctComment[indexPath.row];
            
        }];
    }else{
        return 0;
    }
}
//高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.btnIndex == 1) {
        //字符串
        self.descHeadView.desc = self.ctDetail.intro;
        
        return self.descHeadView.myHeight;
        
    }else {
        
        return 0;
    
    }
}

#pragma mark - 内容设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.btnIndex == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NoCell];
        return cell;
    }else if(self.btnIndex == 2){
        ZZTWordCell *cell = [tableView dequeueReusableCellWithIdentifier:zztWordCell];
        if(self.ctList.count > 0){
            ZZTChapterlistModel *model = self.ctList[indexPath.row];
            cell.model = model;
        }
        return cell;
    }
    else if (self.btnIndex == 3){
        ZZTCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:zztComment];
        if (self.ctComment.count > 0) {
            ZZTCircleModel *model = self.ctComment[indexPath.row];
            cell.model = model;
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NoCell];
        return cell;
    }
}
//设置头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //介绍
    self.descHeadView.desc = self.ctDetail.intro;
    return self.descHeadView;
}

#pragma mark - 设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.btnIndex == 1){
        return 1;
    }else if(self.btnIndex == 2){
        //数组
        return self.ctList.count;
    }else if(self.btnIndex == 3){
        return self.ctComment.count;
    }else{
        return 1;
    }
}

#pragma mark - 解密
-(NSDictionary *)decry:(NSString *)getData{
    //解密
    NSString *data = [self.encryptionManager decryptString:getData keyString:@"ZIZAITIAN@666666" iv:[@"A-16-Byte-String" dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return dic;
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

@end
