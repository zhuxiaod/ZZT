//
//  ZZTAddLengthFooterView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTAddLengthFooterView.h"

@interface ZZTAddLengthFooterView()
@property (weak, nonatomic) IBOutlet UIButton *cellB;
@property (weak, nonatomic) IBOutlet UIButton *lengthB;


@end
@implementation ZZTAddLengthFooterView


-(void)awakeFromNib{
    [super awakeFromNib];
    [_cellB addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _addCellBtn = _cellB;

    [_lengthB addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _addLengthBtn = _lengthB;

}

-(void)btnClick:(UIButton *)btn{
    if(btn == _addCellBtn){
        if (self.addCellBtnClick) {
            self.addCellBtnClick(_addCellBtn);
        }
    }else if(btn == _addLengthBtn){
        if(self.addLengthBtnClick){
            self.addLengthBtnClick(_addLengthBtn);
        }
    }
}
@end
