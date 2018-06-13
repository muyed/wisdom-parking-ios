//
//  PIAlertViewTool.m
//  Parking
//
//  Created by apple on 2018/6/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAlertViewTool.h"

@implementation PIAlertViewTool

+ (id)alertViewToolShowMessage:(NSString *)message fromController:(UIViewController *)controller handler:(ActionBlock)block
{
    return [[self alloc] initWithTitle:nil message:message cancelTitle:@"确定" confiormTitle:nil fromController:controller handler:block showIndex:NO];
}




+ (id)alertViewToolShowTitle:(NSString *)title message:(NSString *)message fromController:(UIViewController *)controller handler:(ActionBlock)block
{
    return [[self alloc] initWithTitle:title message:message cancelTitle:@"确定" confiormTitle:nil fromController:controller handler:block showIndex:NO];
}




+ (id)alertViewToolShowTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confiormTitle:(NSString *)confirmTitle fromController:(UIViewController *)controller handler:(ActionBlockAtIndex)block
{
    return [[self alloc] initWithTitle:title message:message cancelTitle:cancelTitle confiormTitle:confirmTitle fromController:controller handler:block showIndex:YES];
}

+ (id)alertViewToolShowMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle confiormTitle:(NSString *)confirmTitle fromController:(UIViewController *)controller handler:(ActionBlockAtIndex)block {
    
    return [[self alloc] initWithTitle:nil message:message cancelTitle:cancelTitle confiormTitle:confirmTitle fromController:controller handler:block showIndex:YES];
}
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confiormTitle:(NSString *)confirmTitle fromController:(UIViewController *)controller handler:(id)sender showIndex:(BOOL)showIndex
{
    if ([self init]) {
        
        if (showIndex) {
            self.actionBlockAtIndex = sender;
        } else {
            self.actionBlock = sender;
        }
        
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        //取消按钮
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            if (showIndex == NO && self.actionBlock) {
                self.actionBlock();
            }
            
            if (showIndex && self.actionBlockAtIndex) {
                self.actionBlockAtIndex(0);
            }
            
            
            [alertC dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertC addAction:cancleAction];
        
        //[cancleAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
        
        //确定按钮
        if (showIndex) {
            
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (self.actionBlockAtIndex) {
                    self.actionBlockAtIndex(1);
                }
                [alertC dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertC addAction:confirmAction];
        }
        
        
        [controller presentViewController:alertC animated:YES completion:nil];
    }
    return self;
}


@end
