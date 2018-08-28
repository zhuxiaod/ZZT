//
//  ZZTAttentionCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTAttentionCell.h"
#import "ZZTCartonnPlayModel.h"

@interface ZZTAttentionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userIntro;
@property (weak, nonatomic) IBOutlet UIButton *VIPBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@end

@implementation ZZTAttentionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.VIPBtn.layer.cornerRadius = 5.0f;
    self.attentionBtn.layer.cornerRadius = 10.0f;
    
}

-(void)setAttemtion:(ZZTUserModel *)attemtion{
    _attemtion = attemtion;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:attemtion.headimg]];
    [self.userName setText:attemtion.nickName];
    [self.userIntro setText:attemtion.intro];
    if([attemtion.userType isEqualToString:@"1"]){
        _VIPBtn.hidden = YES;
    }
    
    [self.attentionBtn addTarget:self action:@selector(addToShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addToShoppingCart:(UIButton *)sender {
    if (self.attentionCancelBlock) {
        self.attentionCancelBlock(self);
    }
}
@end
