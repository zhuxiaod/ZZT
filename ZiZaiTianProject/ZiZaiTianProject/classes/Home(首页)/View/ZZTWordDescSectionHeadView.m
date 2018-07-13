//
//  ZZTWordDescSectionHeadView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWordDescSectionHeadView.h"
@interface ZZTWordDescSectionHeadView ()

@property (nonatomic,weak) UILabel  *descLabel;

@property (nonatomic,weak) UIButton *openUpBtn;

@property (nonatomic,assign) CGFloat textHeight;

@end

static CGFloat const spaceing = 8;
static CGFloat const tbSpaceing = 12;

@implementation ZZTWordDescSectionHeadView

- (void)setDesc:(NSString *)desc {
    _desc = desc;
    self.descLabel.text = desc;
    //如果大于2行
    if (self.textHeight > self.descLabel.font.lineHeight * 2) {
        
        [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-tbSpaceing * 2);
        }];
        //设置打开按钮
        [self openUpBtn];
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    //显示label
    UILabel *descLabel = [UILabel new];
    
    descLabel.numberOfLines = 2;
    descLabel.font = [UIFont systemFontOfSize:12];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - spaceing * 2;
    
    [self addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(spaceing);
        make.top.equalTo(self).offset(tbSpaceing);
        make.right.equalTo(self).offset(-spaceing);
        make.bottom.equalTo(self).offset(-tbSpaceing);
    }];
    
    self.descLabel = descLabel;
    //底线
    UIView *bottomLine = [UIView new];
    
    bottomLine.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [self addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(SINGLE_LINE_WIDTH));
    }];
}
- (CGFloat)myHeight {
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    return [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}
//文字高度
- (CGFloat)textHeight {
    //如果文字高度大于1
    if (_textHeight < 1) {
        _textHeight = [self getDescTextHeight];
    }
    return _textHeight;
}
//获得文字高度
- (CGFloat)getDescTextHeight {
    //最大尺寸
    CGSize maxSize = CGSizeMake(self.width - spaceing * 2,self.height * 2);
    
    return  [self.descLabel.text boundingRectWithSize:maxSize
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:self.descLabel.font}
                                              context:nil].size.height;
}
- (UIButton *)openUpBtn {
    if (!_openUpBtn) {
        
        UIButton *openUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        openUpBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        
        openUpBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        openUpBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        
        [openUpBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [openUpBtn setTitle:@"全部" forState:UIControlStateNormal];
        [openUpBtn setTitle:@"收起" forState:UIControlStateSelected];
        
//        [openUpBtn setImage:[UIImage imageNamed:@"ic_album_open_7x4_"]  forState:UIControlStateNormal];
//        [openUpBtn setImage:[UIImage imageNamed:@"ic_album_close_7x4_"] forState:UIControlStateSelected];
        
        [openUpBtn addTarget:self action:@selector(openOrClose:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:openUpBtn];
        
        [openUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-tbSpaceing);
            make.bottom.equalTo(self).offset(-spaceing);
            make.width.equalTo(@40);
            make.height.equalTo(@12);
        }];
        
        _openUpBtn = openUpBtn;
    }
    
    return _openUpBtn;
}
//开关状态
- (void)openOrClose:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (self.needReloadHeight) {
        self.descLabel.numberOfLines = btn.selected ? 0 : 2;
        self.needReloadHeight();
    }
}
@end
