//
//  ZZTCartoonCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonCell.h"
@interface ZZTCartoonCell()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *cartoonName;
@property (weak, nonatomic) IBOutlet UIView *kindView;

@end

@implementation ZZTCartoonCell

-(void)setCartoon:(ZZTCartonnPlayModel *)cartoon{
    _cartoon = cartoon;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:cartoon.chapterCover]];
    
    CGFloat titleH = 12;
    CGFloat titleW = 40;
    
    NSArray *array = [cartoon.bookType componentsSeparatedByString:@","];
    
    for (int i = 0; i < array.count; i++) {
        NSInteger col = i % array.count;
        CGFloat margin = 5;
        CGFloat x = margin + (titleW + margin) * col;
        
        //标签
        UILabel *title = [UILabel new];
        title.font = [UIFont systemFontOfSize:14];
        title.text = array[i];
        [title setTextColor:[UIColor colorWithHexString:@"#C7C8C9"]];
        title.frame = CGRectMake(x, 5, titleW, titleH);
        [self.kindView addSubview:title];
    }
    //没有添加类型
    self.cartoonName.text = cartoon.bookName;
}

@end
