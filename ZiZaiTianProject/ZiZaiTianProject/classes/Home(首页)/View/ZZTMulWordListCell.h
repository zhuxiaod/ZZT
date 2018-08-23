//
//  ZZTMulWordListCell.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZTChapterlistModel;

@interface ZZTMulWordListCell : UITableViewCell

@property (nonatomic,strong) ZZTChapterlistModel *model;

@property (nonatomic,strong) NSString *string;

+(instancetype)mulWordListCellWith:(UITableView *)tableView NSString:(NSString *)string;

@end
