//
//  ZZTStoryDetailCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTStoryDetailCell.h"
@interface ZZTStoryDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *storyContent;

@end
@implementation ZZTStoryDetailCell
-(void)awakeFromNib{
    [super awakeFromNib];

}
-(void)setStr:(NSString *)str{
    _str = str;
    [self.storyContent setText:str];
}

@end
