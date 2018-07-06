//
//  ZZTShoppingHeaderView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTShoppingHeaderView.h"
@interface ZZTShoppingHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *viewName;

@end
@implementation ZZTShoppingHeaderView

+(instancetype)ShoppingHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
-(void)awakeFromNib{
    [self.viewName setText:self.viewTitle];
    [self.viewName setTextColor:[UIColor colorWithHexString:@"#58006E"]];
}
-(void)setViewTitle:(NSString *)viewTitle{
    _viewTitle = viewTitle;
    [self.viewName setText:viewTitle];
    [self.viewName setTextColor:[UIColor colorWithHexString:@"#58006E"]];
}
@end
