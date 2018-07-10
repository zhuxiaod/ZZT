//
//  ZZTFirstViewBtn.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTFirstViewBtn.h"
#import "ZXDCartoonFlexoBtn.h"
#import "ZZTEasyBtnModel.h"
@interface ZZTFirstViewBtn()
@property (weak, nonatomic) IBOutlet ZXDCartoonFlexoBtn *button;

@end

@implementation ZZTFirstViewBtn

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setBtnModel:(ZZTEasyBtnModel *)btnModel{
    _btnModel = btnModel;
    [self.button setTitle:btnModel.btnTitile forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:btnModel.btnImage] forState:UIControlStateNormal];
}
@end
