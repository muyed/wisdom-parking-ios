//
//  MBProgressHUD+PI.h
//  Parking
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (PI)
/**
 纯文字提示，可以自己隐藏
 @param message 描述语句
 */
+ (void)showMessage:(NSString *)message;


/**
 在控制器中纯文字提示，可以自己隐藏
 
 @param message 描述语句
 @param view 控制器view
 */
+ (void)showMessage:(NSString *)message toView:(UIView *)view;


/**
 带有菊花，不能自己隐藏
 
 @param message 描述语句
 */
+ (void)showIndeterWithMessage:(NSString *)message;


/**
 在控制器中带有菊花， 不能自己隐藏
 
 @param message 描述语句
 @param view 控制器view
 */
+ (void)showIndeterWithMessage:(NSString *)message toView:(UIView *)view;


/**
 从控制器中隐藏
 
 @param view 控制View
 */
+ (void)hideHUDFromView:(UIView *)view;

/**隐藏*/
+ (void)hideHUD;

@end
