//
//  ZZTCycleCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/9.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCycleCell.h"
#import "DCPicScrollViewConfiguration.h"
#import "DCPicScrollView.h"
#import "ZZTCartoonBtnCell.h"

@interface ZZTCycleCell()<DCPicScrollViewDelegate,DCPicScrollViewDataSource>

@end

@implementation ZZTCycleCell



-(void)setIsTime:(BOOL)isTime{
    _isTime = isTime;
    if(isTime == YES){
        [self.ps.timer begin];
    }
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self setupPicScrollView];
}

#pragma mark 设置无线轮播器
- (void)setupPicScrollView {
    //轮播器模型
    DCPicScrollViewConfiguration *pcv = [DCPicScrollViewConfiguration defaultConfiguration];
    //居中
    pcv.pageAlignment = PageContolAlignmentCenter;
    pcv.itemConfiguration.contentMode =  UIViewContentModeScaleToFill;
    //创建轮播器
    _ps = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - navHeight +20)*0.4) withConfiguration:pcv withDataSource:self];
    
    _ps.delegate = self;
    _ps.dataSource = self;
    [self addSubview:_ps];
    //暂停
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pause:)name:@"tongzhi" object:nil];
}

-(void)pause:(NSNotification *)dic{
    [self.ps.timer pause];
}

#pragma mark 无线轮播器代理方法
- (void)picScrollView:(DCPicScrollView *)picScrollView needUpdateItem:(DCPicItem *)item atIndex:(NSInteger)index {
    //数据
    ZZTCarttonDetailModel *md = [self.dataArray objectAtIndex:index];
    
    [item.imageView sd_setImageWithURL:[NSURL URLWithString:md.cover] placeholderImage:[UIImage imageNamed:@"peien"]];
}
//轮播点击事件
- (void)picScrollView:(DCPicScrollView *)picScrollView selectItem:(DCPicItem *)item atIndex:(NSInteger)index {
    ZZTCarttonDetailModel *md = [self.dataArray objectAtIndex:index];
    ZZTWordsDetailViewController *wdVC = [[ZZTWordsDetailViewController alloc] init];
    wdVC.cartoonDetail = md;
    wdVC.hidesBottomBarWhenPushed = YES;
    [[self myViewController].navigationController pushViewController:wdVC animated:YES];
}
//显示多少轮播图
- (NSUInteger)numberOfItemsInPicScrollView:(DCPicScrollView *)picScrollView {
    return self.dataArray.count;
}

-(void)dealloc{
    NSLog(@"gun");
}

@end
