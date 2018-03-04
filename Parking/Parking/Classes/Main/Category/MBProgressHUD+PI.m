//
//  MBProgressHUD+PI.m
//  Parking
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "MBProgressHUD+PI.h"

#define HideAfterDelay 1.0

typedef NS_ENUM(NSInteger, MLProgressType) {
    
    MLProgressTypeText = 0,
    MLProgressTypeIndeter
};

@implementation MBProgressHUD (PI)

+ (void)showMessage:(NSString *)message {
    
    [self showMessage:message toView:nil];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view {
    
    [self showHUDMessage:message toView:view type:MLProgressTypeText];
}

+ (void)showIndeterWithMessage:(NSString *)message {
    
    [self showIndeterWithMessage:message toView:nil];
}

+ (void)showIndeterWithMessage:(NSString *)message toView:(UIView *)view {
    
    [self showHUDMessage:message toView:view type:MLProgressTypeIndeter];
}

+ (void)showHUDMessage:(NSString *)message toView:(UIView *)view type:(MLProgressType)type{
    
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.removeFromSuperViewOnHide = YES;
    if (type == MLProgressTypeText) {
        
        hud.label.text = message;
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:HideAfterDelay];
    }else {
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.detailsLabel.text = message;
        hud.detailsLabel.font = PISYS_FONT(15);
        hud.detailsLabel.textColor = txtSeconColor;
    }
    
    
}

+ (void)showHUDMessage:(NSString *)message toView:(UIView *)view {
    
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    // MBProgressHUD *hud = [MBProgressHUD ]
}
+ (void)hideHUDFromView:(UIView *)view {
    
    if (view == nil) {
        
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    [self hideHUDForView:view animated:YES];
}


+ (void)hideHUD {
    
    [self hideHUDFromView:nil];
}


@end
