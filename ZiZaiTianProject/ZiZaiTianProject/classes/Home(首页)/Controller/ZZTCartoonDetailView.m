//
//  ZZTCartoonDetailView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/16.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonDetailView.h"
#import "ZZTCartoonContentCell.h"
#import "ZZTCartoonModel.h"
#import "ZZTCartoonDetailHead.h"
#import "ZZTCartoonDetailFoot.h"

@interface ZZTCartoonDetailView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *cartoonDetailArray;
@end

static NSString * const CartoonContentCellIdentifier = @"CartoonContentCell";

@implementation ZZTCartoonDetailView

-(NSArray *)cartoonDetailArray{
    if (!_cartoonDetailArray) {
        _cartoonDetailArray = [NSArray array];
    }
    return _cartoonDetailArray;
}

-(void)setCartoonDetail:(NSArray *)cartoonDetail{
    _cartoonDetail = cartoonDetail;
    self.cartoonDetailArray = cartoonDetail;
    [self reloadData];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self = [[ZZTCartoonDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 400;
        //注册cell
        [self registerClass:[ZZTCartoonContentCell class] forCellReuseIdentifier:CartoonContentCellIdentifier];
        self.showsVerticalScrollIndicator = YES;
        //刷新数据
    }
    return self;
}

#pragma mark UITableViewDataSource 头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //第一节的头  作者介绍
    //第二节的头  热门评论
//    if (section == 0) return authorInfoHeadViewHeight;
//    if (section == 1) return CommentSectionHeadViewHeight;
    
    return 60;
}

//有节头 ==>  第几段(UIlabel) 多少赞(UIButton)
//有尾巴 ==>  下段落 分支
//cell 2种  一种展示文字  一种展示漫画 漫画要通用的 先做漫画
//内容展示 评论
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cartoonDetailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTCartoonContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CartoonContentCellIdentifier];
    ZZTCartoonModel *model = self.cartoonDetailArray[indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
//添加头 ZZTCartoonDetailFoot
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZZTCartoonDetailHead *head = [[ZZTCartoonDetailHead alloc] initWithFrame:self.bounds];
    return head;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ZZTCartoonDetailFoot *foot = [[ZZTCartoonDetailFoot alloc] initWithFrame:self.bounds];
    return foot;
}
@end
