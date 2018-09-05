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
//内容
@property (nonatomic,strong) NSString *viewContent;
//视图型号
@property (nonatomic,assign) NSInteger viewType;

@property (nonatomic,strong) UIImage *localResource;

@property(nonatomic,assign) CGAffineTransform viewTransform;

+(ZZTEditImageViewModel *)initImgaeViewModel:(CGRect)imageViewFrame imageUrl:(NSString *)imageUrl tagNum:(NSInteger )tagNum viewType:(NSInteger)viewType localResource:(UIImage *)localResource viewTransform:(CGAffineTransform)viewTransform;

@end
