//
//  ZZTCircleModel.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class customer;
@interface ZZTCircleModel : NSObject

@property(nonatomic,strong) NSString *customerId;
@property(nonatomic,strong) NSString *parentCommentId;
@property(nonatomic,strong) NSString *contentId;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,assign) NSInteger state;
@property(nonatomic,assign) NSInteger type;

@property(nonatomic,strong) NSDate *commentDate;
@property(nonatomic,strong) NSDate *commentTime;

@property(nonatomic,strong) customer *customer;
@end
