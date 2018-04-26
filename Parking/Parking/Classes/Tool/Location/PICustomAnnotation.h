//
//  PICustomAnnotation.h
//  Parking
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface PICustomAnnotation : NSObject<MAAnnotation>

/**
 *  大头针的位置
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

/**
 *  大头针标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  大头针的子标题
 */
@property (nonatomic, copy) NSString *subtitle;

/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;

@end
