//
//  CaiNiXiHuanCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "CaiNiXiHuanCell.h"
#import "ZZTJiuGongGeView.h"
#import "ZZTCartonnPlayModel.h"
#import "ZZTWordsDetailViewController.h"
static NSUInteger itemCount = 6;

@interface CaiNiXiHuanCell ()

@property (nonatomic,copy) NSArray<ZZTJiuGongGeView *> *items;

//1.去创建一个uiVIEW  也就是一个九宫格的View

@end

@implementation CaiNiXiHuanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//设置数据
- (void)setTopics:(NSArray *)topics {
    _topics = topics;
    //数组数据给单个数据
    [self.items enumerateObjectsUsingBlock:^(ZZTJiuGongGeView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //没有数据  所以先空
        obj.model = topics[idx];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //调实例方法  确定宽度 数量 行数
    self.contentView.frame = self.bounds;
    [ZZTJiuGongGeView jiuGongGeLayout:self.items WithMaxSize:self.contentView.bounds.size WithRow:2];
}
//触摸事件
- (void)tap:(UITapGestureRecognizer *)tap {
    
    NSInteger index = [[tap view] tag];
    NSLog(@"我感受到了你%ld",index);
    ZZTWordsDetailViewController *detailVC = [[ZZTWordsDetailViewController alloc]init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [[self findResponderWithClass:[UINavigationController class]] pushViewController:detailVC animated:YES];
//    ZZTCartonnPlayModel *md = [self.topics objectAtIndex:index];
    
   //设置跳转页面
    
//    [[self findResponderWithClass:[UINavigationController class]] pushViewController:wdvc animated:YES];
    
}
//懒加载
- (NSArray *)items {
    if (!_items) {
        
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:itemCount];
        
        for (NSInteger index = 0; index < itemCount; index++) {
            ZZTJiuGongGeView *view = [ZZTJiuGongGeView new];
            view.tag = index;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [view addGestureRecognizer:tap];
            [self.contentView addSubview:view];
            [arr addObject:view];
        }
        
        _items = arr;
    }
    return _items;
}
@end
