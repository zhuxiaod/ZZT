//
//  ZZTVIPMidView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTVIPMidView.h"

@interface ZZTVIPMidView()

@property (weak, nonatomic) IBOutlet UIButton *xuFeiBtn;
@property (weak, nonatomic) IBOutlet UIButton *oneMBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeMBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixMBtn;
@property (weak, nonatomic) IBOutlet UIButton *twelveMBtn;

@end

@implementation ZZTVIPMidView

+(instancetype)VIPMidView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (IBAction)btnClick:(UIButton *)sender {
    if(self.buttonAction){
        self.buttonAction(sender);
    }
}

@end
