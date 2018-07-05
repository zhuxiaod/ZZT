//
//  ZZTSignButton.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZTSignButton : UIButton

//连续打卡
@property (nonatomic,assign) BOOL isGet;
//当天是否打卡
@property (nonatomic,assign) BOOL ifSign;
//后面都没打卡
@property (nonatomic,assign) BOOL isNo;
@end
