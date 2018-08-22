//
//  ZZTRankCell.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZTRankCell : UITableViewCell

@property (nonatomic,strong) ZZTCarttonDetailModel *dataModel;
@property (weak, nonatomic) IBOutlet UILabel *cartoonName;

@property (nonatomic,assign) NSInteger cellIndex;

@property (nonatomic,strong) NSString *currentIndex;

@property (nonatomic,assign) BOOL isHave;

@end
