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
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@end

@implementation ZZTCartoonCell

-(void)setCartoon:(ZZTCartonnPlayModel *)cartoon{
    _cartoon = cartoon;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:cartoon.chapterCover]];
    
    NSString *title = [cartoon.bookType stringByReplacingOccurrencesOfString:@"," withString:@" "];

    [self.titleView setText:title];
    //没有添加类型
    self.cartoonName.text = cartoon.bookName;
}

@end
