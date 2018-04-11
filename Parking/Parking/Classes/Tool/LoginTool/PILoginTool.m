//
//  PILoginTool.m
//  Parking
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PILoginTool.h"
#import "PINavigationController.h"
#import "PILoginViewController.h"

@implementation PILoginTool

+ (void)loginOut {
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        PINavigationController  *nav = [[PINavigationController alloc] initWithRootViewController:[[PILoginViewController alloc] init]];
        
        [PIUserDefaults removeObjectForKey:SessionId];
        [PIUserDefaults synchronize];
        //重新设置窗口的根视图
        window.rootViewController = nav;
        
        [UIView setAnimationsEnabled:oldState];
        
    } completion:^(BOOL finished) {
        
        
    }];

    
}
@end
