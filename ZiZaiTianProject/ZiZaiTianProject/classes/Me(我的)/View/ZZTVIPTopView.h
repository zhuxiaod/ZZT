//
//  ZZTVIPTopView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZTVIPTopView : UIView

@property (nonatomic,strong) ZZTUserShoppingModel *user;

@property (nonatomic,strong) UIImage *viewImage;

@property (nonatomic,strong) NSString *viewTitle;

@property (nonatomic,strong) NSString *viewDetail;

+(instancetype)VIPTopView;

@end
