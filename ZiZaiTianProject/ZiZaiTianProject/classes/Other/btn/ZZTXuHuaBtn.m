//
//  ZZTXuHuaBtn.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTXuHuaBtn.h"
@interface ZZTXuHuaBtn()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;

@end

@implementation ZZTXuHuaBtn
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [sup])
}
-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.headView setImage:[UIImage imageNamed:imageUrl]];
//    [self.headView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
//    [self.likeNum setText:self.loveNum];
}

-(void)setLoveNum:(NSString *)loveNum{
    _loveNum = loveNum;
    [self.likeNum setText:self.loveNum];
}

@end
