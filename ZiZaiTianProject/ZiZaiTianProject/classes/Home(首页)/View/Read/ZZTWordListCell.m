//
//  ZZTWordListCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWordListCell.h"
#import "ZZTChapterlistModel.h"
@interface ZZTWordListCell()
@property (weak, nonatomic) IBOutlet UIImageView *wordImage;
@property (weak, nonatomic) IBOutlet UILabel *wordName;
@property (weak, nonatomic) IBOutlet UILabel *wordPage;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UILabel *commentNum;

@end
@implementation ZZTWordListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(ZZTChapterlistModel *)model{
    _model = model;
    
    [self.wordImage sd_setImageWithURL:[NSURL URLWithString:model.chapterCover]];
    self.wordName.text = model.chapterName;
    self.wordName.textColor = [UIColor grayColor];

    self.likeNum.text = [NSString stringWithFormat:@"%ld",model.praiseNum];
    self.likeNum.textColor = [UIColor grayColor];

//    self.commentNum.text = [NSString stringWithFormat:@"%ld",model.];

}



@end
