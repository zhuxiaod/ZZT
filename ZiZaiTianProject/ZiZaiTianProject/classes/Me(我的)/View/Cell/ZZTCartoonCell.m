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
@property (weak, nonatomic) IBOutlet UILabel *kind1;
@property (weak, nonatomic) IBOutlet UILabel *kind2;
@property (weak, nonatomic) IBOutlet UILabel *cartoonName;

@end
@implementation ZZTCartoonCell

-(void)setCartoon:(ZZTCartonnPlayModel *)cartoon{
    _cartoon = cartoon;
    [self.image sd_setImageWithURL:[NSURL URLWithString:cartoon.chapterCover]];

    
    if(cartoon){
        self.cartoonName.text = cartoon.bookName;
        NSString *kind1 = [cartoon.bookType substringToIndex:2];
        NSString *kind2 = [cartoon.bookType substringFromIndex:3];
        self.kind1.text = kind1;
        self.kind2.text = kind2;
    }else{
        self.cartoonName.text = @"";
    }
}

@end
