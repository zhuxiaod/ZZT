//
//  ZZTVIPTopView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTVIPTopView.h"
@interface ZZTVIPTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *userHead;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *headButton;
@property (weak, nonatomic) IBOutlet UILabel *topTitle;
@property (weak, nonatomic) IBOutlet UILabel *topContent;

@end

@implementation ZZTVIPTopView

+(instancetype)VIPTopView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    self.userHead.image = [UIImage imageNamed:@"peien"];
    self.userHead.layer.cornerRadius = self.userHead.frame.size.width/2;
    self.userHead.layer.masksToBounds=YES;//隐藏裁剪掉的部分
    self.userHead.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userHead.layer.borderWidth = 1.0f;
    self.userName.text = @"佩恩";
}
-(void)setUser:(ZZTUserShoppingModel *)user{
    _user = user;
    _topTitle.text = user.topTitle;
    _topContent.text = user.topContent;
}
@end
