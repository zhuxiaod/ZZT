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
        _caiNiXiHuan = @[[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"],[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"],[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"],[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"],[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"],[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"]];
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
        _bannerModelArray = @[@"u=346672913,3176690417&fm=27&gp=0.jpg",@"u=2092279950,3036263238&fm=27&gp=0.jpg",@"u=3542609435,1624381455&fm=27&gp=0.jpg"];
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
    }
    return self;
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
    }if(indexPath.section == 1){
        ZZTCartoonBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:zCartoonBtnCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.str = @"朱晓俊";
        cell.array = self.btnArray;
        return cell;
    }if(indexPath.section == 2){
        //猜你喜欢
        //搞一个数据
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
    NSString *title = @"猜你喜欢";
    ZZTCartoonHeaderView *head = [[ZZTCartoonHeaderView alloc] init];
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
