//
//  ZZTSettingViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/3.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTSettingViewController.h"
#import "ZZTSettingSwichCell.h"
#import "ZZTNoTypeCell.h"
#import "ZZTExitCell.h"
#import "ZZTSettingModel.h"

@interface ZZTSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;

//@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic,strong)NSMutableArray *array1;

@property (nonatomic,strong)NSArray *array2;

@property (nonatomic,strong)NSArray *array3;

@end

@implementation ZZTSettingViewController

-(NSMutableArray *)array1{
    if(!_array1){
        _array1 = [NSMutableArray array];
    }
    return _array1;
}

-(NSArray *)array2{
    if(!_array2){
        _array2 = [NSMutableArray array];
    }
    return _array2;
}

-(NSArray *)array3{
    if(!_array3){
        _array3 = [NSMutableArray array];
    }
    return _array3;
}

//cell的标识
NSString *ZZTsetting = @"ZZTsetting";
NSString *ZZTcellq = @"ZZTcellq";
NSString *ZZTcell11 = @"ZZTcell11";
NSString *NoTypeCell = @"NoTypeCell";
NSString *ExitCell = @"ExitCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
    //创建tableView
    [self setupTableView];
    //注册Cell
    [self registerCell];
    //title数据
    [self titleData];
}
#pragma mark - tableView
-(void)setupTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 0;
    _tableView.sectionFooterHeight = 10;
    _tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
    //隐藏滚动条
    _tableView.showsVerticalScrollIndicator = NO;
}
#pragma mark - 注册cell
-(void)registerCell{
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ZZTSettingSwichCell" bundle:nil] forCellReuseIdentifier:ZZTsetting];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZTcellq];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZTcell11];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZZTNoTypeCell" bundle:nil] forCellReuseIdentifier:NoTypeCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZZTExitCell" bundle:nil] forCellReuseIdentifier:ExitCell];
}
#pragma mark - title数据
-(void)titleData{
    _array1 = [NSMutableArray arrayWithObjects:[ZZTSettingModel initSettingModelWith:@"低流量模式" detail:@"非WIFI环境下加载低质量图片,可为您节省70%流量"],[ZZTSettingModel initSettingModelWith:@"回复推送" detail:@"开启后及时收到别人的评论"],[ZZTSettingModel initSettingModelWith:@"更新提示" detail:@"关注作品更新后会及时提醒"],
//               [ZZTSettingModel initSettingModelWith:@"夜间模式" detail:@"开启后,夜间阅读不伤眼睛"],
               nil];
    _array2 = [NSArray arrayWithObjects:@"赏个好评",@"意见反馈",@"推荐给好友", nil];
    _array3 = [NSArray arrayWithObjects:@"缓存清理",@"帮助中心",@"关于我们",@"用户协议", nil];
}



#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return self.array1.count;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return self.array2.count;
    }else{
        return self.array3.count + 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        ZZTSettingSwichCell *cell = [tableView
                                     dequeueReusableCellWithIdentifier:ZZTsetting];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ZZTSettingModel *model = self.array1[indexPath.row];
        cell.settingModel = model;
        return cell;
    }else if (indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZZTcellq];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = @"手机号码";
        UILabel *label = [[UILabel alloc] init];
        label.text = @"188****8888";
        label.font = [UIFont boldSystemFontOfSize:14];
        [label sizeToFit];
        label.backgroundColor = [UIColor clearColor];
        label.frame =CGRectMake(Screen_Width - label.frame.size.width - 50, 15, label.frame.size.width, label.frame.size.height);
        [cell.contentView addSubview:label];
        label.textColor = [UIColor grayColor];
        return cell;
    }else if(indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZZTcellq];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = self.array2[indexPath.row];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZZTcellq];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            ZZTNoTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:NoTypeCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.cellLab.text = self.array3[indexPath.row];
            cell.cache.text = @"39.6";
            return cell;
        }else if (indexPath.row == 4) {
            ZZTExitCell *cell = [tableView dequeueReusableCellWithIdentifier:ExitCell];
            return cell;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = self.array3[indexPath.row];
            
        }
        return cell;
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end
