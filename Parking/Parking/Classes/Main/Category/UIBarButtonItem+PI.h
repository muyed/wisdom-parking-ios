//
//  UIBarButtonItem+PI.h
//  Parking
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,PIBarButtonItemType) {
    
    PIBarButtonItemLeft = 0,
    PIBarButtonItemCenter = 1,
    PIBarButtonItemRight = 2
};

@interface UIBarButtonItem (PI)

/**设置导航栏按钮*/
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action type:(PIBarButtonItemType)type;

/**图片按钮*/
+ (instancetype)itemWithImage:(NSString *)imageName target:(id)target action:(SEL)action;
@end
