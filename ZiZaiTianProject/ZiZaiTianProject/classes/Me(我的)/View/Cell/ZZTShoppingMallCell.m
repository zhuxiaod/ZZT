//
//  ZZTShoppingMallCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTShoppingMallCell.h"
#import "ZZTShoppingBtnModel.h"

@interface ZZTShoppingMallCell()
@property (weak, nonatomic) IBOutlet UILabel *ticketNumber;
@property (weak, nonatomic) IBOutlet UILabel *BNumber;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end
@implementation ZZTShoppingMallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_ticketNumber setTextColor: [UIColor colorWithHexString:@"#58006E"]];
    _BNumber.backgroundColor = [UIColor colorWithHexString:@"#FB9321"];
    [_BNumber setTextColor:[UIColor whiteColor]];
}

-(void)setBtn:(ZZTShoppingBtnModel *)btn
{
    _btn = btn;
    self.ticketNumber.text = btn.ticketNumber;
    self.BNumber.text = btn.BNumber;
    self.cellImage.image = [UIImage imageNamed:btn.BtnImage];
}
@end
