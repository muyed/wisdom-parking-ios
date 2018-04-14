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
#import "PIHomeOrderController.h"
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
    
    [self setIQkeyboard];
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

/**
设置键盘全局
*/
-(void)setIQkeyboard{
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable =YES;// 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside =YES;//控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor =YES;//控制键盘上的工具条文字颜色是否用户自定义
    manager.toolbarDoneBarButtonItemText =@"完成";//将右边Done改成完成
    manager.enableAutoToolbar =YES;// 控制是否显示键盘上的工具条
    manager.toolbarManageBehaviour =IQAutoToolbarByTag;
    
//    [manager.disabledDistanceHandlingClasses addObject:NSClassFromString(@"MLConversationController")];
//    [manager.disabledDistanceHandlingClasses addObject:NSClassFromString(@"MLRebutReasonController")];
//    [manager.disabledDistanceHandlingClasses addObject:NSClassFromString(@"MLFriendPersonalView")];
//    [manager.disabledDistanceHandlingClasses addObject:NSClassFromString(@"MLFriendPersonalController")];
//    [manager.disabledDistanceHandlingClasses addObject:NSClassFromString(@"MLBottomReplyView")];
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
