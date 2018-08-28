//
//  ZZTMeEditButtomView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/4.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextChange)(UITextField * texyField);
typedef void(^BtnInside)(UIButton * btn);

@class ZZTUserModel;

@interface ZZTMeEditButtomView : UIView

@property (nonatomic,strong) ZZTUserModel *model;

@property (nonatomic,copy) TextChange TextChange;
@property (nonatomic,copy) BtnInside BtnInside;

-(void)addTextBlock:(void(^)(UITextField *tf))block;
-(void)addBtnBlock:(void(^)(UIButton *tf))block;

+(instancetype)ZZTMeEditButtomView;



@end
