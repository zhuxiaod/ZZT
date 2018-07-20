//
//  ZZTStoryDetailView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTStoryDetailView.h"
#import "ZZTStoryDetailCell.h"
#import "ZZTCartoonDetailHead.h"
#import "ZZTCartoonDetailFoot.h"
#import "ZZTWritePlayViewController.h"

@interface ZZTStoryDetailView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *storyDetailArray;
@property (nonatomic,strong) NSMutableArray *textCellHeightCache;
@end
NSString *storyDetail = @"storyDetail";
static const CGFloat textCellHeight = 250.0f;

@implementation ZZTStoryDetailView

-(NSArray *)storyDetailArray{
    if (!_storyDetailArray) {
        _storyDetailArray = @[@"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333",@"2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222"];
    }
    return _storyDetailArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self = [[ZZTStoryDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 200;
        //注册cell
        [self registerNib:[UINib nibWithNibName:@"ZZTStoryDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:storyDetail];
//        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:storyDetail];
        self.showsVerticalScrollIndicator = YES;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.storyDetailArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = indexPath.section + indexPath.row;
    ZZTStoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:storyDetail];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.str = self.storyDetailArray[index];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self fd_heightForCellWithIdentifier:storyDetail configuration:^(id cell) {
        NSInteger index = indexPath.section + indexPath.row;
        ZZTStoryDetailCell *storyCell = (ZZTStoryDetailCell *)cell;
        storyCell.str = self.storyDetailArray[index];
    }];
}
//根据字体 调整cell的高度
#pragma mark UITableViewDataSource 头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return detailViewHeaderHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return detailViewHeaderHeight;
}
//添加头 ZZTCartoonDetailFoot
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZZTCartoonDetailHead *head = [[ZZTCartoonDetailHead alloc] initWithFrame:self.bounds];
    return head;
}
//
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ZZTCartoonDetailFoot *foot = [[ZZTCartoonDetailFoot alloc] initWithFrame:self.bounds];
    foot.userWrite.tag = section;
    foot.userWriteBtnClick = ^(UIButton *btn) {
        NSLog(@"%ld",btn.tag);
        ZZTWritePlayViewController *followFeedsTableView = [[ZZTWritePlayViewController alloc] init];
        [[self myViewController] presentViewController:followFeedsTableView animated:YES completion:nil];
    };
    foot.likeUpBtnClick = ^(UIButton *btn) {
        NSLog(@"1111");
//        //先测试下  后期后台联合 重新写需求
     
    };
    return foot;
}

@end
