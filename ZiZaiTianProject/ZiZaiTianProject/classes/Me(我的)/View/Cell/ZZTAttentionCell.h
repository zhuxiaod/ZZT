//
//  ZZTAttentionCell.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZTCartonnPlayModel;
@class ZZTAttentionCell;

typedef void (^AttentionCancelBlock) (ZZTAttentionCell *cell);

@interface ZZTAttentionCell : UICollectionViewCell

@property (nonatomic,strong)ZZTUserModel *attemtion;

@property(nonatomic, copy) AttentionCancelBlock attentionCancelBlock;

@end
