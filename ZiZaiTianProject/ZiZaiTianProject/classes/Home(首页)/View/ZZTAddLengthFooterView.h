//
//  ZZTAddLengthFooterView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FooterBlock)(void);

@interface ZZTAddLengthFooterView : UICollectionReusableView

@property (nonatomic,copy)FooterBlock block;

@property (weak, nonatomic) UIButton *addCellBtn;

@property (weak, nonatomic) UIButton *addLengthBtn;

@property (nonatomic,copy) void (^addCellBtnClick)(UIButton *btn);

@property (nonatomic,copy) void (^addLengthBtnClick)(UIButton *btn);
@end
