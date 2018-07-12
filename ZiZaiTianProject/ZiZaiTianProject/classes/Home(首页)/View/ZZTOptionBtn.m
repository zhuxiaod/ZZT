//
//  ZZTOptionBtn.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTOptionBtn.h"

@implementation ZZTOptionBtn

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected == YES) {
        self.backgroundColor = [UIColor colorWithHexString:@"#E4C1D9"];
    }else{
        self.backgroundColor = [UIColor colorWithHexString:@"#5D4256"];
    }
}

@end
