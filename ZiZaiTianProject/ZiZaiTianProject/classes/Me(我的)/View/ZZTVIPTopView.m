//
//  ZZTVIPTopView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTVIPTopView.h"
@interface ZZTVIPTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *VIPImage;

@property (weak, nonatomic) IBOutlet UILabel *VIPTiTle;
@property (weak, nonatomic) IBOutlet UILabel *VIPDate;

@end

@implementation ZZTVIPTopView

+(instancetype)VIPTopView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setUser:(ZZTUserShoppingModel *)user{
    _user = user;

}
@end
