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
@interface ZZTMeViewController ()<UITableViewDataSource,UITableViewDelegate,ZZTSignInViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property(nonatomic,strong) UITableView *tableView;
//cell数据
@property (nonatomic,strong) NSArray *cellData;

@property (nonatomic,strong) AFHTTPSessionManager *manager;

//获得数据
@property (nonatomic,strong) NSString *getData;

@property (nonatomic,strong) EncryptionTools *encryptionManager;

@property (nonatomic,strong) ZZTUserModel *userData;

@property (nonatomic,strong) ZZTSignInView *signView;
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
    self.rr_navHidden = YES;
    //请求数据
    [self getData];
    //设置table
    [self setupTab];
}


#pragma mark - 设置tableView
-(void)setupTab
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.sectionHeaderHeight = 10;
    _tableView.sectionFooterHeight = 0;
    _tableView.dataSource = self;
    _tableView.delegate = self;

    //隐藏滚动条
    _tableView.showsVerticalScrollIndicator = NO;
    //添加头视图
    ZZTMeTopView *top = [ZZTMeTopView meTopView];
    _tableView.tableHeaderView = top;
    [self.view addSubview:_tableView];
    //注册cell
    [self.tableView registerClass:[ZZTMeCell class] forCellReuseIdentifier:bannerID];
    top.buttonAction = ^(UIButton *sender) {
        [self buttonClick:sender];
    };
}
#pragma mark - headView
-(void)buttonClick:(UIButton *)button{
    if (button.tag == 0) {
        NSLog(@"我是z币");
    }else if(button.tag == 1){
        NSLog(@"我是积分");
    }else if(button.tag == 2){
        NSLog(@"我是票");
    }
    else if(button.tag == 3){
        NSLog(@"我是消息");
    }
    else if(button.tag == 4){
        ZZTMeEditViewController *meEditVC = [[ZZTMeEditViewController alloc]initWithNibName:@"ZZTMeEditViewController" bundle:nil];
        [self.navigationController pushViewController:meEditVC animated:YES];
    }else{
        //确定已签到的次数
        NSInteger signCount = _userData.signCount;
        //判断当天是不是应该签到
        NSInteger ifsigin = _userData.ifsign;
        
        NSLog(@"signCount:%ld",_userData.signCount);
        NSLog(@"ifsigin:%ld",(long)_userData.ifsign);

        //添加签到页面
        _signView = [ZZTSignInView SignView];
        _signView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
        [_signView isget:signCount isSign:ifsigin];
        [self.view addSubview:_signView];
        _signView.delegate = self;

    }
}
#pragma mark - ZZTSignInViewDelegate
-(void)signViewDidClickSignBtn:(ZZTSignButton *)btn
{
    NSDictionary *paramDict = @{
                                @"userId":@"23"
                                };
    [self.manager POST:@"http://120.79.178.191/record/userSign" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self loadUserData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败 -- %@",error);
    }];
}
-(void)signViewDidClickapGesture{
    
    [_signView removeFromSuperview];
    
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 2;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 3;
    }else if (section == 3){
        return 3;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZTMeCell *cell = [tableView dequeueReusableCellWithIdentifier:bannerID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的VIP";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"我的钱包";
        }
        return cell;
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"自在商城";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"积分兑换";
        }
        return cell;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的帖子";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"我的圈子";
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"我的关注";
        }
        return cell;
    }else if(indexPath.section == 3){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"参与作品";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"我的收藏";
        }else if(indexPath.row == 2){
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
        if(indexPath.row == 0){
            ZZTVIPViewController *VIPView = [[ZZTVIPViewController alloc]init];
            VIPView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VIPView animated:YES];
        }else if(indexPath.row == 1){
            ZZTMeWalletViewController *walletVC = [[ZZTMeWalletViewController alloc] init];
            walletVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:walletVC animated:YES];
        }
        else if (indexPath.row == 2){
            ZZTBrowViewController *myAttentionVC = [[ZZTBrowViewController alloc] initWithNibName:@"ZZTBrowViewController" bundle:nil];
            myAttentionVC.viewTitle = @"我的关注";
            myAttentionVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myAttentionVC animated:YES];
        }
    }else if(indexPath.section == 1){
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
            shoppingMallVC.viewTitle = @"积分兑换";
            shoppingMallVC.isShopping = NO;
            [self.navigationController pushViewController:shoppingMallVC animated:YES];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 1) {
            NSDictionary *dic = @{@"index1":@"已浏览",@"index2":@"已加入",@"connector":@"userCollect",@"cellType":@"tableView1"};
            ZZTBrowViewController *myCircleVC = [[ZZTBrowViewController alloc] initWithNibName:@"ZZTBrowViewController" bundle:nil];
            myCircleVC.viewTitle = @"我的圈子";
            myCircleVC.dic = dic;
            myCircleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myCircleVC animated:YES];
        }else if (indexPath.row == 2){
            NSDictionary *dic = @{@"index1":@"用户",@"index2":@"作者",@"connector":@"userCollect",@"cellType":@"tableView2"};
            ZZTBrowViewController *myAttentionVC = [[ZZTBrowViewController alloc] initWithNibName:@"ZZTBrowViewController" bundle:nil];
            myAttentionVC.viewTitle = @"我的关注";
            myAttentionVC.dic = dic;
            myAttentionVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myAttentionVC animated:YES];
        }
    }else if(indexPath.section == 3){
        if(indexPath.row == 0){
            NSDictionary *dic = @{@"index1":@"漫画",@"index2":@"剧本",@"connector":@"userCollect",@"cellType":@"collection"};
            ZZTBrowViewController *participationView = [[ZZTBrowViewController alloc] initWithNibName:@"ZZTBrowViewController" bundle:nil];
            participationView.viewTitle = @"参与作品";
            participationView.dic = dic;
            participationView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:participationView animated:YES];
        }else if(indexPath.row == 1){
            NSDictionary *dic = @{@"index1":@"漫画",@"index2":@"剧本",@"connector":@"userCollect",@"cellType":@"collection"};
            ZZTBrowViewController *browse = [[ZZTBrowViewController alloc] initWithNibName:@"ZZTBrowViewController" bundle:nil];
            browse.viewTitle = @"我的收藏";
            browse.dic = dic;
            browse.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:browse animated:YES];
        }else if(indexPath.row == 2){
            NSDictionary *dic = @{@"index1":@"漫画",@"index2":@"剧本",@"index3":@"发现",@"connector":@"userCollect",@"cellType":@"collection"};
            ZZTHistoryViewController *browse = [[ZZTHistoryViewController alloc] initWithNibName:@"ZZTHistoryViewController" bundle:nil];
            browse.viewTitle = @"浏览历史";
            browse.dic = dic;
            browse.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:browse animated:YES];
        }
    }else{
            ZZTSettingViewController *settingVC = [[ZZTSettingViewController alloc] init];
            settingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingVC animated:YES];
    }
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
                                @"userId":@"23"
                                };
    [self.manager POST:@"http://192.168.0.165:8888/login/usersInfo" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.getData = responseObject[@"result"];
        
        [self decry];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)decry{
//    //解密
//    NSString *data = [self.encryptionManager decryptString:self.getData keyString:@"ZIZAITIAN@666666" iv:[@"A-16-Byte-String" dataUsingEncoding:NSUTF8StringEncoding]];
//    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
//    NSMutableArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//    self.userData = [ZZTUserModel mj_objectWithKeyValues:dic[0]];
}
@end
