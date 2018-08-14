//
//  ZZTMaterialLibraryView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZTMaterialLibraryView,ZZTFodderListModel;

@protocol MaterialLibraryViewDelegate<NSObject>

-(void)sendRequestWithStr:(NSString *)fodderType modelType:(NSString *)modelType modelSubtype:(NSString *)modelSubtype;

-(void)sendImageWithModel:(ZZTFodderListModel *)model;

-(void)sendTextImageWithModel:(ZZTFodderListModel *)model;

@end

@interface ZZTMaterialLibraryView : UIView

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSString *str;

@property (nonatomic,strong)id<MaterialLibraryViewDelegate>delagate;

@end
