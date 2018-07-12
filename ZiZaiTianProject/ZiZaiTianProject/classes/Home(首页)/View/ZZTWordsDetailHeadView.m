//
//  ZZTWordsDetailHeadView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWordsDetailHeadView.h"
@interface ZZTWordsDetailHeadView()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *ctImage;
@property (weak, nonatomic) IBOutlet UILabel *ctName;
@property (weak, nonatomic) IBOutlet UILabel *ctTitle;
@property (weak, nonatomic) IBOutlet UILabel *clkNum;
@property (weak, nonatomic) IBOutlet UILabel *collect;
@property (weak, nonatomic) IBOutlet UILabel *participation;
@property (weak, nonatomic) IBOutlet UILabel *ctNum;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation ZZTWordsDetailHeadView


-(instancetype)init
{
    if (self = [super init]) {
       self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] firstObject];
    }
    return self;
}

-(void)setDetailModel:(ZZTCarttonDetailModel *)detailModel
{
    _detailModel = detailModel;
    [self.ctName setText:_detailModel.bookName];
    self.ctName.text = _detailModel.bookName;
    self.clkNum.text = [NSString stringWithFormat:@"%ld",(long)_detailModel.clickNum];
    self.collect.text = [NSString stringWithFormat:@"%ld",_detailModel.collectNum];
    [self.ctImage sd_setImageWithURL:[NSURL URLWithString:_detailModel.cover] placeholderImage:[UIImage imageNamed:@"peien"]];
    self.participation.text = [NSString stringWithFormat:@"%ld",_detailModel.praiseNum];
}

- (void)setctName:(NSString *)setCtname
{
    NSLog(@"%@",setCtname);
}

//+ (instancetype)creatHeadView
//{
//    return [[NSBundle mainBundle] loadNibNamed:@"ZZTWordsDetailHeadView" owner:self options:nil].lastObject;
//}

//-(instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    return [[[NSBundle mainBundle] loadNibNamed:@"ZZTWordsDetailHeadView" owner:self options:nil]lastObject];
//    if(self){
//        self.frame = frame;
//    }
//    self.ctName.text = _detailModel.bookName;
//    self.clkNum.text = [NSString stringWithFormat:@"%ld",(long)_detailModel.clickNum];
//    self.collect.text = [NSString stringWithFormat:@"%ld",_detailModel.collectNum];
//    [self.ctImage sd_setImageWithURL:[NSURL URLWithString:_detailModel.cover] placeholderImage:[UIImage imageNamed:@"peien"]];
//    self.participation.text = [NSString stringWithFormat:@"%ld",_detailModel.praiseNum];
//    return self;
//}

//设置数据
//-(void)setDetailModel:(ZZTCarttonDetailModel *)detailModel{
//    _detailModel = detailModel;
//
//
//}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

//点击穿透
//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    UIView *result = [super hitTest:point withEvent:event];
//    if (result == self) {
//        return nil;
//    }else{
//        return result;
//    }
//}

- (IBAction)back:(UIButton *)sender {
    [[self findResponderWithClass:[UINavigationController class]] popViewControllerAnimated:YES];

}
- (IBAction)sdas:(UIButton *)sender {
    NSLog(@"111");
}


@end
