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

@interface ZZTWordsDetailHeadView : UIView

@property (nonatomic,strong) ZZTCarttonDetailModel *detailModel;


- (void)setctName:(NSString *)setCtname;

//+ (instancetype)creatHeadView;

//+ (instancetype)wordsDetailHeadViewWithFrame:(CGRect)frame scorllView:(UIScrollView *)sc;
//+ (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)sc;

@end
