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


@end

@implementation ZZTContinueToDrawHeadView

+(instancetype)ContinueToDrawHeadView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZZTContinueToDrawHeadView" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.XuHuaBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.XuHuaBtn.layer.borderWidth = 2.0f;
}

-(void)setArray:(NSArray *)array{
    _array = array;

    CGFloat titleW = 80;
    CGFloat titleH = 105;
    CGFloat space = 10;
    
    for (int i = 0; i < array.count; i++) {
        ZZTCartoonModel *model = self.array[i];
        
        ZZTXuHuaBtn *btn = [[ZZTXuHuaBtn alloc] init];
        btn.imageUrl = @"peien";
        btn.loveNum = @"400";
        CGFloat x = (titleW + space) * i;
        btn.frame = CGRectMake(x, 0, titleW, titleH);
        [self.scrollView addSubview:btn];
    }
}

@end
