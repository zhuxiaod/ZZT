//
//  ZZTEditImageViewModel.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTEditImageViewModel.h"

@implementation ZZTEditImageViewModel

//快速创建一个对象
+(ZZTEditImageViewModel *)initImgaeViewModel:(CGRect)imageViewFrame imageUrl:(NSString *)imageUrl tagNum:(NSInteger )tagNum superView:(NSString *)superView superViewTag:(NSInteger)superViewTag viewType:(NSInteger)viewType{
    ZZTEditImageViewModel *imageModel = [[ZZTEditImageViewModel alloc] init];
    imageModel.imageViewFrame = imageViewFrame;
    imageModel.imageUrl = imageUrl;
    imageModel.tagNum = tagNum;
    imageModel.superView = superView;
    imageModel.superViewTag = superViewTag;
    imageModel.viewType = viewType;
    return imageModel;
}


@end
