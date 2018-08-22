//
//  ZZTRankViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTRankViewController.h"
#import "RankButton.h"
#import "ZZTRankCell.h"
#import "ZZTCartonnPlayModel.h"
@interface ZZTRankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *array;

@property (nonatomic,strong) UIView *topView;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) UITableView *tableView;

@end

NSString *zztRankCell = @"zztRankCell";

@implementation ZZTRankViewController

-(NSArray *)array{
    if(!_array){
        _array = [NSArray array];
    }
    return _array;
}

-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F1F2"];
    //4个btn
    [self setupTopView];
    //默认男生
    [self manTarget:self.array[0]];
    
    //下view
    [self setupTableView];
    
    self.navigationItem.title = @"排行榜";
}

-(void)loadData:(RankButton *)btn{
    NSDictionary *dic = @{
                          @"bookType":btn.rankType,
                          //众创
                          @"cartoonType":@"1",
                          @"pageNum":@"1",
                          @"pageSize":@"10"
                          };
    
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"cartoon/cartoonlist"] parameters:dic success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSMutableArray *array = [ZZTCarttonDetailModel mj_objectArrayWithKeyValuesArray:dic];
        self.dataArray = [self addIsHave:array];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(NSArray *)addIsHave:(NSArray *)array{
    for (int i = 0; i < array.count; i++) {
        ZZTCarttonDetailModel *model = array[i];
        model.isHave = NO;
    }
    return array;
}
-(void)setupTopView{
    //上view
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    _topView = topView;
    [self.view addSubview:topView];
    
    CGFloat btnViewW = SCREEN_WIDTH - 100;
    UIView *btnView = [[UIView alloc] init];
    btnView.frame = CGRectMake((SCREEN_WIDTH - btnViewW)/2, 5, btnViewW, topView.height - 10);
    [topView addSubview:btnView];
    
    CGFloat btnW = 60;
    CGFloat btnH = btnView.height;
    CGFloat space = (btnViewW - btnW*4)/3;
    
    RankButton *man = [[RankButton alloc] init];
    [man setTitle:@"男生榜" forState:UIControlStateNormal];
    [man setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    man.frame = CGRectMake(0, 0, btnW, btnH);
    [man addTarget:self action:@selector(manTarget:) forControlEvents:UIControlEventTouchUpInside];
    man.rankType = @"7";
    [btnView addSubview:man];
    
    RankButton *woman = [[RankButton alloc] init];
    [woman setTitle:@"女生榜" forState:UIControlStateNormal];
    [woman setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [woman addTarget:self action:@selector(manTarget:) forControlEvents:UIControlEventTouchUpInside];
    woman.rankType = @"8";

    woman.frame = CGRectMake(man.x + btnW + space, 0, btnW, btnH);

    [btnView addSubview:woman];
    
    RankButton *multiplayer = [[RankButton alloc] init];
    [multiplayer setTitle:@"众创榜" forState:UIControlStateNormal];
    [multiplayer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    multiplayer.frame = CGRectMake(woman.x + btnW + space, 0, btnW, btnH);
    [multiplayer addTarget:self action:@selector(manTarget:) forControlEvents:UIControlEventTouchUpInside];
    multiplayer.rankType = @"1";
    [btnView addSubview:multiplayer];
    
    RankButton *boom = [[RankButton alloc] init];
    [boom setTitle:@"畅销榜" forState:UIControlStateNormal];
    [boom setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    boom.frame = CGRectMake(multiplayer.x + btnW + space, 0, btnW, btnH);
    [boom addTarget:self action:@selector(manTarget:) forControlEvents:UIControlEventTouchUpInside];
    boom.rankType = @"5";
    [btnView addSubview:boom];
    
    NSArray *array = [NSArray arrayWithObjects:man,woman,multiplayer,boom, nil];
    self.array = array;
}

-(void)manTarget:(RankButton *)btn{
    for (RankButton *button in self.array) {
        if(button == btn){
            [btn setTitleColor:[UIColor colorWithHexString:@"#7B7BE4"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"排行榜-当前榜单"] forState:UIControlStateNormal];
            [self loadData:btn];
        }else{
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setImage:nil forState:UIControlStateNormal];
        }
    }
}

-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topView.height + 10, SCREEN_WIDTH, SCREEN_HEIGHT - self.topView.height +10) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView = tableView;
    [self.view addSubview:tableView];
    //注册
    [tableView registerNib:[UINib nibWithNibName:@"ZZTRankCell" bundle:nil] forCellReuseIdentifier:zztRankCell];
    tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
}
#pragma mark - 设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

#pragma mark - 内容设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTRankCell *cell = [tableView dequeueReusableCellWithIdentifier:zztRankCell];
    ZZTCarttonDetailModel *model = self.dataArray[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSString *index = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.currentIndex = index;
    cell.cellIndex = indexPath.row;
    cell.dataModel = model;
    return cell;
}

#pragma mark 高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //根据点击的不同 判断应该有多少高度
    return 200;
}
@end
