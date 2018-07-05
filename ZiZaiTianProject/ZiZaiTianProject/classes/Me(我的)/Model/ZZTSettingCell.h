//
//  ZZTSettingCell.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTSettingCell : NSObject

/**
 *  这一组所有的cell
 */
@property(nonatomic ,strong)NSArray *ZZTCell;
/**
 *  这一组的头部标题
 */
@property (nonatomic ,copy)NSString * title;

@end
