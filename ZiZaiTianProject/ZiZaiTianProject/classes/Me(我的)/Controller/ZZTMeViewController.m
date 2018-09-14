//
//  ZZTMeViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 zxd. All rights reserved.
//
#import "ZZTSignInView.h"
#import "ZZTMeViewController.h"
#import "ZZTMeTopView.h"
#import "ZZTMeCell.h"
#import "ZZTSettingCell.h"
#import "MJExtension.h"
#import "ZZTCell.h"
#import "ZZTLoginRegisterViewController.h"
#import "ZZTVIPViewController.h"
#import "ZZTBrowViewController.h"
#import "ZZTHistoryViewController.h"
#import "ZZTSettingViewController.h"
#import "ZZTMeEditViewController.h"
#import "ZZTMeWalletViewController.h"
#import "ZZTShoppingMallViewController.h"
#import "ZZTCartoonViewController.h"
#import "ZZTMeAttentionViewController.h"
#import "ZZTLoginRegisterViewController.h"

@interface ZZTMeViewController ()<UITableViewDataSource,UITableViewDelegate,ZZTSignInViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
//cell数据
@property (nonatomic,strong) NSArray *cellData;

@property (nonatomic,strong) AFHTTPSessionManager *manager;

//获得数据
@property (nonatomic,strong) EncryptionTools *encryptionManager;

@property (nonatomic,strong) ZZTUserModel *userData;

@property (nonatomic,strong) ZZTSignInView *signView;

@property (nonatomic,strong) ZZTMeTopView *topView;

@end

@implementation ZZTMeViewController

//cell的标识
NSString *bannerID = @"MeCell";

#pragma mark - 懒加载
- (EncryptionTools *)encryptionManager{
    if(!_encryptionManager){
        _encryptionManager = [EncryptionTools sharedEncryptionTools];
    }
    return _encryptionManager;
}

-(ZZTUserModel *)userData{
    if (!_userData) {
        _userData = [[ZZTUserModel alloc] init];
    }
    return _userData;
}
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#474764"];
    self.rr_navHidden = YES;
    UINavigationBar *nab = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[UIView class]]];

    [nab setBackgroundImage:[UIImage createImageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [UINavigationBar appearance].translucent=NO;
    
    //请求数据
//    [self getData];
    //设置table
    [self setupTab];
}

#pragma mark - 设置tableView
-(void)setupTab
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20 , self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.sectionHeaderHeight = 10;
    _tableView.sectionFooterHeight = 0;
    _tableView.dataSource = self;
    _tableView.delegate = self;

    //隐藏滚动条
    _tableView.showsVerticalScrollIndicator = NO;
    
    //添加头视图
    ZZTMeTopView *top = [ZZTMeTopView meTopView];
    top.frame = CGRectMake(0, 0, ScreenW, 120);
    _tableView.tableHeaderView = top;
    _topView = top;
    top.buttonAction = ^(UIButton *sender) {
        if(sender.tag == 0){
            ZZTMeEditViewController *editVC = [[ZZTMeEditViewController alloc] init];
            editVC.hidesBottomBarWhenPushed = YES;
            editVC.model = self.userData;
            [self.navigationController pushViewController:editVC animated:YES];
        }
    };
    top.loginAction = ^(UIButton *btn) {
        //弹出登录页面
        ZZTLoginRegisterViewController *loginView = [[ZZTLoginRegisterViewController alloc] init];
        [self presentViewController:loginView animated:YES completion:nil];
    };
    
    [self.view addSubview:_tableView];
    //注册cell
    [self.tableView registerClass:[ZZTMeCell class] forCellReuseIdentifier:bannerID];
  
}

