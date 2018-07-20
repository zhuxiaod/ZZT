//
//  ZZTCreatCartoonViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCreatCartoonViewController.h"

@interface ZZTCreatCartoonViewController ()

@end

@implementation ZZTCreatCartoonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rr_navHidden = YES;
    
}

-(void)setModel:(ZZTCreationEntranceModel *)model{
    _model = model;
    NSLog(@"%@",model);
}


@end
