//
//  ZZTMyCircleCellCollectionViewCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMyCircleCellCollectionViewCell.h"
@interface ZZTMyCircleCellCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *userName;
@property (weak, nonatomic) IBOutlet UILabel *userTitile;
@property (weak, nonatomic) IBOutlet UILabel *userDetail;
@property (weak, nonatomic) IBOutlet UILabel *postNumber;

@end

@implementation ZZTMyCircleCellCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userName.layer.borderWidth = 1.0;
    self.userName.layer.borderColor = [UIColor blackColor].CGColor;
}

@end
