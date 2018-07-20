//
//  ZZTCartoonContentCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/16.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonContentCell.h"
#import "ZZTCartoonModel.h"

@implementation ZZTCartoonContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        
        _content = imageView;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.content.frame = self.bounds;
}

-(void)setModel:(ZZTCartoonModel *)model{
    _model = model;
    [_content sd_setImageWithURL:[NSURL URLWithString:model.cartoonUrl] placeholderImage:[UIImage imageNamed:@"peien"]];
}
@end
