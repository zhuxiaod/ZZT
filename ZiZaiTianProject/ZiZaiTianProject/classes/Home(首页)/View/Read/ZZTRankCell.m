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
@property (weak, nonatomic) IBOutlet UIImageView *rankImage;
@property (weak, nonatomic) IBOutlet UILabel *rankNum;
@property (nonatomic,strong) NSMutableArray *array1;
@property (nonatomic,strong) NSMutableArray *array2;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@end

@implementation ZZTRankCell

-(NSMutableArray *)array1{
    if(_array1){
        _array1 = [NSMutableArray array];
    }
    return _array1;
}

-(NSMutableArray *)array2{
    if(_array2){
        _array2 = [NSMutableArray array];
    }
    return _array2;
}

-(void)setDataModel:(ZZTCarttonDetailModel *)dataModel{
    
    _dataModel = dataModel;
    
    [_cartoonImg sd_setImageWithURL:[NSURL URLWithString:dataModel.cover]];
    
    [_cartoonName setText:dataModel.bookName];
    
    NSString *title = [dataModel.bookType stringByReplacingOccurrencesOfString:@"," withString:@" "];
    [_titleView setText:title];
    [_titleView setFont:[UIFont systemFontOfSize:14]];
    [_titleView setTextColor:[UIColor colorWithHexString:@"#949596"]];
    
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
-(void)setIsHave:(BOOL)isHave{
    _isHave = isHave;
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
    NSString *str = [NSString stringWithFormat:@"%ld",cellIndex + 1];
    [_rankNum setText:str];
}

@end
