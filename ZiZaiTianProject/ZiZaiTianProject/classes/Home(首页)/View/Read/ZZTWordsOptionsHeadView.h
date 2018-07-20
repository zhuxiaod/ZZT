//
//  ZZTWordsOptionsHeadView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZTOptionBtn;
#define wordsOptionsHeadViewHeight 40

@interface ZZTWordsOptionsHeadView : UIView

@property (weak, nonatomic) ZZTOptionBtn *leftBtn;
@property (weak, nonatomic) ZZTOptionBtn *midBtn;
@property (weak, nonatomic) ZZTOptionBtn *rightBtn;
@property (strong, nonatomic) NSArray *titleArray;
@property (nonatomic, assign) BOOL isSelectStatus;

@property (nonatomic,copy) void (^leftBtnClick)(ZZTOptionBtn *btn);

@property (nonatomic,copy) void (^rightBtnClick)(ZZTOptionBtn *btn);

@property (nonatomic,copy) void (^midBtnClick)(ZZTOptionBtn *btn);

@end
