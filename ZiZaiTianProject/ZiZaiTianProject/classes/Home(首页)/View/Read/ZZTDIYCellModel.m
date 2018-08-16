//
//  ZZTDIYCellModel.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTDIYCellModel.h"

@implementation ZZTDIYCellModel
- (id)copyWithZone:(NSZone *)zone
{
    ZZTDIYCellModel *s = [[[self class] alloc] init];
    s.height = self.height;
    s.isSelect = self.isSelect;
    s.imageArray = self.imageArray;
    return s;
}

+(instancetype)initCellWith:(CGFloat )height isSelect:(BOOL)isSelect{
    ZZTDIYCellModel *model = [[ZZTDIYCellModel alloc] init];
    model.height = height;
    model.isSelect = isSelect;
    return model;
}
-(NSMutableArray *)imageArray{
    if(!_imageArray){
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
@end
