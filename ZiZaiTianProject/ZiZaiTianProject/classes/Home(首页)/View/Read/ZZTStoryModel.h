//
//  ZZTStoryModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/24.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTStoryModel : NSObject

@property (nonatomic,strong) NSString *chapterId;

@property (nonatomic,strong) NSString *reelId;

@property (nonatomic,strong) NSString *chapterName;

@property (nonatomic,strong) NSString *content;

@property (nonatomic,assign) NSInteger wordNum;

@property (nonatomic,strong) NSDate *createdate;

@property (nonatomic,strong) NSString *state;

@end
