//
//  ZZTEditImageViewModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EditImageView;

@interface ZZTEditImageViewModel : NSObject

@property (nonatomic,assign) CGRect imageViewFrame;

@property (nonatomic,strong) NSString *imageUrl;

@property (nonatomic,strong) NSString *superView;

@property (nonatomic,assign) NSInteger tagNum;

@property (nonatomic,assign) NSInteger superViewTag;


+(ZZTEditImageViewModel *)initImgaeViewModel:(CGRect)imageViewFrame imageUrl:(NSString *)imageUrl tagNum:(NSInteger )tagNum superView:(NSString *)superView superViewTag:(NSInteger)superViewTag;
@end
