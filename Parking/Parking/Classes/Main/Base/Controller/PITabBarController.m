//
//  PITabBarController.m
//  Parking
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PITabBarController.h"
#import "PIHomeViewController.h"
#import "PIOrderViewController.h"
#import "PIMeViewController.h"
#import "PINavigationController.h"

@interface PITabBarController ()

@end

@implementation PITabBarController

+ (void)initialize {
    
    /*统一设置tabBar的样式*/
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = PISYS_FONT(12);
    attrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x999999);
    
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectAttrs[NSForegroundColorAttributeName] = PIMainColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupChildVC:[[PIHomeViewController alloc] init] title:@"首页" image:@"tab_home_normal" selectImage:@"tab_home_selecte"];
    [self setupChildVC:[[PIOrderViewController alloc] init] title:@"订单" image:@"tab_order_normal" selectImage:@"tab_order_selecte"];
    [self setupChildVC:[[PIMeViewController alloc] init] title:@"我的" image:@"tab_me_normal" selectImage:@"tab_me_select"];
}

- (void)setupChildVC:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    
    viewController.tabBarItem.title = title;
    viewController.navigationItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    viewController.view.backgroundColor = PIBackColor;
    
    PINavigationController *navController = [[PINavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:navController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
