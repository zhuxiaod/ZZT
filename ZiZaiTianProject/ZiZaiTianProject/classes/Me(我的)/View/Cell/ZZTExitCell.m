//
//  ZZTExitCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/3.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTExitCell.h"
@interface ZZTExitCell ()

@property (weak, nonatomic) IBOutlet UIButton *exitBtn;

@end
@implementation ZZTExitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.exitBtn.layer.cornerRadius = 10.0f;

}

@end
