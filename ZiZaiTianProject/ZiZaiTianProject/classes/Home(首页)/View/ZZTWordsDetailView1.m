//
//  ZZTWordsDetailView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWordsDetailView1.h"

@implementation ZZTWordsDetailView1

+(ZZTWordsDetailView1 *)loadMyHeadViewFromXibWithFrame:(CGRect)frame
{
    ZZTWordsDetailView1 *view = (ZZTWordsDetailView1 *)[[NSBundle mainBundle] loadNibNamed:@"ZZTWordsDetailView1" owner:nil options:nil].firstObject;
    view.frame = frame;
    return view;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setDetailModel:(ZZTCarttonDetailModel *)detailModel
{
    _detailModel = detailModel;
    NSLog(@"%@",self.detailModel);
}

@end
