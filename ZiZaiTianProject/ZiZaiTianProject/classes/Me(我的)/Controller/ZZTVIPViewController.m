//
//  ZZTVIPViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTVIPViewController.h"
#import "ZZTVIPTopView.h"
#import "ZZTVIPMidView.h"
#import "ZZTVIPBtView.h"
//static NSString * const productId = @"zxd.ZiZaiTianProject2";
#import "MLIAPManager.h"
#import <SVProgressHUD.h>
#import <MBProgressHUD.h>
@interface ZZTVIPViewController () <MLIAPManagerDelegate>

@end

@implementation ZZTVIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"VIP";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [self.view addSubview:scrollView];
    
    //头部
    ZZTVIPTopView *VIPTopView = [ZZTVIPTopView VIPTopView];
    VIPTopView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    [scrollView addSubview:VIPTopView];

    //充值服务
    ZZTVIPMidView *midView = [ZZTVIPMidView VIPMidView];
    midView.frame = CGRectMake(0,VIPTopView.y+VIPTopView.height +15, SCREEN_WIDTH, 280);
    midView.buttonAction = ^(UIButton *sender) {
        NSString *productId = @"";
        if(sender.tag == 0)productId = @"zxd.ZiZaiTianProject1";
        else if(sender.tag == 1)productId = @"zxd.ZiZaiTianProject3";
        else if (sender.tag == 2)productId = @"zxd.ZiZaiTianProject4";
        else if (sender.tag == 3)productId = @"zxd.ZiZaiTianProject5";
        else if (sender.tag == 4)productId = @"zxd.ZiZaiTianProject6";
        [[MLIAPManager sharedManager] requestProductWithId:productId];

        [self refreshBtnClicked];
        //菊花 开始
        [SVProgressHUD showWithStatus:nil];
    };
    [scrollView addSubview:midView];
    
    //VIP特权
    ZZTVIPBtView *btView = [ZZTVIPBtView VIPBtView];
    btView.frame = CGRectMake(0, midView.y+midView.height+15, SCREEN_WIDTH, 280);
    [scrollView addSubview:btView];
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, btView.y+btView.height);
    
    [MLIAPManager sharedManager].delegate = self;

}

#pragma mark - ================ Actions =================

- (void)refreshBtnClicked {
    [[MLIAPManager sharedManager] refreshReceipt];
}


#pragma mark - ================ MLIAPManager Delegate =================

- (void)receiveProduct:(SKProduct *)product {
    
    [SVProgressHUD dismiss];
    
    if (product != nil) {
        //菊花取消
        //购买商品
        if (![[MLIAPManager sharedManager] purchaseProduct:product]) {

            //初始化提示框；
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"失败" message:@"您禁止了应用内购买权限,请到设置中开启" preferredStyle: UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
            }]];
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"Loading";
        }
    } else {
        //菊花取消
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"失败" message:@"无法连接App store!" preferredStyle: UIAlertControllerStyleAlert]; [alert addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
        }]];
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"Loading";
    }
}

- (void)successedWithReceipt:(NSData *)transactionReceipt {
    [SVProgressHUD dismiss];
    NSLog(@"购买成功");
    
    NSString  *transactionReceiptString = [transactionReceipt base64EncodedStringWithOptions:0];
    
    if ([transactionReceiptString length] > 0) {
        // 向自己的服务器验证购买凭证（此处应该考虑将凭证本地保存,对服务器有失败重发机制）
        /**
         服务器要做的事情:
         接收ios端发过来的购买凭证。
         判断凭证是否已经存在或验证过，然后存储该凭证。
         将该凭证发送到苹果的服务器验证，并将验证结果返回给客户端。
         如果需要，修改用户相应的会员权限
         */
        
        /**
         if (凭证校验成功) {
         [[MLIAPManager sharedManager] finishTransaction];
         }
         */
    }
}

- (void)failedPurchaseWithError:(NSString *)errorDescripiton {
    [SVProgressHUD dismiss];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"购买失败";
    NSLog(@"购买失败");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"失败" message:errorDescripiton preferredStyle: UIAlertControllerStyleAlert]; [alert addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
    }]];
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
}
@end
