//
//  ZZTFindAttentionViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTFindAttentionViewController.h"
#import "ZZTCaiNiXiHuanView.h"
#import "ZZTFindCommentCell.h"

@interface ZZTFindAttentionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) UITableView *contentView;

@end

static NSString *CaiNiXiHuanView = @"CaiNiXiHuanView";

@implementation ZZTFindAttentionViewController

-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //猜你喜欢
    self.view.backgroundColor = [UIColor redColor];
    
    
    UITableView *contentView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    contentView.delegate = self;
    contentView.dataSource = self;
    contentView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView registerNib:[UINib nibWithNibName:@"ZZTFindCommentCell" bundle:nil] forCellReuseIdentifier:CaiNiXiHuanView];
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
    ZZTFindCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:CaiNiXiHuanView];
    return commentCell;
}

#pragma mark 高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.contentView fd_heightForCellWithIdentifier:CaiNiXiHuanView cacheByIndexPath:indexPath configuration:^(id cell) {
        ZZTFindCommentCell *CommentCell = (ZZTFindCommentCell *)cell;
        //            CommentCell.model = self.dataArray[indexPath.row];
    }];
    
}
#pragma mark - headView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZZTCaiNiXiHuanView *view = [ZZTCaiNiXiHuanView CaiNiXiHuanView];
    view.buttonAction = ^(UIButton *sender) {
        //换一批
        
    };
    view.backgroundColor = [UIColor yellowColor];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    [self.view addSubview:view];
    
    [self loadViewIfNeeded];
    
    CGFloat space = 5;
    CGFloat btnW = (SCREEN_WIDTH - space * 5)/6;
    CGFloat btnH = btnW;
    
    //获得数据 几个 6个
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"peien"] forState:UIControlStateNormal];
        CGFloat x = (btnW + space) * i;
        btn.frame = CGRectMake(x, 0, btnW, btnH);
        [view.mainView addSubview:btn];
    }
    return view;
}

@end
