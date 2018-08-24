//
//  ZZTContinueToDrawHeadView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTContinueToDrawHeadView.h"
#import "ZZTXuHuaBtn.h"
#import "ZZTCartoonModel.h"
@interface ZZTContinueToDrawHeadView ()

@property (weak, nonatomic) IBOutlet UIButton *XuHuaBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *xuHuaView;


@end

@implementation ZZTContinueToDrawHeadView



+(instancetype)ContinueToDrawHeadView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZZTContinueToDrawHeadView" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.XuHuaBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.XuHuaBtn.layer.borderWidth = 2.0f;
    self.scrollView.backgroundColor = [UIColor yellowColor];
}

-(void)setArray:(NSArray *)array{
    _array = array;

    CGFloat titleW = 50;
    CGFloat titleH = 50;
    CGFloat space = 50;
    self.scrollView.contentSize = CGSizeMake(600, titleH);
    NSLog(@"scrollView frame:%@",NSStringFromCGRect(self.scrollView.frame));
    for (int i = 0; i < 2; i++) {
        //数据源
//        ZZTCartoonModel *model = self.array[i];
        CGFloat x = (titleW + space) * i;
        ZZTXuHuaBtn *btn = [[ZZTXuHuaBtn alloc] initWithFrame:CGRectMake(x, 0, titleW, titleH)];
        btn.imageUrl = @"peien";
        btn.loveNum = @"400";
        
//        btn.frame = ;
        [self.scrollView addSubview:btn];
    }
}

@end
