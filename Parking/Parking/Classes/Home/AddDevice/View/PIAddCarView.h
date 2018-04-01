//
//  PIAddCarView.h
//  Parking
//
//  Created by apple on 2018/4/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZJInputPasswordCompletionBlock)(NSString *password);

@interface PIAddCarView : UIView

@property (nonatomic,copy)ZJInputPasswordCompletionBlock completionBlock;

/** 更新输入框数据 */
- (void)updateLabelBoxWithText:(NSString *)text;

/** 抖动输入框 */
- (void)startShakeViewAnimation;

- (void)didInputPasswordError;

@end
