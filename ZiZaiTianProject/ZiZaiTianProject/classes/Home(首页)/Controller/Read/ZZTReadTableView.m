//
//  ZZTReadTableView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/9.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTReadTableView.h"
#import "DCPicScrollViewConfiguration.h"
#import "DCPicScrollView.h"
#import "ZZTCycleCell.h"
#import "ZZTCartoonBtnCell.h"
#import "ZZTEasyBtnModel.h"
#import "CaiNiXiHuanCell.h"
#import "ZZTCartoonHeaderView.h"
#import "ZZTWordsDetailViewController.h"
#import "ZZTCarttonDetailModel.h"
@interface ZZTReadTableView()<UITableViewDataSource,UITableViewDelegate,DCPicScrollViewDelegate,DCPicScrollViewDataSource>
@property (nonatomic,weak) DCPicScrollView *bannerView;

@property (nonatomic,copy) NSArray *bannerModelArray;

@property (nonatomic,strong) NSArray *btnArray;
@property (nonatomic,strong) NSArray *caiNiXiHuan;
@end
static NSString *zzTCycleCell = @"zzTCycleCell";
static NSString *zCartoonBtnCell = @"zCartoonBtnCell";
static NSString *caiNiXiHuan = @"caiNiXiHuan";

@implementation ZZTReadTableView
//靠传的数字来确定是什么数据源？
//猜你喜欢数据源
-(NSArray *)caiNiXiHuan{
    if (!_caiNiXiHuan) {
        _caiNiXiHuan = [NSArray array];
    }
    return _caiNiXiHuan;
}

-(NSArray *)btnArray{
    if(!_btnArray){
         _btnArray =@[[ZZTEasyBtnModel initWithTitle:@"众创" btnImage:@"Calculator"],[ZZTEasyBtnModel initWithTitle:@"接龙" btnImage:@"Camera"],[ZZTEasyBtnModel initWithTitle:@"排行" btnImage:@"Clock"],[ZZTEasyBtnModel initWithTitle:@"分类" btnImage:@"Cloud"]];
    }
    return _btnArray;
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
        //注册cell
        [self registerClass:[ZZTCycleCell class]  forCellReuseIdentifier:zzTCycleCell];
        [self registerClass:[ZZTCartoonBtnCell class]  forCellReuseIdentifier:zCartoonBtnCell];
        [self registerClass:[CaiNiXiHuanCell class]  forCellReuseIdentifier:caiNiXiHuan];
         self.showsVerticalScrollIndicator = NO;
        //为您推荐数据
        [self loadWeiNingTuiJian];
        //bannerData
        [self loadBannerData];
    }
    return self;
}

-(void)loadWeiNingTuiJian{
    
    NSDictionary *dic = @{
                          @"bookType":@"",
                          @"cartoonType":@"2",
                          @"pageNum":@"1",
                          @"pageSize":@"10"
                          };
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"cartoon/cartoonlist"] parameters:dic success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSMutableArray *array = [ZZTCarttonDetailModel mj_objectArrayWithKeyValuesArray:dic];
        self.caiNiXiHuan = array;
    } failure:^(NSError *error) {
        
    }];
}

-(void)loadBannerData{
    weakself(self);
    [AFNHttpTool POST:@"http://192.168.0.165:8888/homepage/banner" parameters:nil success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSArray *array = [ZZTCarttonDetailModel mj_objectArrayWithKeyValuesArray:dic];
        weakSelf.bannerModelArray = array;
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
        //轮播
        ZZTCycleCell *cell = [tableView dequeueReusableCellWithIdentifier:zzTCycleCell];
        cell.dataArray = self.bannerModelArray;
        cell.isTime = YES;
        return cell;
    }if(indexPath.section == 1){
        ZZTCartoonBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:zCartoonBtnCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.str = @"朱晓俊";
        cell.array = self.btnArray;
        return cell;
    }if(indexPath.section == 2){
        //猜你喜欢
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
        return 100;
    }else{
        return 400;
    }
}
//添加headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *title = @"为您推荐";
    ZZTCartoonHeaderView *head = [[ZZTCartoonHeaderView alloc] init];
    head.moreOnClick = ^{
        ZZTMoreViewController *moreVC = [[ZZTMoreViewController alloc] init];
        moreVC.hidesBottomBarWhenPushed = YES;
        [[self myViewController].navigationController pushViewController:moreVC animated:YES];
    };
    head.title = title;
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return self.height * 0.05;
    }else{
        return 0;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = self.height * 0.05;  // headerView的高度  向上偏移50   达到隐藏的效果
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
@end
