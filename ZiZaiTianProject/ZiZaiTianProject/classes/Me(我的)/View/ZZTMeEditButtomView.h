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

@interface ZZTMeEditButtomView : UIView

@property (nonatomic,copy) TextChange TextChange;
@property (nonatomic,copy) BtnInside BtnInside;

-(void)addTextBlock:(void(^)(UITextField *tf))block;
-(void)addBtnBlock:(void(^)(UIButton *tf))block;

+(instancetype)ZZTMeEditButtomView;



@end
