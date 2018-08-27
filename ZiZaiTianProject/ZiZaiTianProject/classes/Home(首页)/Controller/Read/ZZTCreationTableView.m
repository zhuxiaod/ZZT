//
//  ZZTCreationTableView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCreationTableView.h"
#import "ZZTCycleCell.h"
#import "ZZTCreationBtnCellTableViewCell.h"
#import "CaiNiXiHuanCell.h"
#import "ZZTCartoonHeaderView.h"
#import "ZZTCreationButtonView.h"
#import "ZZTBookType.h"
#import "ZZTCartonnPlayModel.h"
#import "ZZTCarttonDetailModel.h"

@interface ZZTCreationTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *bannerModelArray;

@property (nonatomic,strong) NSArray *caiNiXiHuan;

@end
//注意 重用了id  看会不会出问题
static NSString *zzTCycleCell = @"zzTCycleCell";
static NSString *zztCreationCell = @"zztCreationCell";
static NSString *caiNiXiHuan = @"caiNiXiHuan";

@implementation ZZTCreationTableView

#pragma mark - lazyLoad
-(NSArray *)caiNiXiHuan{
    if (!_caiNiXiHuan) {
        _caiNiXiHuan = [NSArray array];
    }
    return _caiNiXiHuan;
}

-(NSArray *)bannerModelArray{
    if(!_bannerModelArray){
        _bannerModelArray = [NSArray array];
    }
    return _bannerModelArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 200;
        self.showsVerticalScrollIndicator = NO;
        //注册cell
        [self registerClass:[ZZTCycleCell class]  forCellReuseIdentifier:zzTCycleCell];
        [self registerClass:[ZZTCreationButtonView class]  forCellReuseIdentifier:zztCreationCell];
        [self registerClass:[CaiNiXiHuanCell class]  forCellReuseIdentifier:caiNiXiHuan];
        //为您推荐数据
        [self loadWeiNingTuiJian];
        
        [self loadBannerData];
    }
    return self;
}

-(void)loadWeiNingTuiJian{
    
    NSDictionary *dic = @{
                          @"pageNum":@"0",
                          @"pageSize":@"6"
                          };
    NSString *api = [ZZTAPI stringByAppendingString:@"cartoon/getRecommendCartoon"];
    [AFNHttpTool POST:api parameters:dic success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSMutableArray *array = [ZZTCarttonDetailModel mj_objectArrayWithKeyValuesArray:dic];
        self.caiNiXiHuan = array;
        [self reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        ZZTCycleCell *cell = [tableView dequeueReusableCellWithIdentifier:zzTCycleCell];
        cell.dataArray = self.bannerModelArray;
        cell.isTime = YES;
        return cell;
    }else if(indexPath.section == 1) {
        //创建一个View 来管理这三个button是最好的
        ZZTCreationButtonView *cell = [tableView dequeueReusableCellWithIdentifier:zztCreationCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:caiNiXiHuan];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell performSelector:@selector(setTopics:) withObject:self.caiNiXiHuan];
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"朱晓俊";
        return cell;
    }
}
//返回每一行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (SCREEN_HEIGHT - navHeight + 20) * 0.4;
    }else if (indexPath.section == 1){
        return 120;
    }else{
        return 400;
    }
}

//添加headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *title = @"为您推荐";
    ZZTCartoonHeaderView *head = [[ZZTCartoonHeaderView alloc] init];
    head.title = title;
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return self.height * 0.04;
    }else{
        return 0;
    }
}

-(void)loadBannerData{
    weakself(self);
    [AFNHttpTool POST:@"http://120.79.178.191:8888/homepage/banner" parameters:nil success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSArray *array = [ZZTCarttonDetailModel mj_objectArrayWithKeyValuesArray:dic];
        weakSelf.bannerModelArray = array;
        [self reloadData];
    } failure:^(NSError *error) {
        
    }];
}
@end
