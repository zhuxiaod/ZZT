//
//  ZZTChapterlistModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTChapterlistModel : NSObject

@property(nonatomic,strong)NSString *chapterId;

@property(nonatomic,strong)NSString *cartoonId;

@property(nonatomic,strong)NSString *chapterCover;

@property(nonatomic,strong)NSString *chapterName;

@property(nonatomic,assign)NSInteger praiseNum;

@property(nonatomic,strong)NSDate *createdate;

@end
