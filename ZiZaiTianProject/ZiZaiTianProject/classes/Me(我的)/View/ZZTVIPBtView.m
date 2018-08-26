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

@end

@implementation ZZTVIPBtView

+(instancetype)VIPBtView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
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
