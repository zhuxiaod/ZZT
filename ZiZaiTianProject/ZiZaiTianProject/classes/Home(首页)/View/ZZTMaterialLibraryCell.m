//
//  ZZTMaterialLibraryCell.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMaterialLibraryCell.h"
@interface ZZTMaterialLibraryCell()

@property (nonatomic,strong)UIImageView *imageView;

@end

@implementation ZZTMaterialLibraryCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
//        _imageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

-(void)setImageURl:(NSString *)imageURl{
    _imageURl = imageURl;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURl] placeholderImage:[UIImage imageNamed:@"peien"]];
}
@end
