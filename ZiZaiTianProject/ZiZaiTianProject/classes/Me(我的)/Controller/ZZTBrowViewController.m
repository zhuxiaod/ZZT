//
//  ZZTBrowViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTBrowViewController.h"
#import "ZZTCartoonViewController.h"

@interface ZZTBrowViewController ()

@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (weak, nonatomic) IBOutlet UILabel *viewControllerTitle;

@property (strong,nonatomic) AFHTTPSessionManager *manager;

@end

@implementation ZZTBrowViewController

#pragma mark - LazyLoad
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTitle];
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加子页
    [self setUpAllChildViewController];
    
    //设置滑动栏的样式
    [self setupStyle];
}

-(void)setupTitle{
    [_viewControllerTitle setText:_viewTitle];
}
#pragma mark - 加载数据
-(void)loadData{
    //请求参数
    NSDictionary *paramDict = @{
                                @"userId":@"1"
                                };
    
    [self.manager POST:[NSString stringWithFormat:@"http://192.168.0.165:8888/great/%@",[self.dic objectForKey:@"接口"]] parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@---%@",[responseObject class],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败 -- %@",error);
    }];
}

#pragma mark - 设置样式
-(void)setupStyle{
    [self setUpDisplayStyle:^(UIColor *__autoreleasing *titleScrollViewBgColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIColor *__autoreleasing *proColor, UIFont *__autoreleasing *titleFont, CGFloat *titleButtonWidth, BOOL *isShowPregressView, BOOL *isOpenStretch, BOOL *isOpenShade) {
        *titleScrollViewBgColor = [UIColor whiteColor]; //标题View背景色（默认标题背景色为白色）
        *norColor = [UIColor darkGrayColor];            //标题未选中颜色（默认未选中状态下字体颜色为黑色）
        *selColor = [UIColor purpleColor];              //标题选中颜色（默认选中状态下字体颜色为红色）
        *proColor = [UIColor purpleColor];              //滚动条颜色（默认为标题选中颜色）
        *titleFont = [UIFont systemFontOfSize:16];      //字体尺寸 (默认fontSize为15)

        *isShowPregressView = YES;                      //是否开启标题下部Pregress指示器
        *isOpenStretch = YES;                           //是否开启指示器拉伸效果
        *isOpenShade = YES;                             //是否开启字体渐变
    }];

    [self setUpTopTitleViewAttribute:^(CGFloat *topDistance, CGFloat *titleViewHeight, CGFloat *bottomDistance) {
        *topDistance = 64;
    }];

}
#pragma mark - 添加所有子控制器
- (void)setUpAllChildViewController
{
    //传个参数 知道是什么类型的  切换CELL 模型 
    //index1
    ZZTCartoonViewController *carttonVC = [[ZZTCartoonViewController alloc] init];
    carttonVC.title = [self.dic objectForKey:@"index1"];
    carttonVC.dataIndex = @"1";
    carttonVC.cellType = [self.dic objectForKey:@"cellType"];
    carttonVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:carttonVC];
    //index2
    ZZTCartoonViewController *playVC = [[ZZTCartoonViewController alloc] init];
    playVC.title = [self.dic objectForKey:@"index2"];
    playVC.dataIndex = @"2";
    playVC.cellType = [self.dic objectForKey:@"cellType"];
    playVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:playVC];
}
//返回上一页
- (IBAction)disMis:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
