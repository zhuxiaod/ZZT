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

@property (weak, nonatomic) IBOutlet UIImageView *cartoonCover;
@property (weak, nonatomic) IBOutlet UILabel *cartoonName;
@property (weak, nonatomic) IBOutlet UILabel *cartoonTitle;
@property (weak, nonatomic) IBOutlet UILabel *heatNum;
@property (weak, nonatomic) IBOutlet UILabel *participationNum;

@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UILabel *commentNum;
@property (weak, nonatomic) IBOutlet UIImageView *background;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (nonatomic,weak) ZZTWordsDetailViewController *myVc;
@property (nonatomic,assign) BOOL  show;
@property (nonatomic,strong) NSMutableArray *array;

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
////拉动特效
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGFloat offsetY = -[change[NSKeyValueChangeNewKey] CGPointValue].y;

    if (offsetY < 1) return;

    [self setHeight:offsetY > navHeight ? offsetY : navHeight];
    
    //正常变隐藏
    if (offsetY > navHeight + 20) {

        CGFloat alpha = 0.0f;

        alpha = (wordsDetailHeadViewHeight * 0.5)/offsetY - 0.3;
        self.cartoonCover.alpha = 1 - alpha;
        self.cartoonName.alpha = 1 - alpha;
        self.cartoonTitle.alpha = 1 - alpha;
        self.heatNum.alpha = 1 - alpha;
        self.participationNum.alpha = 1 - alpha;
        self.likeNum.alpha = 1 - alpha;
        self.commentNum.alpha = 1 - alpha;

        self.background.alpha = alpha;

        self.show = YES;
    }else {
        //隐藏
        self.show = NO;

        self.background.alpha = 1;
        self.cartoonCover.alpha = 0;
        self.cartoonName.alpha = 0;
        self.cartoonTitle.alpha = 0;
        self.heatNum.alpha = 0;
        self.participationNum.alpha = 0;
        self.likeNum.alpha = 0;
        self.commentNum.alpha = 0;

    }
}
//改变标题的位置

//- (void)setShow:(BOOL)show {
//    if (_show != show) {
//
//        CGFloat leftConstant = spaceing;
//        CGFloat rightContstant = 128;
//
//        self.leading.constant  = leftConstant;
//        self.trailing.constant = rightContstant;
//
//
//        [UIView animateWithDuration:0.25 animations:^{
//            [self layoutIfNeeded];
////            self.replyCount.alpha = show;
////            self.likeCount.alpha = show;
//        }];
////        self.backBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:show ? 0.1:0];
//    }
//    _show = show;
//}
//
-(void)setDetailModel:(ZZTCarttonDetailModel *)detailModel
{
    _detailModel = detailModel;
    //设置数据
    [self.cartoonCover sd_setImageWithURL:[NSURL URLWithString:detailModel.cover]];
    self.cartoonName.text = detailModel.bookName;
    NSString *bookType = [detailModel.bookType stringByReplacingOccurrencesOfString:@"," withString:@" "];
    self.cartoonTitle.text = [NSString stringWithFormat:@"标签  %@",bookType];
    //热度
//    self.heatNum.text = detailModel.praiseNum;

    self.participationNum.text = [NSString stringWithFormat:@"收藏： %ld万",detailModel.collectNum];
    
    self.likeNum.text = [NSString stringWithFormat:@"%ld",detailModel.collectNum];

    self.commentNum.text = [NSString stringWithFormat:@"%ld",detailModel.commentNum];
}

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
//
//-(NSMutableArray *)array{
//    if (!_array) {
//        _array = [NSMutableArray array];
//    }
//    return _array;
//}

@end
