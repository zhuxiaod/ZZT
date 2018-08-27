//
//  ZZTCartoonHistoryCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonHistoryCell.h"
@interface ZZTCartoonHistoryCell()

@property (weak, nonatomic) IBOutlet UIImageView *cartoonImg;

@property (weak, nonatomic) IBOutlet UILabel *cartoonName;

@property (weak, nonatomic) IBOutlet UILabel *cartoonType;

@end

@implementation ZZTCartoonHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setModel:(ZZTCartonnPlayModel *)model{
    _model = model;
    [self.cartoonImg sd_setImageWithURL:[NSURL URLWithString:model.chapterCover]];
    
    if([model.type isEqualToString:@"1"]){
        NSString *bookName = [model.bookName stringByAppendingString:@"(漫画)"];
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:bookName];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(attriStr.length - 4,4)];
        self.cartoonName.attributedText = attriStr;
    }else if([model.type isEqualToString:@"2"]){
        NSString *bookName = [model.bookName stringByAppendingString:@"(剧本)"];
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:bookName];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(attriStr.length - 4,4)];
        self.cartoonName.attributedText = attriStr;
    }
    NSString *bookType = [model.bookType stringByReplacingOccurrencesOfString:@"," withString:@" "];
    self.cartoonType.text = bookType;
}


@end