-(void)setupTopView{
    self.topView.userModel = self.userData;
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 4;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZTMeCell *cell = [tableView dequeueReusableCellWithIdentifier:bannerID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"我的空间";
        return cell;
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"VIP";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"钱包";
        }
        return cell;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"自在商城";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"积分兑换";
        }
        return cell;
    }else if(indexPath.section == 3){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"参与作品";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"书柜";
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"关注";
        }else if(indexPath.row == 3){
            cell.textLabel.text = @"浏览历史";
        }
        return cell;
    }else{
        cell.textLabel.text = @"设置";
        return cell;
    }
    return cell;
}
//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //我的空间
        
    }
    else if (indexPath.section == 1){
        if(indexPath.row == 0){
            //VIP
            ZZTVIPViewController *VIPView = [[ZZTVIPViewController alloc]init];
            VIPView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VIPView animated:YES];
        }else if(indexPath.row == 1){
            //钱包
            ZZTMeWalletViewController *walletVC = [[ZZTMeWalletViewController alloc] init];
            walletVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:walletVC animated:YES];
        }
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            //自在商城
            ZZTShoppingMallViewController *shoppingMallVC = [[ZZTShoppingMallViewController alloc] init];
            shoppingMallVC.hidesBottomBarWhenPushed = YES;
            shoppingMallVC.isShopping = YES;
            shoppingMallVC.viewTitle = @"自在商城";
            [self.navigationController pushViewController:shoppingMallVC animated:YES];
        }else if(indexPath.row == 1){
            //积分兑换
            ZZTShoppingMallViewController *shoppingMallVC = [[ZZTShoppingMallViewController alloc] init];
            shoppingMallVC.hidesBottomBarWhenPushed = YES;
            shoppingMallVC.isShopping = YES;
            shoppingMallVC.viewTitle = @"积分兑换";
            [self.navigationController pushViewController:shoppingMallVC animated:YES];
        }
    }else if (indexPath.section == 3){
        if(indexPath.row == 0){
            ZZTCartoonViewController *bookVC = [[ZZTCartoonViewController alloc] init];
            bookVC.hidesBottomBarWhenPushed = YES;
            bookVC.viewTitle = @"参与作品";
            bookVC.viewType = @"1";
            bookVC.user = self.userData;
            [self.navigationController pushViewController:bookVC animated:YES];
        }else if(indexPath.row == 1){
            //书柜
            ZZTCartoonViewController *bookVC = [[ZZTCartoonViewController alloc] init];
            bookVC.hidesBottomBarWhenPushed = YES;
            bookVC.viewTitle = @"书柜";
            bookVC.viewType = @"2";
            bookVC.user = self.userData;
            [self.navigationController pushViewController:bookVC animated:YES];
        }else if(indexPath.row == 2){
            //关注
            ZZTMeAttentionViewController *meAttentionVC = [[ZZTMeAttentionViewController alloc] init];
            meAttentionVC.hidesBottomBarWhenPushed = YES;
            meAttentionVC.user = self.userData;
            [self.navigationController pushViewController:meAttentionVC animated:YES];
        }else if(indexPath.row == 3){
            //浏览历史
            ZZTHistoryViewController *historyVC = [[ZZTHistoryViewController alloc] init];
            historyVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:historyVC animated:YES];
        }
    }else if(indexPath.section == 4){
        //设置
        ZZTSettingViewController *settingVC = [[ZZTSettingViewController alloc] init];
        settingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingVC animated:YES];
    }
