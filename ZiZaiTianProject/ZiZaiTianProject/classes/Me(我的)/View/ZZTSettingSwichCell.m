//
//  ZZTSettingSwichCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/3.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTSettingSwichCell.h"
#import "ZZTSettingModel.h"
@interface ZZTSettingSwichCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detall;

@end
@implementation ZZTSettingSwichCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setSettingModel:(ZZTSettingModel *)settingModel{
    _settingModel = settingModel;
    self.title.text = settingModel.modelTitle;
    self.detall.text = settingModel.modelDetail;
}

@end
