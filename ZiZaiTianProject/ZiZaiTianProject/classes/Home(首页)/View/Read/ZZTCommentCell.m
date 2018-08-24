//
//  ZZTCommentCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCommentCell.h"
#import "ZZTCircleModel.h"
#import "customer.h"
@interface ZZTCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImge;
@property (weak, nonatomic) IBOutlet UIButton *userHead;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIView *likeView;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;

@end

@implementation ZZTCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

-(void)setModel:(ZZTCircleModel *)model{
    _model = model;
    
    [_headImge sd_setImageWithURL:[NSURL URLWithString:model.customer.headimg] placeholderImage:[UIImage imageNamed:@"peien"]];
    [_userName setText:model.customer.nickName];
    [_comment setText:model.content];
//    [_likeNum setText:model.];
    
}


@end
