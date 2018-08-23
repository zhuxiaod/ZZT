//
//  ZZTMulWordListCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMulWordListCell.h"
#import "ZZTChapterlistModel.h"
@interface ZZTMulWordListCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImg1;
@property (weak, nonatomic) IBOutlet UILabel *nameLab1;
@property (weak, nonatomic) IBOutlet UILabel *pageLab1;
@property (weak, nonatomic) IBOutlet UILabel *likeNum1;
@property (weak, nonatomic) IBOutlet UILabel *commentNum1;


@property (weak, nonatomic) IBOutlet UIImageView *headImg2;
@property (weak, nonatomic) IBOutlet UILabel *nameLab2;
@property (weak, nonatomic) IBOutlet UILabel *pageLab2;
@property (weak, nonatomic) IBOutlet UILabel *likeNum2;
@property (weak, nonatomic) IBOutlet UILabel *commentNum2;


@end

@implementation ZZTMulWordListCell

-(void)setString:(NSString *)string{
    _string = string;
}

//众创 漫画给一个  剧本给一个
-(void)setModel:(ZZTChapterlistModel *)model{
    _model = model;
    
    if([self.string isEqualToString:@"1"]){

        [self.headImg1 sd_setImageWithURL:[NSURL URLWithString:model.chapterCover]];
        [self.nameLab1 setText:model.chapterName];
        [self.likeNum1 setText:[NSString stringWithFormat:@"%ld",model.praiseNum]];
    
    }else{
    
        [self.headImg2 sd_setImageWithURL:[NSURL URLWithString:model.chapterCover]];
        [self.nameLab2 setText:model.chapterName];
        [self.likeNum2 setText:[NSString stringWithFormat:@"%ld",model.praiseNum]];
    
    }


}

+(instancetype)mulWordListCellWith:(UITableView *)tableView NSString:(NSString *)string{
    NSString *identifier = @"";
    NSInteger index = 0;
    //漫画
    if ([string isEqualToString:@"1"]) {
        identifier = @"ZZTMulWordListCellOne";
        index = 0;
    }else{
        identifier = @"ZZTMulWordListCellTwo";
        index = 1;
    }
    ZZTMulWordListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZZTMulWordListCell" owner:self options:nil] objectAtIndex:index];
    }
    return cell;
}

@end
