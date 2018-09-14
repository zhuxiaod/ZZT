//
//  MLIAPManager.m
//  MLIAPurchaseManager
//
//  Created by mali on 16/5/14.
//  Copyright © 2016年 mali. All rights reserved.
//

#import "MLIAPManager.h"

@interface MLIAPManager() <SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    SKProduct *myProduct;
}

@property (nonatomic, strong) SKPaymentTransaction *currentTransaction;

@end

@implementation MLIAPManager

#pragma mark - ================ 单例 =================

+ (instancetype)sharedManager {
    
    static MLIAPManager *iapManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iapManager = [MLIAPManager new];
    });
    
    return iapManager;
}

#pragma mark - ================ 公共方法 =================

#pragma mark ==== 请求商品
//传入产品id 判断商品ID是否为空
- (BOOL)requestProductWithId:(NSString *)productId {
    
    if (productId.length > 0) {
        NSLog(@"请求商品: %@", productId);
        SKProductsRequest *productRequest = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:productId]];
        productRequest.delegate = self;
        [productRequest start];
        return YES;
    } else {
        NSLog(@"商品ID为空");
    }
    return NO;
}

#pragma mark ==== 购买商品
- (BOOL)purchaseProduct:(SKProduct *)skProduct {
    
    if (skProduct != nil) {
        if ([SKPaymentQueue canMakePayments]) {
            SKPayment *payment = [SKPayment paymentWithProduct:skProduct];
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            return YES;
        } else {
            NSLog(@"失败，用户禁止应用内付费购买.");
        }
    }
    return NO;
}

#pragma mark ==== 商品恢复
- (BOOL)restorePurchase {
    
    if ([SKPaymentQueue canMakePayments]) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue]restoreCompletedTransactions];
        return YES;
    } else {
        NSLog(@"失败,用户禁止应用内付费购买.");
    }
    return NO;
}

#pragma mark ==== 结束这笔交易
- (void)finishTransaction {
	[[SKPaymentQueue defaultQueue] finishTransaction:self.currentTransaction];
}



#pragma mark ====  刷新凭证
- (void)refreshReceipt {
    SKReceiptRefreshRequest *request = [[SKReceiptRefreshRequest alloc] init];
    request.delegate = self;
    [request start];
}

#pragma mark - ================ SKRequestDelegate =================

- (void)requestDidFinish:(SKRequest *)request {
    if ([request isKindOfClass:[SKReceiptRefreshRequest class]]) {
        NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
        NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
        [_delegate successedWithReceipt:receiptData];
    }
}


#pragma mark - ================ SKProductsRequest Delegate =================

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
//    NSLog(@"-----------收到产品反馈信息--------------");
//    NSArray *myProduct = response.products;
//    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
//    NSLog(@"产品付费数量: %d", (int)[myProduct count]);
//    // populate UI
//    for(SKProduct *product in myProduct){
//        NSLog(@"product info");
//        NSLog(@"SKProduct 描述信息%@", [product description]);
//        NSLog(@"产品标题 %@" , product.localizedTitle);
//        NSLog(@"产品描述信息: %@" , product.localizedDescription);
//        NSLog(@"价格: %@" , product.price);
//        NSLog(@"Product id: %@" , product.productIdentifier);
//    }
    
    NSArray *myProductArray = response.products;
    if (myProductArray.count > 0) {
        myProduct = [myProductArray objectAtIndex:0];
        [_delegate receiveProduct:myProduct];
    } else {
        NSLog(@"无法获取产品信息，购买失败。");
        [_delegate receiveProduct:myProduct];
    }
}

#pragma mark - ================ SKPaymentTransactionObserver Delegate =================

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing: //商品添加进列表
                NSLog(@"商品:%@被添加进购买列表",myProduct.localizedTitle);
               
                break;
            case SKPaymentTransactionStatePurchased://交易成功
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已购买过该商品
                break;
            case SKPaymentTransactionStateDeferred://交易延迟
                break;
            default:
                break;
        }
    }
}

#pragma mark - ================ Private Methods =================

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    [_delegate successedWithReceipt:receiptData];
    self.currentTransaction = transaction;
}


- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    if (transaction.error.code != SKErrorPaymentCancelled && transaction.error.code != SKErrorUnknown) {
        [_delegate failedPurchaseWithError:transaction.error.localizedDescription];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    self.currentTransaction = transaction;
}

@end
