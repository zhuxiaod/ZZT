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
        _caiNiXiHuan = @[[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"],[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"],[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"],[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"],[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"],[ZZTCartonnPlayModel initPlayWithImage:@"chutian" labelName:@"大女神啊啊啊" title:@"热血"]];
    }
    return _caiNiXiHuan;
}

-(NSArray *)bannerModelArray{
    if(!_bannerModelArray){
        _bannerModelArray = @[@"u=3328170055,3037785353&fm=27&gp=0.jpg",@"u=4070996148,1781906905&fm=27&gp=0.jpg",@"u=4213799443,3151115557&fm=27&gp=0.jpg"];
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
        [self registerClass:[ZZTCreationBtnCellTableViewCell class]  forCellReuseIdentifier:zztCreationCell];
        [self registerClass:[CaiNiXiHuanCell class]  forCellReuseIdentifier:caiNiXiHuan];
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
    }else if(indexPath.section == 1) {
        ZZTCreationBtnCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zztCreationCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.str = @"朱晓俊";
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
@end
