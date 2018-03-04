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

@implementation AppDelegate (PIExtension)

- (void)setupRootViewController {
    
    [self configKeys];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    PINavigationController *nav = [[PINavigationController alloc] initWithRootViewController:[[PIHomeViewController alloc] init]];
    [self.window setRootViewController: nav];
    
    
    
    [self.window makeKeyAndVisible];
}

- (void)configKeys {
    
    NSLog(@"%@", PIAMap_Key);
    
    [AMapServices sharedServices].apiKey = PIAMap_Key;
    //[[PILocationTool shareCoreLoaction] startUpdataingLocation];
}
@end
