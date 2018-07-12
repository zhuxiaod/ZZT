//
//  ZZTWordsDetailView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZTCarttonDetailModel.h"

@interface ZZTWordsDetailView1 : UIView

//@property (weak, nonatomic) IBOutlet UIButton *backBtn;
//@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
//@property (weak, nonatomic) IBOutlet UIImageView *ctImage;
@property (weak, nonatomic) IBOutlet UILabel *ctName;
//@property (weak, nonatomic) IBOutlet UILabel *ctTitle;
//@property (weak, nonatomic) IBOutlet UILabel *clkNum;
//@property (weak, nonatomic) IBOutlet UILabel *collect;
//@property (weak, nonatomic) IBOutlet UILabel *participation;
//@property (weak, nonatomic) IBOutlet UILabel *ctNum;
//@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (nonatomic,strong) ZZTCarttonDetailModel *detailModel;

+ (ZZTWordsDetailView1 *)loadMyHeadViewFromXibWithFrame:(CGRect)frame;

@end
