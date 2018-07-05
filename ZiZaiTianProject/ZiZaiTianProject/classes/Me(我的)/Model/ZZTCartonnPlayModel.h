//
//  ZZTCartonnPlayModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/30.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTCartonnPlayModel : NSObject
//收藏小说、漫画、社区ID
@property (nonatomic,assign)NSInteger cartoonId;
//用户ID
@property (nonatomic,assign)NSInteger userId;
//漫画、小说、章节
@property (nonatomic,copy)NSString *chapterName;
//取消、存在
@property (nonatomic,copy)NSString *status;
//收藏时间
@property (nonatomic,strong)NSData *voteTime;
//书名
@property (nonatomic,strong)NSString *bookName;
//封面
@property (nonatomic,strong)NSString *chapterCover;
//书的类型
@property (nonatomic,strong)NSString *bookType;

@end
