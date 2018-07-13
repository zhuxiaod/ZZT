//
//  ZZTWordsDetailHeadView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWordsDetailHeadView.h"
#import "ZZTWordsDetailViewController.h"
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
@property (weak, nonatomic) IBOutlet UILabel *clk;
@property (weak, nonatomic) IBOutlet UILabel *colt;
@property (weak, nonatomic) IBOutlet UILabel *canyu;
@property (weak, nonatomic) IBOutlet UILabel *ctt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;
@property (nonatomic,weak) ZZTWordsDetailViewController *myVc;
@property (nonatomic,assign) BOOL  show;

@end

@implementation ZZTWordsDetailHeadView

static NSString * const offsetKeyPath = @"contentOffset";

static CGFloat const spaceing   = 8.0f;

//动画效果没搞好还  约束也有问题 需要修正
+(instancetype)wordsDetailHeadViewWithFrame:(CGRect)frame scorllView:(UIScrollView *)sc{
    //初始化xib
    ZZTWordsDetailHeadView *head = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] firstObject];
    //赋值位置
    [head setFrame:frame];
    //kvo
    [sc addObserver:head forKeyPath:offsetKeyPath options:NSKeyValueObservingOptionNew context:nil];
    
    head.scrollView = sc;
    
    return head;
}
//拉动特效
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGFloat offsetY = -[change[NSKeyValueChangeNewKey] CGPointValue].y;
    
    if (offsetY < 1) return;
    
    [self setHeight:offsetY > navHeight ? offsetY : navHeight];
    
    if (offsetY > navHeight + 20) {
        
        CGFloat alpha = 0.0f;
        
        alpha = (wordsDetailHeadViewHeight * 0.5)/offsetY - 0.3;
        
        self.backgroundView.alpha = alpha;
        self.ctImage.alpha = 1 - alpha;

        self.ctTitle.alpha = 1 - alpha;
        self.clkNum.alpha = 1 - alpha;
        self.collect.alpha = 1 - alpha;
        self.participation.alpha = 1 - alpha;
        self.ctNum.alpha = 1 - alpha;
        
        self.ctt.alpha  = 1 - alpha;
        self.clk.alpha = 1 - alpha;
        self.canyu.alpha = 1 - alpha;
        self.colt.alpha = 1 - alpha;
        self.shareBtn.alpha = 1 - alpha;
        self.show = YES;
    }else {
        self.show = NO;
        
        self.backgroundView.alpha = 1;
        self.ctImage.alpha = 0;
        
        self.ctTitle.alpha = 0;
        self.clkNum.alpha = 0;
        self.collect.alpha = 0;
        self.participation.alpha = 0;
        self.ctNum.alpha = 0;
        
        self.ctt.alpha  = 0;
        self.clk.alpha = 0;
        self.canyu.alpha = 0;
        self.colt.alpha = 0;
        self.shareBtn.alpha = 0;

    }
}
- (void)setShow:(BOOL)show {
    if (_show != show) {
        
        CGFloat leftConstant = spaceing;
        CGFloat rightContstant = 128;
        
//        if (!show) {
//            rightContstant =  70;
//            leftConstant   = (self.width - [self.ctName.text getTextWidthWithFont:self.ctName.font]) * 0.5;
//            self.myVc.statusBarStyle = UIStatusBarStyleLightContent;
//        }else {
//            self.myVc.statusBarStyle = UIStatusBarStyleDefault;
//        }
        
        self.leading.constant  = leftConstant;
        self.trailing.constant = rightContstant;
        
        
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
//            self.replyCount.alpha = show;
//            self.likeCount.alpha = show;
            
        }];
        self.backBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:show ? 0.1:0];
        
    }
    _show = show;
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

//销毁观察者
- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:offsetKeyPath context:nil];
}
//懒加载
- (ZZTWordsDetailViewController *)myVc {
    if (!_myVc) {
        _myVc = [self findResponderWithClass:[ZZTWordsDetailViewController class]];
    }
    return _myVc;
}
@end
