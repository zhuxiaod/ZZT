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

@interface ZZTWordsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,strong) EncryptionTools *encryptionManager;
@property (nonatomic,strong) NSString *getData;
@property (nonatomic,strong) ZZTCarttonDetailModel *ctDetail;
@property (nonatomic,strong) ZZTWordsDetailHeadView *head;

@end

@implementation ZZTWordsDetailViewController
- (EncryptionTools *)encryptionManager{
    if(!_encryptionManager){
        _encryptionManager = [EncryptionTools sharedEncryptionTools];
    }
    return _encryptionManager;
}
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
-(ZZTCarttonDetailModel *)ctDetail{
    if (!_ctDetail) {
        _ctDetail = [[ZZTCarttonDetailModel alloc] init];
    }
    return _ctDetail;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //加载用户信息
    [self loadUserData];

    
}



- (void)setupWordsDetailContentView {
    
    UITableView *contenView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    contenView.backgroundColor = [UIColor whiteColor];
    contenView.contentInset = UIEdgeInsetsMake(wordsDetailHeadViewHeight,0,0,0);
    contenView.delegate = self;
    contenView.dataSource = self;
    contenView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contenView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"wordAuthorCell"];
    //头
    //拿接口 上数据
    ZZTWordsDetailHeadView *head = [[ZZTWordsDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, wordsDetailHeadViewHeight)];
    head.ctName.text = _ctDetail.bookName;
    head.clkNum.text = [NSString stringWithFormat:@"%ld",(long)_ctDetail.clickNum];
    head.collect.text = [NSString stringWithFormat:@"%ld",_ctDetail.collectNum];
    [head.ctImage sd_setImageWithURL:[NSURL URLWithString:_ctDetail.cover] placeholderImage:[UIImage imageNamed:@"peien"]];
    head.participation.text = [NSString stringWithFormat:@"%ld",_ctDetail.praiseNum];
//    head.detailModel = _ctDetail;
    self.head = head;
    //选择头
    //注册
    
    
//    [self.view addSubview:contenView];
    [self.view addSubview:head];
}
///设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wordAuthorCell"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)loadUserData{
    NSDictionary *paramDict = @{
                                @"id":@"1"
                                };
    [self.manager POST:@"http://192.168.0.165:8888/cartoon/particulars" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.getData = responseObject[@"result"];
        
        [self decry];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)decry{
    //解密
    NSString *data = [self.encryptionManager decryptString:self.getData keyString:@"ZIZAITIAN@666666" iv:[@"A-16-Byte-String" dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    //这里有问题 应该是转成数组 然后把对象取出
    ZZTCarttonDetailModel *mode = [ZZTCarttonDetailModel mj_objectWithKeyValues:dic];
    _ctDetail = mode;
//    NSMutableArray *arr = [NSMutableArray array];
//    [arr addObject:mode.bookType];
//    ZZTCarttonDetailModel *model = [ZZTCarttonDetailModel mj_objectWithKeyValues:dic];
//    _ctDetail = model;
    [self setupWordsDetailContentView];
//    self.head.detailModel = model;
    NSLog(@"%@",self.ctDetail.bookName);
}
@end
