//
//  ZZTMoreViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/19.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMoreViewController.h"
#import "ZZTWordCell.h"

@interface ZZTMoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArray;
@end

NSString *WordCell = @"WordCell";

@implementation ZZTMoreViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"更多推荐";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self setupTableView];
}

-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor redColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    //注册
    [tableView registerNib:[UINib nibWithNibName:@"ZZTWordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:WordCell];
    [self.view addSubview:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ZZTWordCell *cell = [tableView dequeueReusableCellWithIdentifier:WordCell];
    cell.textLabel.text = @"朱晓俊";
    return cell;
}

@end
