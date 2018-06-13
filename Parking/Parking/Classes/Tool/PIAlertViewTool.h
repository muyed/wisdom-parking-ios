//
//  PIAlertViewTool.h
//  Parking
//
//  Created by apple on 2018/6/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


typedef void (^ActionBlock)();
typedef void (^ActionBlockAtIndex)(NSInteger index);

@interface PIAlertViewTool : NSObject

@property (nonatomic, copy) ActionBlock actionBlock;
@property (nonatomic, copy) ActionBlockAtIndex actionBlockAtIndex;


/**
 *  alertController初始化
 *
 *  @param message     message
 *  @param controller  当前的controller
 *  @param block      action
 *
 *  @return alertController实例
 */
+ (id)alertViewToolShowMessage:(NSString *)message fromController:(UIViewController *)controller handler:(ActionBlock)block;




/**
 *  alertController初始化
 *
 *  @param title       title
 *  @param message     message
 *  @param controller  当前的controller
 *  @param block      action
 *
 *  @return alertController实例化
 */
+ (id)alertViewToolShowTitle:(NSString *)title message:(NSString *)message fromController:(UIViewController *)controller handler:(ActionBlock)block;




/**
 *  alertController初始化
 *
 *  @param title          title
 *  @param message        message
 *  @param cancelTitle    cancelTitle, index为0
 *  @param confirmTitle   confirmTitle, index为1
 *  @param controller     当前的controller
 *  @param block         action
 *
 *  @return alertController实例化
 */
+ (id)alertViewToolShowTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confiormTitle:(NSString *)confirmTitle fromController:(UIViewController *)controller handler:(ActionBlockAtIndex)block;


/**
 *  alertController初始化
 *
 *
 *  @param message        message
 *  @param cancelTitle    cancelTitle, index为0
 *  @param confirmTitle   confirmTitle, index为1
 *  @param controller     当前的controller
 *  @param block         action
 *
 *  @return alertController实例化
 */
+ (id)alertViewToolShowMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle confiormTitle:(NSString *)confirmTitle fromController:(UIViewController *)controller handler:(ActionBlockAtIndex)block;

@end
