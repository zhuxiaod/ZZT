//
//  ZZTFindWorldViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTFindWorldViewController.h"
#import "ZZTFindCommentCell.h"
#import "ZZTCaiNiXiHuanView.h"

@interface ZZTFindWorldViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) UITableView *contentView;

@end

static NSString *CaiNiXiHuanView1 = @"CaiNiXiHuanView1";

@implementation ZZTFindWorldViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //猜你喜欢
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *contentView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    contentView.delegate = self;
    contentView.dataSource = self;
    contentView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView registerNib:[UINib nibWithNibName:@"ZZTFindCommentCell" bundle:nil] forCellReuseIdentifier:CaiNiXiHuanView1];
    _contentView = contentView;
    [self.view addSubview:contentView];
}

#pragma mark - 设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
#pragma mark - 内容设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTFindCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:CaiNiXiHuanView1];
    return commentCell;
}

#pragma mark 高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.contentView fd_heightForCellWithIdentifier:CaiNiXiHuanView1 cacheByIndexPath:indexPath configuration:^(id cell) {
        ZZTFindCommentCell *CommentCell = (ZZTFindCommentCell *)cell;
        //            CommentCell.model = self.dataArray[indexPath.row];
    }];
    
}
#pragma mark - headView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor yellowColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 150;
}

@end
