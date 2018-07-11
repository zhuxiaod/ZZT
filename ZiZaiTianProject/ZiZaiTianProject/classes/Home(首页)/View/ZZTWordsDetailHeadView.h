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
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *ctImage;
@property (weak, nonatomic) IBOutlet UILabel *ctName;
@property (weak, nonatomic) IBOutlet UILabel *ctTitle;
@property (weak, nonatomic) IBOutlet UILabel *clkNum;
@property (weak, nonatomic) IBOutlet UILabel *collect;
@property (weak, nonatomic) IBOutlet UILabel *participation;
@property (weak, nonatomic) IBOutlet UILabel *ctNum;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
+ (instancetype)wordsDetailHeadViewWithFrame:(CGRect)frame scorllView:(UIScrollView *)sc;
+ (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)sc;

@end
