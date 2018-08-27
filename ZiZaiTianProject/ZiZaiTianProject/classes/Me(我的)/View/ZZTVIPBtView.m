//
//  ZZTVIPBtView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTVIPBtView.h"
@interface ZZTVIPBtView()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *viewTitle;

@end

@implementation ZZTVIPBtView

+(instancetype)VIPBtView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


-(void)setTitle:(NSString *)title{
    _title = title;
    [_viewTitle setText:title];
}

-(void)setTextViewStr:(NSString *)textViewStr{
    _textViewStr = textViewStr;
    [_textView setText:textViewStr];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    // 字体的行间距
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:17], NSParagraphStyleAttributeName:paragraphStyle };
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.textView.text attributes:attributes];
}
@end
