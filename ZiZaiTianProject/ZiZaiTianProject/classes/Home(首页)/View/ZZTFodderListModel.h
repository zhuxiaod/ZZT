//
//  ZZTFodderListModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTFodderListModel : NSObject

@property (nonatomic,strong) NSString *fodderType;
@property (nonatomic,strong) NSString *modelType;
@property (nonatomic,strong) NSString *modelSubtype;
@property (nonatomic,strong) NSString *owner;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSDate *createdate;

@end
