//
//  ZZTMeEditTopView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/4.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClick)(UIButton * sender);

@interface ZZTMeEditTopView : UIView

@property (nonatomic,strong) NSString *backImage;

@property (nonatomic,strong) NSString *headImage;


@property (nonatomic,copy) ButtonClick buttonAction;


-(void)addTapBlock:(void(^)(UIButton *btn))block;

+(instancetype)ZZTMeEditTopView;


@end
