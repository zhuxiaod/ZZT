//
//  ZZTXuHuaBtn.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTXuHuaBtn.h"
@interface ZZTXuHuaBtn()
@property (weak, nonatomic) IBOutlet UIImageView *headView1;
@property (weak, nonatomic) IBOutlet UILabel *likeNum1;

@property (nonatomic,strong) UIImageView *imageView1;
@property (nonatomic,strong) UIImageView *headView;
@property (nonatomic,strong) UIImageView *likeView;
@property (nonatomic,strong) UILabel *likeNum;

@end

@implementation ZZTXuHuaBtn

+(instancetype)XuHuaBtn{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ZZTXuHuaBtn" owner:nil options:nil]lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    //图片框
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"我的-头像框"];
    imageView.backgroundColor = [UIColor redColor];
    self.imageView1 = imageView;
    [self addSubview:imageView];
    
    //头像
    UIImageView *headView = [[UIImageView alloc] init];
    headView.image = [UIImage imageNamed:@"peien"];
    self.headView = headView;
    headView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headView];
    
    //点赞
    UIImageView *likeView = [[UIImageView alloc] init];
    likeView.image = [UIImage imageNamed:@"正文-点赞-已点赞"];
    likeView.backgroundColor = [UIColor whiteColor];
    self.likeView = likeView;
    [self addSubview:likeView];
    
    //点赞数
    UILabel *likeNum = [[UILabel alloc] init];
    self.likeNum = likeNum;
    likeNum.text = @"100";
    likeNum.backgroundColor = [UIColor greenColor];
    [self addSubview:likeNum];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView1.frame = CGRectMake(0, 0, self.width, self.width);
    self.headView.frame = CGRectMake(3, 3, self.width - 6, self.width - 6);
    self.likeView.frame = CGRectMake(0, self.width, self.height - self.width, self.height - self.width);
    self.likeNum.frame = CGRectMake(self.height - self.width, self.width, self.width - self.likeView.width, self.height - self.width);
}


-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
//    [self.headView setImage:[UIImage imageNamed:imageUrl]];
//    self.headView.backgroundColor = [UIColor redColor];
//    [self.headView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

-(void)setLoveNum:(NSString *)loveNum{
    _loveNum = loveNum;
    [self.likeNum setText:self.loveNum];
}

@end
