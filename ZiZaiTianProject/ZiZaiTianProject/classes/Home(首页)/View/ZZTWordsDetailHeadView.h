//
//  ZZTWordsDetailHeadView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZTWordsDetailModel.h"
#import "ZZTCarttonDetailModel.h"
#define wordsDetailHeadViewHeight  300

@interface ZZTWordsDetailHeadView : UIView

@property (nonatomic,strong) ZZTCarttonDetailModel *detailModel;

+ (instancetype)wordsDetailHeadViewWithFrame:(CGRect)frame scorllView:(UIScrollView *)sc;




@end
