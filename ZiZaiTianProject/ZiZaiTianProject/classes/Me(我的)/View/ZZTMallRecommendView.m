//
//  ZZTMallRecommendView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/26.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMallRecommendView.h"
#import "ZZTCartoonShowView.h"

@interface ZZTMallRecommendView ()

@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UILabel *headLab;
@property (nonatomic,strong) UIButton *moreBtn;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) ZZTCartoonShowView *showView1;
@property (nonatomic,strong) ZZTCartoonShowView *showView2;
@property (nonatomic,strong) ZZTCartoonShowView *showView3;

@end
@implementation ZZTMallRecommendView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    //头标题
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    _headView = headView;
    [self addSubview:headView];
    //推荐
    UILabel *headLab = [[UILabel alloc] init];
    [headLab setText:@"素材推荐"];
    _headLab = headLab;
    [headView addSubview:headLab];
    //更多
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"作品-按钮-更多"] forState:UIControlStateNormal];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    _moreBtn = moreBtn;
    [headView addSubview:moreBtn];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    _contentView = contentView;
    [self addSubview:contentView];
    
    //3个推荐
    ZZTCartoonShowView *showView1 = [ZZTCartoonShowView CartoonShowView];
    _showView1 = showView1;
    CGFloat w = self.contentView.width / 3;
    
    [self.contentView addSubview:showView1];
    
    ZZTCartoonShowView *showView2 = [ZZTCartoonShowView CartoonShowView];
    _showView2 = showView2;
    [self.contentView addSubview:showView2];
    
    ZZTCartoonShowView *showView3 = [ZZTCartoonShowView CartoonShowView];
    _showView3 = showView3;
    [self.contentView addSubview:showView3];
    
   
}

-(void)layoutSubviews{
    [super layoutSubviews];

    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.equalTo(@(30));
    }];

    [self.headLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headView);
        make.height.equalTo(self.headView).offset(-2);
        make.left.equalTo(self.headView).offset(10);
    }];

    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headView).offset(-10);
        make.centerY.equalTo(self.headView);
        make.height.equalTo(self.headView).offset(-2);
        make.width.offset(100);
    }];

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).offset(30);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
    }];


    [self layoutIfNeeded];
    CGFloat viewW = (SCREEN_WIDTH - 10)/3;
    
    //这个地方 三个VIew宽是0 哪三个view  不是存在吗  我要
    self.showView1.frame = CGRectMake(0, 0, viewW, self.contentView.height);
    self.showView2.frame = CGRectMake(viewW + 5, 0, viewW, self.contentView.height);
    self.showView3.frame = CGRectMake(viewW * 2 + 10, 0, viewW, self.contentView.height);
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self.headLab setText:title];
}


@end
