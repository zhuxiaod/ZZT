//
//  ZZTCreationButtonView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCreationButtonView.h"
#import "ZXDCartoonFlexoBtn.h"
#import "ZZTCreationCartoonTypeViewController.h"

@interface ZZTCreationButtonView ()
@property (nonatomic,strong) ZXDCartoonFlexoBtn *cartoon;
@property (nonatomic,strong) ZXDCartoonFlexoBtn *play;
@property (nonatomic,strong) ZXDCartoonFlexoBtn *continuation;
@property (nonatomic,strong) UIView *botttomView;
@property (nonatomic,strong) UIView *btnView;



@end
@implementation ZZTCreationButtonView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *btnView = [[UIView alloc] init];
        _btnView = btnView;
        [self addSubview:btnView];

        //创建漫画
        ZXDCartoonFlexoBtn *cartoon = [[ZXDCartoonFlexoBtn alloc] init];
        self.cartoon = cartoon;
        [cartoon setTitle:@"创建漫画" forState:UIControlStateNormal];
        [cartoon setImage:[UIImage imageNamed:@"创作-图标-创建漫画"] forState:UIControlStateNormal];
        cartoon.titleLabel.font = [UIFont systemFontOfSize:14];
        [cartoon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //添加事件
        [cartoon addTarget:self action:@selector(didCartoon) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:cartoon];

        //创建剧本
        ZXDCartoonFlexoBtn *play = [[ZXDCartoonFlexoBtn alloc] init];
        self.play = play;
        [play setTitle:@"创建剧本" forState:UIControlStateNormal];
        [play setImage:[UIImage imageNamed:@"创作-图标-创建剧本"] forState:UIControlStateNormal];
        play.titleLabel.font = [UIFont systemFontOfSize:14];
        [play setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [play addTarget:self action:@selector(didPlay) forControlEvents:UIControlEventTouchUpInside];

        [btnView addSubview:play];

        //作品续作
        ZXDCartoonFlexoBtn *continuation = [[ZXDCartoonFlexoBtn alloc] init];
        self.continuation = continuation;
        [continuation setTitle:@"作品续作" forState:UIControlStateNormal];
        [continuation setImage:[UIImage imageNamed:@"创作-图标-续作作品"] forState:UIControlStateNormal];
        continuation.titleLabel.font = [UIFont systemFontOfSize:14];
        [continuation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [continuation addTarget:self action:@selector(didContinuation) forControlEvents:UIControlEventTouchUpInside];

        [btnView addSubview:continuation];

        //一条线
        UIView *bottomView = [[UIView alloc] init];
        self.botttomView = bottomView;
        bottomView.backgroundColor = [UIColor colorWithHexString:@"#F0F1F2"];
        [self addSubview:bottomView];
    }
    return self;
}

-(void)didCartoon{
    ZZTCreationCartoonTypeViewController *cartoonVC = [[ZZTCreationCartoonTypeViewController alloc] init];
    cartoonVC.viewTitle = @"创建漫画";
    cartoonVC.type = @"1";
    [self myViewController].hidesBottomBarWhenPushed = YES;
    [[self myViewController].navigationController pushViewController:cartoonVC animated:YES];
    [self myViewController].hidesBottomBarWhenPushed = NO;
}

-(void)didPlay{
    ZZTCreationCartoonTypeViewController *cartoonVC = [[ZZTCreationCartoonTypeViewController alloc] init];
    cartoonVC.viewTitle = @"创建剧本";
    cartoonVC.type = @"2";
    [self myViewController].hidesBottomBarWhenPushed = YES;
    [[self myViewController].navigationController pushViewController:cartoonVC animated:YES];
    [self myViewController].hidesBottomBarWhenPushed = NO;
}
- (void)didContinuation{
    ZZTCreationCartoonTypeViewController *cartoonVC = [[ZZTCreationCartoonTypeViewController alloc] init];
    cartoonVC.viewTitle = @"作品续作";
    cartoonVC.type = @"3";
    [self myViewController].hidesBottomBarWhenPushed = YES;
    [[self myViewController].navigationController pushViewController:cartoonVC animated:YES];
    [self myViewController].hidesBottomBarWhenPushed = NO;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat btnWidth = 60;
    CGFloat btnY = 25;
    CGFloat btnHeight = height - height/5 * 2;
    CGFloat btnViewWidth = width - 100;
    CGFloat btnViewHeight = height - 4;
    CGFloat space = (btnViewWidth - btnWidth*3)/2;
    
    self.btnView.frame = CGRectMake((width - btnViewWidth)/2, 0, btnViewWidth, btnViewHeight);
    
    self.cartoon.frame = CGRectMake(0, btnY, btnWidth, btnHeight);
    
    self.play.frame = CGRectMake(self.cartoon.x+btnWidth+space, btnY, btnWidth, btnHeight);
    
    self.continuation.frame = CGRectMake(self.play.x+btnWidth+space, btnY, btnWidth, btnHeight);
    
    self.botttomView.frame = CGRectMake(0, height - 4, width, 4);
    
}
@end