//            ZZTBrowViewController *myAttentionVC = [[ZZTBrowViewController alloc] initWithNibName:@"ZZTBrowViewController" bundle:nil];
//            myAttentionVC.viewTitle = @"我的关注";
//            myAttentionVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:myAttentionVC animated:YES];
//        }
//    }else if(indexPath.section == 1){
//        if(indexPath.row == 0){
//            //自在商城
//            ZZTShoppingMallViewController *shoppingMallVC = [[ZZTShoppingMallViewController alloc] init];
//
//            shoppingMallVC.hidesBottomBarWhenPushed = YES;
//            shoppingMallVC.isShopping = YES;
//            shoppingMallVC.viewTitle = @"自在商城";
//            [self.navigationController pushViewController:shoppingMallVC animated:YES];
//        }else if(indexPath.row == 1){
//            //积分兑换
//            ZZTShoppingMallViewController *shoppingMallVC = [[ZZTShoppingMallViewController alloc] init];
//            shoppingMallVC.hidesBottomBarWhenPushed = YES;
//            shoppingMallVC.viewTitle = @"积分兑换";
//            shoppingMallVC.isShopping = NO;
//            [self.navigationController pushViewController:shoppingMallVC animated:YES];
//        }
//    }else if (indexPath.section == 2){
//        if (indexPath.row == 1) {
//            NSDictionary *dic = @{@"index1":@"已浏览",@"index2":@"已加入",@"connector":@"userCollect",@"cellType":@"tableView1"};
//            ZZTBrowViewController *myCircleVC = [[ZZTBrowViewController alloc] initWithNibName:@"ZZTBrowViewController" bundle:nil];
//            myCircleVC.viewTitle = @"我的圈子";
//            myCircleVC.dic = dic;
//            myCircleVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:myCircleVC animated:YES];
//        }else if (indexPath.row == 2){
//            NSDictionary *dic = @{@"index1":@"用户",@"index2":@"作者",@"connector":@"userCollect",@"cellType":@"tableView2"};
//            ZZTBrowViewController *myAttentionVC = [[ZZTBrowViewController alloc] initWithNibName:@"ZZTBrowViewController" bundle:nil];
//            myAttentionVC.viewTitle = @"我的关注";
//            myAttentionVC.dic = dic;
//            myAttentionVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:myAttentionVC animated:YES];
//        }
//    }else if(indexPath.section == 3){
//        if(indexPath.row == 0){
//            NSDictionary *dic = @{@"index1":@"漫画",@"index2":@"剧本",@"connector":@"userCollect",@"cellType":@"collection"};
//            ZZTBrowViewController *participationView = [[ZZTBrowViewController alloc] initWithNibName:@"ZZTBrowViewController" bundle:nil];
//            participationView.viewTitle = @"参与作品";
//            participationView.dic = dic;
//            participationView.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:participationView animated:YES];
//        }else if(indexPath.row == 1){
//            NSDictionary *dic = @{@"index1":@"漫画",@"index2":@"剧本",@"connector":@"userCollect",@"cellType":@"collection"};
//            ZZTBrowViewController *browse = [[ZZTBrowViewController alloc] initWithNibName:@"ZZTBrowViewController" bundle:nil];
//            browse.viewTitle = @"我的收藏";
//            browse.dic = dic;
//            browse.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:browse animated:YES];
//        }else if(indexPath.row == 2){
//            NSDictionary *dic = @{@"index1":@"漫画",@"index2":@"剧本",@"index3":@"发现",@"connector":@"userCollect",@"cellType":@"collection"};
//            ZZTHistoryViewController *browse = [[ZZTHistoryViewController alloc] initWithNibName:@"ZZTHistoryViewController" bundle:nil];
//            browse.viewTitle = @"浏览历史";
//            browse.dic = dic;
//            browse.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:browse animated:YES];
//        }
//    }else{
//            ZZTSettingViewController *settingVC = [[ZZTSettingViewController alloc] init];
//            settingVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:settingVC animated:YES];
//    }
}
#pragma mark - 请求数据
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏Bar
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //加载用户信息
    [self loadUserData];
}
-(void)loadUserData{
    NSDictionary *paramDict = @{
                                @"userId":@"10"
                                };
    [self.manager POST:[ZZTAPI stringByAppendingString:@"login/usersInfo"] parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger code = (long)responseObject[@"code"];
        if(code == 100){
            NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
            NSArray *array = [ZZTUserModel mj_objectArrayWithKeyValuesArray:dic];
            ZZTUserModel *model = array[0];
            model.isLogin = NO;
            self.userData = model;
            [self setupTopView];
        }else{
            ZZTUserModel *model = [[ZZTUserModel alloc] init];
            model.isLogin = NO;
            self.userData = model;
            [self setupTopView];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
