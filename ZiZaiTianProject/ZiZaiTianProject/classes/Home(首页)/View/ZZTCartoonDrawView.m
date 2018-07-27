//
//  ZZTCartoonDrawView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonDrawView.h"

@implementation ZZTCartoonDrawView

-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if(isSelect == YES){
        self.alpha = 1;
        self.operationView.userInteractionEnabled = YES;
    }else{
        self.alpha = 0.6;
        self.operationView.userInteractionEnabled = NO;
    }
}

@end
