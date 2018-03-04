//
//  PITool.h
//  Parking
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PITool : NSObject

///手机驱动
+ (NSString*)deviceVersion;
///是否全屏显示
+ (BOOL)isFullScreen;

@end
