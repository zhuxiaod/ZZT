//
//  ZZTMaterialCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMaterialCell.h"
@interface ZZTMaterialCell ()
@property (weak, nonatomic) IBOutlet UIImageView *materialImage;
@property (weak, nonatomic) IBOutlet UILabel *materialTitle;
@property (weak, nonatomic) IBOutlet UILabel *materialPrice;

@end

@implementation ZZTMaterialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_materialTitle setTextColor: [UIColor colorWithHexString:@"#58006E"]];
    _materialPrice.backgroundColor = [UIColor colorWithHexString:@"#FB9321"];
    [_materialPrice setTextColor:[UIColor whiteColor]];
}

@end
