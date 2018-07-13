//
//  ZZTWordsOptionsBottomView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#define wordsOptionsHeadViewHeight 40

@interface ZZTWordsOptionsBottomView : UIView

@property (weak, nonatomic) UIButton *leftBtn;
@property (weak, nonatomic) UIButton *midBtn;
@property (weak, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) NSArray *titleArray;
@property (nonatomic, assign) BOOL isSelectStatus;

@property (nonatomic,copy) void (^leftBtnClick)(UIButton *btn);

@property (nonatomic,copy) void (^rightBtnClick)(UIButton *btn);

@property (nonatomic,copy) void (^midBtnClick)(UIButton *btn);

@end
