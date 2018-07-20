//
//  ZZTCreationEntranceView.h
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZTCreationEntranceModel;

typedef void (^ClickTureBtnBlock) (ZZTCreationEntranceModel *model);

@interface ZZTCreationEntranceView : UIView
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UILabel *viewTitel;

@property(nonatomic, copy) ClickTureBtnBlock TureBtnBlock;

+(instancetype)CreationEntranceViewWithFrame:(CGRect)frame;

@end
