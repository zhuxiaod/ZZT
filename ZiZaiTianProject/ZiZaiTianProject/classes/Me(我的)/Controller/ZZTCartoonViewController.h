//
//  ZZTCartoonViewController.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZTUserModel;

@interface ZZTCartoonViewController : BaseViewController

@property(nonatomic,strong)ZZTUserModel *user;

@property(nonatomic,strong)NSString *viewTitle;

@property(nonatomic,strong)NSString *viewType;

@end
