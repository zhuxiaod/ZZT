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

@interface ZZTReadTableView()<UITableViewDataSource,UITableViewDelegate,DCPicScrollViewDelegate,DCPicScrollViewDataSource>
@property (nonatomic,weak) DCPicScrollView *bannerView;

@property (nonatomic,copy) NSArray *bannerModelArray;

@end
static NSString *zzTCycleCell = @"zzTCycleCell";

@implementation ZZTReadTableView

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
        //上拉
        //下拉
        //加载头
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
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"朱晓俊";
    if (indexPath.section == 0) {
        
        ZZTCycleCell *cell = [tableView dequeueReusableCellWithIdentifier:zzTCycleCell];
        cell.dataArray = self.bannerModelArray;
        cell.height = self.viewHeight;
        return cell;
    }
    return cell;
}

//返回每一行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (SCREEN_HEIGHT - navHeight + 20)*0.4;
    }else{
        return 100;
    }
}
@end
