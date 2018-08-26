//
//  ZZTCartoonShowView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/26.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonShowView.h"

@interface ZZTCartoonShowView ()

@property (weak, nonatomic) IBOutlet UIImageView *cartoonImg;

@property (weak, nonatomic) IBOutlet UILabel *cartoonName;

@property (weak, nonatomic) IBOutlet UILabel *cartoonType;

@end

@implementation ZZTCartoonShowView

+(instancetype)CartoonShowView{
      return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


@end
