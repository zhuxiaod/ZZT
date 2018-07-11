//
//  ZZTSecondCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTSecondCell.h"
#import "ZZTSecondBtn.h"
#import "ZZTEasyBtnModel.h"

@interface ZZTSecondCell()

@property (weak, nonatomic) IBOutlet ZZTSecondBtn *cellBtn;

@end

@implementation ZZTSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];

}


//除非跳转界面是一样的 否则使用九宫格最好
-(void)setBtnMoedel:(ZZTEasyBtnModel *)btnMoedel{
    _btnMoedel = btnMoedel;
    [_cellBtn setTitle:btnMoedel.btnTitile forState:UIControlStateNormal];
    [_cellBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cellBtn setBackgroundColor:[UIColor colorWithHexString:btnMoedel.btnColor]];
}
@end
