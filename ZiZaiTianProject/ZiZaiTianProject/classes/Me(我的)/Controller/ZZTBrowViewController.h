//
//  ZZTBrowViewController.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "DCPagerController.h"

@interface ZZTBrowViewController : DCPagerController

@property(nonatomic,strong)NSString *viewTitle;
@property(nonatomic,strong)NSDictionary *dic;
//@property(nonatomic,strong)NSDictionary *dic2;

-(void)initWithStr:(NSString *)viewTitle;

@end
