//
//  ZZTXuHuaBtn.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTXuHuaBtn.h"
@interface ZZTXuHuaBtn()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;

@end

@implementation ZZTXuHuaBtn

+(instancetype)XuHuaBtn{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ZZTXuHuaBtn" owner:nil options:nil]lastObject];

}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *nibs=[[NSBundle mainBundle]loadNibNamed:@"ZZTXuHuaBtn" owner:nil options:nil];
        self=[nibs objectAtIndex:0];
        self.frame = frame;
    }
    return self;
    
}

-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
//    [self.headView setImage:[UIImage imageNamed:imageUrl]];
    self.headView.backgroundColor = [UIColor redColor];
//    [self.headView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

-(void)setLoveNum:(NSString *)loveNum{
    _loveNum = loveNum;
    [self.likeNum setText:self.loveNum];
}

@end
