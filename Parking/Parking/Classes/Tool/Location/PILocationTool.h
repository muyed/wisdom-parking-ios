//
//  PILocationTool.h
//  Parking
//
//  Created by apple on 2018/3/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PILocationTool : NSObject

/**
 单利
 */
+(instancetype)shareCoreLoaction;
- (void)startUpdataingLocation;
- (void)stopUpdataingLocation;
/**
 位置信息
 */
@property (nonatomic, strong) CLLocation *location;

@end
