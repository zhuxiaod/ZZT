//
//  ZZTCycleCell.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/9.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DCPicScrollView;
@protocol ZZTCycleCellDelegate <NSObject>

- (void)bannerTime:(DCPicScrollView *)view;

@end
@interface ZZTCycleCell : UITableViewCell

@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic, weak) id<ZZTCycleCellDelegate> delegate;

@property (nonatomic,assign) BOOL isTime;

@property(nonatomic,strong)DCPicScrollView *ps;

@end
