//
//  ZZTSignInView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTSignInView.h"
#import "ZZTSignButton.h"

@interface ZZTSignInView()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *eventView;
@property(nonatomic,strong) NSMutableArray *btns;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day1;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day2;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day3;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day4;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day5;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day6;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day7;
@property(nonatomic,assign) int i;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end
@implementation ZZTSignInView

-(NSMutableArray *)btns{
    if(!_btns){
        _btns = [NSMutableArray array];
    }
    return _btns;
}

+(instancetype)SignView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //设置背景页面的点击事件
    self.backgroundView.userInteractionEnabled = YES;

    //设置button
    [self.btns  addObject:_day1];
    [self.btns  addObject:_day2];
    [self.btns  addObject:_day3];
    [self.btns  addObject:_day4];
    [self.btns  addObject:_day5];
    [self.btns  addObject:_day6];
    [self.btns  addObject:_day7];
    for (NSInteger i = 0; i < 7; i++) {
        ZZTSignButton *btn = self.btns[i];
        btn.isGet = NO;
        btn.ifSign = NO;
        [btn setEnabled:NO];
        [btn setTag:i];
        [btn addTarget:self action:@selector(clickSignBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//算法  点击btn以后会有什么效果  传递什么数据
-(void)clickSignBtn:(ZZTSignButton *)btn{
    NSLog(@"我是button:%@",btn.titleLabel.text);
    [btn setIfSign:YES];
    if ([self.delegate respondsToSelector:@selector(signViewDidClickSignBtn:)]) {
        [self.delegate signViewDidClickSignBtn:btn];
    }
}

//btn状态
// 
-(void)isget:(NSInteger)signCount isSign:(NSInteger)isSign{
    //连续打卡
    //如果状态是1 那么连续打卡少一个  如果状态是0 就是正常的
    if(isSign == 1)
    {
        if(signCount == 0){
            signCount = 0;
        }else{
            signCount = signCount - 1;
        }
    }
    for (NSInteger i = 0;i < signCount;i++) {
        ZZTSignButton *btn = self.btns[i];
        btn.isGet = YES;
    }
    //判断当天是否打卡 1打y 0没n
    if (isSign == 1) {
        ZZTSignButton *btn = _btns[signCount];
        btn.ifSign = YES;
    }else{
        ZZTSignButton *btn = _btns[signCount];
        btn.ifSign = NO;
        [btn setEnabled:YES];
    }
    for (signCount = signCount + 1; signCount < 7; signCount++)
    {
        ZZTSignButton *btn = _btns[signCount];
        btn.isNo = YES;
    }
}
- (IBAction)clickBackground:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(signViewDidClickapGesture)]) {
        [self.delegate signViewDidClickapGesture];
    }
}

@end
