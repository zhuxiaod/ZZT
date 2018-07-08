//
//  ZZTMeWalletViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMeWalletViewController.h"
#import "ZZTVIPTopView.h"
#import "ZZTWalletCell.h"
#import "ZZTFreeBiModel.h"
#import "ZZTShoppingButtomCell.h"

@interface ZZTMeWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation ZZTMeWalletViewController


NSString *zztWalletCell = @"zztWalletCell";
NSString *zzTShoppingButtomCell = @"ZZTShoppingButtomCell";

-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建tableView
    [self setupTableView];
    
    ZZTVIPTopView *vipView = [ZZTVIPTopView VIPTopView];
    ZZTUserShoppingModel *userShopping = [ZZTUserShoppingModel initWith:@"自在币" content:@"1百万"];
//    vipView.frame = CGRectMake(0, 0, Screen_Width, 300);
    vipView.user = userShopping;
    _tableView.tableHeaderView = vipView;

    ZZTShoppingButtomCell *shoppingButtom = [ZZTShoppingButtomCell ZZTShoppingButtom];
    _tableView.tableFooterView = shoppingButtom;
    
    //注册Cell
    [self registerCell];
    //创建数据源
    [self setupArray];
}

#pragma mark - 设置数据源
-(void)setupArray{
    self.dataArray = @[[ZZTFreeBiModel initZZTFreeBiWith:@"600自在币" ZZTBSpend:@"1阅读卷" btnType:@"￥6"],[ZZTFreeBiModel initZZTFreeBiWith:@"3000自在币" ZZTBSpend:@"7阅读卷" btnType:@"￥30"],[ZZTFreeBiModel initZZTFreeBiWith:@"5000自在币" ZZTBSpend:@"15阅读卷" btnType:@"￥50"],[ZZTFreeBiModel initZZTFreeBiWith:@"9800自在币" ZZTBSpend:@"38阅读卷" btnType:@"￥98"],[ZZTFreeBiModel initZZTFreeBiWith:@"19800自在币" ZZTBSpend:@"98阅读卷" btnType:@"￥198"],[ZZTFreeBiModel initZZTFreeBiWith:@"38800自在币" ZZTBSpend:@"238阅读卷" btnType:@"￥388"]];
}
#pragma mark - tableView
-(void)setupTableView{
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 0;
    _tableView.sectionFooterHeight = 10;
    
    //隐藏滚动条
    _tableView.showsVerticalScrollIndicator = NO;
}

#pragma mark - 注册cell
-(void)registerCell{
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ZZTWalletCell" bundle:nil] forCellReuseIdentifier:zztWalletCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZZTShoppingButtomCell" bundle:nil] forCellReuseIdentifier:zzTShoppingButtomCell];

//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZTcellq];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZTcell11];
//    [self.tableView registerNib:[UINib nibWithNibName:@"ZZTNoTypeCell" bundle:nil] forCellReuseIdentifier:NoTypeCell];
//    [self.tableView registerNib:[UINib nibWithNibName:@"ZZTExitCell" bundle:nil] forCellReuseIdentifier:ExitCell];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArray.count;


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        ZZTWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:zztWalletCell];
        cell.freeBiModel = self.dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}

- (IBAction)backBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
