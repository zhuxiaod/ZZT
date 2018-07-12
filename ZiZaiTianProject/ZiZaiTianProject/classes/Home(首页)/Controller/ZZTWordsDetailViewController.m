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

@interface ZZTWordsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
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

@end
NSString *zztWordCell = @"WordCell";
NSString *NoCell = @"NoCell";

@implementation ZZTWordsDetailViewController
//目录
-(NSArray *)ctList{
    if (!_ctList) {
        _ctList = [NSArray array];
    }
    return _ctList;
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
    
    [self setup];

    //详情页上面的数据
    [self loadtopData];
    
    //目录数据
    [self loadListData];
    //设置页面
    [self setupWordsDetailContentView];
}

//初始化
-(void)setup{
    //默认是1
    self.btnIndex = 1;
    self.isDataCome = NO;
    self.view.backgroundColor = [UIColor redColor];
}
#pragma mark - 请求数据
-(void)loadListData{
    weakself(self);
    NSDictionary *paramDict = @{
                                @"cartoonId":@"1"
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
-(void)setIsDataCome:(BOOL)isDataCome{
    _isDataCome = isDataCome;
    if(isDataCome == YES){
        [self.contentView reloadData];
        self.isDataCome = NO;
    }
}
-(void)loadtopData{
    //加载用户信息
    weakself(self);
    NSDictionary *paramDict = @{
                                @"id":@"1"
                                };
    [AFNHttpTool POST:@"http://192.168.0.165:8888/cartoon/particulars" parameters:paramDict success:^(id responseObject) {
        NSString *data = responseObject[@"result"];
        NSDictionary *dic = [self decry:data];
        //这里有问题 应该是转成数组 然后把对象取出
        ZZTCarttonDetailModel *mode = [ZZTCarttonDetailModel mj_objectWithKeyValues:dic];
        weakSelf.ctDetail = mode;
        weakSelf.head.detailModel = mode;
        weakSelf.isDataCome = YES;
    } failure:^(NSError *error) {
        
    }];
    [self.contentView reloadData];
}
#pragma mark - 设置内容页面
- (void)setupWordsDetailContentView {
    //滚动还是要加的  - -
    UITableView *contenView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    contenView.backgroundColor = [UIColor redColor];
    contenView.contentInset = UIEdgeInsetsMake(wordsDetailHeadViewHeight,0,0,0);
    contenView.delegate = self;
    contenView.dataSource = self;
    contenView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contenView registerClass:[UITableViewCell class] forCellReuseIdentifier:NoCell];
    
    //拿接口 上数据
    _head = [[ZZTWordsDetailHeadView alloc] init];
    _head.frame = CGRectMake(0, 0, SCREEN_WIDTH, wordsDetailHeadViewHeight);
    
    //选择头
    ZZTWordsOptionsHeadView *headView = [[ZZTWordsOptionsHeadView alloc] init];
    [headView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, wordsOptionsHeadViewHeight)];
    
    weakself(self);
    //左边事件
    [headView setLeftBtnClick:^(ZZTOptionBtn *btn) {
        weakSelf.btnIndex = 1;
        [weakSelf.contentView layoutIfNeeded];
        [weakSelf.contentView setContentOffset:CGPointMake(0, -wordsDetailHeadViewHeight)];
        [self.contentView reloadData];
    }];
    //中间事件
    [headView setMidBtnClick:^(ZZTOptionBtn *btn) {
        weakSelf.btnIndex = 2;
        [self.contentView reloadData];
    }];
    //右边事件
    [headView setRightBtnClick:^(ZZTOptionBtn *btn) {
        weakSelf.btnIndex = 3;
        [self.contentView reloadData];
    }];
    //点击响应Ok  中间也搞好了  两边上数据
    //注册
    [contenView registerNib:[UINib nibWithNibName:@"ZZTWordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:zztWordCell];
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
        return 200;
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
    }
    ZZTWordCell *cell = [tableView dequeueReusableCellWithIdentifier:zztWordCell];
    if(self.ctList.count > 0){
        ZZTChapterlistModel *model = self.ctList[indexPath.row];
        cell.model = model;
    }
    return cell;
}
//设置头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //如果是介绍
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
    }if(self.btnIndex == 2){
        //数组
        return self.ctList.count;
    }else{
        return 2;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
        _descHeadView.backgroundColor = [UIColor yellowColor];
        weakself(self);
        
        [_descHeadView setNeedReloadHeight:^{
            
            [weakSelf.contentView reloadData];
            
        }];
        
    }
    return _descHeadView;
}
@end
