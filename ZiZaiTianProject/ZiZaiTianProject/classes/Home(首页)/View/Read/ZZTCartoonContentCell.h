//
//  ZZTCartoonContentCell.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/16.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZTCartoonModel;
@interface ZZTCartoonContentCell : UITableViewCell

@property (nonatomic,strong,readonly) UIImageView *content;

@property (nonatomic,strong) ZZTCartoonModel *model;

@end
