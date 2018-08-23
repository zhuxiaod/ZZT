//
//  ZZTCartoonDetailViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonDetailViewController.h"
#import "ZZTCartoonContentCell.h"
#import "ZZTCartoonModel.h"
#import "ZZTAuthorHeadView.h"
#import "ZZTContinueToDrawHeadView.h"

@interface ZZTCartoonDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *cartoonDetailArray;

@property (nonatomic,strong) UITableView *tableView;
@end

NSString *CartoonContentCellIdentifier = @"CartoonContentCellIdentifier";

@implementation ZZTCartoonDetailViewController

-(NSArray *)cartoonDetailArray{
    if (!_cartoonDetailArray) {
        _cartoonDetailArray = [NSArray array];
    }
    return _cartoonDetailArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //先把漫画显示出来
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Screen_Height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 400;
    
    [tableView registerClass:[ZZTCartoonContentCell class] forCellReuseIdentifier:CartoonContentCellIdentifier];
    tableView.showsVerticalScrollIndicator = YES;
    _tableView = tableView;
    [self.view addSubview:tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return self.cartoonDetailArray.count;
    }else{
        return self.cartoonDetailArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTCartoonContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CartoonContentCellIdentifier];
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:CartoonContentCellIdentifier];
        ZZTCartoonModel *model = self.cartoonDetailArray[indexPath.row];
        cell.model = model;
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:CartoonContentCellIdentifier];
        ZZTCartoonModel *model = self.cartoonDetailArray[0];
        cell.model = model;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.height;
}
-(void)setCartoonId:(NSString *)cartoonId{
    weakself(self);
    NSDictionary *paramDict = @{
                                @"id":cartoonId
                                };
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"cartoon/cartoonImg"] parameters:paramDict success:^(id responseObject) {
        NSString *data = responseObject[@"result"];
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:data];
        NSArray *array = [ZZTCartoonModel mj_objectArrayWithKeyValuesArray:dic];
        weakSelf.cartoonDetailArray = array;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark UITableViewDataSource 头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 100;
    }{
        return 150;
    }
}
//添加头 ZZTCartoonDetailFoot
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        ZZTAuthorHeadView *authorHead = [ZZTAuthorHeadView AuthorHeadView];
        authorHead.backgroundColor = [UIColor yellowColor];
        return authorHead;
    }else{
        ZZTContinueToDrawHeadView *view = [ZZTContinueToDrawHeadView ContinueToDrawHeadView];
        view.backgroundColor = [UIColor redColor];
        view.array = self.cartoonDetailArray;
        return view;
    }
}
@end
