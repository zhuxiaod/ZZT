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
#import "ZZTWordDetailViewController.h"

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
    if (topics.count > 0) {
        //数据对应模型
        [self.items enumerateObjectsUsingBlock:^(ZZTJiuGongGeView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //赋值
            obj.model = topics[idx];
        }];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //与父View大小相同
    self.contentView.frame = self.bounds;
    //最大创建的宽度   行数
    [ZZTJiuGongGeView jiuGongGeLayout:self.items WithMaxSize:self.contentView.bounds.size WithRow:2];
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
//触摸事件
- (void)tap:(UITapGestureRecognizer *)tap {
    
    NSInteger index = [[tap view] tag];
    NSLog(@"我感受到了你%ld",index);
    ZZTWordDetailViewController *detailVC = [[ZZTWordDetailViewController alloc]init];
    detailVC.cartoonDetail = self.topics[index];
    detailVC.hidesBottomBarWhenPushed = YES;
    [[self findResponderWithClass:[UINavigationController class]] pushViewController:detailVC animated:YES];
}
@end
