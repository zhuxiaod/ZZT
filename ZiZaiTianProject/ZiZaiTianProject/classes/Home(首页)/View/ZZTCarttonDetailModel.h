//
//  ZZTCarttonDetailModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTCarttonDetailModel : NSObject

@property (nonatomic,strong) NSString *id;

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *bookName;
@property (nonatomic,strong) NSString *intro;
@property (nonatomic,strong) NSString *cover;
@property (nonatomic,strong) NSString *bookType;
@property (nonatomic,strong) NSString *type;

@property (nonatomic,assign) NSInteger clickNum;
@property (nonatomic,assign) NSInteger collectNum;
@property (nonatomic,assign) NSInteger praiseNum;

@property (nonatomic,strong) NSDate *createTime;

@property (nonatomic,strong) NSString *recordNum;
@property (nonatomic,strong) NSString *ifConcern;

@property (nonatomic,strong) NSString *cartoonType;

@property (nonatomic,strong) NSString *ifrelease;

@property (nonatomic,assign) NSInteger commentNum;





@end
