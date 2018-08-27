//
//  ZZTSignInViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTSignInViewController.h"
#import "ZZTVIPTopView.h"
#import "ZZTUserModel.h"
#import "ZZTSignButton.h"

@interface ZZTSignInViewController ()
@property (weak, nonatomic) IBOutlet ZZTSignButton *dayOne;
@property (weak, nonatomic) IBOutlet ZZTSignButton *dayTwo;
@property (weak, nonatomic) IBOutlet ZZTSignButton *dayThree;
@property (weak, nonatomic) IBOutlet ZZTSignButton *dayFour;
@property (weak, nonatomic) IBOutlet ZZTSignButton *dayFive;
@property (weak, nonatomic) IBOutlet ZZTSignButton *daySix;
@property (weak, nonatomic) IBOutlet ZZTSignButton *daySeven;

@property (nonatomic,strong) NSMutableArray *dayBtnArray;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic,strong) ZZTUserModel* userData;
@end

@implementation ZZTSignInViewController

-(NSMutableArray *)dayBtnArray{
    if(!_dayBtnArray){
        _dayBtnArray = [NSMutableArray arrayWithObjects:_dayOne,_dayTwo,_dayThree,_dayFour,_dayFive,_daySix,_daySeven, nil];
    }
    return _dayBtnArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"签到";
    
    //头视图  -没接好
    ZZTVIPTopView *topView = [ZZTVIPTopView VIPTopView];
    topView.frame = CGRectMake(0, 0, self.topView.width, self.topView.height);
    topView.viewImage = [UIImage imageNamed:@"我的-页面标识-签到"];
    topView.viewTitle = @"签到";
    topView.viewDetail = @"签到领5积分";
    [self.topView addSubview:topView];
    
    //初始化签到btn
    for (int i = 0; i < self.dayBtnArray.count; i++) {
        ZZTSignButton *btn = self.dayBtnArray[i];
        btn.isGet = NO;
        btn.ifSign = NO;
        [btn setEnabled:NO];
        [btn setTag:i];
        [btn addTarget:self action:@selector(clickSignBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self loadUserData];
}

-(void)isget:(NSInteger)signCount isSign:(NSInteger)isSign{
    //连续打卡
    //如果状态是1 那么连续打卡少一个  如果状态是0 就是正常的
    if(isSign == 1)
    {
        if(signCount == 0){
            signCount = 0;
        }else{
            signCount = signCount - 1;
        }
    }
    for (NSInteger i = 0;i < signCount;i++) {
        ZZTSignButton *btn = self.dayBtnArray[i];
        btn.isGet = YES;
    }
    //判断当天是否打卡 1打y 0没n
    if (isSign == 1) {
        ZZTSignButton *btn = self.dayBtnArray[signCount];
        btn.ifSign = YES;
    }else{
        ZZTSignButton *btn = self.dayBtnArray[signCount];
        btn.ifSign = NO;
        [btn setEnabled:YES];
    }
    for (signCount = signCount + 1; signCount < 7; signCount++)
    {
        ZZTSignButton *btn = self.dayBtnArray[signCount];
        btn.isNo = YES;
    }
}

-(void)clickSignBtn:(ZZTSignButton *)btn{
    [btn setIfSign:YES];

    [self signViewDidClickSignBtn:btn];

}

#pragma mark - ZZTSignInViewDelegate
-(void)signViewDidClickSignBtn:(UIButton *)btn
{
    NSDictionary *paramDict = @{
                                @"userId":self.userData.userId
                                };
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"record/userSign"] parameters:paramDict success:^(id responseObject) {

    } failure:^(NSError *error) {

    }];
}

-(void)loadUserData{
    NSDictionary *paramDict = @{
                                @"userId":@"1"
                                };
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"login/usersInfo"] parameters:paramDict success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSLog(@"%@",dic);
        NSArray *array = [ZZTUserModel mj_objectArrayWithKeyValuesArray:dic];
        ZZTUserModel *model = array[0];
        self.userData = model;
        [self isget:model.signCount isSign:model.ifsign];
    } failure:^(NSError *error) {
        
    }];
}
@end
