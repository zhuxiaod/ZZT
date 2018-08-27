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
#import "ZZTWalletTopView.h"
#import "ZZTTopUpView.h"
#import "ZZTVIPBtView.h"

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
    self.navigationItem.title = @"钱包";
    
    //scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [self.view addSubview:scrollView];
    
    //top
    ZZTWalletTopView *topView = [ZZTWalletTopView WalletTopView];
    topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140);
    [scrollView addSubview:topView];
    
    //midView
    ZZTTopUpView *midView = [ZZTTopUpView TopUpView];
    midView.frame = CGRectMake(0, topView.y + topView.height+15, SCREEN_WIDTH, 300);
    [scrollView addSubview:midView];
    
    //bottom
    ZZTVIPBtView *bottomView = [ZZTVIPBtView VIPBtView];
    bottomView.frame = CGRectMake(0, midView.y + midView.height+15, SCREEN_WIDTH, 300);
    bottomView.title = @"Z币用途";
    bottomView.textViewStr = @"1 .购买订阅章节 2 .打赏作者 3 .购买素材 ";
    [scrollView addSubview:bottomView];
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, bottomView.y + bottomView.height);
    
    //创建数据源
    [self setupArray];
    
    UIButton *leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    
    [leftbutton setImage:[UIImage imageNamed:@"我的-注释"] forState:UIControlStateNormal];
    leftbutton.contentEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    self.navigationItem.rightBarButtonItem = rightitem;
}

#pragma mark - 设置数据源
-(void)setupArray{
    self.dataArray = @[[ZZTFreeBiModel initZZTFreeBiWith:@"600自在币" ZZTBSpend:@"1阅读卷" btnType:@"￥6"],[ZZTFreeBiModel initZZTFreeBiWith:@"3000自在币" ZZTBSpend:@"7阅读卷" btnType:@"￥30"],[ZZTFreeBiModel initZZTFreeBiWith:@"5000自在币" ZZTBSpend:@"15阅读卷" btnType:@"￥50"],[ZZTFreeBiModel initZZTFreeBiWith:@"9800自在币" ZZTBSpend:@"38阅读卷" btnType:@"￥98"],[ZZTFreeBiModel initZZTFreeBiWith:@"19800自在币" ZZTBSpend:@"98阅读卷" btnType:@"￥198"],[ZZTFreeBiModel initZZTFreeBiWith:@"38800自在币" ZZTBSpend:@"238阅读卷" btnType:@"￥388"]];
}

@end
