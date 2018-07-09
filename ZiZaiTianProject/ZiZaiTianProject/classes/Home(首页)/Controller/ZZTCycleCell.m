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
@interface ZZTCycleCell()<DCPicScrollViewDelegate,DCPicScrollViewDataSource>

@end

@implementation ZZTCycleCell



-(void)setIsTime:(BOOL)isTime{
    _isTime = isTime;
    if(isTime == YES){
        [self.ps.timer begin];
    }else{
        [self.ps.timer pause];
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
}

#pragma mark 无线轮播器代理方法
- (void)picScrollView:(DCPicScrollView *)picScrollView needUpdateItem:(DCPicItem *)item atIndex:(NSInteger)index {
    //数据
    NSString *md = [self.dataArray objectAtIndex:index];
    
    [item.imageView setImage:[UIImage imageNamed:md]];
    
//    [item.imageView sd_setImageWithURL:[NSURL URLWithString:md.pic] placeholderImage:[UIImage imageNamed:@"ic_new_comic_placeholder_s_355x149_"]];
}
//轮播点击事件
- (void)picScrollView:(DCPicScrollView *)picScrollView selectItem:(DCPicItem *)item atIndex:(NSInteger)index {
    
//    bannerModel *md = [self.bannerModelArray objectAtIndex:index];
//
//    CartoonDetailViewController *cdv = [[CartoonDetailViewController alloc] init];
//
//    cdv.cartoonId = [NSNumber numberWithInteger:md.value.integerValue];
//
//    [self.navigationController pushViewController:cdv animated:YES];
}
//显示多少轮播图
- (NSUInteger)numberOfItemsInPicScrollView:(DCPicScrollView *)picScrollView {
    return self.dataArray.count;
}

-(void)dealloc{
    NSLog(@"gun");
}

@end
