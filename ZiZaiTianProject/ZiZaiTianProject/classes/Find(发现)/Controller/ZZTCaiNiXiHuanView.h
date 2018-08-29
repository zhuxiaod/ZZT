//
//  ZZTCaiNiXiHuanView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^restartBtnBlock) (UIButton *sender);

@interface ZZTCaiNiXiHuanView : UIView

@property (nonatomic,copy) restartBtnBlock buttonAction;

@property (weak, nonatomic) IBOutlet UIView *mainView;

+(instancetype)CaiNiXiHuanView;

@end
