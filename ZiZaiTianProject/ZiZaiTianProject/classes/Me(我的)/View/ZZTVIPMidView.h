//
//  ZZTVIPMidView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^topUpBtnBlock) (UIButton *sender);

@interface ZZTVIPMidView : UIView

@property (nonatomic,copy) topUpBtnBlock buttonAction;


+(instancetype)VIPMidView;

@end
