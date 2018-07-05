//
//  ZZTMeCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMeCell.h"

@implementation ZZTMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.textColor = [UIColor darkGrayColor];
    }
    return self;
}


@end
