//
//  ZZTWordsDetailHeadView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWordsDetailHeadView.h"
@interface ZZTWordsDetailHeadView()

@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation ZZTWordsDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"ZZTWordsDetailHeadView" owner:self options:nil]lastObject];
    if(self){
        self.frame = frame;
    }
//    self.ctName.text = _detailModel.bookName;
//    self.clkNum.text = [NSString stringWithFormat:@"%ld",(long)_detailModel.clickNum];
//    self.collect.text = [NSString stringWithFormat:@"%ld",_detailModel.collectNum];
//    [self.ctImage sd_setImageWithURL:[NSURL URLWithString:_detailModel.cover] placeholderImage:[UIImage imageNamed:@"peien"]];
//    self.participation.text = [NSString stringWithFormat:@"%ld",_detailModel.praiseNum];
    return self;
}

//设置数据
//-(void)setDetailModel:(ZZTCarttonDetailModel *)detailModel{
//    _detailModel = detailModel;
//
//
//}
//点击穿透
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *result = [super hitTest:point withEvent:event];
    if (result == self) {
        return nil;
    }else{
        return result;
    }
}

- (IBAction)back:(UIButton *)sender {
    [[self findResponderWithClass:[UINavigationController class]] popViewControllerAnimated:YES];

}
- (IBAction)sdas:(UIButton *)sender {
    NSLog(@"111");
}


@end
