//
//  PINavigationController.m
//  Parking
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 GM. All rights reserved.
//  全局导航控制器

#import "PINavigationController.h"

@interface PINavigationController ()

@end

@implementation PINavigationController

+ (void)initialize {
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:PIMainColor];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18.0], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //-- 设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemDic = [NSMutableDictionary dictionary];
    itemDic[NSFontAttributeName] = PISYS_FONT(17);
    itemDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:itemDic forState:UIControlStateNormal];
    
    //-- enable状态
    NSMutableDictionary *itemDisableDic = [NSMutableDictionary dictionary];
    itemDisableDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisableDic forState:UIControlStateDisabled];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        
        UIButton *backBtn = [[UIButton alloc] init];
        [backBtn setImage:[UIImage imageNamed:@"navgation-back"] forState:UIControlStateNormal];
        backBtn.size = CGSizeMake(70, 30);
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    
    [self popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
