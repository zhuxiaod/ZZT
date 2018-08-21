//
//  ZZTRankCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTRankCell.h"
@interface ZZTRankCell()
@property (weak, nonatomic) IBOutlet UIImageView *cartoonImg;
@property (weak, nonatomic) IBOutlet UILabel *cartoonName;
@property (weak, nonatomic) IBOutlet UIImageView *rankImage;
@property (weak, nonatomic) IBOutlet UILabel *rankNum;
@end

@implementation ZZTRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataModel:(ZZTCarttonDetailModel *)dataModel{
    
    _dataModel = dataModel;
    
    [_cartoonImg sd_setImageWithURL:[NSURL URLWithString:dataModel.cover]];
    
    [_cartoonName setText:dataModel.bookName];
    
    NSArray *array = [dataModel.bookType componentsSeparatedByString:@","];
    
    CGFloat titleH = 20;
    
    CGFloat spaceing2 = 2;
    CGFloat titleW = 30;
    for (int i = 0; i < array.count; i++) {
        NSInteger col = i % array.count;
        CGFloat margin = 5;
        CGFloat x = self.cartoonName.x + titleW * i + margin;
//        margin + (titleW + margin) * col;
        
        //标签
        UILabel *title = [UILabel new];
        title.font = [UIFont systemFontOfSize:12];
        title.text = array[i];
        [title setTextColor:[UIColor colorWithHexString:@"#C7C8C9"]];
        title.frame = CGRectMake(x,self.cartoonName.y+self.cartoonName.height +2, titleW, titleH);
        [self addSubview:title];
    }
    
    if([dataModel.type isEqualToString:@"1"]){
        NSString *bookName = [dataModel.bookName stringByAppendingString:@"(漫画)"];
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:bookName];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(attriStr.length - 4,4)];
        self.cartoonName.attributedText = attriStr;
    }else if([dataModel.type isEqualToString:@"2"]){
        NSString *bookName = [dataModel.bookName stringByAppendingString:@"(剧本)"];
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:bookName];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(attriStr.length - 4,4)];
        self.cartoonName.attributedText = attriStr;
    }
}

-(void)setCellIndex:(NSInteger)cellIndex{
    if(cellIndex == 0){
        _rankImage.image = [UIImage imageNamed:@"排行榜图标-第1名"];
    }else if(cellIndex == 1){
        _rankImage.image = [UIImage imageNamed:@"排行榜图标-第2名"];
    }else if (cellIndex == 2){
        _rankImage.image = [UIImage imageNamed:@"排行榜图标-第3名"];
    }else{
        _rankImage.image = [UIImage imageNamed:@"排行榜图标-第4名"];
    }

    _rankNum.text = [NSString stringWithFormat:@"%ld",cellIndex + 1];
}

@end
