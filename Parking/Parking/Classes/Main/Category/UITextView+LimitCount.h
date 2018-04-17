//
//  UITextView+LimitCount.h
//  ML
//
//  Created by apple on 2017/7/21.
//  Copyright © 2017年 HS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LimitCount)

/** 限制字数*/
@property (nonatomic, assign) NSInteger zw_limitCount;
/** lab的右边距(默认10)*/
@property (nonatomic, assign) CGFloat zw_labMargin;
/** lab的高度(默认20)*/
@property (nonatomic, assign) CGFloat zw_labHeight;
/** 统计限制字数Label*/
@property (nonatomic, readonly) UILabel *zw_inputLimitLabel;
@property (assign) BOOL isHasobserver;

@end
