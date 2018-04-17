//
//  PITextView.h
//  Parking
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PITextView : UITextView

///-- 占位文字
@property (nonatomic, copy) NSString *placeholder;
///-- 占位文字颜色
@property (nonatomic, strong) UIColor *placeholderColor;
///-- 限制字数
@property (nonatomic, assign) NSInteger limitCount;

@end
