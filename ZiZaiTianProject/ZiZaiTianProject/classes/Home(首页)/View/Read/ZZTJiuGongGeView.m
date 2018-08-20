//
//  ZZTJiuGongGeView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTJiuGongGeView.h"
@interface ZZTJiuGongGeView ()

@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UILabel *CartoonTitle;


@end

@implementation ZZTJiuGongGeView

+(void)jiuGongGeLayout:(NSArray<ZZTJiuGongGeView *> *)views WithMaxSize:(CGSize)maxSize WithRow:(NSInteger)row{
    
    NSInteger itemCount = 3;
    
    CGFloat itemWidth = (maxSize.width - (itemCount + 1) * spaceing)/itemCount;
    
    CGFloat itemHeight = (maxSize.height - (row + 1) * spaceing)/row;
    
    CGFloat y,x;
    
    for (NSInteger section = 0; section < row; section++) {
        if(section == 0){
            y = 2;
        }else{
            y = section * (itemHeight + spaceing) + spaceing;
        }
        for (NSInteger index = 0; index < itemCount; index++) {
            x = index * (itemWidth + spaceing) + spaceing;
            
            [views[index + itemCount * section] setFrame:CGRectMake(x, y, itemWidth, itemHeight)];
        }
    }
}

-(void)setModel:(ZZTCarttonDetailModel *)model{
    _model = model;
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    
    if([model.type isEqualToString:@"1"]){
        model.bookName = [model.bookName stringByAppendingString:@"(漫画)"];
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:model.bookName];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,4)];
        self.titleLabel.text = attriStr;
    }
    
    CGFloat titleH = 12;
    
    CGFloat spaceing2 = 2;
    CGFloat titleW = 30;

    NSArray *array = [model.bookType componentsSeparatedByString:@","];
    
    for (int i = 0; i < array.count; i++) {
        NSInteger col = i % array.count;
        CGFloat margin = 5;
        CGFloat x = margin + (titleW + margin) * col;

        //标签
        UILabel *title = [UILabel new];
        title.font = [UIFont systemFontOfSize:12];
        title.text = array[i];
        [title setTextColor:[UIColor colorWithHexString:@"#C7C8C9"]];
        title.frame = CGRectMake(x, self.height - titleH + spaceing2, titleW, titleH);
        [self addSubview:title];
    }
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UIImageView *imageView = [UIImageView new];
    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imageView.layer.borderWidth = 0.5;
    [self addSubview:imageView];
    
    self.imageView = imageView;
    //标题
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    [label setTextColor:[UIColor blackColor]];
    [self addSubview:label];
    
    self.titleLabel = label;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat labelH = 12;
    CGFloat titleH = 12;

    CGFloat spaceing1 = 5;
    CGFloat spaceing2 = 2;

    self.imageView.frame = CGRectMake(0, 0, self.width, self.height-labelH-titleH-spaceing2-spaceing2);
    self.titleLabel.frame = CGRectMake(spaceing1, self.height-labelH-titleH , self.width - 10, labelH);
}

@end
