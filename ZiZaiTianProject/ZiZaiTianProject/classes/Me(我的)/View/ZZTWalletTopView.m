//
//  ZZTWalletTopView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWalletTopView.h"
@interface ZZTWalletTopView ()

@property (weak, nonatomic) IBOutlet UILabel *ZBNum;

@property (weak, nonatomic) IBOutlet UILabel *integralNum;

@end

@implementation ZZTWalletTopView

+(instancetype)WalletTopView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
@end
