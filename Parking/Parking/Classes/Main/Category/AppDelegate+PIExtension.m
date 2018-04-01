//
//  AppDelegate+PIExtension.m
//  Parking
//
//  Created by apple on 2018/1/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "AppDelegate+PIExtension.h"
#import "PILoginViewController.h"
#import "PITabBarController.h"
#import "PIHomeViewController.h"
#import "PINavigationController.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation AppDelegate (PIExtension)

- (void)setupRootViewController {
    
    [self configKeys];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    PINavigationController *nav;
    
    if ([PIUserDefaults objectForKey:SessionId]) {
        
        nav = [[PINavigationController alloc] initWithRootViewController:[[PIHomeViewController alloc] init]];
    }else {
        
        nav = [[PINavigationController alloc] initWithRootViewController:[[PILoginViewController alloc] init]];
    }
    
    [self.window setRootViewController: nav];
    
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    
    
    [self.window makeKeyAndVisible];
}

- (void)configKeys {
    
    NSLog(@"%@", PIAMap_Key);
    
    [AMapServices sharedServices].apiKey = PIAMap_Key;
    //[[PILocationTool shareCoreLoaction] startUpdataingLocation];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    NSLog(@"-----> ：%@", url.host);
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
           
        }];
        
        return YES;
    }
    
    return NO;
}
@end
