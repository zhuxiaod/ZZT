//
//  ZZTWalletCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWalletCell.h"
#import "ZZTRoundRectButton.h"

@interface ZZTWalletCell ()

@property (weak, nonatomic) IBOutlet UILabel *ZZTBiType;
@property (weak, nonatomic) IBOutlet UILabel *ZZTBiContent;
@property (weak, nonatomic) IBOutlet ZZTRoundRectButton *btnTitle;

@end
@implementation ZZTWalletCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setFreeBiModel:(ZZTFreeBiModel *)freeBiModel{
    _freeBiModel = freeBiModel;
    self.ZZTBiType.text = freeBiModel.ZZTBtype;
    self.ZZTBiContent.text = freeBiModel.ZZTBSpend;
    [self.btnTitle setTitle:freeBiModel.btnType forState:UIControlStateNormal];
}

@end
